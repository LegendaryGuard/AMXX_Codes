/* 
|--------------------ESF Powerlevel changer v. 0.1.------------------------------------
|We made this plugin because I was sick of people gasping for 
|powerlevel changer utility. Well, this is it - the powerlevel changer
|----------------------------------------------
|Usage : esf_powerlevel <nickname, authid, team or Steam:id> <powerlevel to give>
|:::::NOTE:::::: Sometimes you must activate and deactivate turbo to see a change
|on your HUD.
|.Version - to see which version this powerlevel is.
|.cvar_powerlevel 0/1 - turn off/on Powerlevel changer
|----------------------------------------------
|Requirements : you need to have cstrike, fun, and FakeMeta module enabled.
|----------------------------------------------
|Known bugs:
|- when you transform your powerlevel sometimes returns to normal.
|----------------------------------------------
|In later revisions of this plugin we will add KI reffiler and infinite KI commands,
|and when I found out how to properly change models without skeleton and animation
|glitches, I'll release model changer too ( Encore_SX knows it how but won't let me his part of code).
|----------------------------------------------
|Credits:
|AMXX team for the best AMX Mod X and excellent FakeMeta module
|AMXX community which always gave me good solutions to mine problems,
|and provided support.
| f117bomb which I took part of his ADMIN HEAL plugin - without him this plugin wouldn't be possible
|----------------------------------------------
|v 0.3
|- fixed transformation loose powerlevel bug, now when you transform your tweked plugin stays
|v 0.2
|- improved code a bit
|- fixed bug that you couldn't enter bigger powerlevel than 7 symbols
|- added cvar to enable/disable powerlevel changer
|v 0.1
|- added esf_powerlevel command
|- added .Version command
|----------------------------------------------
| Peace, LynX & Encore_SX
|--------------------------------------------------------------------------------------
| Compatible with Amxx 1.0 and thus compatible with EVM
*/  

#include <amxmodx>
#include <amxmisc>
#include <fun>
#include <fakemeta>
#include <fakemeta_const>

public plugin_init()

{

	register_plugin("[ ESF Powerlevel changer ]","[ 0.3 ]","LynX & Encore_SX")
	register_concmd("esf_powerlevel","clientPowerlevelChange",ADMIN_LEVEL_A,"<authid, nick, @team or #userid> <powerlevel to give>")
	register_clcmd(".version","clVersion")
	register_cvar(".cvar_powerlevel","1")

	
	return PLUGIN_CONTINUE

}

public clientPowerlevelChange(id,level,cid)
{
	if(get_cvar_num(".cvar_powerlevel") == 0)
	{
		client_print(id, print_chat, " [ ESF Powerlevel Changer ] >> [ Powerlevel changer is off ] ")
		return PLUGIN_HANDLED
	}
//---------------------------------------
	if (!cmd_access(id,level,cid,3))
		return PLUGIN_HANDLED

	new arg[32], arg2[11], name2[32]
	read_argv(1,arg,31)
	read_argv(2,arg2,10)
	get_user_name(id,name2,31)
	if (arg[0]=='@'){
		new players[32], inum
		get_players(players,inum,"ae",arg[1])
		if (inum==0){
			console_print(id,"[ No clients in such team ]")
			return PLUGIN_HANDLED
		}
		for(new a=0;a<inum;++a) {
			set_pdata_int(players[a], 460, str_to_num(arg2))
			set_pdata_int(players[a], 461, str_to_num(arg2))
		}
		switch(get_cvar_num("amx_show_activity"))	{
			case 2:	client_print(0,print_chat,"[ESF Powerlevel changer] ADMIN %s: set powerlevel on all %s",name2,arg[1])
			case 1:	client_print(0,print_chat,"[ESF Powerlevel changer] ADMIN: set powerlevel on all %s",arg[1])
		}
		console_print(id,"[ESF Powerlevel changer] All clients have set powerlevel")
		log_amx("ADMIN HEAL - this command was issued by %s on all %s",name2,arg[1])
	}
	else {
		new player = cmd_target(id,arg,10)
		if (!player) return PLUGIN_HANDLED
		set_pdata_int(player, 460, str_to_num(arg2))
		set_pdata_int(player, 461, str_to_num(arg2))
		new name[32]
		get_user_name(player,name,31)
		switch(get_cvar_num("amx_show_activity"))	{
			case 2:	client_print(0,print_chat,"[ESF Powerlevel changer] ADMIN %s: set powerlevel on %s",name2,name)
			case 1:	client_print(0,print_chat,"[ESF Powerlevel changer] ADMIN: set powerlevel on %s",name)
		}
		console_print(id,"[ESF Powerlevel Changer] Client ^"%s^" has set powerlevel",name)
		log_amx("[AMXX] [ ESF Powerlevel ] - this command was issued by %s on %s",name2,name)
	}
	return PLUGIN_HANDLED
}

public clVersion(id)

{

	client_print(id, print_chat, " [ ESF Powerlevel changer ] >> [ Revision v. 0.3. ] ")

	return PLUGIN_HANDLED

}

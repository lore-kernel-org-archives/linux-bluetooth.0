Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404192354.21196.cijoml@volny.cz>
Subject: [Bluez-users] bthid 2.6.5 bad keycode
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 19 Apr 2004 23:54:20 +0200

Hi Marcel,

there is bug in 2.6.5 and bthid configuration.
It badly resolve "|" key:

KeyPress event, serial 28, synthetic NO, window 0x2800001,
    root 0x3f, subw 0x0, time 645528, (104,-2), root:(695,18),
    state 0x90, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 characters:  ""

KeyPress event, serial 28, synthetic NO, window 0x2800001,
    root 0x3f, subw 0x0, time 645982, (104,-2), root:(695,18),
    state 0x91, keycode 111 (keysym 0xff61, Print), same_screen YES,
    XLookupString gives 0 characters:  ""

KeyRelease event, serial 28, synthetic NO, window 0x2800001,
    root 0x3f, subw 0x0, time 646121, (104,-2), root:(695,18),
    state 0x91, keycode 111 (keysym 0xff61, Print), same_screen YES,
    XLookupString gives 0 characters:  ""

KeyRelease event, serial 28, synthetic NO, window 0x2800001,
    root 0x3f, subw 0x0, time 646842, (104,-2), root:(695,18),
    state 0x91, keycode 50 (keysym 0xffe1, Shift_L), same_screen YES,
    XLookupString gives 0 characters:  ""

It returns Print and not "|"

It is problem to use unix like system without | :)

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

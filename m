Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <44032D51.2000902@gmx.de>
From: Eryk Borych <borych@gmx.de>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Broken sound stream (Motorola H300 and ISSC Dongle)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 27 Feb 2006 17:48:17 +0100

Hi!
I have a weird problem, i couldn't find on this mailing list:
I have Integrated System Solution Corp usb bluetooth dongle (ID 1131:1001)
and a Motorola Bluetooth H300 headset.
I am able to connect SCO channel, get no errors, but the sound stream is
broken - i hear sound only for about half a second, followed by a
half-second silence.
Of course, it is impossible to make a Skype call like that :)
As I've told, i have no usual errors (not errors at all) in my outputs,
but i'll post my hcitool -con output during the
connection:

< SCO 00:0B:2E:70:51:BE handle 2 state 1 lm SLAVE
< ACL 00:0B:2E:70:51:BE handle 1 state 1 lm SLAVE

and a small output of hcidump:

...
> SCO data: handle 2 dlen 48
< SCO data: handle 2 dlen 48
< SCO data: handle 2 dlen 48
< SCO data: handle 2 dlen 48
> SCO data: handle 2 dlen 48
> SCO data: handle 2 dlen 48
> SCO data: handle 2 dlen 48
< SCO data: handle 2 dlen 48
< SCO data: handle 2 dlen 48
< SCO data: handle 2 dlen 48
> SCO data: handle 2 dlen 48
> SCO data: handle 2 dlen 48
> SCO data: handle 2 dlen 48
> SCO data: handle 2 dlen 48
...

Got it working once, but can't repeat this :)

thanks for your help.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

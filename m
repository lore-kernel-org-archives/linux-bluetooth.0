Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <436884DD.2060505@icmanage.com>
From: Shiv Sikand <shiv@icmanage.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] rfcomm issues with newer distros ?
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
Date: Wed, 02 Nov 2005 01:20:29 -0800

Hi,

I have been using my Treo 650 with Bluetooth DUN on Mandrake 10.2 with
no problems.

I recently tried the same thing on Mandriva LE 2006  and SUSE 10 and
both these distros have the same issues: when connecting to the Treo
using /dev/rfcomm*, the modem does not respond to any AT commands.

i.e.

Mandrake 10.2:
Modem Ready
ATZ
OK

SUSE 10:
Modem Ready
ATZ
[no response]

and then rfcomm disconnects after a few seconds....


Kernel versions I observe are:

Mandrake 10.2: 2.6.11-6mdk
Mandriva 2006 : 2.6.12-12mdksmp
SUSE 10: 2.6.13-5

Has anyone got any advice ?

Thanks,
Shiv




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050104152233.17839.qmail@DEFAULT-ID0.IPLNet>
From: "Nuno Cruz" <ncruz@isel.ipl.pt>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [Bluez-users] AMBIT T60M665 Firmware Upgrade
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
Date: Tue, 4 Jan 2005 15:22:33 -0000

Hi all,

I have an internal AMBIT T60M665 Bluecore2-Ext on my laptop, and I tried to
upgrade it since it had an old version (16.4), with the genericcsr file (the
dongle is recognized as a CSR generic device), the update went fine but I
lost the blue light on the laptop so I decided to go back and tried to
downgrade, but since I din't the backup I just tried some firmware that I
supposed to be the same as mine from an epox BT-DG02A dongle (the header is
the same - "LOADER=bc02x_hci_1v1_16.4_56, STACK=bc02x_hci_1v1_16.4_56" and
the VID+PID also)
Well doing this reduced the range of my device to 1m, my bluetooth mouse
that sits on the side of the laptop has a realy bad reception. So I got an
identical laptop from work and got the firmware from it to put in mine, but
I can't do the upgrade I always get an error at the middle of the upgrade
about the device not being ready... This happens at byte 2046 if I try with
my backup but with genericcsr.dfu I get this error at byte ~ 613000.

Does anyone have a hint on how to resolve this?
I've tried this with dfu update from marcel and also with the widcomm tools
in windows...

Thanks!

--
Regards,

Nuno Cruz 



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <000601c3f8c9$98e2c820$3d4bb850@ULLA>
From: "Zbigniew Diaczyszyn \(gmx\)" <z.dia@gmx.de>
To: <bluez-users@lists.sourceforge.net>
References: <000d01c3f343$d89f1ad0$e04db850@ULLA> <1076855680.14758.55.camel@pegasus>  <000b01c3f599$04aaf520$de4bb850@ULLA> <1077058491.2665.131.camel@pegasus>  <003b01c3f65e$371ef400$dc4db850@ULLA> <1077147114.2685.11.camel@pegasus>
Subject: Re: [Bluez-users] hcidump, was: rfcomm: permission denied
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Sat, 21 Feb 2004 23:24:12 +0100

Hi Marcel,

> yes, hciconfig shows you the local address of your device. For rfcomm
> you have to use the remote address.

Well, I tried so once again, but hcidump is silent...

Perhaps the following kernel warning in /var/log/messages can show the =
way to a solution:

Feb 19 22:22:54 linux su: (to root) dia on /dev/pts/1
Feb 19 22:22:54 linux su: pam_unix2: session started for user root, =
service su
Feb 19 22:30:11 linux pppd[3070]: Plugin passwordfd.so loaded.
Feb 19 22:30:11 linux pppd[3070]: pppd 2.4.1 started by root, uid 0
Feb 19 22:30:13 linux hcid[1307]: link_key_request =
(sba=3D8C:97:A6:60:10:00, dba=3D2C:AC:29:60:10:00)
-------------------------------------------------------------------------=
------
Feb 19 22:30:13 linux kernel: Warning: null TTY for (d8:00) in =
tty_fasync
-------------------------------------------------------------------------=
------
Feb 19 22:30:13 linux pppd[3070]: Failed to open /dev/rfcomm0: =
Permission denied
Feb 19 22:30:13 linux pppd[3070]: Exit.
Feb 19 22



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

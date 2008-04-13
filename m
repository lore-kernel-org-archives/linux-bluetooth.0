Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Apr 2008 16:39:49 +0200
From: Michael Domann <profbunny@gmx.de>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
Message-Id: <20080413163949.da11ab14.profbunny@gmx.de>
Mime-Version: 1.0
Subject: [Bluez-users] headset connection works only one time
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

hi list,

with the 3.30 release my headset works (tanks for this). its a jabra bt135. the sound quality is low, but this is possible to get better with an different option. how can i see which is the best way to connect to my headset?

sysiphus:/home/profbunny# hcitool cc 00:1A:45:6E:D5:23
sysiphus:/home/profbunny# hcitool inq 00:1A:45:6E:D5:23
Inquiring ...
00:1A:45:6E:D5:23       clock offset: 0x7b4c    class: 0x200404
sysiphus:/home/profbunny# hcitool info 00:1A:45:6E:D5:23
Requesting information ...
BD Address:  00:1A:45:6E:D5:23
LMP Version: 2.0 (0x3) LMP Subversion: 0x978
Manufacturer: Cambridge Silicon Radio (10)
Features: 0xfc 0xfe 0x0b 0x00 0x08 0x08 0x00 0x00
<encryption> <slot offset> <timing accuracy> <role switch> 
<hold mode> <sniff mode> <RSSI> <channel quality> <SCO link> 
<HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD> 
<paging scheme> <transparent SCO> <AFH cap. slave> 
<AFH cap. master>


The mayor problem even is, that it is one times usable, then is required to reboot.
When i sotp the call in skype for example and i wont to call another people, i can get a connection to the headset, syslog shows

Apr 10 15:21:10 sysiphus hcid[10086]: Audio API: sending BT_GETCAPABILITIES_RSP
Apr 10 15:21:10 sysiphus hcid[10086]: Audio API: received BT_SETCONFIGURATION_REQ
Apr 10 15:21:10 sysiphus hcid[10086]: config sco - device = 00:1A:45:6E:D5:23 access_mode = 2
Apr 10 15:21:50 sysiphus hcid[10086]: connect(): Connection timed out (110)
Apr 10 15:21:50 sysiphus hcid[10086]: config failed
Apr 10 15:21:50 sysiphus hcid[10086]: Audio API: sending BT_SETCONFIGURATION_RSP
Apr 10 15:21:50 sysiphus kernel: hci_cmd_task: hci0 command tx timeout


then is impossible to get it react, stop the deamon remove the modul and load it and start the deamon don't help.

Any suggestions if i get this working?

thanks
micha

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "pdjj14" <pdjj14@gmail.com>
To: <bluez-devel@lists.sourceforge.net>
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAmaUem1Nm8k+FVVBwbPkbkcKAAAAQAAAAOM1JOHBst0q7ZTbxEE486QEAAAAA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
In-Reply-To: <20060106055011.0AA19F94F@sc8-sf-spam2.sourceforge.net>
Subject: [Bluez-devel] linux 2.4.20 & alsa 0.9.6
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 6 Jan 2006 14:59:31 +0900

Hi~
 Thank you for your kindness. ^^
 I want to listen the music which be played at PC as BT headset.
 My environment is Redhat 9.0 + kernel 2.4.20-8 + bluez-utils-2.10 + bluez-
libs-2.10 + bluez-hcidump-1.10 + alsa-dirver-0.9.6 + alsa-lib-0.9.6 +
bluezsco-0.1.

 I want to play the music with alsa.
 When I installed the alsa, I referenced web page
(http://www.dcs.gla.ac.uk/~jp/snd-bluez-sco/README)
 But, when I type 'bluezsco', I see the error message.
	[root@wooki bluezsco-0.1]# ./bluezsco
	Error: control open (hw:0): No such file or directory
	Error: Can't find device. Bail
 Device hci0 is enable state.
 I always work as root.
 Necessary modules(rfcomm, sco, l2cap...) already loaded.
 I want to know if I miss somethings.
 I want to know method to succeed.

 Another question is about hciconfig.
 When I type hciconfig -a, I see the message.
	[root@wooki alsa-lib-0.9.6]# hciconfig -a
	hci0:   Type: USB
        BD Address: 00:0B:24:01:23:B3 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:3547 acl:49 sco:0 events:173 errors:0
        TX bytes:2141 acl:101 sco:0 commands:46 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver:
0x33c
        Manufacturer: Cambridge Silicon Radio (10)  When I type hciconfig
hci0 revision, I see the message.
	[root@wooki sco]# hciconfig hci0 revision
	hci0:   Type: USB
        BD Address: 00:0B:24:01:23:B3 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.14
        Max key size: 16 bit
 The other's result different from mine.
 I want to see more informations as 'Chip version', 'SCO mapping'.
 My dongle is based on 'Cambridge Silicon Radio'.
 What do I do more to see more informations?

 I can't change my environment as kernel version up.
 Because, at final, I will load the program to the target board.
 The target board's environment already be promised by co-workers.
 
 Thank you...I will wait for your response. ^^



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

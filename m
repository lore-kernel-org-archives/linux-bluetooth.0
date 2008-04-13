Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Apr 2008 22:29:52 +0200
From: Michael Domann <profbunny@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-Id: <20080413222952.132a1aa6.profbunny@gmx.de>
In-Reply-To: <20080413163949.da11ab14.profbunny@gmx.de>
References: <20080413163949.da11ab14.profbunny@gmx.de>
Mime-Version: 1.0
Subject: Re: [Bluez-users] headset connection works only one time
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

On Sun, 13 Apr 2008 16:39:49 +0200
Michael Domann <profbunny@gmx.de> wrote:

Hi,

some addition infos:
my bluetooth dongle
hciconfig -a
hci0:   Type: USB
        BD Address: 00:13:EF:F1:44:13 ACL MTU: 120:20 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:659 acl:0 sco:0 events:18 errors:0
        TX bytes:316 acl:0 sco:0 commands:18 errors:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'sysiphus-0'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous, 
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
        Manufacturer: Silicon Wave (11)


this is wrote in syslog, when the connection is ended(finished skype call):
Apr 13 22:16:13 sysiphus hcid[30958]: Audio API: sending BT_GETCAPABILITIES_RSP
Apr 13 22:16:13 sysiphus hcid[30958]: Audio API: received BT_SETCONFIGURATION_REQ
Apr 13 22:16:13 sysiphus hcid[30958]: config sco - device = 00:1A:45:6E:D5:23 access_mode = 2
Apr 13 22:16:14 sysiphus hcid[30958]: connect(): Software caused connection abort (103)
Apr 13 22:16:14 sysiphus hcid[30958]: config failed
Apr 13 22:16:14 sysiphus hcid[30958]: Audio API: sending BT_SETCONFIGURATION_RSP
Apr 13 22:16:14 sysiphus kernel: hci_scodata_packet: hci0 SCO packet for unknown connection handle 256

i think the connection is not closed correct.

any suggestions?

thanks

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

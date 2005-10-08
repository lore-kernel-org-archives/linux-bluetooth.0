Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Adam Ritter <xiph@freemail.hu>
Message-ID: <loom.20051008T232205-496@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] full duplex SCO communication for head set profile
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
Date: Sat, 8 Oct 2005 21:33:08 +0000 (UTC)

Hi!

I try to use my computer as a headset for a mobile phone. The computer makes an
rfcomm connection and when the mobile makes an SCO connection to the computer,
it accepts it. The computer can read data from the SCO socket, but when it
writes to that socket, the write fails with error ,,Invalid argument''.  Do you
have any ideas what I should do to transfer sound from the computer to the
mobile with that profile?

Adam


# hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:72:B2:F6:72 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:1362628 acl:313 sco:26537 events:543 errors:0
        TX bytes:5706 acl:238 sco:0 commands:203 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)

bash-2.05b# hciconfig hci0 voice
hci0:   Type: USB
        BD Address: 00:02:72:B2:F6:72 ACL MTU: 192:8 SCO MTU: 64:8
        Voice setting: 0x0060 (Default Condition)
        Input Coding: Linear
        Input Data Format: 2's complement
        Input Sample Size: 16 bit
        # of bits padding at MSB: 0
        Air Coding Format: CVSD



zzz


zzz

zzz

z
efewafafweawfe

fewafaweafwe






-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

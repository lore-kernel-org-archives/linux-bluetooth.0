Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Reply-To: <ag@new-media-artists.de>
From: "Andreas Gaufer" <ag@new-media-artists.de>
To: <bluez-devel@lists.sourceforge.net>
Message-ID: <FJENILNPNAGPJMMDOKDCAEJJDJAA.ag@new-media-artists.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-devel] Device Busy during "hcitool info" or "sdptool search"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 Dec 2003 17:38:52 +0100

Hi,

I appreciate your great work and dedication to the bluetooth technologie.
The blueZ Stack is the most stable BT-Software i ever used on a PC-Style
Hardware and im verry happy that it is avaiable. I hope i can contribute at
some point, but i think i need to keep on learning to be able to. Heres what
i found out for now.

I have noticed that

"hcitool inq" returnes "Device or resource busy" every time if a
"hcitool info <mac>" || "sdptool search --bdaddr <mac> <someservice>" is
running on the same hciX device.

Is this normal or should this be considered a problem?
If it is normal, i would appreciate some pointer to readings that could make
me understand why this happens.

Im using:

hcitool - HCI Tool ver 2.3
sdptool - SDP Tool v1.5

kernel 2.4.23
BlueZ Core ver 2.3
BlueZ RFCOMM ver 1.1
BlueZ L2CAP ver 2.3
BlueZ HCI USB driver ver 2.4


The problem appears with both USB-BT Devices i own:

MSI PC2PC Bluetooth
[root@localhost root]# hciconfig hci0 -a
	  hci0:   Type: USB
        BD Address: 00:10:DC:E9:32:D1 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        Features: 0xff 0xff 0x0f 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'TuxBox'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)
[root@localhost root]# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:10:DC:E9:32:D1 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.4 (bc02x)

and also a

Acer BT-600
[root@localhost root]# hciconfig hci0 -a
hci0:   Type: USB
        BD Address: 00:02:72:01:4C:B8 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        Features: 0xff 0xff 0x0f 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'TuxBox'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)
[root@localhost root]# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:02:72:01:4C:B8 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.4 (bc02x)

I saw some threads that discuss problems that could be similar to the one
discribed here but they all where quite old and didnt point to a solution.
Also a lot of things changed in BlueZ and the Tools so i hope im not
bothering you starting this topic again.
If any further information is needed for tracking the problem i´ll be happy
to provide it.

Greetings

Andreas Gaufer




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

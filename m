Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Charles Bueche <charles@bueche.ch>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1106681895.20288.0.camel@bluez.bueche.ch>
Mime-Version: 1.0
Subject: [Bluez-users] MX900 sometimes catalepsic
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
Date: Tue, 25 Jan 2005 20:38:15 +0100

Hi,

[once again with the correct "From:", sorry if it appear twice]

I'm running 2.6.10-gentoo-r4 with patch-2.6.10-mh1.gz. My hardware is a
Logitech MX900 mouse and a Dell Inspiron 8600 with a CSR chip :

hci0:   Type: USB
        BD Address: 00:10:C6:22:54:AF ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:113629 acl:7992 sco:0 events:88 errors:0
        TX bytes:1043 acl:24 sco:0 commands:42 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'laptopcb (0)'
        Class: 0x100100
        Service Classes: Object Transfer
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x235 LMP Ver: 1.1 (0x1) LMP Subver: 0x235
        Manufacturer: Cambridge Silicon Radio (10)

I'm not using the mouse bluetooth dock for any connection (only battery
loading).

Often, after unpacking my laptop and MX900 mouse from its bag, the mouse
appear to "hang". The laptop doesn't see it, and I have to open the
mouse battery location and quickly unplug one battery to reset the
mouse. After this treatment, the mouse announce itself and the laptop
sees it and create the devices with udev.

The problem happen about 1/4 of the time when unpacking the laptop, but
in a systematic way after a reboot (eg after upgrading my kernel). I
never boot my laptop under Windows, and I never use the mouse with other
machines. The "connect" button has no effect.

The problem has be present since a long time and several kernels and
bluez patches, maybe since always.

It would only be annoying, but the battery door of my mouse is starting
to present a bad shape after openning it with just about all the tools
that fits it, including cisors.

Any hint welcome.

TIA,
Charles

-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

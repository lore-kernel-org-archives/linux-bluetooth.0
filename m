Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] ISSC dongle not working
References: <200601150005.26582.yann.morin.1998@anciens.enib.fr>
In-Reply-To: <200601150005.26582.yann.morin.1998@anciens.enib.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200601162013.09018.yann.morin.1998@anciens.enib.fr>
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
Date: Mon, 16 Jan 2006 20:13:08 +0100

Hello all!

On Sunday 15 January 2006 000, Yann E. MORIN wrote:
> I have this USB/Bluetooth dongle:
> | $ lsusb
> | Bus 002 Device 025: ID 1131:1001 Integrated System Solution Corp.

I was trying to make it work on my AMD64 dual-core.

Today I tried on an i686 (32bit machine) and it works (to some extents at
least):

| $ hciconfig -a
| hci0:   Type: USB
|         BD Address: FF:FF:FF:FF:FF:FF ACL MTU: 678:8 SCO MTU: 48:10|
|         UP RUNNING PSCAN ISCAN=20
|         RX bytes:662 acl:0 sco:0 events:21 errors:0
|         TX bytes:331 acl:0 sco:0 commands:21 errors:0
|         Features: 0xff 0xff 0x8d 0x78 0x08 0x18 0x00 0x00
|         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
|         Link policy: RSWITCH HOLD SNIFF PARK=20
|         Link mode: SLAVE ACCEPT=20
|         Name: 'lesneven-0'
|         Class: 0x3e0100
|         Service Classes: Networking, Rendering, Capturing
|         Device Class: Computer, Uncategorized
|         HCI Ver:  (0xff) HCI Rev: 0xffff LMP Ver:  (0x8f) LMP Subver: 0x1=
ae
|         Manufacturer: Integrated System Solution Corp. (57)

What is strange is the BD Address: All FF's. Is it a problem?...

hcitool scan does scan the network and returns the available devices. Good.
hcitool info xx:XX:yy:YY:zz:ZZ returns info on the device. Good.
sdptool browse xx:XX:yy:YY:zz:ZZ returns the available services on the devi=
ce.
So far so good! :-)

So all is well on ia32.

Why on earth won't it work on x86_64? hcid is running, hidd is running,
sdpd as well. It get recognise (in dmesg):

| [101878.834988] usb 1-2.5: new full speed USB device using ehci_hcd and a=
ddress 15
| [101878.856539] hci_usb_intr_rx_submit: hci0 intr rx submit failed urb ff=
ff81002ac69228 err -28
| [101878.856751] hci_cmd_task: hci0 command tx timeout

Any hint? Oh yes, the bluez is the same version on both machines:
On the x86_64:
| $ hcitool -h
| hcitool - HCI Tool ver 2.24
[--SNIP--]
| $ ls -l /lib*/*blue*.so
| lrwxrwxrwx  1 root root 22 Jan 13 19:11 /lib64/libbluetooth.so -> libblue=
tooth.so.1.0.24

On the i686:
| $ hcitool -h
| hcitool - HCI Tool ver 2.24
[--SNIP--]
| $ ls -l /lib*/*blue*.so
| lrwxrwxrwx  1 root root 22 Jan 16 19:46 /lib/libbluetooth.so -> libblueto=
oth.so.1.0.24

Running linux-2.6.12 on both machines.

If you need something more from here, please tell.

I'm actually gaping, my mouth wide open, at my two screens, when on one I c=
an
see my dongle working, while doing the same on the other gets me nowhere...

=3D=3D=3D
Help me if you can, I'm feeling down
And I do appreciate you being round.
Help me, get my feet back on the ground,
Won't you please, please help me, help me, help me, oh.=20
=3D=3D=3D
:-)

Regards, and thanks for your attention,
Yann E. MORIN.

=2D-=20
=2E-----------------.--------------------.------------------.--------------=
=2D-----.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspira=
cy: |
| +0/33 662376056 | Software  Designer | \ / CAMPAIGN     |   ^            =
    |
| --=3D=3D< =B0_=B0 >=3D=3D-- =B0---.----------------:  X  AGAINST      |  =
/e\  There is no  |
| web: ymorin.free.fr | SETI@home 3808 | / \ HTML MAIL    |  """  conspirac=
y.  |
=B0---------------------=B0----------------=B0------------------=B0--------=
=2D-----------=B0


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

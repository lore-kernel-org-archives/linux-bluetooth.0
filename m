Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marko Kreen <marko@l-t.ee>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] hci_usb: add entry for FMWBA-101 Bluetooth usb-dongle
Message-ID: <20050928191714.GA17254@l-t.ee>
References: <20050928152415.GA11240@l-t.ee> <1127922285.5321.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1127922285.5321.20.camel@localhost.localdomain>
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
Date: Wed, 28 Sep 2005 22:17:14 +0300

On Wed, Sep 28, 2005 at 05:44:44PM +0200, Marcel Holtmann wrote:
> > This patch adds ID's for Fujitsu-Siemens FMWBA-101 Bluetooth
> > USB Adapter.
> > 
> > /proc/bus/usb/devices:
> > T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
> > D:  Ver= 1.10 Cls=0e(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=0bf8 ProdID=1003 Rev= 3.36
> > S:  Manufacturer=ALPS
> > S:  Product=BT USB
> 
> this is not needed, because the USB class is enough.

But it is not, the device won't be detected without this patch.

# uname -r
2.6.13.2
# modprobe hci_usb
# hciconfig -a
# rmmod hci_usb
# modprobe hci_usb_fix
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:C7:42:6A:F2 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:111 acl:0 sco:0 events:14 errors:0
        TX bytes:310 acl:0 sco:0 commands:14 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'grue-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x150 LMP Ver: 1.1 (0x1) LMP Subver: 0x150
        Manufacturer: Cambridge Silicon Radio (10)

-- 
marko



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

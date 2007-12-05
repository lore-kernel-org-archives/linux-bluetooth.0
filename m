Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <bc2917430712040950x21220f7an64d0d558939d42f7@mail.gmail.com>
References: <bc2917430712040950x21220f7an64d0d558939d42f7@mail.gmail.com>
Date: Wed, 05 Dec 2007 08:24:26 +0100
Message-Id: <1196839466.12292.154.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Dell D830 laptop BT card doesn't start
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

Hi Franck,

> I've been trying to make my embedded bluetooth card work, but it seems
> i have a big problem...
> Before explaining it, here is my hardware specification:
> Dell D830 laptop, and my bluetooth card (running lsusb): 
> Bus 001 Device 003: ID 413c:8140 Dell Computer Corp. Wireless 360
> Bluetooth

show me /proc/bus/usb/devices for your card.

> I have installed bluez-utils, bluez-libs, bluetooth, everything that
> is seem to be needed.
> 
> Here is what hciconfig give me: 
> hci0:   Type: USB
>         BD Address: 00:1A:6B:8A:xx:xx ACL MTU: 310:10 SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:4134 acl:0 sco:0 events:136 errors:0
>         TX bytes:2047 acl:0 sco:0 commands:133 errors:0 
> 
> So my BT card seems to work ... but when I run a scan or an inq (with
> hcitool), nothing is found. Also, the bluetooth led of my laptop is
> off ...
> 
> After doing many test, i was wondering if it was not a hardware
> problem, so i have boot to windows to see if my card words. Everything
> worked fine, the led was on, the scan showed my phone. Then i reboot
> on linux, and here is the thing weird, my bluetooth card was still
> working (the led was on). 
> 
> So i start bluetooth daemon (hcid, sdpd), i run a scan, and my phone
> is found !!!
> 
> The problem seems to be the bluetooth card doesn't "start"/"stop" on
> linux (the led story confirms that). So, is there a way to solve this
> thing ? Have I done something wrong ? 

The card might need a special init sequence to make it work. You can try
to load hci_usb with reset=1 module option. That might be enough.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Microsoft Bluethooth "Elite" Keyboard & Mouse
References: <20050116174616.GA2201@virgilio.it>
In-Reply-To: <20050116174616.GA2201@virgilio.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501161851.01291.cijoml@volny.cz>
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
Date: Sun, 16 Jan 2005 18:51:01 +0100

Hi,

You should use 2.6.10-mh1 and latest firmware for Digianswer dongle (adapter 
use it I think)

Michal

Dne ne 16. ledna 2005 18:46 Francesco Bochicchio napsal(a):
> Hi all,
>
> I have a Microsft Bluetooth "Elite" keyboard and optical mouse,
> and I'm trying to make it work with Linux.
>
> I have googled and read stuff, but currently I'm stucked.
>
> When I plug the USB Dongle in an USB port I get the following kernel
> messages (among others):
>
>
> Jan 15 13:48:22 superlap kernel: usb 1-2.2: new full speed USB device using
> address 8 Jan 15 13:48:23 superlap kernel: input: USB HID v1.11 Keyboard
> [045e:00bf] on usb-0000:00:10.0-2.2 Jan 15 13:48:24 superlap kernel: usb
> 1-2.3: new full speed USB device using address 9 Jan 15 13:48:25 superlap
> kernel: input: USB HID v1.11 Mouse [045e:00be] on usb-0000:00:10.0-2.3
>
> Also, hotplug loads a bunch of modules, including :
>
> usbmouse
> joydev
> usbkbd
> usbhid
> hci_usb
> rfcomm
> l2cap
> bluetooth
>
> Finally, I get the message:
>
> Jan 15 13:48:31 superlap hcid[2744]: Can't init device hci0. Connection
> timed out(110)
>
>
> The device hci0 is created but not opeerative:
>
> superlap:/home/fb# hciconfig
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:3 acl:0 sco:0 commands:1 errors:0
>
> and if I try to bring it up:
>
> superlap:/home/fb# hciconfig hci0 up
> Can't init device hci0. Connection timed out(110)
>
>
> I also tried hcidump, but it hangs after this output:
>
> superlap:/home/fb# hcidump -x
> HCIDump - HCI packet analyzer ver 1.12
> device: hci0 snap_len: 1028 filter: 0xffffffff
>
> I tried all this with and without batteries inserted (no change).
> I also tried pressing the litte button on the back while doing
> "hciconfig hci0 up" and pressing keys while doing "hcidump -x".
>
> The keyboard and mouse works with Windows XP SP2, so the problem
> is not the hardware.
>
> My questions:
>
> 1. Does this device works with Linux+blueZ ? (I know that someone had
>    success with other models of MS BT keyboards).
>
> 2. Do I have to patch the kernel? (actually I have a Kernel 2.6.9
>    pre-compiled (Debian Unstable distro) for AMD k7).
>
> 3. What else can I try?
>
>
> Thanks for any hint.
>
> Ciao
> ----
> FB
>
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-- 
S pozdravem

Michal Semler


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

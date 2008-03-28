Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Mar 2008 13:33:11 +0100
From: Gaele Strootman <gaele@guruburu.com>
In-reply-to: <47E65680.1010102@guruburu.com>
To: bluez-users@lists.sourceforge.net
Message-id: <47ECE587.8070809@guruburu.com>
MIME-version: 1.0
References: <47E65680.1010102@guruburu.com>
Subject: Re: [Bluez-users] "Can't get device information: Too many links"
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

So far I haven't received any answer. Is this mailing list the right
platform to ask a question like the one below? I'm looking for an
explanation of Bluez error messages.


Gaele Strootman wrote:
> Hi,
>
> I have a problem connecting both an Apple wireless keyboard and mouse to
> an USB Bluetooth adapter on Ubuntu Gutsy (AMD64). I can connect either
> the mouse or keyboard, but not both. The error message I get is "Can't
> get device information: Too many links".
>
> Unfortunately I didn't find any explanation on Bluez error messages.
> What's going on?
>
> $ lsusb
> Bus 001 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> Dongle (HCI mode)
>
> $ hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:15:83:YY:YY:YY ACL MTU: 310:10 SCO MTU: 64:8
>         UP RUNNING PSCAN
>         RX bytes:59304 acl:2646 sco:0 events:568 errors:0
>         TX bytes:4847 acl:189 sco:0 commands:173 errors:0
>         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'slimpy-0'
>         Class: 0x080104
>         Service Classes: Capturing
>         Device Class: Computer, Desktop workstation
>         HCI Ver: 2.0 (0x3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP Subver:
> 0xc5c
>         Manufacturer: Cambridge Silicon Radio (10)
>
> $ hcitool scan
> Scanning ...
>         00:1E:52:XX:XX:XX       My Mouse
>
> $ sudo hidd --connect 00:1E:52:XX:XX:XX
> Can't get device information: Too many links
>
> I used instructions from a guy with the same setup, except for the USB
> adapter which is a D-Link DBT-120:
> http://travismetcalf.com/blog/2008/02/02/sharing-an-apple-keyboard-and-mouse-between-leopard-and-ubuntu/
>
> Any help appreciated.
>
> Gaele
>
>   


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

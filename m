Return-Path: <cyrus@holtmann.org>
Subject: Re: build issues with rtl8723au_bt
To: Bhuvanchandra <bhuvanchandradv@gmail.com>,
	linux-bluetooth@vger.kernel.org
References: <55ED8120.4060604@gmail.com>
Cc: bhuvanchandra.dv@gmail.com
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <55EE0161.8080402@lwfinger.net>
Date: Mon, 7 Sep 2015 16:28:01 -0500
MIME-Version: 1.0
In-Reply-To: <55ED8120.4060604@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 09/07/2015 07:20 AM, Bhuvanchandra wrote:
> Hi!
>
> I'm testing RTL8723BU(available in LM811. USB ID 0bda:b720) WiFi BT USB module.
> Kernel version used: 4.1.5. Cross-compiled the Wifi Driver from[1] it worked fine.
> While crosscompiling the driver for BT which is available at[2], there are few
> compile time errors:
> ....
> make ARCH=arm CROSS_COMPILE=/home/dvb/gcc-linaro/bin/arm-linux-gnueabihf- -C
> /home/dvb/linux-toradex M=/home/dvb/rtl8723au_bt modules
> make[1]: Entering directory
> '/home/dvb/toradex/linux-toradex/linux-toradex-vf/linux-toradex'
>    CC [M]  /home/dvb/rtl8723au_bt/btusb.o
> /home/dvb/rtl8723au_bt/btusb.c: In function 'hci_reassembly':
> /home/dvb/rtl8723au_bt/btusb.c:376:15: error: 'NUM_REASSEMBLY' undeclared (first
> use in this function)
>        index >= NUM_REASSEMBLY)
>                 ^
> /home/dvb/rtl8723au_bt/btusb.c:376:15: note: each undeclared identifier is
> reported only once for each function it appears in
> /home/dvb/rtl8723au_bt/btusb.c:379:12: error: 'struct hci_dev' has no member
> named 'reassembly'
>    skb = hdev->reassembly[index];
>              ^
> /home/dvb/rtl8723au_bt/btusb.c:405:7: error: 'struct hci_dev' has no member
> named 'reassembly'
>     hdev->reassembly[index] = skb;
>         ^
> /home/dvb/rtl8723au_bt/btusb.c:427:10: error: 'struct hci_dev' has no member
> named 'reassembly'
>        hdev->reassembly[index] = NULL;
>            ^
> /home/dvb/rtl8723au_bt/btusb.c:440:10: error: 'struct hci_dev' has no member
> named 'reassembly'
>        hdev->reassembly[index] = NULL;
>            ^
> /home/dvb/rtl8723au_bt/btusb.c:453:10: error: 'struct hci_dev' has no member
> named 'reassembly'
>        hdev->reassembly[index] = NULL;
>            ^
> /home/dvb/rtl8723au_bt/btusb.c:466:8: error: 'struct hci_dev' has no member
> named 'reassembly'
>      hdev->reassembly[index] = NULL;
>          ^
> scripts/Makefile.build:264: recipe for target '/home/dvb/rtl8723au_bt/btusb.o'
> failed
> make[2]: *** [/home/dvb/rtl8723au_bt/btusb.o] Error 1
> Makefile:1384: recipe for target '_module_/home/dvb/rtl8723au_bt' failed
> make[1]: *** [_module_/home/dvb/rtl8723au_bt] Error 2
> make[1]: Leaving directory
> '/home/dvb/toradex/linux-toradex/linux-toradex-vf/linux-toradex'
> Makefile-custom:22: recipe for target 'all' failed
> make: *** [all] Error 2
> .....
>
> I also tried the recent branches all got the same errors.
> Does any one tested RTL8723BU's bluetooth?

No. I have an RTL8723BU device on order. Once it arrives, I will be able to 
test. The vendor BT driver relies on some features that were removed in kernel 
4.1. As a proper driver for the Realtek BT devices is in kernel 4.2, I suggest 
that you use it, rather than 4.1.

> I couldn't find any in-tree driver available for RTL8723BU. Is there anything
> i'm missing or
> doing wrong ?

No, there is none. I refuse to submit any code that I have not tested. In 
addition, I doubt that the vendor driver will ever be submitted to staging. It 
is just too much work to clean up that ugly code. More likely, the device will 
be added to the new driver rtl8xxxu that has just been submitted.

Larry


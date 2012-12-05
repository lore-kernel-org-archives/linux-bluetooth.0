Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGm1_kva5xN1K0aDwvhaLBqW0qNCtdpQxp-ipzVRpLUD7XBVYw@mail.gmail.com>
References: <CAGm1_kva5xN1K0aDwvhaLBqW0qNCtdpQxp-ipzVRpLUD7XBVYw@mail.gmail.com>
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Wed, 5 Dec 2012 14:36:36 +0100
Message-ID: <CAGm1_kuAVCZUd9C=uzUwHvMFf4b8zuCHoGwx=h+TYH8RLExPWQ@mail.gmail.com>
Subject: Re: Cybertan MM230-M issue
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Nov 2, 2012 at 10:55 AM, Yegor Yefremov
<yegorslists@googlemail.com> wrote:
> I'm using this WLAN-BT-combo card with linux 3.2 and TI am335x based
> board. WLAN (88W8686/B1 (Marvell) ) is working, but Bluetooth
> (BC4ROM/21e (CSR)) only partly.
>
> I can connect to the card via hciattach ttyO5 bcsp and then I can
> bring it up and enable pscan. But hcitool scan delivers nothing.
>
> I get following values via bccmd:
>
> Chip revision: 0x0030 (BC4-ROM)
> Build name: odj_4hci_rom_bt2.0_21e_0604241634_encr128 2006-04-24
>
> bccmd -t BCSP -d /dev/ttyO5 -b 115200 enabletx returns with error:
> Can't execute command: No such device or address (6)
>
> Any idea how to get the card working?

When I execute hciattach I get following message:

root@arm:~# hciattach /dev/ttyO5 bcsp
Device setup complete
Bluetooth: Out-of-order packet arrived, got 1 expected 0

Is there any real tutorial for this chip? I found some related
threads, but would like to see the picture in whole or to get some
tips on how to debug my issue.

http://projects.goldelico.com/p/gta04-kernel/page/Wireless/
http://gumstix.8.n6.nabble.com/Bluetooth-on-2-6-39-pm-kernel-td4641950.html
http://permalink.gmane.org/gmane.linux.bluez.user/13460

Yegor

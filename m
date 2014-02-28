Return-Path: <cyrus@holtmann.org>
Message-ID: <5310FD93.3000407@gmail.com>
Date: Fri, 28 Feb 2014 21:20:19 +0000
From: Andrea <mariofutire@gmail.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: partial success with PS3 sixaxis
References: <52FBE820.6050701@gmail.com> <2534491.XllyezJg3g@uw000953> <52FF593F.30007@gmail.com> <4617658.ClQmBLQ0NT@uw000953>
In-Reply-To: <4617658.ClQmBLQ0NT@uw000953>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 28/02/14 10:47, Szymon Janc wrote:
> Hi Andrea,
> 
> 
> Failing probe is a problem here. Do you use same dongle on RaspPi as on Fedora?
> I've seen that DS3 is not playing well with some controllers i.e. it doesn't work
> with one on my CSR 2.0 USB dongle.

yes I seem to confirm it.

using kernel 3.10.xxx on Pi, the PS3 does not seem to work on any usb dongle

3.12 Fedora and 3.13 Pi with a CSR 4.0 it works (let's ignore the crashes on Pi which seems to be
related to Pi USB stack). No LEDs.

3.12 Fedora and 3.13 Pi with a CSR 2.0, it pairs, connects but /dev/input/js0 is only readable for a
few seconds then it stops reading events

3.13 Pi with a CSR 4.0 I sometimes get device timeout when I try "hciconfig hcio up"

What is strange here is that sixad was working with more dongles and more kernels.

So, to be concrete, my current issues are

1) no LEDs (you said it is going to be fixed in Linux 3.15)
2) CSR with dongle 2.0 produces a non usable /dev/input/js0
3) CSR 4.0 I cant always bring hci0 up

The 2 dongles I am using now are both reporting the same usb device id

0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)

although they are very different 2.0 vs 4.0

Anything I can do to narrow down these last issues?


> 
>> I am not too familiar with whom is responsible for /dev/input/js0? kernel? bluez? the sixaxis plugin?
> 
> Kernel. sixaxis plugin is used only to associate DS3 with host controller (and to set LEDs).
> 
>> Since this controller always works with the alternative sixad daemon, can I log the traffic and
>> compare it? or maybe post it here so some of you guys can help me?
> 
> Yeap, btmon logs could give us some more info what is going on.
> 


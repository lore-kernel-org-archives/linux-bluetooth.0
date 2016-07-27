Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Disappointing BLE throughput scheme/results
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <CABBYNZLyFJUv4gcnvfM+61MZ=VGTK27YWd8cbn5Awsb6UZtv5g@mail.gmail.com>
Date: Wed, 27 Jul 2016 16:34:33 -0700
Message-Id: <14CC0C8F-490C-45EE-9D96-EB48439D5293@gmail.com>
References: <1468500345-5833-1-git-send-email-luiz.dentz@gmail.com> <812914A8-66C2-4343-8A1B-FB6EC1905DFE@gmail.com> <CABBYNZLyFJUv4gcnvfM+61MZ=VGTK27YWd8cbn5Awsb6UZtv5g@mail.gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Jul 19, 2016, at 4:48 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> 
> Try using l2test:
> 
> /* Central */
> ./l2test -i 0 -s -V le_public -P 128 <peripheral bdaddr>
> 
> /* Peripheral */
> - Make sure it is advertising an it is connectable
> ./l2test -t -V le_public -P 128
> 
> The results for me is the following:
> l2test[1532]: Options [imtu 672, omtu 672, flush_to 0, mode 0, handle
> 74, class 0x000000, priority 0, rcvbuf 212992]
> l2test[1532]: Sending ...
> l2test[1533]: Receiving ...
> l2test[1533]: 672 bytes in 0.70 sec, 0.94 kB/s
> l2test[1533]: 672 bytes in 0.49 sec, 1.34 kB/s
> l2test[1533]: 672 bytes in 0.42 sec, 1.55 kB/s
> l2test[1533]: 672 bytes in 0.63 sec, 1.05 kB/s
> l2test[1533]: 672 bytes in 0.63 sec, 1.04 kB/s
> l2test[1533]: 672 bytes in 0.49 sec, 1.34 kB/s
> l2test[1533]: 672 bytes in 0.56 sec, 1.17 kB/s
> l2test[1533]: 672 bytes in 0.63 sec, 1.04 kB/s
> l2test[1533]: 672 bytes in 0.49 sec, 1.35 kB/s
> l2test[1533]: 672 bytes in 0.70 sec, 0.93 kB/s
> l2test[1533]: 672 bytes in 0.49 sec, 1.35 kB/s
> l2test[1533]: 672 bytes in 0.49 sec, 1.34 kB/s
> l2test[1533]: 672 bytes in 0.77 sec, 0.86 kB/s
> l2test[1533]: 672 bytes in 0.43 sec, 1.54 kB/s
> l2test[1533]: 672 bytes in 0.77 sec, 0.86 kB/s
> l2test[1533]: 672 bytes in 0.56 sec, 1.17 kB/s
> l2test[1533]: 672 bytes in 0.63 sec, 1.04 kB/s
> 
> So very slow indeed, but that is using the default connection
> parameters which are probably not good for transfer speed.


Finally got to the point where I could run this. I ran the test between two of my SBCs. I got numbers similar to yours, but it only seemed to do about half as many before having connection issues. Not sure what that was about.

Being a neophyte at this, here’s what a little googling has led me to believe. Please correct as appropriate.

L2CAP is a lower level layer that works over both BTClassic as well as BLE? If you have it, you can create channels and stream data between the two.

This l2test gives an idea of what the current bluez stack, my particular usb ble dongle and host hardware MIGHT be able to achieve. It shows that ~1kB/s is achievable in some situation. It may be possible to go faster, but that is unknown. And I’ve already proved I can go slower. :)

It does not appear that iOS (or Android?) have any (or at least strong) support for L2CAP, so while this might give a demonstration, I wouldn’t be able to use it between handhelds and the linux SBC running bluez as a peripheral. So I’ll need to figure out a way to make the bluez gatt characteristics go as fast as possible.

Any useful hints on where I might instrument what to see where the time is being spent?
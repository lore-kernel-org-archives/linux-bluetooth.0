Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Apr 2009 20:19:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Stuart Pook <linux-bluetooth4@pook.es>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez 4.34 + Linksys USBBT100 + hcitool scan -> core dump
Message-ID: <20090405171936.GA6612@jh-x301>
References: <49D89DCD.7090808@pook.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49D89DCD.7090808@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

On Sun, Apr 05, 2009, Stuart Pook wrote:
> I have a Linksys (Cisco) USBBT100 Bluetooth 1.1 Adapter which has a 1.2 dBi
> antenna. I used to use it with Bluez 3 and it had a better range than my
> Belkin F8T017. It used to work (but not for audio) with older versions of
> bluez 4. I tried it again with bluez 4.34 and now a simple "hcitool scan"
> makes bluetoothd core dump.
>
> Bluetoothd does not crash when I swap my USBBT100 for my F8T017. A hcitool
> scan does however find fewer hosts.
>
> It would be great if my USBBT100 worked again. Please let me know if I can
> send any more information.

Thanks for the report! Unfortunately the valgrind report doesn't give too much
clues (except that this might be a stack overflow). Could you try and see if
this is reproducable with the latest git? You don't necessarily need to install
it, just compile with "./bootstrap-configure && make" and run the compiled
bluetoothd directly from the tree. Also, if you still don't manage to make
valgrind give you something sensible you could also try with gdb to see if it
works better in producing backtrace.

Johan

Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Jamin Collins <jamin.collins@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bluetooth related possible system hard lockups
In-Reply-To: <CAG7CpCj5o6Z6zPXmotVu+tTsW8BQeRFNM8Re1MUDv-US4LUaeg@mail.gmail.com>
References: <CAG7CpCj5o6Z6zPXmotVu+tTsW8BQeRFNM8Re1MUDv-US4LUaeg@mail.gmail.com>
Date: Wed, 19 Aug 2015 19:54:05 -0300
Message-ID: <87twrurisy.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jamin,

Jamin Collins <jamin.collins@gmail.com> writes:

> I've recently started experiencing what appear to be hard lockups on
> what has otherwise been a very solid system (Lenovo W530 Thinkpad).
> I'm running a fully updated Arch Linux install on it, and have been
> for a few months (since roughly April of this year).  Just before
> experiencing these lockups I started using a bluetooth mouse.
>
> When the apparent lockup occurs:
> - the laptop screen seems to be off (no display)
> - the CPU fan is running at a moderate speed (not the slowest, and not
> the fastest)
> - no apparent disk activity
> - nothing in journalctl (when I hard reset I find only a gap, last
> entry hours before)
> - unresponsive to network requests (ping, etc)
>
> The only way I've found to recover the system thus far is a hard reset
> (hold power for 4+ seconds).
>

Without more information (the backtrace of the crash, from the kernel
logs or even a picture of the screen showing the crash dump), it is hard
to be sure. I can only guess.

This looks like this issue (for one colleague on a very similar setup as
yours, it was the case):

http://thread.gmane.org/gmane.linux.kernel.input/45023

I just checked, that patch is in the stable queue, and for little it
missed the 4.1.6 deadline, but it should appear on 4.1.7 (if it is
released) or 4.2 (for sure).

You can also apply that patch locally and see if solves your problem,
or you can give the input subsystem kernel tree a try:

https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git


Cheers,
--
Vinicius

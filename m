Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAG7CpCj5o6Z6zPXmotVu+tTsW8BQeRFNM8Re1MUDv-US4LUaeg@mail.gmail.com>
References: <CAG7CpCj5o6Z6zPXmotVu+tTsW8BQeRFNM8Re1MUDv-US4LUaeg@mail.gmail.com>
Date: Wed, 19 Aug 2015 14:09:01 -0700
Message-ID: <CAG7CpCjOFxnO3UhMszmbuDXB6m2aF16p4rNAbhmkhrzcakyBjw@mail.gmail.com>
Subject: Re: Bluetooth related possible system hard lockups
From: Jamin Collins <jamin.collins@gmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Issue Update

I have not been successful in reproducing the issue *without*
connecting a bluetooth device at least once.

I have however actually witnessed the lockup now:
- the screen does *not* turn off as part of the lockup
- initially the keyboard was non-responsive
- after a few seconds of use the jmouse stopped responding
- was able to momentarily reconnect the bluetooth mouse and then it
too stopped responding

On Wed, Aug 19, 2015 at 1:04 PM, Jamin Collins <jamin.collins@gmail.com> wrote:
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
> I know it involves bluetooth being on, possibly requires having
> connected a device, and then some indeterminate amount of time away
> from the system (lack of user interaction).  I'm currently testing
> with bluetooth on, but no device connected to see if the issue occurs.
>
> The kernel in question:
> Linux version 4.1.5-1-ARCH (builduser@tobias) (gcc version 5.2.0 (GCC)
> ) #1 SMP PREEMPT Tue Aug 11 15:41:14 CEST 2015
>
> Bluetooth:
> Bluetooth daemon 5.33
>
> The bluetooth device I've been using is a Thinkpad Bluetooth Laser Mouse:
> ThinkPad Bluetooth Laser Mouse as
> /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4:1.0/bluetooth/hci0/hci0:11/0005:17EF:6002.0001/input/input19
>
> I'm not subscribed to this list, so please CC me on replies.

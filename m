Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120214180937.GA17364@smtp.free.fr>
References: <20120214164518.GA11881@smtp.free.fr>
	<CANq1E4QEeoFr4HC+DajcsPt_BNNgzsp8-_7tRFVOOVin1atTEA@mail.gmail.com>
	<20120214175813.GA16393@smtp.free.fr>
	<CANq1E4Q7UQjQNKPy0c-w4DX8dimuRNYB_mOsetMBNPaY44Ae5A@mail.gmail.com>
	<20120214180937.GA17364@smtp.free.fr>
Date: Tue, 14 Feb 2012 19:15:56 +0100
Message-ID: <CANq1E4R0xkzJF8CebBFkc5R=idO=cEPciK2XQW9Yv9nWuWGnGw@mail.gmail.com>
Subject: Re: Entering the PIN of a device?
From: David Herrmann <dh.herrmann@googlemail.com>
To: Fabrice DELENTE <delentef@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabrice

On Tue, Feb 14, 2012 at 7:09 PM, Fabrice DELENTE <delentef@gmail.com> wrote:
>> Please answer directly to the mailing-list instead of directly to me
>> ("Reply to All") if you want others to read your messages, too.
>
> Sorry, I thought the CC to linux-bluetooth was enough!

There was no CC ;) CC is enough of course.

>> Then you need to use the kernel driver. The Wii Remote uses 2 L2CAP
>> channels so don't try rfcomm.
>
> Ok, I'll look into docs about L2CAP.

No, don't! The user shouldn't care what protocols are used. I just wanted to
notify you that using rfcomm won't work here.

>> The driver is located in ./drivers/hid/hid-wiimote* in the kernel
>> sources. The user-space utilities are currently under
>> development. See http://github.com/dvdhrm/xwiimote for more
>> information.  To use the Wii Remote you need to connect to the Wii
>> Remote with a tool like simple-agent, gnome-bluetooth, blueman or
>> similar. The kernel driver and BlueZ stack will directly detect the
>> Wii Remote. See "dmesg" for information whether the device was
>> detected. It should also show up as new directory in
>> /sys/bus/hid/devices/<did>
>
> Thanks for the info.
>
> My trouble is that when I start simple-agent and then push 1+2 to pair
> the wiimote with my laptop, simple-agent doesn't ask for the
> PIN... should it happens automagically?

This is exactly what should happen, yes. No PIN as BlueZ generates it for you.

> I have grepped the files in /var/lib/bluetooth, I have found my mote
> BT address in the files but nothing clearly linked to the PIN key. I
> read on wiimote-brew that it was the mote BT address in binary form?

Did the device show up in /sys/bus/hid/devices ? Did you check dmesg? I think
you got the device connected successfully, it just doesn't do anything useful
without configuration ;)

> Thanks again! :^)

You may also want to have a look at
https://wiki.archlinux.org/index.php/XWiimote
This is a short summary of the current state of the xwiimote drivers.
The user-space
part is still under development so you might want to look at cwiid instead.

Cheers
David

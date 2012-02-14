Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 19:09:37 +0100
From: Fabrice DELENTE <delentef@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Entering the PIN of a device?
Message-ID: <20120214180937.GA17364@smtp.free.fr>
References: <20120214164518.GA11881@smtp.free.fr>
 <CANq1E4QEeoFr4HC+DajcsPt_BNNgzsp8-_7tRFVOOVin1atTEA@mail.gmail.com>
 <20120214175813.GA16393@smtp.free.fr>
 <CANq1E4Q7UQjQNKPy0c-w4DX8dimuRNYB_mOsetMBNPaY44Ae5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CANq1E4Q7UQjQNKPy0c-w4DX8dimuRNYB_mOsetMBNPaY44Ae5A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Please answer directly to the mailing-list instead of directly to me
> ("Reply to All") if you want others to read your messages, too.

Sorry, I thought the CC to linux-bluetooth was enough!

> Then you need to use the kernel driver. The Wii Remote uses 2 L2CAP
> channels so don't try rfcomm.

Ok, I'll look into docs about L2CAP.

> The driver is located in ./drivers/hid/hid-wiimote* in the kernel
> sources. The user-space utilities are currently under
> development. See http://github.com/dvdhrm/xwiimote for more
> information.  To use the Wii Remote you need to connect to the Wii
> Remote with a tool like simple-agent, gnome-bluetooth, blueman or
> similar. The kernel driver and BlueZ stack will directly detect the
> Wii Remote. See "dmesg" for information whether the device was
> detected. It should also show up as new directory in
> /sys/bus/hid/devices/<did>

Thanks for the info.

My trouble is that when I start simple-agent and then push 1+2 to pair
the wiimote with my laptop, simple-agent doesn't ask for the
PIN... should it happens automagically?

I have grepped the files in /var/lib/bluetooth, I have found my mote
BT address in the files but nothing clearly linked to the PIN key. I
read on wiimote-brew that it was the mote BT address in binary form?

Thanks again! :^)

-- 
F. Delente

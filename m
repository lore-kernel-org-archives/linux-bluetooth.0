Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKafyqpW_dO6kLpZiSVnx1OFG4mSgtQTWd9Y9PSDh5L1eRMkUg@mail.gmail.com>
References: <CAKafyqpW_dO6kLpZiSVnx1OFG4mSgtQTWd9Y9PSDh5L1eRMkUg@mail.gmail.com>
Date: Tue, 24 Mar 2015 18:42:32 +0530
Message-ID: <CAKafyqqc1-gr7HwfUhBTPNQ1QSOfAqgXhXUSNDjU+F_ftp=nVQ@mail.gmail.com>
Subject: Re: Querry : HID Over GATT (HoG)
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

    I am trying to connect a BT LE Keyboard and Mouse to my embedded
target, I have enabled the kernel configurations for HIDP and HID RAW
drivers, and I am seeing /dev/uhid node.

I built the units/test-uhid.c and run, I didn't understand the output
and there was no error given.

I am running Bluez 5.28 and Linux kernel 3.8.13.

I tried ./samples/uhid/uhid-example.c from kernel source tree, but I
dint get how can I use it.
Any example that would  help me pair and connect LE HID devices will be helpful.


ManyThanks,
Prabhu

On Tue, Mar 24, 2015 at 6:36 PM, Prabhu Chawandi <foss.chaws@gmail.com> wrote:
> Hi,
>
>     I am trying to connect a BT LE Keyboard and Mouse to my embedded target,
> I have enabled the kernel configurations for HIDP and HID RAW drivers, and I
> am seeing /dev/uhid node.
>
> I built the units/test-uhid.c and run, I didn't understand the output and
> there was no error given.
>
> I am running Bluez 5.28 and Linux kernel 3.8.13.
>
> I tried ./samples/uhid/uhid-example.c from kernel source tree, but I dint
> get how can I use it.
> Any example that would  help me pair and connect LE HID devices will be
> helpful.
>
>
> ManyThanks,
> Prabhu

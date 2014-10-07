Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAG0bkvKJZMhurNNpc_2wgaACRzhyEikb0G0YSY7QnxqBe1rnjw@mail.gmail.com>
References: <CAG0bkvK4-gfeYXXsdNg4BKdjxmo1e5d8rKuABohtYNNBHKJwDA@mail.gmail.com>
	<1412598268.1132.15.camel@linux-0dmf.site>
	<CAG0bkv+nKt-TgONDLENNUncz9NScdJGcYR+J2Z6b=wg2grvqhg@mail.gmail.com>
	<1412600108.28177.0.camel@linux-0dmf.site>
	<CAG0bkvK=fumhJNzuSgx=HFHiVP08V+QH2wLajdffx+f5ugoQPQ@mail.gmail.com>
	<1412602169.28177.2.camel@linux-0dmf.site>
	<CAG0bkv+d9SxToWpk49s=C-w_aA4zbP_RvV_8kcgV254rsvHR0A@mail.gmail.com>
	<1412607050.1743.1.camel@linux-0dmf.site>
	<CAG0bkvKJZMhurNNpc_2wgaACRzhyEikb0G0YSY7QnxqBe1rnjw@mail.gmail.com>
Date: Tue, 7 Oct 2014 12:14:26 +0530
Message-ID: <CAG0bkv+_t8CqM9w5N1hKJtT=_mQmtWWCPe-9jSHuOkNZCL3B9A@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> +       err = usb_clear_halt(data->udev,
> +                            usb_rcvbulkpipe(data->udev,
> +                                            data->intr_ep->bEndpointAddress));

EPIPE occurred for INT in endpoint, so we should use usb_rcvintpipe()
instead of usb_rcvbulkpipe() right?


Does the “lsusb –v” gives any clue about the reason for getting -EPIPE?

Thanks,
Naveen



On Mon, Oct 6, 2014 at 8:42 PM, Naveen Kumar Parna <pnaveenkos@gmail.com> wrote:
> Attached the lsusb -v file.
>
> Captured the usbmon log file for this patch and attached it.
>
>
>
> Thanks,
>
> Naveen
>
> On Mon, Oct 6, 2014 at 8:20 PM, Oliver Neukum <oneukum@suse.de> wrote:
>> On Mon, 2014-10-06 at 20:08 +0530, Naveen Kumar Parna wrote:
>>> Thanks for the patch.
>>>
>>> I tried and It crashed after the first occurrence of EPIPE.
>>>
>>> Crash log is attached.
>>
>> Could you post a full "lsusb -v"?
>>
>>         Regards
>>                 Oliver
>>
>>

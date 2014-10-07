Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412676071.1926.1.camel@linux-0dmf.site>
References: <CAG0bkvK4-gfeYXXsdNg4BKdjxmo1e5d8rKuABohtYNNBHKJwDA@mail.gmail.com>
	<1412598268.1132.15.camel@linux-0dmf.site>
	<CAG0bkv+nKt-TgONDLENNUncz9NScdJGcYR+J2Z6b=wg2grvqhg@mail.gmail.com>
	<1412600108.28177.0.camel@linux-0dmf.site>
	<CAG0bkvK=fumhJNzuSgx=HFHiVP08V+QH2wLajdffx+f5ugoQPQ@mail.gmail.com>
	<1412602169.28177.2.camel@linux-0dmf.site>
	<CAG0bkv+d9SxToWpk49s=C-w_aA4zbP_RvV_8kcgV254rsvHR0A@mail.gmail.com>
	<1412607050.1743.1.camel@linux-0dmf.site>
	<CAG0bkvKJZMhurNNpc_2wgaACRzhyEikb0G0YSY7QnxqBe1rnjw@mail.gmail.com>
	<CAG0bkv+_t8CqM9w5N1hKJtT=_mQmtWWCPe-9jSHuOkNZCL3B9A@mail.gmail.com>
	<1412676071.1926.1.camel@linux-0dmf.site>
Date: Tue, 7 Oct 2014 19:04:32 +0530
Message-ID: <CAG0bkvKYT5+ZBZwdvG71g98CqZR03er6rN4y5RRfq6UUL5KnCw@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for the new patch.



The new patch clears the halt condition. But after submitting the urb
again the INT in endpoint returns EPIPE, this behavior continues
infinitely.



Corresponding kernel log is here:

Oct  7 17:58:41 naveen-OptiPlex-745 kernel: [   16.311863] hci0 urb
ffff88012f670b40 status -32 count 0

Oct  7 17:58:41 naveen-OptiPlex-745 kernel: [   16.311988] hci5 urb
ffff8801379d2180 status -32 count 0

Oct  7 17:58:41 naveen-OptiPlex-745 kernel: [   16.455464] hci4 urb
ffff88012a4b2e40 status -32 count 0

Oct  7 17:58:41 naveen-OptiPlex-745 kernel: [   16.455586] hci1 urb
ffff88012a4b2180 status -32 count 0

Oct  7 17:58:41 naveen-OptiPlex-745 kernel: [   16.455691] hci2 urb
ffff88012f670480 status -32 count 0

Oct  7 17:58:41 naveen-OptiPlex-745 kernel: [   16.455784] hci3 urb
ffff88012f670e40 status -32 count 0

Oct  7 17:58:41 naveen-OptiPlex-745 kernel: [   16.455853] hci0 urb
ffff880131e5ee40 status -32 count 0

Oct  7 17:58:41 naveen-OptiPlex-745 kernel: [   16.455913] hci5 urb
ffff880131e5e780 status -32 count 0

Oct  7 17:58:44 naveen-OptiPlex-745 kernel: [   19.690366] hci4 urb
ffff880131e5e780 status -32 count 0

Oct  7 17:58:44 naveen-OptiPlex-745 kernel: [   19.690490] hci5 urb
ffff880131e5e300 status -32 count 0

Oct  7 17:58:47 naveen-OptiPlex-745 kernel: [   22.163163] hci5 urb
ffff88012f541540 status -32 count 0

Oct  7 18:06:01 naveen-OptiPlex-745 kernel: [   45.313996] hci1 urb
ffff880131e5ee40 status -32 count 0

Oct  7 18:06:01 naveen-OptiPlex-745 kernel: [   45.314121] hci0 urb
ffff880131e5e900 status -32 count 0

Oct  7 18:06:01 naveen-OptiPlex-745 kernel: [   45.314169] hci3 urb
ffff880131e5e3c0 status -32 count 0

Oct  7 18:06:01 naveen-OptiPlex-745 kernel: [   45.314213] hci2 urb
ffff880131e5ef00 status -32 count 0

Oct  7 18:06:01 naveen-OptiPlex-745 kernel: [   45.314245] hci4 urb
ffff88012f541d80 status -32 count 0

Oct  7 18:06:01 naveen-OptiPlex-745 kernel: [   45.314274] hci5 urb
ffff88012f541540 status -32 count 0

Oct  7 18:06:01 naveen-OptiPlex-745 kernel: [   45.319974] hci2 urb
ffff8801384dcb40 status -32 count 0

Oct  7 18:06:01 naveen-OptiPlex-745 kernel: [   45.320095] hci0 urb
ffff8801384dc300 status -32 count 0

Oct  7 18:06:01 naveen-OptiPlex-745 kernel: [   45.320151] hci4 urb
ffff8801384dc6c0 status -32 count 0

Oct  7 18:06:01 naveen-OptiPlex-745 kernel: [   45.320193] hci5 urb
ffff8801384dcf00 status -32 count 0



Thanks,

Naveen

On Tue, Oct 7, 2014 at 3:31 PM, Oliver Neukum <oneukum@suse.de> wrote:
> On Tue, 2014-10-07 at 12:14 +0530, Naveen Kumar Parna wrote:
>> > +       err = usb_clear_halt(data->udev,
>> > +                            usb_rcvbulkpipe(data->udev,
>> > +                                            data->intr_ep->bEndpointAddress));
>>
>> EPIPE occurred for INT in endpoint, so we should use usb_rcvintpipe()
>> instead of usb_rcvbulkpipe() right?
>
> Yes. And I noticed a copy and past error.
>
>> Does the “lsusb –v” gives any clue about the reason for getting -EPIPE?
>
> No. Could you nevertheless test the attached version?
>
>         Regards
>                 Oliver
>

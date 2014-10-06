Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412600108.28177.0.camel@linux-0dmf.site>
References: <CAG0bkvK4-gfeYXXsdNg4BKdjxmo1e5d8rKuABohtYNNBHKJwDA@mail.gmail.com>
	<1412598268.1132.15.camel@linux-0dmf.site>
	<CAG0bkv+nKt-TgONDLENNUncz9NScdJGcYR+J2Z6b=wg2grvqhg@mail.gmail.com>
	<1412600108.28177.0.camel@linux-0dmf.site>
Date: Mon, 6 Oct 2014 18:33:29 +0530
Message-ID: <CAG0bkvK=fumhJNzuSgx=HFHiVP08V+QH2wLajdffx+f5ugoQPQ@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you very much. I will try that patch.



Thanks,
Naveen

On Mon, Oct 6, 2014 at 6:25 PM, Oliver Neukum <oneukum@suse.de> wrote:
> On Mon, 2014-10-06 at 18:18 +0530, Naveen Kumar Parna wrote:
>> Hi,
>>
>> I just collected the usbmon log(1.mon.out) and attached it. It stalls
>> for INT in transfers.
>>
>> Corresponding kernel log is here:
>> Oct  6 18:00:48 naveen-OptiPlex-745 kernel: [ 7528.718473] hci3 urb
>> ffff88012954dd80 status -32 count 0
>> Oct  6 18:05:35 naveen-OptiPlex-745 kernel: [ 7814.688122] hci3 urb
>> ffff88012954dd80 status -32 count 0
>> Oct  6 18:05:35 naveen-OptiPlex-745 kernel: [ 7814.693086] hci3 urb
>> ffff88012954dd80 status -32 count 0
>> Oct  6 18:05:35 naveen-OptiPlex-745 kernel: [ 7814.695058] hci3 urb
>> ffff88012954dd80 status -32 count 0
>> Oct  6 18:05:35 naveen-OptiPlex-745 kernel: [ 7814.703073] hci3 urb
>> ffff88012954dd80 status -32 count 0
>> Oct  6 18:05:35 naveen-OptiPlex-745 kernel: [ 7814.717038] hci5 urb
>> ffff88012954de40 status -32 count 0
>> Oct  6 18:05:35 naveen-OptiPlex-745 kernel: [ 7814.717496] hci3 urb
>> ffff88012954dd80 status -32 count 0
>>
>> Corresponding Usbmon trace:
>> ffff88012954dd80 2936526502 C Ii:1:009:1 -32:1 0
>> ffff88012954dd80 3223215374 C Ii:1:009:1 -32:1 0
>> ffff88012954dd80 3223220352 C Ii:1:009:1 -32:1 0
>> ffff88012954dd80 3223222332 C Ii:1:009:1 -32:1 0
>> ffff88012954dd80 3223230362 C Ii:1:009:1 -32:1 0
>> ffff88012954de40 3223244362 C Ii:1:019:1 -32:1 0
>> ffff88012954dd80 3223244830 C Ii:1:009:1 -32:1 0
>>
>> Does it gives any clue?
>
> Not really. I'll make a patch to clear the condition.
> Let's see what happens then.
>
>         Regards
>                 Oliver
>
>

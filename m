Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <C1E229B1-274F-4B5B-81EA-A546488B07DD@holtmann.org>
References: <CANzaTi6_OF9C6DjPeRqaoUBKqdJZSQ+0k0cJLodWS3o5LzTsbw@mail.gmail.com>
	<20150716105937.GA18341@t440s.lan>
	<CANzaTi5gK457ZJP5V_ty6ufSzm2LmX6wsfVracqR0MwDZS6jyg@mail.gmail.com>
	<20150716131004.GA28916@t440s.P-661HNU-F1>
	<C1E229B1-274F-4B5B-81EA-A546488B07DD@holtmann.org>
Date: Fri, 17 Jul 2015 17:03:33 +0200
Message-ID: <CANzaTi6s3W1Q4sPZW9U32-oV8qmqDYYTdcDD8yNEohuH1PND7A@mail.gmail.com>
Subject: Re: Advertising API, possible to set LE only?
From: dogan yazar <doganyazar@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jul 16, 2015 at 10:39 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Johan,
>
>>> Thanks a lot for the answer. That is exactly what I need.  However
>>> putting in the main.conf did not really make any reference and trying
>>> the btmgmt returns "Rejected"
>>> [mgmt]# bredr off
>>> Set BR/EDR for hci0 failed with status 0x0b (Rejected)
>>>
>>> Any idea why? Is it controller related?
>>
>> First of all, please don't top-post on this list. I think you need to
>> power off the adapter before you can disable BR/EDR, i.e. "btmgmt power
>> off".

Thanks! This worked well. Any hints for me to track down why
"ControllerMode=le in the [General] section of
/etc/bluetooth/main.conf" did not work fine? Running a shell command
from our software is not a very neat solution.


>
> actually you need to power off the controller, enable LE and only then you can turn off BR/EDR. Of course you require a dual-mode BR/EDR + LE controller in the first place to do this.

This is also good to know. Thanks! LE was enabled by default so did
not need it this time.

>
> Regards
>
> Marcel
>

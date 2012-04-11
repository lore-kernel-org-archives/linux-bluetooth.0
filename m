Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334136286.16897.98.camel@aeonflux>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334126932-27327-5-git-send-email-mikel.astiz.oss@gmail.com>
	<1334136286.16897.98.camel@aeonflux>
Date: Wed, 11 Apr 2012 14:43:47 +0300
Message-ID: <CABBYNZJFYJGWWLvOoAfkKJm7KR6-c4dJLObdF8UsD47WyFe2kQ@mail.gmail.com>
Subject: Re: [PATCH v0 4/6] Bluetooth: Simplify outgoing SCO scheduling code
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>, linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel, Marcel,

On Wed, Apr 11, 2012 at 12:24 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mikel,
>
>> This patch refactors the SCO scheduling algorithm to remove code that is
>> not making any difference. There is no HCI SCO flow control in the
>> kernel so the scheduling can be simplified.
>>
>> All data produced by userspace is sent to the controller without any
>> flow control. This was also the case before this patch, but now it's
>> more obvious and readable.
>
> as in the previous patch. You can only do this if you make sure that the
> controller does not have flow control enabled. You need another basic
> check here to ensure this first. Otherwise a lot of things might break.

It also seems to remove any quote/fairness of the scheduling, actually
Im not sure how it works because it sends the frames regardless of the
number of available slots/buffers indicated by sco_cnt, I also wonder
how it will scale with multiple SCO connections, even though it is
quite rare to have more than one who knows what crazy ideas people
will come.

-- 
Luiz Augusto von Dentz

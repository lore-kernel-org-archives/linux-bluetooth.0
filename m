Return-Path: <cyrus@holtmann.org>
Message-ID: <51306800.3050805@tieto.com>
Date: Fri, 1 Mar 2013 09:34:08 +0100
From: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <20130220075725.GA14731@x220> <512F62E0.1030706@tieto.com> <20130228141847.GA24103@x220>
In-Reply-To: <20130228141847.GA24103@x220>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> You might want to fix those in a separate patch set then. Just because
> something is in the source tree doesn't mean that it's worth copying
> into new code/documentation.

Will do so.

> Couldn't you just return a "NotSupported" error to
> EnableIntermediateMeasurement?

Sure, it could. It's rather cosmetic change then big one.

>> Similarly as in thermometer api.
>
> I suspect there are several messed up LE APIs and implementations in the
> source tree, so I'd say it's highly advisable to not just blindly copy
> from the existing code but also use some common sense and be critical of
> what you see.

I wouldn't say this particular api is messed up. For me it looks sane. 
It's rather the matter of approach than blind copy/paste.

If something existing make sense and is pretty rational then should be 
used. You can always code one thing in many ways which differ only in 
details.

Proposed 'NotSupported" seems fine as well. I can go for it and remove 
BloodPressure1 interface totally.

Any more comments before I will send v2 ?

Thanks,
/Waldek






Return-Path: <cyrus@holtmann.org>
Message-ID: <70400021c330cb81dde63d07727bb7c1.squirrel@www.codeaurora.org>
In-Reply-To: <20100805102513.GA7221@jh-x301>
References: <1280962831-18147-1-git-send-email-ingas@codeaurora.org>
    <1280962831-18147-8-git-send-email-ingas@codeaurora.org>
    <20100805102513.GA7221@jh-x301>
Date: Thu, 5 Aug 2010 14:26:31 -0700 (PDT)
Subject: Re: [PATCH 7/7] Add service UUIDs from EIR to device properties in
     "Device Found" signal.
From: ingas@codeaurora.org
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> I've pushed the six other patches upstream, but I'm still a bit
> concerned with this one.
>

Thanks :)

>
> Then, a more general concern about this function. It will receive data
> as input that any nearby device that's discoverable has declared in
> their EIR data. I.e. we need to be super strict about checking the
> validity of the data and not make any assumptions about the correctness
> of encoded field lengths etc. in order not to do buffer overflows. Have
> you taken this into account when designing the function? Looking at it
> it seems it might be possible to give it data that will cause some
> buffer overflows (by e.g. placing a uuid list at the very end of the EIR
> data with an invalid field length value).
>

I agree. Adding few more checks there. Will send a new patch today.

Inga


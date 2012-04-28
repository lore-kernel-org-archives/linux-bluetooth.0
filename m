Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120428094310.GA7293@x220.P-661HNU-F1>
References: <1335547341-19459-1-git-send-email-puffy.taco@gmail.com>
	<20120428094310.GA7293@x220.P-661HNU-F1>
Date: Sat, 28 Apr 2012 10:58:11 -0500
Message-ID: <CAB7rCTi743ZsxiE4y=1mH=o1-YqxD-DA08pAW7Xfx3A-NgxopA@mail.gmail.com>
Subject: Re: [PATCH] audio: Fix AVDTP General Reject message
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> As per spec, bits other than Transaction Label and Packet Type are RFA. This
>> fixes the RFA bits which were previously set to the invalid signal_id.
>>
>> Test case TP/SIG/SMG/BI-28-C.
>> ---
>>  audio/avdtp.c |   11 +++++------
>>  1 files changed, 5 insertions(+), 6 deletions(-)
>
> See commit 998b0976e28cd33cbfd2f71b6f27a162da6fe668
>
> This is how BlueZ used to behave until ESR04 was released (still
> available on bluetooth.org adopted specs page) which clarified the AVDTP
> 1.0 specification (both profile and test spec) to define general reject
> as containing the signal id. For whatever reason it seems like the
> content of ESR04 never made it the the 1.2 spec version. I'd like to get
> some clarity on this, i.e. was the errata dropped on purpose or by
> mistake.

I think this [1] covers it.  It looks like they are in the process of
adding a new PICS option that declares support for ESR04, but it's not
quite there yet which is why my test plan had TP/SIG/SMG/BI-28-C.  The
ESR04 test case (TP/SIG/SMG/ESR04/BI-28-C) is already in the test
spec.  You can drop this patch.

Thanks!
Mike

[1] https://www.bluetooth.org/tse/errata_view.cfm?errata_id=2834

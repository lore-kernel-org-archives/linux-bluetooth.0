Return-Path: <cyrus@holtmann.org>
Message-ID: <f2726c88094b005363760fd17f9d1057.squirrel@www.codeaurora.org>
In-Reply-To: <20100806173042.GA28198@jh-x301>
References: <20100805102513.GA7221@jh-x301>
    <1281047801-4044-1-git-send-email-ingas@codeaurora.org>
    <20100806075552.GA22150@jh-x301>
    <1844054b1cfff4c91e67223013eb09ac.squirrel@www.codeaurora.org>
    <20100806173042.GA28198@jh-x301>
Date: Fri, 6 Aug 2010 11:18:26 -0700 (PDT)
Subject: Re: [PATCH 7/7] Add service UUIDs from EIR to device properties in
     "Device Found" signal.
From: ingas@codeaurora.org
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>
> There's still however one issue (I only now tried to compile the patch):
>
> src/adapter.c: In function ‘get_eir_uuids’:
> src/adapter.c:2810: error: comparison between signed and unsigned integer
> expressions
> src/adapter.c:2820: error: comparison between signed and unsigned integer
> expressions
> src/adapter.c:2833: error: comparison between signed and unsigned integer
> expressions
> make[1]: *** [src/adapter.o] Error 1
>
> Could you please fix it and always in the future ensure that the code
> compiles cleanly when configured with ./bootstrap-configure. Also, could
> you make the commit message more descriptive. The summary line should be
> a very short summary of what the patch is about and the more detailed
> description should be in the message body.
>

Oops, sorry about that: I was using bootstrap and configure as separate
scripts. Apparently the warning level is not set high enough in there.
Will fix and resubmit.

Regards,

Inga




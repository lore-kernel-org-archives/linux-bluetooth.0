Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1397724982-9238-1-git-send-email-sebastian.chlad@tieto.com>
References: <1397724982-9238-1-git-send-email-sebastian.chlad@tieto.com>
Date: Thu, 17 Apr 2014 11:18:45 +0200
Message-ID: <CAJCsO8e+y2UNRdu8tGNdHM+R+71MhkJAUPzCB9xrnBpQgAyt_A@mail.gmail.com>
Subject: Re: [PATCH] OPP regression or PTS issues
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've created an issue: https://01.org/jira/browse/BZ-10 with some logs attached.

On 17 April 2014 10:56, Sebastian Chlad <sebastian.chlad@tieto.com> wrote:
> There were some major changes between PTS 5.0 and 5.1 for OPP. Some PICS were
> added as well as some tests cases. While doing the regression tests I came
> across some regression however some of those looks to me like PTS issue; vide:
> vcf extension not being recognized.
> Would be good to get developers insight into this matter.
>
> Sebastian Chlad (1):
>   android/pts: Re-run OPP PTS 5.1 test
>
>  android/pts-opp.txt | 116 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 72 insertions(+), 44 deletions(-)
>
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Seb/

Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Brad Midgley" <bmidgley@gmail.com>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Date: Fri, 2 Jan 2009 19:11:20 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812311803.45279.siarhei.siamashka@nokia.com> <200901021807.17443.siarhei.siamashka@nokia.com> <d89ddf300901020827w20c48a5fgb37d35ff33ea5fd3@mail.gmail.com>
In-Reply-To: <d89ddf300901020827w20c48a5fgb37d35ff33ea5fd3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901021911.20265.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 02 January 2009 18:27:33 ext Brad Midgley wrote:
> Siarhei
>
> > I wonder what CPU architectures are the most important for bluez?
>
> This is not an easy question, but one perspective is to consider the
> impact on battery life. Running sbc encoding on a phone will have a
> greater impact on battery life than it does to run it on a laptop.

I see. I'm mostly interested in ARM, so this one should be quite fine. On the
other hand, if we sacrifice performance let's say for MIPS when adding
some of the changes beneficial for other platforms, will it be considered an
important regression?

I also submitted MMX implementation first as this is the code which can be
hopefully tested by more people. Anyway, the most hard part was to transform
the code to be efficiently vectorizable (done by writing several additional
scripts which were used to find an optimal input data permutation and generate
the tables). After that, just converting C code to the appropriate MMX
instructions in gcc inline assembly took probably only ~1 day of working time,
including testing. Support for the other architectures should be quite easy
from this point (ARM will follow next).

> The ideal is to have portable devices mitigate this with dsp hardware,
> but we can't count on the hardware or the driver to be there in all
> cases. (see https://garage.maemo.org/projects/dsp-sbc/ for some work
> using the TI dsp)

Yes, I know about this project. And its maintainer should be subscribed here
too :)

Making code a bit more C55x friendly is not difficult at all and can be surely
done.

-- 
Best regards,
Siarhei Siamashka

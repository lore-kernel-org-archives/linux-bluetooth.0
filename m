Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] android/hf-client: API fixes
Date: Fri, 12 Sep 2014 13:37:41 +0200
Message-ID: <2150281.j2P5hTWFZv@uw000953>
In-Reply-To: <CABBYNZKSFiQbPv7cmxLWe9VV-vc8OtJkF8h66-=X0h=F4tR=XQ@mail.gmail.com>
References: <1410347494-22084-1-git-send-email-lukasz.rymanowski@tieto.com> <1477172.5pA5BI0JMS@uw000953> <CABBYNZKSFiQbPv7cmxLWe9VV-vc8OtJkF8h66-=X0h=F4tR=XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Friday 12 of September 2014 14:20:43 Luiz Augusto von Dentz wrote:
> Hi Szymon,
> 
> On Thu, Sep 11, 2014 at 1:17 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > Hi Łukasz,
> >
> > On Wednesday 10 of September 2014 13:11:30 Lukasz Rymanowski wrote:
> >> Couple of fixes to hf-client api.
> >>
> >> Those patches previously where a part of bigger set
> >> [PATCH 00/39] android: HF Client initial implementation
> >> but on Luiz request I split it into smaller sets.
> >>
> >> Lukasz Rymanowski (4):
> >>   android/hal-ipc-api: Use 2 bytes for location in dial memory
> >>   android/hal-ipc-api: Use Tone instead of Code DTMF
> >>   android/hal-ipc-api: Add missing peer features parameter
> >>   android/hal-ipc-api: Fix define for HF-Client
> >>
> >>  android/hal-ipc-api.txt | 11 ++++++-----
> >>  1 file changed, 6 insertions(+), 5 deletions(-)
> >>
> >
> > Applied. Thanks.
> 
> This one went in without taking my comments into account.

This was applied before your comments showed up on ML.
I've asked Łukasz to address your comments with follow-up patch.

-- 
Best regards, 
Szymon Janc

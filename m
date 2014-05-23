Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal-audio: Decouple SBC codec from core HAL
Date: Fri, 23 May 2014 09:28:53 +0200
Message-ID: <3187088.gBzXr2MLj0@uw000953>
In-Reply-To: <1400691979-25080-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400691979-25080-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wednesday 21 of May 2014 19:06:19 Andrzej Kaczmarek wrote:
> Codec abstraction in hal-audio is now good enough to allow splitting
> code into core and codec implementation easily so this patch moves
> SBC codec code into separate file and provides interface required for
> other codecs to be implemented.
> ---
>  android/Android.mk      |   4 +-
>  android/Makefile.am     |   2 +
>  android/hal-audio-sbc.c | 389 +++++++++++++++++++++++++++++++++++++++
>  android/hal-audio.c     | 469 +-----------------------------------------------
>  android/hal-audio.h     | 110 ++++++++++++
>  5 files changed, 511 insertions(+), 463 deletions(-)
>  create mode 100644 android/hal-audio-sbc.c
>  create mode 100644 android/hal-audio.h

Patch has been applied, thanks.

-- 
Best regards, 
Szymon Janc

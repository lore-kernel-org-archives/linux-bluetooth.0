Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Nov 2013 11:05:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/debug: Move debug functions to hal-utils.c
Message-ID: <20131114090526.GA7427@x220.p-661hnu-f1>
References: <1384413276-29884-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384413276-29884-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Nov 14, 2013, Andrei Emeltchenko wrote:
> Debug functions will be used by HALs and haltest.
> ---
>  android/Android.mk        |    2 -
>  android/Makefile.am       |    3 -
>  android/client/if-av.c    |    1 +
>  android/client/if-bt.c    |    1 +
>  android/client/if-hf.c    |    1 +
>  android/client/if-hh.c    |    1 +
>  android/client/if-main.h  |    2 -
>  android/client/if-pan.c   |    1 +
>  android/client/if-sock.c  |    1 +
>  android/client/textconv.c |  300 ---------------------------------------------
>  android/client/textconv.h |  120 ------------------
>  android/hal-bluetooth.c   |    3 +-
>  android/hal-utils.c       |  269 ++++++++++++++++++++++++++++++++++++++++
>  android/hal-utils.h       |  103 ++++++++++++++++
>  14 files changed, 379 insertions(+), 429 deletions(-)
>  delete mode 100644 android/client/textconv.c
>  delete mode 100644 android/client/textconv.h

Applied. Thanks.

Johan

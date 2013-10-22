Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Oct 2013 14:15:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/3] android: add support for hidhost to haltest
Message-ID: <20131022111541.GA5416@x220.p-661hnu-f1>
References: <1382439747-13864-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382439747-13864-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Tue, Oct 22, 2013, Jerzy Kasenberg wrote:
> - adds support for hidhost
> - adds tab completion for hidhost
> - adds help for hidhost
> - magic number to #define change for buffer sizes
> 
> Jerzy Kasenberg (3):
>   android: Add definition of buffer sizes to haltest
>   android: Add calls to hidhost interface to haltest
>   android: Add help to hidhost in haltest
> 
>  Makefile.android          |    2 +
>  android/Android.mk        |    1 +
>  android/client/haltest.c  |    1 +
>  android/client/if-bt.c    |   10 +-
>  android/client/if-hh.c    |  431 +++++++++++++++++++++++++++++++++++++++++++++
>  android/client/if-main.h  |    2 +
>  android/client/textconv.c |    2 +-
>  android/client/textconv.h |    2 +
>  8 files changed, 445 insertions(+), 6 deletions(-)
>  create mode 100644 android/client/if-hh.c

All three patches have been applied. Thanks.

Johan

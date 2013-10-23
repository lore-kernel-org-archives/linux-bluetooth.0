Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Oct 2013 19:35:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Add calls to av methods in haltest
Message-ID: <20131023163504.GB26531@x220.p-661hnu-f1>
References: <1382539105-10811-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382539105-10811-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Wed, Oct 23, 2013, Jerzy Kasenberg wrote:
> This patch adds calls to av interface in haltest.
> ---
>  Makefile.android         |    2 +
>  android/Android.mk       |    1 +
>  android/client/haltest.c |    1 +
>  android/client/if-av.c   |  130 ++++++++++++++++++++++++++++++++++++++++++++++
>  android/client/if-main.h |    2 +
>  5 files changed, 136 insertions(+)
>  create mode 100644 android/client/if-av.c

Applied. Thanks.

Johan

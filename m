Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Oct 2013 14:42:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/4] Add handsfree interface methods to haltest
Message-ID: <20131028124216.GA6450@x220.p-661hnu-f1>
References: <1382960343-10765-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382960343-10765-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Mon, Oct 28, 2013, Jerzy Kasenberg wrote:
> With this patchset handsfree interface is available in haltest.
> 
> Jerzy Kasenberg (4):
>   android/client: Add skeleton for handsfree calls
>   android/client: Add code for handsfree callbacks
>   android/client: Add code for handsfree methods
>   android/client: Add completion for hf methods
> 
>  Makefile.android         |    2 +
>  android/Android.mk       |    1 +
>  android/client/haltest.c |    1 +
>  android/client/if-bt.c   |    2 +-
>  android/client/if-hf.c   |  784 ++++++++++++++++++++++++++++++++++++++++++++++
>  android/client/if-main.h |    2 +
>  6 files changed, 791 insertions(+), 1 deletion(-)
>  create mode 100644 android/client/if-hf.c

All patches have been applied. Thanks.

Johan

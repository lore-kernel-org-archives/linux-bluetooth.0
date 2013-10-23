Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Oct 2013 13:05:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support to pan and socket in haltest
Message-ID: <20131023100509.GA11748@x220.p-661hnu-f1>
References: <1382517298-28093-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382517298-28093-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Wed, Oct 23, 2013, Jerzy Kasenberg wrote:
> - Add calls to methods of socket and pan
> 
> Jerzy Kasenberg (2):
>   android: Add calls to socket methods in haltest
>   android: Add calls to pan methods to haltest
> 
>  Makefile.android         |    4 +
>  android/Android.mk       |    2 +
>  android/client/haltest.c |    2 +
>  android/client/if-bt.c   |    4 +-
>  android/client/if-main.h |    4 +
>  android/client/if-pan.c  |  209 +++++++++++++++++++++++++++++
>  android/client/if-sock.c |  334 ++++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 557 insertions(+), 2 deletions(-)
>  create mode 100644 android/client/if-pan.c
>  create mode 100644 android/client/if-sock.c

Both patches have been applied. Thanks.

Johan

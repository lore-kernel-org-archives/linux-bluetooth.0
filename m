Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Aug 2011 11:43:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniele Forsi <dforsi@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix compilation when NEED_G_SLIST_FREE_FULL is
 defined
Message-ID: <20110804084322.GA17693@dell>
References: <1312410038-21169-1-git-send-email-dforsi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1312410038-21169-1-git-send-email-dforsi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 04, 2011, Daniele Forsi wrote:
> To use the replacement for g_slist_free_full() both compat.h and
> glib-helper.h need to be included.
> 
> Fixes:
> gobex/gobex.c:911: error: implicit declaration of function 'g_slist_free_full'
> tools/test-server.c:344: error: implicit declaration of function ‘g_slist_free_full’
> ---
>  gobex/gobex.c       |    5 +++++
>  tools/test-server.c |    4 ++++
>  2 files changed, 9 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan

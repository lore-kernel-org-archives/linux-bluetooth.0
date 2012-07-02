Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Jul 2012 13:24:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5 v2] audio: Remove unix socket support
Message-ID: <20120702102400.GA29931@x220.P-661HNU-F1>
References: <1340615179-368-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340615179-368-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Jun 25, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Unix socket support is deprecated by Media API.
> ---
> v2: Rebase on top of 4.101
> 
>  Makefile.am     |    1 -
>  audio/a2dp.c    |    4 -
>  audio/device.c  |    3 -
>  audio/manager.c |    7 -
>  audio/unix.c    | 1909 -------------------------------------------------------
>  audio/unix.h    |   30 -
>  6 files changed, 1954 deletions(-)
>  delete mode 100644 audio/unix.c
>  delete mode 100644 audio/unix.h

All five patches have been applied. Thanks.

This marks also the beginning of applying patches which are only
destined for BlueZ 5.

Johan

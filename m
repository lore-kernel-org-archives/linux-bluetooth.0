Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Nov 2014 10:08:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/io-glib: Fix not calling destroy callback
Message-ID: <20141126080800.GB16861@t440s>
References: <1416868537-2478-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416868537-2478-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 24, 2014, Szymon Janc wrote:
> Destroy callback should be called also for G_IO_ERR | G_IO_NVAL
> condition.
> ---
>  src/shared/io-glib.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan

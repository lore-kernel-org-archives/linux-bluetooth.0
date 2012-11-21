Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Nov 2012 12:38:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gdbus: Remove not needed NULL pointer checks
Message-ID: <20121121103830.GA5966@x220>
References: <1353493263-18191-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353493263-18191-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Nov 21, 2012, Szymon Janc wrote:
> g_strdup returns NULL if argument passed is NULL and there is no need
> to double check that.
> ---
>  gdbus/watch.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan

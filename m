Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Dec 2011 12:06:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] audio: Use headset_shutdown in headset_setconf_cb
Message-ID: <20111227100648.GC5584@x220.P-661HNU-F1>
References: <1324639080-32467-1-git-send-email-radoslawjablonski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324639080-32467-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Fri, Dec 23, 2011, Radoslaw Jablonski wrote:
> If pending connection will stay after state has been changed
> to HEADSET_STATE_DISCONNECTED, then crash may happen (e.g. when
> hs_connect will be called quickly again after that)
> To avoid that kind of problems using headset_shutdown,
> which does necessary cleanup first (finalizes pending connections)
> and after that changes state to HEADSET_STATE_DISCONNECTED.
> ---
>  audio/media.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan

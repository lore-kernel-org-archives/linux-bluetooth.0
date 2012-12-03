Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Dec 2012 16:17:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] adaptername: Fix passing negative error code to strerror
Message-ID: <20121203141753.GA27783@x220>
References: <1354543409-21258-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354543409-21258-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 03, 2012, Szymon Janc wrote:
> This also make error reporting code compliant with convention used.
> ---
>  plugins/adaptername.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan

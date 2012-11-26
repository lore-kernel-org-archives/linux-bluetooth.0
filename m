Return-Path: <cyrus@holtmann.org>
Date: Mon, 26 Nov 2012 14:56:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] adaptername: Remove not needed empty remove
 callback
Message-ID: <20121126125651.GA29516@x220>
References: <1353930524-22701-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353930524-22701-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 26, 2012, Szymon Janc wrote:
> Remove callback is called only if it is not NULL so there is no need to
> register empty callback function.
> ---
>  plugins/adaptername.c |    5 -----
>  1 file changed, 5 deletions(-)

Both patches have been applied. Thanks.

Johan

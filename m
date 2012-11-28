Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Nov 2012 19:08:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] adapter: Fix memory leak in convert_config
Message-ID: <20121128170849.GA13329@x220.P-661HNU-F1>
References: <1354115856-29301-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354115856-29301-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Nov 28, 2012, Szymon Janc wrote:
> 'converted' was not freed if config file was already converted.
> ---
>  src/adapter.c |    1 +
>  1 file changed, 1 insertion(+)

Both patches have been applied. Thanks.

Johan

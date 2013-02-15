Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2013 14:22:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] adapter: Fix registering adapter with no address
Message-ID: <20130215122224.GA25965@x220>
References: <1360317793-2015-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360317793-2015-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Feb 08, 2013, Szymon Janc wrote:
> adapter->bdaddr is set later in read_info_complete and current check
> always returns false. Check against bdaddr received in command response
> instead and fail if it is all zeros.
> ---
>  src/adapter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan

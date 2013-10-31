Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 15:47:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] android: Always enable SSP if supported by
 controller
Message-ID: <20131031134755.GC21600@x220.p-661hnu-f1>
References: <1383225309-7260-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383225309-7260-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Oct 31, 2013, Szymon Janc wrote:
> There is no HAL function to enable/disable SSP so always enable it if
> supported by controller.
> ---
> 
> v2:
>   use missing_settings mask for checking if setting is enabled
> 
>  android/adapter.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Both patches have been applied. Thanks.

Johan

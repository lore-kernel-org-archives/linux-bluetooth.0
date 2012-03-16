Return-Path: <cyrus@holtmann.org>
Message-ID: <1331914215.14217.157.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: mgmt: Don't allow to set invalid value
 to DeviceID source
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Date: Fri, 16 Mar 2012 09:10:15 -0700
In-Reply-To: <1331910177-11513-2-git-send-email-szymon.janc@tieto.com>
References: <1331910177-11513-1-git-send-email-szymon.janc@tieto.com>
	 <1331910177-11513-2-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Reply with MGMT_STATUS_INVALID_PARAMS when userspace is trying to set
> source with out-of-scope value.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
>  net/bluetooth/mgmt.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel



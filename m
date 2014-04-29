Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Apr 2014 11:16:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 32/36] android/gatt: Add write callback to server
Message-ID: <20140429081609.GJ21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1398734107-4793-34-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398734107-4793-34-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
> Write callback is now attached to characteristics and descriptors
> registered by Android app.
> 
> Transaction id is generated and stored in gatt_app together with request
> data(device ptr, cmd opcode etc).
> ---
>  android/gatt.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 2eb5b18..09eae80 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -82,6 +82,10 @@ struct gatt_app {
>  
>  	/* Valid for client applications */
>  	struct queue *notifications;
> +
> +	/* Transaction data valid for server application */
> +	int32_t pend_trans_id;

Could we please be consistent with async operation id types. I.e. use an
unsigned int here.

Johan

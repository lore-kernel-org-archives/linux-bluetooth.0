Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Mar 2011 23:10:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove unused fields in btd_driver_data struct
Message-ID: <20110322211036.GA7180@jh-x301>
References: <1300827396-8043-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300827396-8043-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Mar 22, 2011, Claudio Takahasi wrote:
> ---
>  src/device.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/src/device.c b/src/device.c
> index e9d9e65..5121064 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -68,9 +68,7 @@
>  #define GLOBAL_TRUST "[all]"
>  
>  struct btd_driver_data {
> -	guint id;
>  	struct btd_device_driver *driver;
> -	void *priv;
>  };

Why is btd_driver_data needed at all if btd_device_driver is the only
thing that it contains (i.e. why can't places pointing to
btd_driver_data just point to btd_device_driver directly)?

Johan

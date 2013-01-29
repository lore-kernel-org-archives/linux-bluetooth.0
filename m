Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2013 17:36:06 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Damjan Cvetko <damjan.cvetko@monotek.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add heartrate monitoring LE device to auto connect list.
Message-ID: <20130129233606.GA16365@x220>
References: <1359408442-8002-1-git-send-email-damjan.cvetko@monotek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359408442-8002-1-git-send-email-damjan.cvetko@monotek.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Damjan,

On Mon, Jan 28, 2013, Damjan Cvetko wrote:
> ---
>  profiles/heartrate/heartrate.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
> index 5c56d3f..1788d4f 100644
> --- a/profiles/heartrate/heartrate.c
> +++ b/profiles/heartrate/heartrate.c
> @@ -801,6 +801,8 @@ static int heartrate_device_register(struct btd_device *device,
>  	hr->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
>  						attio_disconnected_cb, hr);
>  
> +	device_set_auto_connect(device, TRUE);
> +
>  	return 0;
>  }

This patch isn't needed anymore since btd_device_add_attio_callback was
fixed to enable the auto connecting. Please verify that latest git works
for you.

Johan

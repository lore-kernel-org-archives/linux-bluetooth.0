Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Reduce RSSI delta threshold for RSSI property updates on Device1.
Date: Tue, 30 Sep 2014 10:34:40 +0200
Message-ID: <12072518.xz8sZz3RZr@uw000953>
In-Reply-To: <1412028964-5298-1-git-send-email-armansito@chromium.org>
References: <1412028964-5298-1-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Monday 29 of September 2014 15:16:04 Arman Uguray wrote:
> Currently the daemon does not update the RSSI property of a device object unless
> it sees a change of at least 8 dBm. This is too large for proximity use cases
> involving changes in distance within 4-5 feet. This patch reduces the threshold
> to 2 dBm to address this.
> ---
>  src/device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/device.c b/src/device.c
> index 875a5c5..821549e 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4094,8 +4094,8 @@ void device_set_rssi(struct btd_device *device, int8_t rssi)
>  		else
>  			delta = rssi - device->rssi;
>  
> -		/* only report changes of 8 dBm or more */
> -		if (delta < 8)
> +		/* only report changes of 2 dBm or more */
> +		if (delta < 2)
>  			return;

I'm not sure if having this so small is good... ie those few devices I have
they tend to have ~4 dBm RSSI oscillation when just lying next to each other
on the desk.
  
>  		DBG("rssi %d delta %d", rssi, delta);
> 

-- 
Best regards, 
Szymon Janc

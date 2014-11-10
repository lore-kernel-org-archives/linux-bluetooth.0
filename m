Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/gatt: Fix dead code warnings
Date: Mon, 10 Nov 2014 21:05:41 +0100
Message-ID: <1584207.SFKaHYrozt@leonov>
In-Reply-To: <1415625918-10189-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415625918-10189-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 10 of November 2014 15:25:18 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> gatt_db_attribute_get_permissions() used everywhere without check since
> those conditions are checked already.

It would make sense to put such warning into commit message if you are 
referring to it in subject.

> ---
>  android/gatt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 086bb94..04101f6 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -5992,8 +5992,7 @@ static void write_cmd_request(const uint8_t *cmd,
> uint16_t cmd_len, if (!attrib)
>  		return;
> 
> -	if (!gatt_db_attribute_get_permissions(attrib, &permissions))
> -		return;
> +	gatt_db_attribute_get_permissions(attrib, &permissions);
> 
>  	if (check_device_permissions(dev, cmd[0], permissions))
>  		return;

So if we always pass valid pointers to this function, then maybe we should 
change it definition to something like:

uint32_t gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib);


Thoughts?

-- 
BR
Szymon Janc

Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	claudio.takahasi@openbossa.org, anderson.lizardo@openbossa.org,
	armansito@chromium.org
Subject: Re: [PATCH 01/10] attrib: Add API for reliable write
Date: Mon, 14 Apr 2014 16:28:07 +0200
Message-ID: <3028620.qKlJO94k3d@uw000953>
In-Reply-To: <1397340031-29711-2-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com> <1397340031-29711-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Sunday 13 of April 2014 00:00:22 Lukasz Rymanowski wrote:
> Android expose to application api for reliable write. Therefore we need
> to add this support to gattrib
> ---
>  attrib/gatt.c | 18 ++++++++++++++++++
>  attrib/gatt.h |  6 ++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/attrib/gatt.c b/attrib/gatt.c
> index 49cd1a3..e461ab7 100644
> --- a/attrib/gatt.c
> +++ b/attrib/gatt.c
> @@ -871,6 +871,24 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
>  	return prepare_write(long_write);
>  }
>  
> +guint gatt_reliable_write_char(GAttrib *attrib, uint16_t handle,
> +					const uint8_t *value, size_t vlen,
> +					GAttribResultFunc func,
> +					gpointer user_data)
> +{
> +	uint8_t *buf;
> +	guint16 plen;
> +	size_t buflen;
> +
> +	buf = g_attrib_get_buffer(attrib, &buflen);
> +
> +	plen = enc_prep_write_req(handle, 0, value, vlen, buf, buflen);
> +	if (!plen)
> +		return 0;
> +
> +	return g_attrib_send(attrib, 0, buf, plen, func, user_data, NULL);
> +}
> +
>  guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
>  							gpointer user_data)
>  {
> diff --git a/attrib/gatt.h b/attrib/gatt.h
> index c65bf6c..76820e0 100644
> --- a/attrib/gatt.h
> +++ b/attrib/gatt.h
> @@ -84,6 +84,12 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
>  					size_t vlen, GAttribResultFunc func,
>  					gpointer user_data);
>  
> +guint gatt_reliable_write_char(GAttrib *attrib, uint16_t handle,
> +					const uint8_t *value, size_t vlen,
> +					GAttribResultFunc func,
> +					gpointer user_data);
> +
> +

Just a minor: double empty line.

>  guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
>  				GAttribResultFunc func, gpointer user_data);
>  
> 

-- 
Best regards, 
Szymon Janc

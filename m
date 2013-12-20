Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 4/5] android/hal-bluetooth: Add support for device service record property
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1387535140-6223-5-git-send-email-szymon.janc@tieto.com>
Date: Fri, 20 Dec 2013 05:18:03 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <D18535D5-351D-4C61-9D7E-6486E8558859@holtmann.org>
References: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com> <1387535140-6223-5-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This allows to correctly handle device service record property.
> ---
> android/hal-bluetooth.c | 15 +++++++++++++++
> android/hal-msg.h       |  7 +++++++
> 2 files changed, 22 insertions(+)
> 
> diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
> index d0c1c01..4ef2ebe 100644
> --- a/android/hal-bluetooth.c
> +++ b/android/hal-bluetooth.c
> @@ -166,6 +166,21 @@ static void device_props_to_hal(bt_property_t *send_props,
> 			break;
> #endif
> 		case HAL_PROP_DEVICE_SERVICE_REC:
> +		{
> +			static bt_service_record_t e;

why static here. Since we are essentially multi-threaded, this can be dangerous.

> +			const struct hal_prop_device_service_rec *p;
> +
> +			send_props[i].val = &e;
> +			send_props[i].len = sizeof(e);
> +
> +			p = (struct hal_prop_device_service_rec *) prop->val;
> +
> +			memset(&e, 0, sizeof(e));
> +			memcpy(&e.channel, &p->channel, sizeof(e.channel));
> +			memcpy(e.uuid.uu, p->uuid, sizeof(e.uuid.uu));
> +			memcpy(e.name, p->name, p->name_len);
> +		}
> +			break;
> 		default:
> 			send_props[i].len = prop->len;
> 			send_props[i].val = prop->val;

Regards

Marcel


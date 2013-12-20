Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1387535140-6223-4-git-send-email-szymon.janc@tieto.com>
References: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com>
	<1387535140-6223-4-git-send-email-szymon.janc@tieto.com>
Date: Fri, 20 Dec 2013 08:07:19 -0400
Message-ID: <CAJdJm_NKdhrpie3x+6rndGhn5otJSdR+2AnRjid3yG3H=Xqf_Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] android/hal-bluetooth: Add support for remote version
 info property
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Dec 20, 2013 at 6:25 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> +#if PLATFORM_SDK_VERSION > 17
>                 case HAL_PROP_DEVICE_VERSION_INFO:
> +               {
> +                       static bt_remote_version_t e;
> +                       const struct hal_prop_device_info *p;
> +                       uint16_t tmp;
> +
> +                       send_props[i].val = &e;
> +                       send_props[i].len = sizeof(e);
> +
> +                       p = (struct hal_prop_device_info *) prop->val;
> +
> +                       memcpy(&tmp, &p->manufacturer, sizeof(tmp));
> +                       e.manufacturer = tmp;
> +                       memcpy(&tmp, &p->sub_version, sizeof(tmp));
> +                       e.sub_ver = tmp;
> +                       e.version = p->version;

I fail to see why you need the "tmp" variable above (p->manufacturer
and p->sub_version are both uint16_t according to hal-msg.h).

> +               }
> +                       break;
> +#endif
> +               case HAL_PROP_DEVICE_SERVICE_REC:
>                 default:
>                         send_props[i].len = prop->len;
>                         send_props[i].val = prop->val;

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

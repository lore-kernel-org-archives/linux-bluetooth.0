Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1348129663-1701-10-git-send-email-chen.ganir@ti.com>
References: <1348129663-1701-1-git-send-email-chen.ganir@ti.com>
	<1348129663-1701-10-git-send-email-chen.ganir@ti.com>
Date: Thu, 20 Sep 2012 06:54:44 -0400
Message-ID: <CAJdJm_P07N-VwgnHy=1m3D68086dP9fFy5AmkhZC_3b4d2xpmg@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] battery: Add support for notifications
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Sep 20, 2012 at 4:27 AM,  <chen.ganir@ti.com> wrote:
> @@ -140,6 +156,18 @@ static void process_batteryservice_char(struct characteristic *ch)
>         }
>  }
>
> +static void batterylevel_enable_notify_cb(guint8 status, const guint8 *pdu,
> +                                               guint16 len, gpointer user_data)
> +{
> +       struct characteristic *ch = (struct characteristic *)user_data;

Casting above seems unnecessary (gpointer is typedef to void*).

> +
> +       if (status != 0) {
> +               error("Could not enable batt level notification.");
> +               ch->canNotify = FALSE;

This camelCase is inconsistent with other struct fields on the same file.

> +               process_batteryservice_char(ch);
> +       }
> +}
> +
>  static gint device_battery_cmp(gconstpointer a, gconstpointer b)
>  {
>         const struct characteristic *ch = a;

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

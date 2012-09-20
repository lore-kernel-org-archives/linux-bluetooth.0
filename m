Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1348129663-1701-7-git-send-email-chen.ganir@ti.com>
References: <1348129663-1701-1-git-send-email-chen.ganir@ti.com>
	<1348129663-1701-7-git-send-email-chen.ganir@ti.com>
Date: Thu, 20 Sep 2012 06:46:48 -0400
Message-ID: <CAJdJm_MyO5Fq-rDWMnSm3pkR_Qj8ghCri8We0fXtaYVXtpzB6A@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] battery: Get Battery ID
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Sep 20, 2012 at 4:27 AM,  <chen.ganir@ti.com> wrote:
> @@ -150,31 +200,35 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
>
>         for (l = characteristics; l; l = l->next) {
>                 struct gatt_char *c = l->data;
> -               struct characteristic *ch;
> -               uint16_t start, end;
> -
> -               ch = g_new0(struct characteristic, 1);
> -               ch->attr.handle = c->handle;
> -               ch->attr.properties = c->properties;
> -               ch->attr.value_handle = c->value_handle;
> -               memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
> -               ch->batt = batt;
>
> -               batt->chars = g_slist_append(batt->chars, ch);
> -
> -               start = c->value_handle + 1;
> -
> -               if (l->next != NULL) {
> -                       struct gatt_char *c = l->next->data;
> -                       if (start == c->handle)
> +               if (g_strcmp0(c->uuid, BATTERY_LEVEL_UUID) == 0) {

Minor comment, but looks like it would be cleaner if you used:

if (g_strcmp0(c->uuid, BATTERY_LEVEL_UUID) != 0)
    continue;

and avoided all this shifting and one more level of indentation.

> +                       struct characteristic *ch;
> +                       uint16_t start, end;
> +
> +                       ch = g_new0(struct characteristic, 1);
> +                       ch->attr.handle = c->handle;
> +                       ch->attr.properties = c->properties;
> +                       ch->attr.value_handle = c->value_handle;
> +                       memcpy(ch->attr.uuid, c->uuid, MAX_LEN_UUID_STR + 1);
> +                       ch->batt = batt;
> +
> +                       batt->chars = g_slist_append(batt->chars, ch);
> +
> +                       start = c->value_handle + 1;
> +
> +                       if (l->next != NULL) {
> +                               struct gatt_char *c = l->next->data;
> +                               if (start == c->handle)
> +                                       continue;
> +                               end = c->handle - 1;
> +                       } else if (c->value_handle != batt->svc_range->end)
> +                               end = batt->svc_range->end;
> +                       else
>                                 continue;
> -                       end = c->handle - 1;
> -               } else if (c->value_handle != batt->svc_range->end)
> -                       end = batt->svc_range->end;
> -               else
> -                       continue;
>
> -               gatt_find_info(batt->attrib, start, end, discover_desc_cb, ch);
> +                       gatt_find_info(batt->attrib, start, end,
> +                                                       discover_desc_cb, ch);
> +               }
>         }
>  }

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

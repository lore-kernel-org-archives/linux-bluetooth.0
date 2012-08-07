Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343194947-13659-10-git-send-email-chen.ganir@ti.com>
References: <1343194947-13659-1-git-send-email-chen.ganir@ti.com>
	<1343194947-13659-10-git-send-email-chen.ganir@ti.com>
Date: Tue, 7 Aug 2012 13:29:47 -0300
Message-ID: <CAAngNMaAM4zYqhGs+sD18DqwA8Hx8ysiy=6ksCVXo9ygb5V+bQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] Battery: Emit property changed on first read
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: Chen Ganir <chen.ganir@ti.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 25, 2012 at 2:42 AM, Chen Ganir <chen.ganir@ti.com> wrote:
> Emit battery level property changed upon connection, on first read.
> ---
>  profiles/batterystate/batterystate.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/profiles/batterystate/batterystate.c b/profiles/batterystate/batterystate.c
> index 718863b..4300f85 100644
> --- a/profiles/batterystate/batterystate.c
> +++ b/profiles/batterystate/batterystate.c
> @@ -72,6 +72,8 @@ struct descriptor {
>         bt_uuid_t               uuid;           /* UUID */
>  };
>
> +static void emit_battery_level_changed(struct characteristic *c);
> +

No need of this forward declaration, simply move the function
implementation before the first function that references it
(read_batterylevel_cb).

>  static void char_free(gpointer user_data)
>  {
>         struct characteristic *c = user_data;
> @@ -161,6 +163,7 @@ static void read_batterylevel_cb(guint8 status, const guint8 *pdu, guint16 len,
>         }
>
>         ch->level = value[0];
> +       emit_battery_level_changed(ch);
>  }
>
>  static void process_batteryservice_char(struct characteristic *ch)
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
João Paulo Rechi Vita
Openbossa Labs - INdT

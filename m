Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1291386290-2521-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1291386290-2521-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Fri, 3 Dec 2010 16:37:00 +0200
Message-ID: <AANLkTikrFvKHQ9zcxiK_hA7L1cr8ooBUJgu2GHa8yBEP@mail.gmail.com>
Subject: Re: [PATCH] Remove automatic battery state change on attribute example
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 3, 2010 at 4:24 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Legacy code implemented to test Indication and Notification
> ---
>  attrib/example.c |   19 -------------------
>  1 files changed, 0 insertions(+), 19 deletions(-)
>
> diff --git a/attrib/example.c b/attrib/example.c
> index c29e1e4..2d5b758 100644
> --- a/attrib/example.c
> +++ b/attrib/example.c
> @@ -59,22 +59,6 @@
>  #define FMT_KILOGRAM_UUID              0xA010
>  #define FMT_HANGING_UUID               0xA011
>
> -static guint timeout_id = 0;
> -
> -static gboolean change_battery_state(gpointer user_data)
> -{
> -       static uint8_t state =  0x05;
> -       uuid_t uuid;
> -       uint8_t atval[1];
> -
> -       /* Battery state is being increased every 10 seconds. */
> -       atval[0] = state++;
> -       sdp_uuid16_create(&uuid, BATTERY_STATE_UUID);
> -       attrib_db_update(0x0110, &uuid, atval, 1);
> -
> -       return TRUE;
> -}
> -
>  static int register_attributes(void)
>  {
>        const char *devname = "Example Device";
> @@ -170,8 +154,6 @@ static int register_attributes(void)
>        atval[1] = 0x00;
>        attrib_db_add(0x0111, &uuid, atval, 2);
>
> -       timeout_id = g_timeout_add_seconds(10, change_battery_state, NULL);
> -
>        /* Thermometer: primary service definition */
>        sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
>        u16 = htons(THERM_HUMIDITY_SVC_UUID);
> @@ -436,5 +418,4 @@ int server_example_init(void)
>
>  void server_example_exit(void)
>  {
> -       g_source_remove(timeout_id);
>  }
> --
> 1.7.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

I wonder what is the relation of this code with attrib-server.c, does
this work if we don't have the attrib server enabled?

-- 
Luiz Augusto von Dentz
Computer Engineer

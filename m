Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327403188-21981-2-git-send-email-sancane@gmail.com>
References: <1327403188-21981-1-git-send-email-sancane@gmail.com>
	<1327403188-21981-2-git-send-email-sancane@gmail.com>
Date: Tue, 24 Jan 2012 08:03:17 -0400
Message-ID: <CAJdJm_Pp5oqkeovTa7rGJGW8VBKQun7mu-0dyN=ika2F_O26QA@mail.gmail.com>
Subject: Re: [PATCH 1/8] gatt-service: Add support for 128-bit Bluetooth UUIDs
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Jan 24, 2012 at 7:06 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> UUID services in GATT should be either 16-bit or 128-bit. Current
> GATT interface does not allow to provide 128-bit ones. This patch
> enables plugins to register services using 128-bit UUIDs.
> ---
>  attrib/gatt-service.c  |   57 ++++++++++++++++++++++++++++++++++-------------
>  attrib/gatt-service.h  |    2 +-
>  plugins/gatt-example.c |    7 ++++-
>  time/server.c          |    6 ++++-
>  4 files changed, 52 insertions(+), 20 deletions(-)
>
> diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
> index bfefdee..eeda366 100644
> --- a/attrib/gatt-service.c
> +++ b/attrib/gatt-service.c
> @@ -116,6 +116,28 @@ static GSList *parse_opts(gatt_option opt1, va_list args)
>        return l;
>  }
>
> +static struct attribute *add_service_declaration(struct btd_adapter *adapter,
> +                               uint16_t handle, uint16_t scv, bt_uuid_t *uuid)

typo: scv -> svc

> +{
> +       bt_uuid_t bt_uuid;
> +       uint8_t atval[16];
> +       int len;
> +
> +       if (uuid->type == BT_UUID16) {
> +               att_put_u16(uuid->value.u16, &atval[0]);
> +               len = 2;
> +       } else if (uuid->type == BT_UUID128) {
> +               att_put_u128(uuid->value.u128, &atval[0]);
> +               len = 16;
> +       } else
> +               return NULL;
> +
> +       bt_uuid16_create(&bt_uuid, scv);
> +
> +       return attrib_db_add(adapter, handle, &bt_uuid, ATT_NONE,
> +                                               ATT_NOT_PERMITTED, atval, len);
> +}
> +
>  static int att_read_reqs(int authorization, int authentication, uint8_t props)
>  {
>        if (authorization == GATT_CHR_VALUE_READ ||
> @@ -268,15 +290,21 @@ static void service_attr_del(struct btd_adapter *adapter, uint16_t start_handle,
>  }
>
>  gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
> -                               uint16_t svc_uuid, gatt_option opt1, ...)
> +                               bt_uuid_t svc_uuid, gatt_option opt1, ...)

I think it is more efficient to pass svc_uuid as pointer (this avoids
a possible 128-bit copy).

>  {
> +       char uuidstr[MAX_LEN_UUID_STR];
>        uint16_t start_handle, h;
>        unsigned int size;
> -       bt_uuid_t bt_uuid;
> -       uint8_t atval[2];
>        va_list args;
>        GSList *chrs, *l;
>
> +       bt_uuid_to_string(&svc_uuid, uuidstr, MAX_LEN_UUID_STR);
> +
> +       if (svc_uuid.type != BT_UUID16 && svc_uuid.type != BT_UUID128) {
> +               error("Invalid service uuid: %s", uuidstr);
> +               return FALSE;
> +       }
> +
>        va_start(args, opt1);
>        chrs = parse_opts(opt1, args);
>        /* calculate how many attributes are necessary for this service */

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1447708112-12695-3-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1447708112-12695-1-git-send-email-lukasz.rymanowski@codecoup.pl>
	<1447708112-12695-3-git-send-email-lukasz.rymanowski@codecoup.pl>
Date: Tue, 17 Nov 2015 16:10:14 +0200
Message-ID: <CABBYNZJZTQLXXEMsAj0jREB1Rsdop-0Dtey+yBViJCtqLO+bXQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] shared/gatt-client: Add notify type to notification callback
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Nov 16, 2015 at 11:08 PM, Łukasz Rymanowski
<lukasz.rymanowski@codecoup.pl> wrote:
> Android expect information either its indication or notification.
> This patch adds that.
> ---
>  profiles/scanparam/scan.c |  5 +++--
>  src/gatt-client.c         |  4 ++--
>  src/shared/gatt-client.c  | 13 +++++++++----
>  src/shared/gatt-client.h  | 13 ++++++++++---
>  tools/btgatt-client.c     |  2 +-
>  unit/test-gatt.c          | 10 ++++++----
>  6 files changed, 31 insertions(+), 16 deletions(-)
>
> diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
> index 4015b3f..fd01135 100644
> --- a/profiles/scanparam/scan.c
> +++ b/profiles/scanparam/scan.c
> @@ -92,8 +92,9 @@ static void write_scan_params(struct scan *scan)
>                                                 false, value, sizeof(value));
>  }
>
> -static void refresh_value_cb(uint16_t value_handle, const uint8_t *value,
> -                                       uint16_t length, void *user_data)
> +static void refresh_value_cb(notify_t type, uint16_t value_handle,
> +                                       const uint8_t *value, uint16_t length,
> +                                       void *user_data)
>  {
>         struct scan *scan = user_data;
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 39f6646..e74803c 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1057,8 +1057,8 @@ static bool match_notify_sender(const void *a, const void *b)
>         return strcmp(client->owner, sender) == 0;
>  }
>
> -static void notify_cb(uint16_t value_handle, const uint8_t *value,
> -                                       uint16_t length, void *user_data)
> +static void notify_cb(notify_t type, uint16_t value_handle,
> +                       const uint8_t *value, uint16_t length, void *user_data)
>  {
>         struct async_dbus_op *op = user_data;
>         struct notify_client *client = op->data;
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 06ac763..76e4a9a 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1109,7 +1109,7 @@ struct service_changed_op {
>  static void process_service_changed(struct bt_gatt_client *client,
>                                                         uint16_t start_handle,
>                                                         uint16_t end_handle);
> -static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
> +static void service_changed_cb(notify_t type, uint16_t value_handle, const uint8_t *value,
>                                         uint16_t length, void *user_data);
>
>  static void complete_notify_request(void *data)
> @@ -1446,8 +1446,9 @@ fail:
>                                         " after Service Changed");
>  }
>
> -static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
> -                                       uint16_t length, void *user_data)
> +static void service_changed_cb(notify_t type, uint16_t value_handle,
> +                                       const uint8_t *value, uint16_t length,
> +                                       void *user_data)
>  {
>         struct bt_gatt_client *client = user_data;
>         struct service_changed_op *op;
> @@ -1545,6 +1546,7 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
>  }
>
>  struct pdu_data {
> +       notify_t type;
>         const void *pdu;
>         uint16_t length;
>  };
> @@ -1614,7 +1616,8 @@ static void notify_handler(void *data, void *user_data)
>          * CCC, there is really no reason not to notify the handlers.
>          */
>         if (notify_data->notify)
> -               notify_data->notify(value_handle, value, pdu_data->length - 2,
> +               notify_data->notify(pdu_data->type, value_handle, value,
> +                                                       pdu_data->length - 2,
>                                                         notify_data->user_data);
>  }
>
> @@ -1629,6 +1632,8 @@ static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
>         memset(&pdu_data, 0, sizeof(pdu_data));
>         pdu_data.pdu = pdu;
>         pdu_data.length = length;
> +       pdu_data.type = opcode == BT_ATT_OP_HANDLE_VAL_IND ?
> +                               BT_GATT_INDICATION : BT_GATT_NOTIFICATION;
>
>         queue_foreach(client->notify_list, notify_handler, &pdu_data);
>
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index befa43f..3018a99 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -27,6 +27,11 @@
>
>  #define BT_GATT_UUID_SIZE 16
>
> +typedef enum {
> +       BT_GATT_NOTIFICATION,
> +       BT_GATT_INDICATION,
> +} notify_t;
> +
>  struct bt_gatt_client;
>
>  struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
> @@ -46,9 +51,11 @@ typedef void (*bt_gatt_client_read_callback_t)(bool success, uint8_t att_ecode,
>  typedef void (*bt_gatt_client_write_long_callback_t)(bool success,
>                                         bool reliable_error, uint8_t att_ecode,
>                                         void *user_data);
> -typedef void (*bt_gatt_client_notify_callback_t)(uint16_t value_handle,
> -                                       const uint8_t *value, uint16_t length,
> -                                       void *user_data);
> +typedef void (*bt_gatt_client_notify_callback_t)(notify_t type,
> +                                                       uint16_t value_handle,
> +                                                       const uint8_t *value,
> +                                                       uint16_t length,
> +                                                       void *user_data);
>  typedef void (*bt_gatt_client_register_callback_t)(uint16_t att_ecode,
>                                                         void *user_data);
>  typedef void (*bt_gatt_client_service_changed_callback_t)(uint16_t start_handle,
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index 0f6a1bd..76fd6d0 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -1099,7 +1099,7 @@ static void register_notify_usage(void)
>         printf("Usage: register-notify <chrc value handle>\n");
>  }
>
> -static void notify_cb(uint16_t value_handle, const uint8_t *value,
> +static void notify_cb(notify_t type, uint16_t value_handle, const uint8_t *value,
>                                         uint16_t length, void *user_data)
>  {
>         int i;
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 326a32c..b6d4ab6 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -2202,8 +2202,9 @@ static const struct test_step test_long_read_15 = {
>         .expected_att_ecode = 0x0c
>  };
>
> -static void notification_cb(uint16_t value_handle, const uint8_t *value,
> -                                       uint16_t length, void *user_data)
> +static void notification_cb(notify_t type, uint16_t value_handle,
> +                                       const uint8_t *value, uint16_t length,
> +                                       void *user_data)
>  {
>         struct context *context = user_data;
>         const struct test_step *step = context->data->step;
> @@ -2270,8 +2271,9 @@ static void test_server_indication_confirm(struct context *context)
>         g_assert(indication_received == 1);
>  }
>
> -static void indication_cb(uint16_t value_handle, const uint8_t *value,
> -                                       uint16_t length, void *user_data)
> +static void indication_cb(notify_t type, uint16_t value_handle,
> +                                       const uint8_t *value, uint16_t length,
> +                                       void *user_data)

Can't you figure out from the callback type? I the code already have
dedicated callbacks for both so you can hardcode their types there.


-- 
Luiz Augusto von Dentz

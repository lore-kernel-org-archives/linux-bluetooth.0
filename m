Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1396353771-10434-1-git-send-email-marcin.kraglak@tieto.com>
References: <1396353771-10434-1-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 1 Apr 2014 14:07:07 -0300
Message-ID: <CAKT1EBfAPYDwbC4A1KWhf9=fV2=oLA9EzAEJtq1PJUweaOC5aw@mail.gmail.com>
Subject: Re: [PATCH] gatt: replace GList with struct queue
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin/Johan,

On Tue, Apr 1, 2014 at 9:02 AM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> Store local attributes in queue instead of GList, which depends on Glib.
> ---
>  src/gatt.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/src/gatt.c b/src/gatt.c
> index f07effa..018ca27 100644
> --- a/src/gatt.c
> +++ b/src/gatt.c
> @@ -31,6 +31,7 @@
>  #include "lib/uuid.h"
>  #include "attrib/att.h"
>  #include "src/shared/util.h"
> +#include "src/shared/queue.h"
>
>  #include "gatt-dbus.h"
>  #include "gatt.h"
> @@ -51,7 +52,7 @@ struct btd_attribute {
>         uint8_t value[0];
>  };
>
> -static GList *local_attribute_db;
> +static struct queue *local_attribute_db;
>  static uint16_t next_handle = 0x0001;
>
>  static inline void put_uuid_le(const bt_uuid_t *src, void *dst)
> @@ -104,13 +105,11 @@ static struct btd_attribute *new_attribute(const bt_uuid_t *type,
>         return attr;
>  }
>
> -static int local_database_add(uint16_t handle, struct btd_attribute *attr)
> +static bool local_database_add(uint16_t handle, struct btd_attribute *attr)
>  {
>         attr->handle = handle;
>
> -       local_attribute_db = g_list_append(local_attribute_db, attr);
> -
> -       return 0;
> +       return queue_push_tail(local_attribute_db, attr);
>  }
>
>  struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
> @@ -138,7 +137,7 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
>         if (!attr)
>                 return NULL;
>
> -       if (local_database_add(next_handle, attr) < 0) {
> +       if (!local_database_add(next_handle, attr)) {
>                 free(attr);
>                 return NULL;
>         }
> @@ -191,7 +190,7 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
>         if (!char_value)
>                 goto fail;
>
> -       if (local_database_add(next_handle, char_decl) < 0)
> +       if (!local_database_add(next_handle, char_decl))
>                 goto fail;
>
>         next_handle = next_handle + 1;
> @@ -209,7 +208,7 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
>          * implementation (external entity).
>          */
>
> -       if (local_database_add(next_handle, char_value) < 0)
> +       if (!local_database_add(next_handle, char_value))
>                 /* TODO: remove declaration */
>                 goto fail;
>
> @@ -253,7 +252,7 @@ struct btd_attribute *btd_gatt_add_char_desc(const bt_uuid_t *uuid,
>         if (!attr)
>                 return NULL;
>
> -       if (local_database_add(next_handle, attr) < 0) {
> +       if (!local_database_add(next_handle, attr)) {
>                 free(attr);
>                 return NULL;
>         }
> @@ -267,6 +266,8 @@ void gatt_init(void)
>  {
>         DBG("Starting GATT server");
>
> +       local_attribute_db = queue_new();

It is missing to check the returned value, allocation may fail.

I agree with this change if we extend the queue API implementing
functions to iterate through the elements.

In some cases it is more convenient to access elements directly
instead of using queue_foreach, callbacks and user_data. One example
applied to GATT/ATT is Read by Group Type Request (discover all
primary service) which needs to access all service declarations
(static attributes).

Regards,
Claudio

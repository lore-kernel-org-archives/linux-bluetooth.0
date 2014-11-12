Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415715778-28994-1-git-send-email-luiz.dentz@gmail.com>
References: <1415715778-28994-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 12 Nov 2014 15:49:53 +0200
Message-ID: <CABBYNZ++Eaof=nP4dYcG_7ouZOfiQvEYfGb3XxaWNzpjm1QM3A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/gatt-db: Add timeout to read/write
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 11, 2014 at 4:22 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds a timeout (1 second) to attribute operations since these can
> cause unexpected transport disconnections if they take too long to
> complete.
> ---
>  src/shared/gatt-db.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 5 deletions(-)
>
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index bab1202..a39eec2 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -22,14 +22,17 @@
>   */
>
>  #include <stdbool.h>
> +#include <errno.h>
>
>  #include "lib/uuid.h"
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> +#include "src/shared/timeout.h"
>  #include "src/shared/gatt-db.h"
>
>  #define MAX_CHAR_DECL_VALUE_LEN 19
>  #define MAX_INCLUDED_VALUE_LEN 6
> +#define ATTRIBUTE_TIMEOUT 1000
>
>  static const bt_uuid_t primary_service_uuid = { .type = BT_UUID16,
>                                         .value.u16 = GATT_PRIM_SVC_UUID };
> @@ -46,13 +49,17 @@ struct gatt_db {
>  };
>
>  struct pending_read {
> +       struct gatt_db_attribute *attrib;
>         unsigned int id;
> +       unsigned int timeout_id;
>         gatt_db_attribute_read_t func;
>         void *user_data;
>  };
>
>  struct pending_write {
> +       struct gatt_db_attribute *attrib;
>         unsigned int id;
> +       unsigned int timeout_id;
>         gatt_db_attribute_write_t func;
>         void *user_data;
>  };
> @@ -773,6 +780,30 @@ bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
>         return true;
>  }
>
> +static void pending_read_result(struct pending_read *p, int err,
> +                                       const uint8_t *data, size_t length)
> +{
> +       if (p->timeout_id > 0)
> +               timeout_remove(p->timeout_id);
> +
> +       p->func(p->attrib, err, data, length, p->user_data);
> +
> +       free(p);
> +}
> +
> +static bool read_timeout(void *user_data)
> +{
> +       struct pending_read *p = user_data;
> +
> +       p->timeout_id = 0;
> +
> +       queue_remove(p->attrib->pending_reads, p);
> +
> +       pending_read_result(p, -ETIMEDOUT, NULL, 0);
> +
> +       return false;
> +}
> +
>  bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>                                 uint8_t opcode, bdaddr_t *bdaddr,
>                                 gatt_db_attribute_read_t func, void *user_data)
> @@ -789,7 +820,10 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>                 if (!p)
>                         return false;
>
> +               p->attrib = attrib;
>                 p->id = ++attrib->read_id;
> +               p->timeout_id = timeout_add(ATTRIBUTE_TIMEOUT, read_timeout,
> +                                                               p, NULL);
>                 p->func = func;
>                 p->user_data = user_data;
>
> @@ -834,11 +868,32 @@ bool gatt_db_attribute_read_result(struct gatt_db_attribute *attrib,
>         if (!p)
>                 return false;
>
> -       p->func(attrib, err, value, length, p->user_data);
> +       pending_read_result(p, err, value, length);
> +
> +       return true;
> +}
> +
> +static void pending_write_result(struct pending_write *p, int err)
> +{
> +       if (p->timeout_id > 0)
> +               timeout_remove(p->timeout_id);
> +
> +       p->func(p->attrib, err, p->user_data);
>
>         free(p);
> +}
>
> -       return true;
> +static bool write_timeout(void *user_data)
> +{
> +       struct pending_write *p = user_data;
> +
> +       p->timeout_id = 0;
> +
> +       queue_remove(p->attrib->pending_writes, p);
> +
> +       pending_write_result(p, -ETIMEDOUT);
> +
> +       return false;
>  }
>
>  bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
> @@ -857,7 +912,10 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>                 if (!p)
>                         return false;
>
> +               p->attrib = attrib;
>                 p->id = ++attrib->write_id;
> +               p->timeout_id = timeout_add(ATTRIBUTE_TIMEOUT, write_timeout,
> +                                                               p, NULL);
>                 p->func = func;
>                 p->user_data = user_data;
>
> @@ -900,9 +958,7 @@ bool gatt_db_attribute_write_result(struct gatt_db_attribute *attrib,
>         if (!p)
>                 return false;
>
> -       p->func(attrib, err, p->user_data);
> -
> -       free(p);
> +       pending_write_result(p, err);
>
>         return true;
>  }
> --
> 1.9.3

Pushed.


-- 
Luiz Augusto von Dentz

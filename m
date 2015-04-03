Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1428068636-13073-2-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
	<1428068636-13073-2-git-send-email-mariusz.skamra@tieto.com>
Date: Fri, 3 Apr 2015 09:33:45 -0700
Message-ID: <CAJLTA8ikb_8AS_x+L6f_9iGCnHN213guX5-09QX=wBqDpXropQ@mail.gmail.com>
Subject: Re: [PATCHv2 01/27] android/hidhost: Create bt_gatt_client
From: Michael Janssen <jamuraa@google.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mariusz Skamra <mariusz.skamra@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

Just a minor thing.

On Fri, Apr 3, 2015 at 6:43 AM, Mariusz Skamra <mariusz.skamra@tieto.com> wrote:
> From: Mariusz Skamra <mariusz.skamra@gmail.com>
>
> This patch introduces bt_gatt_client to be used by HoG profile.
> As long as the android/gatt doesn't use bt_gatt_client, initialization
> can be performed here.
> ---
>  android/Android.mk |  2 ++
>  android/hidhost.c  | 75 ++++++++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 66 insertions(+), 11 deletions(-)
>
> diff --git a/android/Android.mk b/android/Android.mk
> index f218805..b9dd1c8 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -72,6 +72,8 @@ LOCAL_SRC_FILES := \
>         bluez/src/shared/crypto.c \
>         bluez/src/shared/uhid.c \
>         bluez/src/shared/att.c \
> +       bluez/src/shared/gatt-helpers.c \
> +       bluez/src/shared/gatt-client.c \
>         bluez/src/sdpd-database.c \
>         bluez/src/sdpd-service.c \
>         bluez/src/sdpd-request.c \
> diff --git a/android/hidhost.c b/android/hidhost.c
> index 729b884..26a8013 100644
> --- a/android/hidhost.c
> +++ b/android/hidhost.c
> @@ -36,15 +36,22 @@
>
>  #include "btio/btio.h"
>  #include "lib/bluetooth.h"
> +#include "lib/uuid.h"
>  #include "lib/sdp.h"
>  #include "lib/sdp_lib.h"
>  #include "src/shared/mgmt.h"
> +#include "src/shared/queue.h"
>  #include "src/shared/util.h"
>  #include "src/shared/uhid.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/shared/gatt-client.h"
>  #include "src/sdp-client.h"
>  #include "src/uuid-helper.h"
>  #include "src/log.h"
>
> +#include "attrib/gattrib.h"
> +
>  #include "hal-msg.h"
>  #include "ipc-common.h"
>  #include "ipc.h"
> @@ -113,6 +120,9 @@ struct hid_device {
>         uint8_t         last_hid_msg;
>         struct bt_hog   *hog;
>         int             sec_level;
> +       GAttrib         *attrib;
> +       struct gatt_db  *db;
> +       struct bt_gatt_client *client;
>  };
>
>  static int device_cmp(gconstpointer s, gconstpointer user_data)
> @@ -145,6 +155,9 @@ static void hid_device_free(void *data)
>         if (dev->hog)
>                 bt_hog_unref(dev->hog);
>
> +       if (dev->db)
> +               gatt_db_unref(dev->db);
> +

gatt_db_unref already checks for null, so you don't need a check here.
bt_hog_unref does too although it's unrelated.

>         g_free(dev->rd_data);
>         g_free(dev);
>  }
> @@ -792,10 +805,37 @@ fail:
>         hid_device_remove(dev);
>  }
>
> +static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
> +{
> +       struct hid_device *dev = user_data;
> +
> +       if (!success) {
> +               error("HoG: client not ready");
> +               goto fail;
> +       }
> +
> +       if (!bt_hog_attach(dev->hog, dev->attrib)) {
> +               error("HoG: unable to attach");
> +               goto fail;
> +       }
> +
> +       bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTED);
> +
> +       if (!bt_gatt_add_autoconnect(hog_app, &dev->dst))
> +               error("HoG: Could not add to autoconnect list");
> +
> +       return;
> +fail:
> +       bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
> +       hid_device_remove(dev);
> +}
> +
>  static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
>  {
>         GSList *l;
>         struct hid_device *dev;
> +       struct bt_att *att;
> +       uint16_t mtu;
>
>         l = g_slist_find_custom(devices, addr, device_cmp);
>         dev = l ? l->data : NULL;
> @@ -807,6 +847,10 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
>                         bt_hid_notify_state(dev,
>                                                 HAL_HIDHOST_STATE_DISCONNECTED);
>                         bt_hog_detach(dev->hog);
> +                       bt_gatt_client_unref(dev->client);
> +                       g_attrib_unref(dev->attrib);
> +                       dev->attrib = NULL;
> +                       dev->client = NULL;
>                         return;
>                 }
>                 goto fail;
> @@ -816,34 +860,43 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
>                 dev = hid_device_new(addr);
>
>         if (!dev->hog) {
> -               /* TODO: Get device details and primary */
> +               /* TODO: Get device details */
>                 dev->hog = bt_hog_new_default("bluez-input-device", dev->vendor,
>                                         dev->product, dev->version, NULL);
>                 if (!dev->hog) {
>                         error("HoG: unable to create session");
>                         goto fail;
>                 }
> -       }
>
> -       if (!bt_hog_attach(dev->hog, attrib)) {
> -               error("HoG: unable to attach");
> -               goto fail;
> +               dev->db = gatt_db_new();
> +               if (!dev->db) {
> +                       error("HoG: unable to create gatt_db");
> +                       goto fail;
> +               }
>         }
>
> -       if (!bt_gatt_set_security(addr, BT_IO_SEC_MEDIUM)) {
> +       att = g_attrib_get_att(attrib);
> +       dev->attrib = g_attrib_ref(attrib);
> +       mtu = bt_att_get_mtu(att);
> +
> +       /* Enable encryption before gatt_client starts discovering services */
> +       if (!bt_att_set_sec_level(att, BT_SECURITY_MEDIUM)) {
>                 error("Failed to set security level");
>                 goto fail;
>         }
>
>         DBG("");
>
> -       bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTED);
> -
> -       if (!bt_gatt_add_autoconnect(hog_app, &dev->dst))
> -               error("hidhost: Could not add to autoconnect list");
> +       dev->client = bt_gatt_client_new(dev->db, att, mtu);
> +       if (!dev->client) {
> +               error("Failed to create gatt_client");
> +               goto fail;
> +       }
>
> +       /* Wait until client is initialized */
> +       bt_gatt_client_set_ready_handler(dev->client, client_ready_cb,
> +                                                               dev, NULL);
>         return;
> -
>  fail:
>         bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
>         hid_device_remove(dev);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Michael Janssen

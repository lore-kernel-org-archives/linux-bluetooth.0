Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 21/28] android/bas: Start using bt_gatt_client
Date: Thu, 02 Apr 2015 17:37:11 +0200
Message-ID: <4892132.Mhxg8hoJYK@leonov>
In-Reply-To: <1427906444-11769-22-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com> <1427906444-11769-22-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Wednesday 01 of April 2015 18:40:37 Mariusz Skamra wrote:
> This patch replaces gattrib with bt_gatt_client and strips glib
> dependencies. ---
>  android/bas.c | 162
> ++++++++++++++++++---------------------------------------- android/bas.h | 
>  4 +-
>  android/hog.c |  40 ++-------------
>  3 files changed, 57 insertions(+), 149 deletions(-)
> 
> diff --git a/android/bas.c b/android/bas.c
> index c5de3b1..3b641eb 100644
> --- a/android/bas.c
> +++ b/android/bas.c
> @@ -28,53 +28,47 @@
>  #include <stdbool.h>
>  #include <errno.h>
> 
> -#include <glib.h>
> -
>  #include "src/log.h"
> 
>  #include "lib/bluetooth.h"
> -#include "lib/sdp.h"
>  #include "lib/uuid.h"
> 
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> -
> -#include "attrib/gattrib.h"
> -#include "attrib/att.h"
> -#include "attrib/gatt.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-db.h"
> +#include "src/shared/gatt-client.h"
> 
>  #include "android/bas.h"
> 
> -#define ATT_NOTIFICATION_HEADER_SIZE 3
> -#define ATT_READ_RESPONSE_HEADER_SIZE 1
> -
>  struct bt_bas {
>  	int ref_count;
> -	GAttrib *attrib;
> -	struct gatt_primary *primary;
> -	uint16_t handle;
> -	uint16_t ccc_handle;
> -	guint id;
> +	uint16_t service_handle; /* Battery service start handle */
> +	uint16_t handle; /* Battery level value handle */
> +	uint32_t id;
> +	struct bt_gatt_client *client;
> +	struct gatt_db *db;
>  };
> 
>  static void bas_free(struct bt_bas *bas)
>  {
>  	bt_bas_detach(bas);
> 
> -	g_free(bas->primary);
> -	g_free(bas);
> +	free(bas);
>  }
> 
> -struct bt_bas *bt_bas_new(void *primary)
> +struct bt_bas *bt_bas_new(uint16_t service_handle)
>  {
>  	struct bt_bas *bas;
> 
> -	bas = g_try_new0(struct bt_bas, 1);
> +	if (!service_handle)
> +		return NULL;
> +
> +	bas = new0(struct bt_bas, 1);
>  	if (!bas)
>  		return NULL;
> 
> -	if (primary)
> -		bas->primary = g_memdup(primary, sizeof(*bas->primary));
> +	bas->service_handle = service_handle;
> 
>  	return bt_bas_ref(bas);
>  }
> @@ -100,132 +94,76 @@ void bt_bas_unref(struct bt_bas *bas)
>  	bas_free(bas);
>  }
> 
> -static void notification_cb(const guint8 *pdu, guint16 len, gpointer
> user_data) -{
> -	DBG("Battery Level at %u", pdu[ATT_NOTIFICATION_HEADER_SIZE]);
> -}
> -
> -static void read_value_cb(guint8 status, const guint8 *pdu, guint16 len,
> -					gpointer user_data)
> -{
> -	DBG("Battery Level at %u", pdu[ATT_READ_RESPONSE_HEADER_SIZE]);
> -}
> -
> -static void ccc_written_cb(guint8 status, const guint8 *pdu,
> -					guint16 plen, gpointer user_data)
> +static void notification_cb(uint16_t value_handle, const uint8_t *value,
> +					uint16_t length, void *user_data)
>  {
> -	struct bt_bas *bas = user_data;
> -
> -	if (status != 0) {
> -		error("Write Scan Refresh CCC failed: %s",
> -						att_ecode2str(status));
> -		return;
> -	}
> -
> -	DBG("Battery Level: notification enabled");
> -
> -	bas->id = g_attrib_register(bas->attrib, ATT_OP_HANDLE_NOTIFY,
> -					bas->handle, notification_cb, bas,
> -					NULL);
> +	DBG("Battery Level at %u", value[0]);
>  }
> 
> -static void write_ccc(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
> -							void *user_data)
> +static void read_value_cb(bool success, uint8_t att_ecode, const uint8_t
> *value, +		uint16_t length, void *user_data)
>  {
> -	uint8_t value[2];
> +	if (!success)
> +		error("Read battery level failed: att_ecode %d", att_ecode);
> 
> -	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
> -
> -	gatt_write_char(attrib, handle, value, sizeof(value), ccc_written_cb,
> -								user_data);
> +	DBG("Battery Level at %u", value[0]);
>  }
> 
> -static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
> -							gpointer user_data)
> +static void ccc_written_cb(uint16_t att_ecode, void *user_data)
>  {
> -	struct bt_bas *bas = user_data;
> -
> -	if (status != 0) {
> -		error("Error reading CCC value: %s", att_ecode2str(status));
> -		return;
> -	}
> -
> -	write_ccc(bas, bas->attrib, bas->ccc_handle, bas);
> -}
> -
> -static void discover_descriptor_cb(uint8_t status, GSList *descs,
> -								void *user_data)
> -{
> -	struct bt_bas *bas = user_data;
> -	struct gatt_desc *desc;
> -
> -	if (status != 0) {
> -		error("Discover descriptors failed: %s", att_ecode2str(status));
> -		return;
> -	}
> -
> -	/* There will be only one descriptor on list and it will be CCC */
> -	desc = descs->data;
> -	bas->ccc_handle = desc->handle;
> -
> -	gatt_read_char(bas->attrib, desc->handle, ccc_read_cb, bas);
> +	DBG("Battery Level: notification enabled");
>  }
> 
> -static void bas_discovered_cb(uint8_t status, GSList *chars, void
> *user_data) +static void bas_discovered_cb(struct gatt_db_attribute
> *attrib, void *user_data) {
>  	struct bt_bas *bas = user_data;
> -	struct gatt_char *chr;
> -	uint16_t start, end;
> +	uint16_t value_handle;
>  	bt_uuid_t uuid;
> 
> -	if (status) {
> -		error("Battery: %s", att_ecode2str(status));
> -		return;
> -	}
> +	gatt_db_attribute_get_char_data(attrib, NULL, &value_handle,
> +							NULL, &uuid);
> 
> -	chr = chars->data;
> -	bas->handle = chr->value_handle;
> +	bas->handle = value_handle;
> 
>  	DBG("Battery handle: 0x%04x", bas->handle);
> 
> -	gatt_read_char(bas->attrib, bas->handle, read_value_cb, bas);
> -
> -	start = chr->value_handle + 1;
> -	end = bas->primary->range.end;
> +	bt_gatt_client_read_value(bas->client, bas->handle, read_value_cb,
> +								bas, NULL);
> 
> -	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
> +	bas->id = bt_gatt_client_register_notify(bas->client, bas->handle,
> +				ccc_written_cb, notification_cb, bas, NULL);
> 
> -	gatt_discover_desc(bas->attrib, start, end, &uuid,
> -						discover_descriptor_cb, bas);
> +	/* TODO Characteristic Presentation Format shall be read */
>  }
> 
> -bool bt_bas_attach(struct bt_bas *bas, void *attrib)
> +bool bt_bas_attach(struct bt_bas *bas, struct bt_gatt_client *client)
>  {
> -	if (!bas || bas->attrib || !bas->primary)
> -		return false;
> +	struct gatt_db_attribute *attrib;
> 
> -	bas->attrib = g_attrib_ref(attrib);
> +	if (!bas || bas->client || !bas->service_handle)
> +		return false;
> 
> -	if (bas->handle > 0)
> -		return true;
> +	bas->client = bt_gatt_client_ref(client);
> +	bas->db = bt_gatt_client_get_db(client);
> +	attrib = gatt_db_get_attribute(bas->db, bas->service_handle);
> 
> -	gatt_discover_char(bas->attrib, bas->primary->range.start,
> -					bas->primary->range.end, NULL,
> -					bas_discovered_cb, bas);
> +	if (!bas->handle)
> +		gatt_db_service_foreach_char(attrib, bas_discovered_cb, bas);
> 
>  	return true;
>  }
> 
>  void bt_bas_detach(struct bt_bas *bas)
>  {
> -	if (!bas || !bas->attrib)
> +	if (!bas || !bas->client)
>  		return;
> 
> -	if (bas->id > 0) {
> -		g_attrib_unregister(bas->attrib, bas->id);
> +	if (bas->id) {
> +		bt_gatt_client_unregister_notify(bas->client, bas->id);
>  		bas->id = 0;
>  	}
> 
> -	g_attrib_unref(bas->attrib);
> -	bas->attrib = NULL;
> +	gatt_db_unref(bas->db);

bas->db = NULL;

> +	bt_gatt_client_unref(bas->client);
> +	bas->client = NULL;
>  }
> diff --git a/android/bas.h b/android/bas.h
> index 3e175b5..ce903e3 100644
> --- a/android/bas.h
> +++ b/android/bas.h
> @@ -23,10 +23,10 @@
> 
>  struct bt_bas;
> 
> -struct bt_bas *bt_bas_new(void *primary);
> +struct bt_bas *bt_bas_new(uint16_t service_handle);
> 
>  struct bt_bas *bt_bas_ref(struct bt_bas *bas);
>  void bt_bas_unref(struct bt_bas *bas);
> 
> -bool bt_bas_attach(struct bt_bas *bas, void *gatt);
> +bool bt_bas_attach(struct bt_bas *bas, struct bt_gatt_client *client);
>  void bt_bas_detach(struct bt_bas *bas);
> diff --git a/android/hog.c b/android/hog.c
> index 78c1b26..4565e86 100644
> --- a/android/hog.c
> +++ b/android/hog.c
> @@ -990,15 +990,15 @@ static void hog_attach_dis(struct bt_hog *hog,
> uint16_t service_handle) }
>  }
> 
> -static void hog_attach_bas(struct bt_hog *hog, struct gatt_primary
> *primary) +static void hog_attach_bas(struct bt_hog *hog, uint16_t
> service_handle) {
>  	struct bt_bas *instance;
> 
> -	instance = bt_bas_new(primary);
> +	instance = bt_bas_new(service_handle);
>  	if (!instance)
>  		return;
> 
> -	bt_bas_attach(instance, hog->attrib);
> +	bt_bas_attach(instance, hog->client);
>  	queue_push_head(hog->bas, instance);
>  }
> 
> @@ -1025,34 +1025,6 @@ static void hog_attach_hog(struct bt_hog *hog,
> uint16_t service_handle) queue_push_tail(hog->instances, instance);
>  }
> 
> -static void primary_cb(uint8_t status, GSList *services, void *user_data)
> -{
> -	struct bt_hog *hog = user_data;
> -	struct gatt_primary *primary;
> -	GSList *l;
> -
> -	DBG("");
> -
> -	if (status) {
> -		const char *str = att_ecode2str(status);
> -		DBG("Discover primary failed: %s", str);
> -		return;
> -	}
> -
> -	if (!services) {
> -		DBG("No primary service found");
> -		return;
> -	}
> -
> -	for (l = services; l; l = l->next) {
> -		primary = l->data;
> -
> -		if (strcmp(primary->uuid, BATTERY_UUID) == 0) {
> -			hog_attach_bas(hog, primary);
> -		}
> -	}
> -}
> -
>  static void service_cb(struct gatt_db_attribute *attrib, void *user_data)
>  {
>  	struct bt_hog *hog = user_data;
> @@ -1073,8 +1045,7 @@ static void service_cb(struct gatt_db_attribute
> *attrib, void *user_data) else if (!bt_uuid_strcmp(uuid,
> DEVICE_INFORMATION_UUID))
>  		hog_attach_dis(hog, service_handle);
>  	else if (!bt_uuid_strcmp(uuid, BATTERY_UUID))
> -		/* TODO */
> -		return;
> +		hog_attach_bas(hog, service_handle);
>  }
> 
>  bool bt_hog_attach(struct bt_hog *hog, void *gatt, void *client)
> @@ -1090,7 +1061,6 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt,
> void *client)
> 
>  	if (!hog->service_handle) {
>  		gatt_db_foreach_service(hog->db, NULL, service_cb, hog);
> -		gatt_discover_primary(hog->attrib, NULL, primary_cb, hog);
>  		return true;
>  	}
> 
> @@ -1100,7 +1070,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt,
> void *client) if (hog->dis)
>  		bt_dis_attach(hog->dis, hog->client);
> 
> -	queue_foreach(hog->bas, (void *) bt_bas_attach, gatt);
> +	queue_foreach(hog->bas, (void *) bt_bas_attach, hog->client);
> 
>  	hog_entry = queue_get_entries(hog->instances);
>  	while (hog_entry) {

-- 
BR
Szymon Janc

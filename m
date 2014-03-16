Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 3/4] android/gatt: Add GATT Connect
Date: Sun, 16 Mar 2014 18:32:25 +0100
Message-ID: <1484281.rtieurC29v@leonov>
In-Reply-To: <1394804979-7270-4-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394804979-7270-1-git-send-email-lukasz.rymanowski@tieto.com> <1394804979-7270-4-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Friday 14 of March 2014 14:49:38 Lukasz Rymanowski wrote:
> This patch introduce connect LE device functionality.
> 
> There is gatt_device representing remote le device. Each gatt device
> has a list own list of clients as it is possible that more apps
> would like to use same remote device.
> 
> Possible connect scenarios:
> 
> 1.  There is no ACL connection to device:
> Then new dev is put on conn_wait_queue and le scan is enabled.
> Once device is found we do connect it.
> 
> Once device is connected then device is moved form conn_wait_queue to
> conn_list and success event is sent to client(s) with conn_id
> 
> 2. Device is already connected:
> Then we update client list, reply with success and do send connect event.
> 
> 3. For unregisterd clients or uknown conn_id, failed response is sent.
> ---
>  android/Android.mk  |   4 +
>  android/Makefile.am |   3 +
>  android/gatt.c      | 475
> +++++++++++++++++++++++++++++++++++++++++++++++++--- 3 files changed, 463
> insertions(+), 19 deletions(-)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 34e21ea..0e0932d 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -60,9 +60,13 @@ LOCAL_SRC_FILES := \
>  	bluez/lib/sdp.c \
>  	bluez/lib/bluetooth.c \
>  	bluez/lib/hci.c \
> +	bluez/lib/uuid.c \
>  	bluez/btio/btio.c \
>  	bluez/src/sdp-client.c \
>  	bluez/profiles/network/bnep.c \
> +	bluez/attrib/gattrib.c \
> +	bluez/attrib/gatt.c \
> +	bluez/attrib/att.c
> 
>  LOCAL_C_INCLUDES := \
>  	$(call include-path-for, glib) \
> diff --git a/android/Makefile.am b/android/Makefile.am
> index e7de560..1d0747e 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -42,6 +42,9 @@ android_bluetoothd_SOURCES = android/main.c \
>  				android/handsfree.h android/handsfree.c \
>  				android/gatt.h android/gatt.c \
>  				android/health.h android/health.c \
> +				attrib/att.c attrib/att.h \
> +				attrib/gatt.c attrib/gatt.h \
> +				attrib/gattrib.c attrib/gattrib.h \
>  				btio/btio.h btio/btio.c \
>  				src/sdp-client.h src/sdp-client.c \
>  				profiles/network/bnep.h profiles/network/bnep.c
> diff --git a/android/gatt.c b/android/gatt.c
> index 38f7c1b..9afdf4b 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -29,10 +29,13 @@
>  #include <stdlib.h>
>  #include <stdint.h>
>  #include <glib.h>
> +#include <errno.h>
> +#include <sys/socket.h>
> 
>  #include "ipc.h"
>  #include "ipc-common.h"
>  #include "lib/sdp.h"
> +#include "lib/uuid.h"
>  #include "bluetooth.h"
>  #include "gatt.h"
>  #include "src/log.h"
> @@ -40,16 +43,38 @@
>  #include "utils.h"
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> +#include "attrib/gattrib.h"
> +#include "attrib/att.h"
> +#include "attrib/gatt.h"
> +#include "btio/btio.h"
> 
>  struct gatt_client {
>  	int32_t id;
>  	uint8_t uuid[16];
>  };
> 
> +struct gatt_device {
> +	bdaddr_t bdaddr;
> +	uint8_t bdaddr_type;
> +
> +	struct queue *clients;
> +
> +	bool connect_ready;
> +	int32_t conn_id;
> +
> +	GAttrib *attrib;
> +	GIOChannel *att_io;
> +
> +	guint watch_id;
> +};
> +
>  static struct ipc *hal_ipc = NULL;
>  static bdaddr_t adapter_addr;
> +
>  static struct queue *gatt_clients = NULL;
>  static struct queue *scan_clients = NULL;
> +static struct queue *conn_list	= NULL;		/* Connected devices */
> +static struct queue *conn_wait_queue = NULL;	/* Devices waiting for connect
> */
> 
>  static bool match_client_by_uuid(const void *data, const void *user_data)
>  {
> @@ -72,29 +97,25 @@ static bool match_by_value(const void *data, const void
> *user_data) return data == user_data;
>  }
> 
> -static void le_device_found_handler(bdaddr_t *addr, uint8_t addr_type, int
> rssi, -					uint16_t eir_len, const void *eir)
> +static bool match_dev_by_bdaddr(const void *data, const void *user_data)
>  {
> -	uint8_t buf[IPC_MTU];
> -	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
> -	char bda[18];
> +	const struct gatt_device *dev = data;
> +	const bdaddr_t *addr = user_data;
> 
> -	if (queue_isempty(scan_clients))
> -		return;
> -
> -	ba2str(addr, bda);
> -	DBG("gatt: LE Device found: %s, rssi: %d, adv_data: %d", bda, rssi,
> -							eir ? true : false);
> +	return !bacmp(&dev->bdaddr, addr);
> +}
> 
> -	bdaddr2android(addr, ev->bda);
> -	ev->rssi = rssi;
> -	ev->len = eir_len;
> +static bool match_dev_connect_ready(const void *data, const void
> *user_data) +{
> +	const struct gatt_device *dev = data;
> 
> -	memcpy(ev->adv_data, eir, ev->len);
> +	return dev->connect_ready;
> +}
> 
> -	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> -						HAL_EV_GATT_CLIENT_SCAN_RESULT,
> -						sizeof(ev) + eir_len, ev);
> +static void destroy_device(struct gatt_device *dev)
> +{
> +	queue_destroy(dev->clients, NULL);
> +	free(dev);
>  }
> 
>  static void handle_client_register(const void *buf, uint16_t len)
> @@ -172,6 +193,253 @@ failed:
>  					HAL_OP_GATT_CLIENT_UNREGISTER, status);
>  }
> 
> +static void connection_cleanup(struct gatt_device *device)
> +{
> +	if (device->watch_id) {
> +		g_source_remove(device->watch_id);
> +		device->watch_id = 0;
> +	}
> +
> +	if (device->att_io) {
> +		g_io_channel_shutdown(device->att_io, FALSE, NULL);
> +		g_io_channel_unref(device->att_io);
> +		device->att_io = NULL;
> +	}
> +
> +	if (device->attrib) {
> +		GAttrib *attrib = device->attrib;
> +		device->attrib = NULL;
> +		g_attrib_cancel_all(attrib);
> +		g_attrib_unref(attrib);
> +	}
> +}
> +
> +static void send_disconnect_notify(void *data, void *user_data)
> +{
> +	struct hal_ev_gatt_client_disconnect ev;
> +	struct gatt_device *dev = user_data;
> +
> +	ev.client_if = PTR_TO_INT(data);
> +	ev.conn_id = dev->conn_id;
> +	ev.status = HAL_STATUS_SUCCESS;
> +	bdaddr2android(&dev->bdaddr, &ev.bda);
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> +			HAL_EV_GATT_CLIENT_DISCONNECT, sizeof(ev), &ev);
> +}

This should have proper types as parameters and if needed dedicated wrapper 
callback for list iteration should be added.

> +
> +static bool is_device_wating_for_connect(const bdaddr_t *addr, uint8_t
> addr_type) +{
> +	struct gatt_device *dev;
> +
> +	DBG("");
> +
> +	dev = queue_find(conn_wait_queue, match_dev_by_bdaddr, (void *)addr);

No need cast to (void *) here.

> +	if (!dev)
> +		return false;
> +
> +	dev->bdaddr_type = addr_type;
> +
> +	/* Mark that this device is ready for connect.
> +	 * Need it because will continue with connect after scan is stopped
> +	 */
> +	dev->connect_ready = true;
> +
> +	return true;
> +}
> +
> +static void bt_le_discovery_stop_cb(void);

If this is really needed I'd prefer to have this before any function 
definitions at file's top.

> +
> +static void le_device_found_handler(bdaddr_t *addr, uint8_t addr_type,
> +						int rssi, uint16_t eir_len,
> +							const void *eir)
> +{
> +	uint8_t buf[IPC_MTU];
> +	struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
> +	char bda[18];
> +
> +	if (queue_isempty(scan_clients))
> +		goto connect;
> +
> +	ba2str(addr, bda);
> +	DBG("gatt: LE Device found: %s, rssi: %d, adv_data: %d", bda, rssi,
> +									!!eir);
> +
> +	bdaddr2android(addr, ev->bda);
> +	ev->rssi = rssi;
> +	ev->len = eir_len;
> +
> +	memcpy(ev->adv_data, eir, ev->len);
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> +						HAL_EV_GATT_CLIENT_SCAN_RESULT,
> +						sizeof(ev) + eir_len, ev);

Use ev->len here instead of eir_len.

> +
> +connect:
> +	if (!is_device_wating_for_connect(addr, addr_type))
> +		return;
> +
> +	/* We are ok to perform connect now. Stop discovery
> +	* and once it is stopped continue with creating ACL
> +	*/
> +	bt_le_discovery_stop(bt_le_discovery_stop_cb);
> +}
> +
> +static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
> +							gpointer user_data)
> +{
> +	bdaddr_t *addr = user_data;
> +	struct gatt_device *dev;
> +	int sock, err = 0;
> +	socklen_t len;
> +
> +	sock = g_io_channel_unix_get_fd(io);
> +	len = sizeof(err);
> +	getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len);

Should check if getsockopt() succeed. Also this watch should probably check 
for G_IO_ERR and G_IO_NVAL as well.

> +
> +	DBG("%s (%d)", strerror(err), err);
> +
> +	dev = queue_remove_if(conn_list, match_dev_by_bdaddr, addr);
> +	connection_cleanup(dev);
> +
> +	/* Keep scanning/re-connection active if disconnection reason
> +	 * is connection timeout, remote user terminated connection or local
> +	 * initiated disconnection.
> +	 */
> +	if (err == ETIMEDOUT || err == ECONNRESET || err == ECONNABORTED) {
> +		if (!queue_push_tail(conn_wait_queue, dev)) {
> +			error("gatt: Cannot push data");
> +		} else {
> +			bt_le_discovery_start(le_device_found_handler);
> +			return FALSE;
> +		}
> +	}
> +
> +	queue_foreach(dev->clients, send_disconnect_notify, dev);
> +	destroy_device(dev);
> +
> +	return FALSE;
> +}
> +
> +static void send_client_connect_notify(void *data, void *user_data)
> +{
> +	struct hal_ev_gatt_client_connect *ev = user_data;
> +	int32_t id = PTR_TO_INT(data);
> +
> +	ev->client_if = id;
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> +				HAL_EV_GATT_CLIENT_CONNECT, sizeof(*ev), ev);
> +
> +}
> +static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
> +{
> +	bdaddr_t *addr = user_data;
> +	struct gatt_device *dev;
> +	struct hal_ev_gatt_client_connect ev;
> +	GAttrib *attrib;
> +	static uint32_t conn_id = 0;
> +	uint8_t status;
> +
> +	/* Take device form conn waiting queue */

typo: form->from

> +	dev = queue_remove_if(conn_wait_queue, match_dev_by_bdaddr, addr);
> +	if (!dev) {
> +		error("gatt: Device not on the connect wait queue!?");
> +		g_io_channel_shutdown(io, TRUE, NULL);
> +		return;
> +	}
> +
> +	g_io_channel_unref(dev->att_io);
> +	dev->att_io = NULL;
> +
> +	/* Set address and client id in the event */
> +	bdaddr2android(&dev->bdaddr, &ev.bda);
> +
> +	if (gerr) {
> +		error("gatt: connection failed %s", gerr->message);
> +		status = HAL_STATUS_FAILED;
> +		goto reply;
> +	}
> +
> +	attrib = g_attrib_new(io);
> +	if (!attrib) {
> +		error("gatt: unable to create new GAttrib instance");
> +		status = HAL_STATUS_FAILED;
> +		goto reply;
> +	}
> +
> +	dev->attrib = attrib;
> +	dev->watch_id = g_io_add_watch(io, G_IO_HUP, disconnected_cb, dev);
> +	dev->conn_id = ++conn_id;
> +
> +	/* Move gatt device from connect queue to conn_list */
> +	if (!queue_push_tail(conn_list, dev)) {
> +		error("gatt: Cannot push dev on conn_list");
> +		connection_cleanup(dev);
> +		status = HAL_STATUS_FAILED;
> +		goto reply;
> +	}
> +
> +	status = HAL_STATUS_SUCCESS;
> +	goto reply;
> +
> +reply:
> +	ev.conn_id = dev ? conn_id : 0;

I would do  dev ? dev->conn_id : 0 for clarity.

> +	ev.status = status;
> +
> +	queue_foreach(dev->clients, send_client_connect_notify, &ev);
> +
> +	/* If connection did not succeed, destroy device */
> +	if (status)
> +		destroy_device(dev);
> +}
> +
> +static int connect_le(struct gatt_device *dev)
> +{
> +	BtIOSecLevel sec_level;
> +	GIOChannel *io;
> +	GError *gerr = NULL;
> +	char addr[18];
> +
> +	ba2str(&dev->bdaddr, addr);
> +
> +	/* There is one connection attempt going on */
> +	if (dev->att_io) {
> +		info("gatt: connection to dev %s is ongoing", addr);
> +		return -EALREADY;
> +	}
> +
> +	DBG("Connection attempt to: %s", addr);
> +
> +	/*TODO: If we are bonded then we should use higier sec level */
> +	sec_level = BT_IO_SEC_LOW;
> +
> +	/*
> +	 * This connection will help us catch any PDUs that comes before
> +	 * pairing finishes
> +	 */
> +	io = bt_io_connect(connect_cb, dev, NULL, &gerr,
> +			BT_IO_OPT_SOURCE_BDADDR,
> +			&adapter_addr,
> +			BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
> +			BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
> +			BT_IO_OPT_DEST_TYPE, dev->bdaddr_type,
> +			BT_IO_OPT_CID, ATT_CID,
> +			BT_IO_OPT_SEC_LEVEL, sec_level,
> +			BT_IO_OPT_INVALID);
> +	if (!io) {
> +		error("gatt: Failed bt_io_connect(%s): %s", addr,
> +							gerr->message);
> +		g_error_free(gerr);
> +		return -EIO;
> +	}
> +
> +	/* Keep this, so we can cancel the connection */
> +	dev->att_io = io;
> +
> +	return 0;
> +}
> +
>  static void handle_client_scan(const void *buf, uint16_t len)
>  {
>  	const struct hal_cmd_gatt_client_scan *cmd = buf;
> @@ -229,12 +497,166 @@ reply:
>  									status);
>  }
> 
> +static int connect_next_dev(void)
> +{
> +	struct gatt_device *dev;
> +
> +	DBG("");
> +
> +	if (queue_isempty(conn_wait_queue))
> +		return 0;
> +
> +	/* Discovery has been stopped because there is connection waiting */
> +	dev = queue_find(conn_wait_queue, match_dev_connect_ready, NULL);
> +	if (!dev)
> +		/* Lets try again. */
> +		return -1;
> +
> +	dev->connect_ready = false;
> +
> +	return connect_le(dev);
> +}
> +
> +static void bt_le_discovery_stop_cb(void)
> +{
> +	DBG("");
> +
> +	/* Check now if there is any device ready to connect*/
> +	if (connect_next_dev() < 0)
> +		bt_le_discovery_start(le_device_found_handler);
> +}
> +
> +static struct gatt_device *find_device(bdaddr_t *addr)
> +{
> +	struct gatt_device *dev;
> +
> +	dev = queue_find(conn_list, match_dev_by_bdaddr, addr);
> +	if (dev)
> +		return dev;
> +
> +	dev = queue_find(conn_wait_queue, match_dev_by_bdaddr, addr);
> +	if (dev)
> +		return dev;
> +
> +	return NULL;
> +}
> +
>  static void handle_client_connect(const void *buf, uint16_t len)
>  {
> +	const struct hal_cmd_gatt_client_connect *cmd = buf;
> +	struct gatt_device *dev = NULL;
> +	void *l;
> +	bdaddr_t addr;
> +	uint8_t status;
> +	bool send_notify = false;
> +
>  	DBG("");
> 
> +	/* Check if client is registered */
> +	l = queue_find(gatt_clients, match_client_by_id,
> +						INT_TO_PTR(cmd->client_if));
> +	if (!l) {
> +		error("gatt: Client id %d not found", cmd->client_if);
> +		status = HAL_STATUS_FAILED;
> +		goto reply;
> +	}
> +
> +	android2bdaddr(&cmd->bdaddr, &addr);
> +
> +	/* We do support many clients for one device connection so lets check
> +	  * If device is connected or in connecting state just update list of
> +	  * clients
> +	  */
> +	dev = find_device(&addr);
> +	if (dev) {
> +
> +		status = HAL_STATUS_SUCCESS;

Set status before goto only.

> +
> +		/* Remeber to send dummy notification event  if we area
> +		 * connected
> +		 */
> +		if (dev->conn_id)
> +			send_notify = true;
> +
> +		if (queue_find(dev->clients, match_by_value,
> +						INT_TO_PTR(cmd->client_if)))
> +				goto reply;
> +
> +		/* Store another client */
> +		if (!queue_push_tail(dev->clients,
> +						INT_TO_PTR(cmd->client_if))) {
> +			error("gatt: Cannot push client on gatt device list");
> +			status = HAL_STATUS_FAILED;
> +			goto reply;
> +		}
> +
> +		goto reply;
> +	}
> +
> +	/* Lets create new gatt device and put it on conn_wait_queue.
> +	  * Once it is connected we move it to conn_list
> +	  */
> +	dev = new0(struct gatt_device, 1);
> +	if (!dev) {
> +		status = HAL_STATUS_FAILED;
> +		goto reply;
> +	}
> +
> +	memcpy(&dev->bdaddr, &addr, sizeof(bdaddr_t));
> +
> +	/* Create queue to keep list of clients for given device*/
> +	dev->clients = queue_new();
> +	if (!dev->clients) {
> +		error("gatt: Cannot create client queue");
> +		status = HAL_STATUS_FAILED;
> +		goto reply;
> +	}
> +
> +	/* Update client list of device */
> +	if (!queue_push_tail(dev->clients, INT_TO_PTR(cmd->client_if))) {
> +		error("gatt: Cannot push client on the client queue!?");
> +		status = HAL_STATUS_FAILED;
> +		goto reply;
> +	}
> +
> +	/* Start le scan if not started */
> +	if (queue_isempty(scan_clients)) {
> +		if (!bt_le_discovery_start(le_device_found_handler)) {
> +			error("gatt: Could not start scan");
> +			status = HAL_STATUS_FAILED;
> +			goto reply;
> +		}
> +	}
> +
> +	if (!queue_push_tail(conn_wait_queue, dev)) {
> +		error("gatt: Cannot push device on conn_wait_queue");
> +		status = HAL_STATUS_FAILED;
> +		goto reply;
> +	}
> +
> +	status = HAL_STATUS_SUCCESS;
> +	goto reply;
> +

This goto is not needed :)

> +reply:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_CONNECT,
> -							HAL_STATUS_FAILED);
> +								status);
> +
> +	/* Send dummy notification since ACL is already up*/
> +	if (send_notify) {
> +		struct hal_ev_gatt_client_connect ev;
> +
> +		ev.conn_id = dev->conn_id;
> +		ev.status = HAL_STATUS_SUCCESS;
> +		ev.client_if = cmd->client_if;
> +		bdaddr2android(&addr, &ev.bda);
> +
> +		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> +						HAL_EV_GATT_CLIENT_CONNECT,
> +						sizeof(ev), &ev);
> +	}
> +

You are already dereferencing dev in if above. 

> +	if (status && dev)
> +		destroy_device(dev);
>  }
> 
>  static void handle_client_disconnect(const void *buf, uint16_t len)
> @@ -610,6 +1032,18 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t
> *addr)
> 
>  	hal_ipc = ipc;
> 
> +	conn_list = queue_new();
> +	if (!conn_list) {
> +		error("gatt: Can not create conn queue");
> +		return false;
> +	}
> +
> +	conn_wait_queue = queue_new();
> +	if (!conn_wait_queue) {
> +		error("gatt: Can not create conn queue");
> +		return false;
> +	}
> +
>  	ipc_register(hal_ipc, HAL_SERVICE_ID_GATT, cmd_handlers,
>  						G_N_ELEMENTS(cmd_handlers));
> 
> @@ -637,4 +1071,7 @@ void bt_gatt_unregister(void)
> 
>  	ipc_unregister(hal_ipc, HAL_SERVICE_ID_GATT);
>  	hal_ipc = NULL;
> +
> +	queue_destroy(conn_list, NULL);
> +	queue_destroy(conn_wait_queue, NULL);

Full those lists here for completeness.

>  }

-- 
BR
Szymon Janc

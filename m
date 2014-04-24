Return-Path: <cyrus@holtmann.org>
Message-ID: <5358EE2D.5090807@tieto.com>
Date: Thu, 24 Apr 2014 12:57:49 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] android/gatt: Refactor client connection handling
References: <1398255967-22167-1-git-send-email-jakub.tyszkowski@tieto.com> <1398255967-22167-2-git-send-email-jakub.tyszkowski@tieto.com> <CAF3PWx1E4DscULb_y-_c_xzGwuywKppX7+UxJ290r4Ekto0bHA@mail.gmail.com>
In-Reply-To: <CAF3PWx1E4DscULb_y-_c_xzGwuywKppX7+UxJ290r4Ekto0bHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Andrzej

On 04/23/2014 07:35 PM, Andrzej Kaczmarek wrote:
> Hi Jakub,
>
> On 23 April 2014 14:26, Jakub Tyszkowski <jakub.tyszkowski@tieto.com> wrote:
>>
>> Multiple, connection specific device lists were replaced with one,
>> while devices store their connection state instead. Client list in each
>> device were replaced with single, global list, storing (connection_id,
>> client*, device*) tuples. This seams to be more natural and easier to
>> perform actions which are mostly triggered by specific clients on
>> specific device or connection.
>>
>> Connection id previously assigned to device now properly identifies
>> client<->device and not the physical adapter<->device connection.
>> ---
>>   android/gatt.c | 957 +++++++++++++++++++++++++++++----------------------------
>>   1 file changed, 495 insertions(+), 462 deletions(-)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index 8a6bc12..55f4f97 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -54,6 +54,20 @@
>>   #define GATT_SUCCESS   0x00000000
>>   #define GATT_FAILURE   0x00000101
>>
>> +typedef enum {
>> +       DEVICE_DISCONNECTED = 0,
>> +       DEVICE_CONNECTION_PENDING,
>> +       DEVICE_CONNECTABLE,
>> +       DEVICE_CONNECTED,
>> +} gatt_device_t;
>
> I'd call it device_state.
>

Ups, I've renamed it by accident. Will fix that.

>> +static char *device_str[] = {
>> +       "DISCONNECTED",
>> +       "CONNECTION PENDING",
>> +       "CONNECTABLE",
>> +       "CONNECTED",
>> +};
>
> device_state_str here and make it const.
>

Renamed by accident as above. I'll make it const

>>   struct gatt_client {
>>          int32_t id;
>>          uint8_t uuid[16];
>> @@ -98,8 +112,7 @@ struct service {
>>   struct notification_data {
>>          struct hal_gatt_srvc_id service;
>>          struct hal_gatt_gatt_id ch;
>> -       struct gatt_client *client;
>> -       struct gatt_device *dev;
>> +       struct connection_record *connection;
>>          guint notif_id;
>>          guint ind_id;
>>          int ref;
>> @@ -109,16 +122,21 @@ struct gatt_device {
>>          bdaddr_t bdaddr;
>>          uint8_t bdaddr_type;
>>
>> -       struct queue *clients;
>> -
>> -       bool connect_ready;
>> -       int32_t conn_id;
>> +       gatt_device_t state;
>>
>>          GAttrib *attrib;
>>          GIOChannel *att_io;
>>          struct queue *services;
>>
>>          guint watch_id;
>> +
>> +       uint32_t connection_ref_count;
>
> Why not just e.g. 'conn_ref'? You won't have loooooong lines later.
>

Yeap. Why not :)

>> +};
>> +
>> +struct connection_record {
>> +       struct gatt_device *device;
>> +       struct gatt_client *client;
>> +       int32_t id;
>>   };
>
> connection should be enough (you actually use it like this in function
> names anyway)
>

OK.

>>   static struct ipc *hal_ipc = NULL;
>> @@ -127,9 +145,8 @@ static bool scanning = false;
>>
>>   static struct queue *gatt_clients = NULL;
>>   static struct queue *gatt_servers = NULL;
>> -static struct queue *conn_list = NULL;         /* Connected devices */
>> -static struct queue *conn_wait_queue = NULL;   /* Devs waiting to connect */
>> -static struct queue *disc_dev_list = NULL;     /* Disconnected devices */
>> +static struct queue *gatt_devices = NULL;
>
> And this one I'd call just devices unless there's other list of
> non-gatt devices to be added.
>

Just wanted to keep the gatt_clients, gatt_server convention, but yes, 
this could be changed.

>> +static struct queue *client_connections = NULL;
>>
>>   static struct queue *listen_clients = NULL;
>>
>> @@ -276,26 +293,76 @@ static bool match_dev_by_bdaddr(const void *data, const void *user_data)
>>          return !bacmp(&dev->bdaddr, addr);
>>   }
>>
>> -static bool match_dev_connect_ready(const void *data, const void *user_data)
>> +static bool match_dev_by_state(const void *data, const void *user_data)
>
> You have other functions called e.g.
> 'match_connection_by_device_and_client' so would be good to have this
> consistent - either dev there or device here.
>

I'd go with "device", like "find_device..." functions.

>>   {
>>          const struct gatt_device *dev = data;
>>
>> -       return dev->connect_ready;
>> +       if (dev->state != PTR_TO_UINT(user_data))
>> +               return false;
>> +
>> +       return true;
>>   }
>>
>> -static bool match_dev_by_conn_id(const void *data, const void *user_data)
>> +static bool match_connection_by_id(const void *data, const void *user_data)
>>   {
>> -       const struct gatt_device *dev = data;
>> -       const int32_t conn_id = PTR_TO_INT(user_data);
>> +       const struct connection_record *record = data;
>
> Same here, later in code you use 'conn' or 'connection' as local
> variable for this so as long as it's possible, let's make it
> consistent. I'd make it 'connection' for function arguments and 'conn'
> for local variables to avoid conflicts.
>

Sure.

>> +       const int32_t id = PTR_TO_INT(user_data);
>>
>> -       return dev->conn_id == conn_id;
>> +       return record->id == id;
>>   }
>>
>> -static bool match_dev_without_client(const void *data, const void *user_data)
>> +static bool match_connection_by_device_and_client(const void *data,
>> +                                                       const void *user_data)
>>   {
>> -       const struct gatt_device *dev = data;
>> +       const struct connection_record *record = data;
>> +       const struct connection_record *match = user_data;
>>
>> -       return queue_isempty(dev->clients);
>> +       if (record->device == match->device)
>> +               return record->client == match->client;
>> +
>> +       return false;
>
> return (record->device == match->device && record->client == match->client);
>

OK.

>> +}
>> +
>> +static struct connection_record *find_connection_by_id(int32_t conn_id)
>> +{
>> +       return queue_find(client_connections, match_connection_by_id,
>> +                                                       INT_TO_PTR(conn_id));
>> +}
>> +
>> +static bool match_connection_by_device(const void *data, const void *user_data)
>> +{
>> +       const struct connection_record *record = data;
>> +       const struct gatt_device *dev = user_data;
>> +
>> +       return record->device == dev;
>> +}
>> +
>> +static bool match_connection_by_client(const void *data, const void *user_data)
>> +{
>> +       const struct connection_record *record = data;
>> +       const struct gatt_client *client = user_data;
>> +
>> +       return record->client == client;
>> +}
>> +
>> +static struct gatt_device *find_device(struct gatt_device *dev)
>> +{
>> +       return queue_find(gatt_devices, match_by_value, dev);
>> +}
>> +
>> +static struct gatt_device *find_device_by_addr(const bdaddr_t *addr)
>> +{
>> +       return queue_find(gatt_devices, match_dev_by_bdaddr, (void *)addr);
>> +}
>> +
>> +static struct gatt_device *find_device_by_state(uint32_t state)
>> +{
>> +       struct gatt_device *dev;
>> +
>> +       dev = queue_find(gatt_devices, match_dev_by_state,
>> +                                                       UINT_TO_PTR(state));
>> +
>> +       return dev;
>
> You have other functions above which return directly from queue_find,
> why this one can't?
>

Well... it should. I'll fix it.

>>   }
>>
>>   static bool match_srvc_by_element_id(const void *data, const void *user_data)
>> @@ -355,7 +422,7 @@ static bool match_notification(const void *a, const void *b)
>>          const struct notification_data *a1 = a;
>>          const struct notification_data *b1 = b;
>>
>> -       if (bacmp(&a1->dev->bdaddr, &b1->dev->bdaddr))
>> +       if (a1->connection != b1->connection)
>>                  return false;
>>
>>          if (memcmp(&a1->ch, &b1->ch, sizeof(a1->ch)))
>> @@ -381,11 +448,13 @@ static bool match_char_by_element_id(const void *data, const void *user_data)
>>   static void destroy_notification(void *data)
>>   {
>>          struct notification_data *notification = data;
>> +       struct gatt_client *client;
>>
>>          if (--notification->ref)
>>                  return;
>>
>> -       queue_remove_if(notification->client->notifications, match_notification,
>> +       client = notification->connection->client;
>> +       queue_remove_if(client->notifications, match_notification,
>>                                                                  notification);
>>          free(notification);
>>   }
>> @@ -393,14 +462,31 @@ static void destroy_notification(void *data)
>>   static void unregister_notification(void *data)
>>   {
>>          struct notification_data *notification = data;
>> +       struct gatt_device *dev = notification->connection->device;
>>
>> -       if (notification->notif_id)
>> -               g_attrib_unregister(notification->dev->attrib,
>> -                                                       notification->notif_id);
>> +       /* No device means it was already disconnected and client cleanup was
>> +        * triggered afterwards, but once client unregisters, device stays if
>> +        * used by others. Then just unregister single handle.
>> +        */
>> +       if (!queue_find(gatt_devices, match_by_value, dev))
>> +               return;
>> +
>> +       if (notification->notif_id && dev)
>> +               g_attrib_unregister(dev->attrib, notification->notif_id);
>> +
>> +       if (notification->ind_id && dev)
>> +               g_attrib_unregister(dev->attrib, notification->ind_id);
>> +}
>> +
>> +static void device_set_state(struct gatt_device *dev, uint32_t state)
>> +{
>> +       char bda[18];
>> +
>> +       ba2str(&dev->bdaddr, bda);
>> +       DBG("gatt: Device %s state changed %s -> %s", bda,
>> +                               device_str[dev->state], device_str[state]);
>>
>> -       if (notification->ind_id)
>> -               g_attrib_unregister(notification->dev->attrib,
>> -                                                       notification->ind_id);
>> +       dev->state = state;
>>   }
>>
>>   static void connection_cleanup(struct gatt_device *device)
>> @@ -422,21 +508,18 @@ static void connection_cleanup(struct gatt_device *device)
>>                  g_attrib_cancel_all(attrib);
>>                  g_attrib_unref(attrib);
>>          }
>> -}
>> -
>> -static void destroy_device(void *data)
>> -{
>> -       struct gatt_device *dev = data;
>>
>> -       if (!dev)
>> -               return;
>> -
>> -       if (dev->conn_id)
>> -               connection_cleanup(dev);
>> +       /* If device was in connection_pending or connectable state we
>> +        * search device list if we should stop the scan.
>> +        */
>> +       if (device->state == DEVICE_CONNECTION_PENDING ||
>> +                                       device->state == DEVICE_CONNECTABLE) {
>> +               if (!find_device_by_state(DEVICE_CONNECTION_PENDING) &&
>> +                       !find_device_by_state(DEVICE_CONNECTABLE) && !scanning)
>
> Check bool first - no need to iterate list twice in case scanning==false anyway.
> And perhaps there should be some helper to check if there's device in
> either state so we don't need to iterate list twice - this can be done
> in single pass.
>

I'll add helper function for that.

>> +                                       bt_le_discovery_stop(NULL);
>> +       }
>>
>> -       queue_destroy(dev->clients, NULL);
>> -       queue_destroy(dev->services, destroy_service);
>> -       free(dev);
>> +       device_set_state(device, DEVICE_DISCONNECTED);
>>   }
>>
>>   static void destroy_gatt_client(void *data)
>> @@ -531,123 +614,89 @@ failed:
>>                                                                          status);
>>   }
>>
>> -static void send_client_disconnect_notify(int32_t id, struct gatt_device *dev,
>> -                                                               int32_t status)
>> +static void send_client_connection_notify(struct connection_record *conn,
>> +                                                       int32_t gatt_event,
>> +                                                       int32_t status)
>>   {
>>          struct hal_ev_gatt_client_disconnect ev;
>>
>> -       ev.client_if = id;
>> -       ev.conn_id = dev->conn_id;
>> +       ev.client_if = conn->client->id;
>> +       ev.conn_id = conn->id;
>>          ev.status = status;
>> -       bdaddr2android(&dev->bdaddr, &ev.bda);
>>
>> -       ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
>> -                       HAL_EV_GATT_CLIENT_DISCONNECT, sizeof(ev), &ev);
>> -}
>> +       bdaddr2android(&conn->device->bdaddr, &ev.bda);
>>
>> -static void send_client_connect_notify(int32_t id, struct gatt_device *dev,
>> -                                                               int32_t status)
>> -{
>> -       struct hal_ev_gatt_client_connect ev;
>> -
>> -       ev.client_if = id;
>> -       ev.status = status;
>> -       bdaddr2android(&dev->bdaddr, &ev.bda);
>> -       ev.conn_id = status == GATT_SUCCESS ? dev->conn_id : 0;
>> -
>> -       ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
>> -                               HAL_EV_GATT_CLIENT_CONNECT, sizeof(ev), &ev);
>> +       ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT, gatt_event, sizeof(ev),
>> +                                                                       &ev);
>>   }
>>
>> -static void remove_client_from_device_list(void *data, void *user_data)
>> +static void send_client_disconnect_notify(struct connection_record *conn,
>> +                                                               int32_t status)
>>   {
>> -       struct gatt_device *dev = data;
>> -
>> -       queue_remove_if(dev->clients, match_by_value, user_data);
>> +       send_client_connection_notify(conn, HAL_EV_GATT_CLIENT_DISCONNECT,
>> +                                                                       status);
>>   }
>>
>> -static void put_device_on_disc_list(struct gatt_device *dev)
>> +static void send_client_connect_notify(struct connection_record *conn,
>> +                                                               int32_t status)
>>   {
>> -       dev->conn_id = 0;
>> -       queue_remove_all(dev->clients, NULL, NULL, NULL);
>> -       queue_push_tail(disc_dev_list, dev);
>> +       send_client_connection_notify(conn, HAL_EV_GATT_CLIENT_CONNECT, status);
>>   }
>>
>> -static void cleanup_conn_list(int32_t id)
>> +static void disconnect_notify_by_dev(void *data, void *user_data)
>>   {
>> -       struct gatt_device *dev;
>> -
>> -       /* Find device without client */
>> -       dev = queue_remove_if(conn_list, match_dev_without_client, NULL);
>> -       while (dev) {
>> -               /* Device is connected, lets disconnect and notify client */
>> -               connection_cleanup(dev);
>> -               send_client_disconnect_notify(id, dev, GATT_SUCCESS);
>> +       struct connection_record *record = data;
>> +       struct gatt_device *dev = user_data;
>>
>> -               /* Put device on disconnected device list */
>> -               put_device_on_disc_list(dev);
>> -               dev = queue_remove_if(conn_list, match_dev_without_client,
>> -                                                                       NULL);
>> -       };
>> +       if (dev == record->device) {
>
> if (dev != record->device)
>          return;
>

Got it.

>> +               if (dev->state == DEVICE_CONNECTED)
>> +                       send_client_disconnect_notify(record, GATT_SUCCESS);
>> +               else if (dev->state == DEVICE_CONNECTION_PENDING ||
>> +                                       dev->state == DEVICE_CONNECTABLE)
>> +                       send_client_connect_notify(record, GATT_FAILURE);
>> +       }
>>   }
>>
>> -static void cleanup_conn_wait_queue(int32_t id)
>> +static void destroy_connection(void *data)
>>   {
>> -       struct gatt_device *dev;
>> +       struct connection_record *conn = data;
>>
>> -       /* Find device without client */
>> -       dev = queue_remove_if(conn_wait_queue, match_dev_without_client, NULL);
>> -       while (dev) {
>> -               send_client_connect_notify(id, dev, GATT_FAILURE);
>> +       if (!queue_find(gatt_devices, match_by_value, conn->device))
>> +               goto cleanup;
>>
>> -               /* Put device on disconnected device list */
>> -               put_device_on_disc_list(dev);
>> -               dev = queue_remove_if(conn_wait_queue,
>> -                                               match_dev_without_client, NULL);
>> -       };
>> +       if (conn->device->connection_ref_count > 0)
>> +               conn->device->connection_ref_count--;
>
> As long as reference counting works fine you do not need to check >0
> since it should not be possible to have connection for device without
> +1 reference.
> This actually hides potential issue in reference counting.
>

That's true. Will change that.

>> -       /* Stop scan we had for connecting devices */
>> -       if (queue_isempty(conn_wait_queue) && !scanning)
>> -               bt_le_discovery_stop(NULL);
>> +       if (conn->device->connection_ref_count == 0)
>> +               connection_cleanup(conn->device);
>> +
>> +cleanup:
>> +       free(conn);
>>   }
>>
>> -static void remove_client_from_devices(int32_t id)
>> +static void device_disconnect_clients(struct gatt_device *dev)
>>   {
>> -       DBG("");
>> +       /* Notify disconnection to all clients */
>> +       queue_foreach(client_connections, disconnect_notify_by_dev, dev);
>>
>> -       queue_foreach(conn_list, remove_client_from_device_list,
>> -                                                       INT_TO_PTR(id));
>> -       cleanup_conn_list(id);
>> -
>> -       queue_foreach(conn_wait_queue, remove_client_from_device_list,
>> -                                                       INT_TO_PTR(id));
>> -       cleanup_conn_wait_queue(id);
>> +       /* Remove all clients by given device's */
>> +       queue_remove_all(client_connections, match_connection_by_device, dev,
>> +                                                       destroy_connection);
>>   }
>>
>> -static void handle_client_unregister(const void *buf, uint16_t len)
>> +static void destroy_device(void *data)
>>   {
>> -       const struct hal_cmd_gatt_client_unregister *cmd = buf;
>> -       uint8_t status;
>> -       struct gatt_client *cl;
>> +       struct gatt_device *dev = data;
>>
>> -       DBG("");
>> +       if (!dev)
>> +               return;
>>
>> -       cl = queue_remove_if(gatt_clients, match_client_by_id,
>> -                                               INT_TO_PTR(cmd->client_if));
>> -       if (!cl) {
>> -               error("gatt: client_if=%d not found", cmd->client_if);
>> -               status = HAL_STATUS_FAILED;
>> -       } else {
>> -               /* Check if there is any connect request or connected device for this
>> -                * client. If so, remove this client from those lists.
>> -                */
>> -               remove_client_from_devices(cl->id);
>> -               destroy_gatt_client(cl);
>> -               status = HAL_STATUS_SUCCESS;
>> -       }
>> +       if (dev->state != DEVICE_DISCONNECTED)
>> +               device_disconnect_clients(dev);
>>
>> -       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
>> -                                       HAL_OP_GATT_CLIENT_UNREGISTER, status);
>> +       queue_destroy(dev->services, destroy_service);
>> +
>> +       free(dev);
>>   }
>>
>>   static void send_client_primary_notify(void *data, void *user_data)
>> @@ -670,17 +719,18 @@ static void send_client_primary_notify(void *data, void *user_data)
>>                                          sizeof(ev), &ev);
>>   }
>>
>> -static void send_client_all_primary(int32_t status, struct queue *services,
>> -                                                       int32_t conn_id)
>> +static void send_client_all_primary(struct connection_record *conn,
>> +                                                               int32_t status)
>>   {
>>          struct hal_ev_gatt_client_search_complete ev;
>>
>>          if (!status)
>> -               queue_foreach(services, send_client_primary_notify,
>> -                                                       INT_TO_PTR(conn_id));
>> +               queue_foreach(conn->device->services,
>> +                                               send_client_primary_notify,
>> +                                               INT_TO_PTR(conn->id));
>>
>>          ev.status = status;
>> -       ev.conn_id = conn_id;
>> +       ev.conn_id = conn->id;
>>          ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
>>                          HAL_EV_GATT_CLIENT_SEARCH_COMPLETE, sizeof(ev), &ev);
>>
>> @@ -735,7 +785,7 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
>>
>>   static void primary_cb(uint8_t status, GSList *services, void *user_data)
>>   {
>> -       struct gatt_device *dev = user_data;
>> +       struct connection_record *conn = user_data;
>>          GSList *l;
>>          int32_t gatt_status;
>>          uint8_t instance_id;
>> @@ -755,7 +805,7 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
>>                  goto done;
>>          }
>>
>> -       if (!queue_isempty(dev->services)) {
>> +       if (!queue_isempty(conn->device->services)) {
>>                  info("gatt: Services already cached");
>>                  gatt_status = GATT_SUCCESS;
>>                  goto done;
>> @@ -774,7 +824,7 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
>>                  if (!p)
>>                          continue;
>>
>> -               if (!queue_push_tail(dev->services, p)) {
>> +               if (!queue_push_tail(conn->device->services, p)) {
>>                          error("gatt: Cannot push primary service to the list");
>>                          free(p);
>>                          continue;
>> @@ -787,36 +837,7 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
>>          gatt_status = GATT_SUCCESS;
>>
>>   done:
>> -       send_client_all_primary(gatt_status, dev->services, dev->conn_id);
>> -}
>> -
>> -static void client_disconnect_notify(void *data, void *user_data)
>> -{
>> -       struct gatt_device *dev = user_data;
>> -       int32_t id = PTR_TO_INT(data);
>> -
>> -       send_client_disconnect_notify(id, dev, GATT_SUCCESS);
>> -}
>> -
>> -static bool is_device_wating_for_connect(const bdaddr_t *addr,
>> -                                                       uint8_t addr_type)
>> -{
>> -       struct gatt_device *dev;
>> -
>> -       DBG("");
>> -
>> -       dev = queue_find(conn_wait_queue, match_dev_by_bdaddr, (void *)addr);
>> -       if (!dev)
>> -               return false;
>> -
>> -       dev->bdaddr_type = addr_type;
>> -
>> -       /* Mark that this device is ready for connect.
>> -        * Need it because will continue with connect after scan is stopped
>> -        */
>> -       dev->connect_ready = true;
>> -
>> -       return true;
>> +       send_client_all_primary(conn, gatt_status);
>>   }
>>
>>   static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
>> @@ -826,6 +847,7 @@ static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
>>   {
>>          uint8_t buf[IPC_MTU];
>>          struct hal_ev_gatt_client_scan_result *ev = (void *) buf;
>> +       struct gatt_device *dev;
>>          char bda[18];
>>
>>          if (!scanning || !discoverable)
>> @@ -845,9 +867,13 @@ static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
>>                                                  sizeof(*ev) + ev->len, ev);
>>
>>   connect:
>> -       if (!is_device_wating_for_connect(addr, addr_type))
>> +       dev = find_device_by_addr(addr);
>> +       if (!dev || (dev->state != DEVICE_CONNECTION_PENDING))
>>                  return;
>>
>> +       device_set_state(dev, DEVICE_CONNECTABLE);
>> +       dev->bdaddr_type = addr_type;
>> +
>>          /* We are ok to perform connect now. Stop discovery
>>           * and once it is stopped continue with creating ACL
>>           */
>> @@ -861,45 +887,36 @@ static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
>>          int sock, err = 0;
>>          socklen_t len;
>>
>> -       queue_remove(conn_list, dev);
>> -
>>          sock = g_io_channel_unix_get_fd(io);
>>          len = sizeof(err);
>>          if (!getsockopt(sock, SOL_SOCKET, SO_ERROR, &err, &len))
>>                  DBG("%s (%d)", strerror(err), err);
>>
>> -       connection_cleanup(dev);
>> -
>> -       queue_foreach(dev->clients, client_disconnect_notify, dev);
>> -
>> -       /* Reset conn_id and put on disconnected list. */
>> -       put_device_on_disc_list(dev);
>> +       device_disconnect_clients(dev);
>>
>>          return FALSE;
>>   }
>>
>> -struct connect_data {
>> -       struct gatt_device *dev;
>> -       int32_t status;
>> -};
>> -
>>   static void send_client_connect_notifications(void *data, void *user_data)
>>   {
>> -       int32_t id = PTR_TO_INT(data);
>> -       struct connect_data *c = user_data;
>> +       struct connection_record *rec = data;
>> +       uint32_t status = PTR_TO_UINT(user_data);
>>
>> -       send_client_connect_notify(id, c->dev, c->status);
>> +       send_client_connect_notify(rec, status);
>>   }
>>
>>   static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>>   {
>>          struct gatt_device *dev = user_data;
>> -       struct connect_data data;
>> +       uint32_t status;
>>          GAttrib *attrib;
>> -       static uint32_t conn_id = 0;
>>
>> -       /* Take device from conn waiting queue */
>> -       if (!queue_remove(conn_wait_queue, dev)) {
>> +       /* Look for device if connection request is valid.
>> +        * TODO: Is this even possible when we have dev->att_io check
>> +        * in connect_le()?
>> +        */
>> +       dev = find_device(dev);
>> +       if (!dev || dev->state != DEVICE_CONNECTABLE) {
>>                  error("gatt: Device not on the connect wait queue!?");
>>                  g_io_channel_shutdown(io, TRUE, NULL);
>>                  return;
>> @@ -910,38 +927,31 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>>
>>          if (gerr) {
>>                  error("gatt: connection failed %s", gerr->message);
>> -               data.status = GATT_FAILURE;
>> +               status = GATT_FAILURE;
>>                  goto reply;
>>          }
>>
>>          attrib = g_attrib_new(io);
>>          if (!attrib) {
>>                  error("gatt: unable to create new GAttrib instance");
>> -               data.status = GATT_FAILURE;
>> +               status = GATT_FAILURE;
>>                  goto reply;
>>          }
>>
>>          dev->attrib = attrib;
>>          dev->watch_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
>>                                                          disconnected_cb, dev);
>> -       dev->conn_id = ++conn_id;
>>
>> -       /* Move gatt device from connect queue to conn_list */
>> -       if (!queue_push_tail(conn_list, dev)) {
>> -               error("gatt: Cannot push dev on conn_list");
>> -               connection_cleanup(dev);
>> -               data.status = GATT_FAILURE;
>> -               goto reply;
>> -       }
>> +       device_set_state(dev, DEVICE_CONNECTED);
>>
>> -       data.status = GATT_SUCCESS;
>> +       status = GATT_SUCCESS;
>>
>>   reply:
>> -       data.dev = dev;
>> -       queue_foreach(dev->clients, send_client_connect_notifications, &data);
>> +       queue_foreach(client_connections, send_client_connect_notifications,
>> +                                                       UINT_TO_PTR(status));
>>
>>          /* If connection did not succeed, destroy device */
>> -       if (data.status)
>> +       if (status)
>>                  destroy_device(dev);
>>
>>          /* Check if we should restart scan */
>> @@ -1050,16 +1060,9 @@ static int connect_next_dev(void)
>>
>>          DBG("");
>>
>> -       if (queue_isempty(conn_wait_queue))
>> -               return 0;
>> -
>> -       /* Discovery has been stopped because there is connection waiting */
>> -       dev = queue_find(conn_wait_queue, match_dev_connect_ready, NULL);
>> +       dev = find_device_by_state(DEVICE_CONNECTABLE);
>>          if (!dev)
>> -               /* Lets try again. */
>> -               return -1;
>> -
>> -       dev->connect_ready = false;
>> +               return -ENODEV;
>>
>>          return connect_le(dev);
>
> There should be separate CONNECTING state for device which is
> currently pending connection (actual one, not
> scanning-to-be-connected). Once there's connection request, we should
> not start scanning if there's device pending connection, just leave it
> in CONNECTION_PENDING state and then restart scanning in connect_cb in
> case there's any device in such state. This covers scenario where
> device was advertising and just stopped before we try to make actual
> connection - for consecutive connection request we'll try to start
> scanning but it won't work since there's connection request still
> pending.

Ok, It sounds reasonable to have such state.

>
>>   }
>> @@ -1073,22 +1076,6 @@ static void bt_le_discovery_stop_cb(void)
>>                  bt_le_discovery_start(le_device_found_handler);
>>   }
>>
>> -static struct gatt_device *find_device(bdaddr_t *addr)
>> -{
>> -       struct gatt_device *dev;
>> -
>> -       dev = queue_find(conn_list, match_dev_by_bdaddr, addr);
>> -       if (dev)
>> -               return dev;
>> -
>> -       return queue_find(conn_wait_queue, match_dev_by_bdaddr, addr);
>> -}
>> -
>> -static struct gatt_device *find_device_by_conn_id(int32_t conn_id)
>> -{
>> -       return queue_find(conn_list, match_dev_by_conn_id, INT_TO_PTR(conn_id));
>> -}
>> -
>>   static struct gatt_device *create_device(bdaddr_t *addr)
>>   {
>>          struct gatt_device *dev;
>> @@ -1099,96 +1086,202 @@ static struct gatt_device *create_device(bdaddr_t *addr)
>>
>>          bacpy(&dev->bdaddr, addr);
>>
>> -       dev->clients = queue_new();
>>          dev->services = queue_new();
>> -
>> -       if (!dev->clients || !dev->services) {
>> +       if (!dev->services) {
>>                  error("gatt: Failed to allocate memory for client");
>> +
>
> Avoid unrelated changes, i.e. whitespace.
>

OK.

>>                  destroy_device(dev);
>>                  return NULL;
>>          }
>>
>> +       if (!queue_push_head(gatt_devices, dev)) {
>> +               error("gatt: Cannot push device to queue");
>> +
>> +               return NULL;
>
> Need to destroy device here.
>

Thanks, missed that one.

>> +       }
>> +
>>          return dev;
>>   }
>>
>> -static void handle_client_connect(const void *buf, uint16_t len)
>> +static struct connection_record *create_connection(struct gatt_device *device,
>> +                                               struct gatt_client *client)
>>   {
>> -       const struct hal_cmd_gatt_client_connect *cmd = buf;
>> -       struct gatt_device *dev = NULL;
>> -       void *l;
>> -       bdaddr_t addr;
>> +       struct connection_record *new_conn;
>> +       struct connection_record *last;
>> +
>> +       /* Check if already connected */
>> +       new_conn = new0(struct connection_record, 1);
>> +       if (!new_conn)
>> +               return NULL;
>> +
>> +       new_conn->client = client;
>> +       new_conn->device = device;
>> +
>> +       /* Make connection id unique to connection record
>> +        * (client, device) pair.
>> +        */
>> +       last = queue_peek_head(client_connections);
>> +       if (last)
>> +               new_conn->id = last->id + 1;
>> +       else
>> +               new_conn->id = 1;
>
> You can just make static which will increment id for each connection
> and avoid this unnecessary logic here.
>

This was a "sort of" id reusage, but yes, we have plenty of those in 
int32_t range. I'll change that.

>> +
>> +       if (!queue_push_head(client_connections, new_conn)) {
>> +               error("gatt: Cannot push client on the client queue!?");
>> +
>> +               free(new_conn);
>> +               return NULL;
>> +       }
>> +
>> +       new_conn->device->connection_ref_count++;
>> +
>> +       return new_conn;
>> +}
>> +
>> +static void trigger_disconnection(struct connection_record *conn)
>> +{
>> +       /* Notify client */
>> +       if (queue_remove(client_connections, conn))
>> +               send_client_disconnect_notify(conn, GATT_SUCCESS);
>> +
>> +       destroy_connection(conn);
>> +}
>> +
>> +static void client_disconnect_devices(struct gatt_client *client)
>> +{
>> +       struct connection_record *conn;
>> +
>> +       /* find every connection for client record and trigger disconnect */
>> +       while ((conn = queue_remove_if(client_connections,
>> +                                       match_connection_by_client, client)))
>
> Make it without assignment in condition.
>

OK.

>> +               trigger_disconnection(conn);
>> +}
>> +
>> +static bool trigger_connection(struct connection_record *conn)
>> +{
>> +       switch (conn->device->state) {
>> +       case DEVICE_DISCONNECTED:
>> +               device_set_state(conn->device, DEVICE_CONNECTION_PENDING);
>> +               break;
>> +       case DEVICE_CONNECTED:
>> +               send_client_connect_notify(conn, GATT_SUCCESS);
>> +               break;
>> +       case DEVICE_CONNECTION_PENDING:
>> +       default:
>> +               break;
>> +       }
>> +
>> +       /* after state change trigger discovering */
>> +       if (!scanning && (conn->device->state == DEVICE_CONNECTION_PENDING))
>> +               if (!bt_le_discovery_start(le_device_found_handler)) {
>> +                       error("gatt: Could not start scan");
>> +
>> +                       return false;
>> +               }
>> +
>> +       return true;
>> +}
>> +
>> +static void handle_client_unregister(const void *buf, uint16_t len)
>> +{
>> +       const struct hal_cmd_gatt_client_unregister *cmd = buf;
>>          uint8_t status;
>> -       bool send_notify = false;
>> +       struct gatt_client *cl;
>>
>>          DBG("");
>>
>> -       /* Check if client is registered */
>> -       l = find_client_by_id(cmd->client_if);
>> -       if (!l) {
>> -               error("gatt: Client id %d not found", cmd->client_if);
>> +       cl = queue_remove_if(gatt_clients, match_client_by_id,
>> +                                               INT_TO_PTR(cmd->client_if));
>> +       if (!cl) {
>> +               error("gatt: client_if=%d not found", cmd->client_if);
>>                  status = HAL_STATUS_FAILED;
>> -               goto reply;
>> +       } else {
>> +               /* Check if there is any connect request or connected device
>> +                * for this client. If so, remove this client from those lists.
>> +                */
>> +               client_disconnect_devices(cl);
>> +               destroy_gatt_client(cl);
>> +               status = HAL_STATUS_SUCCESS;
>>          }
>>
>> -       android2bdaddr(&cmd->bdaddr, &addr);
>> +       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
>> +                                       HAL_OP_GATT_CLIENT_UNREGISTER, status);
>> +}
>>
>> -       /* We do support many clients for one device connection so lets check
>> -        * If device is connected or in connecting state just update list of
>> -        * clients
>> -        */
>> -       dev = find_device(&addr);
>> -       if (dev) {
>> -               /* Remeber to send dummy notification event  if we area
>> -                * connected
>> -                */
>> -               if (dev->conn_id)
>> -                       send_notify = true;
>> +static struct connection_record *find_connection_by_dev_client_id(
>
> It's by addr and client_id.
>

Yeap, I'll fix that.

>
> BR,
> Andrzej
>

Thanks, I'll resend v2 with all those issues fixed.

BR,
Jakub


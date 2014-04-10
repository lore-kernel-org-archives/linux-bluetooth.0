Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1494829.XNOEbLYcfZ@uw000953>
References: <1397119381-13294-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1397119381-13294-2-git-send-email-lukasz.rymanowski@tieto.com>
	<1494829.XNOEbLYcfZ@uw000953>
Date: Thu, 10 Apr 2014 15:40:43 +0200
Message-ID: <CAMudyAtu7xQ6pGCQaHG3YB_ihOuTWdh2dTnGGLRPD_B20qs9bw@mail.gmail.com>
Subject: Re: [PATCH 1/6] android/gatt: Add client listen support
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,


On 10 April 2014 14:15, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Łukasz,
>
> On Thursday 10 of April 2014 10:42:56 Lukasz Rymanowski wrote:
>> This patch adds handling client listen support
>> ---
>>  android/gatt.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 146 insertions(+), 2 deletions(-)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index e10324e..df9c675 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -121,6 +121,12 @@ struct gatt_device {
>>       guint watch_id;
>>  };
>>
>> +struct gatt_listen {
>> +     struct queue *clients;
>> +
>> +     GIOChannel *att_io;
>> +};
>
> I would not put this in dedicated structure, especially since att_io will be
> shared with server (and so it should be created on init and not on demand).
>
>> +
>>  static struct ipc *hal_ipc = NULL;
>>  static bdaddr_t adapter_addr;
>>  static bool scanning = false;
>> @@ -131,6 +137,10 @@ static struct queue *conn_list   = NULL;         /* Connected devices */
>>  static struct queue *conn_wait_queue = NULL; /* Devs waiting to connect */
>>  static struct queue *disc_dev_list = NULL;   /* Disconnected devices */
>>
>> +static struct gatt_listen listen_clients;
>> +
>> +static uint32_t conn_id = 0;
>> +
>>  static void bt_le_discovery_stop_cb(void);
>>
>>  static void android2uuid(const uint8_t *uuid, bt_uuid_t *dst)
>> @@ -815,7 +825,6 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>>       struct gatt_device *dev;
>>       struct hal_ev_gatt_client_connect ev;
>>       GAttrib *attrib;
>> -     static uint32_t conn_id = 0;
>>       int32_t status;
>>
>>       /* Take device from conn waiting queue */
>> @@ -1200,12 +1209,147 @@ reply:
>>       put_device_on_disc_list(dev);
>>  }
>>
>> +static void copy_client_to_dev(void *data, void *user_data)
>> +{
>
> I would name it add_client_to_dev.

Ok

>
>> +     int32_t *client_id = data;
>> +     struct gatt_device *dev = user_data;
>> +
>> +     if (!queue_push_tail(dev->clients, client_id))
>> +             error("gatt: Could not copy client to dev->clients");
>> +}
>> +
>> +static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
>> +{
>> +     struct gatt_device *dev = NULL;
>> +     struct hal_ev_gatt_client_connect ev;
>> +     GAttrib *attrib;
>> +     uint8_t dst_type;
>> +     bdaddr_t src, dst;
>> +
>> +     DBG("");
>> +
>> +     if (gerr) {
>> +             error("gatt: %s", gerr->message);
>> +             g_error_free(gerr);
>> +             ev.status = GATT_FAILURE;
>> +             goto done;
>> +     }
>> +
>> +     bt_io_get(io, &gerr,
>> +                     BT_IO_OPT_SOURCE_BDADDR, &src,
>
> This is not used, and we only have single adapter anyway.
yup
>
>> +                     BT_IO_OPT_DEST_BDADDR, &dst,
>> +                     BT_IO_OPT_DEST_TYPE, &dst_type,
>> +                     BT_IO_OPT_INVALID);
>> +     if (gerr) {
>> +             error("gatt: bt_io_get: %s", gerr->message);
>> +             g_error_free(gerr);
>> +             ev.status = GATT_FAILURE;
>> +             goto done;
>> +     }
>> +
>> +     dev = create_device(&dst);
>> +     if (!dev) {
>> +             ev.status = GATT_FAILURE;
>> +             dev = NULL;
>> +             goto done;
>> +     }
>> +
>> +     dev->bdaddr_type = dst_type;
>> +
>> +     /* Set address and client id in the event */
>> +     bdaddr2android(&dev->bdaddr, &ev.bda);
>> +
>> +     attrib = g_attrib_new(io);
>> +     if (!attrib) {
>> +             error("gatt: unable to create new GAttrib instance");
>> +             ev.status = GATT_FAILURE;
>> +             destroy_device(dev);
>> +             dev = NULL;
>> +             goto done;
>> +     }
>> +
>> +     dev->attrib = attrib;
>> +     dev->watch_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
>> +                                                     disconnected_cb, dev);
>> +     dev->conn_id = ++conn_id;
>> +
>> +     ev.status = GATT_SUCCESS;
>> +
>> +done:
>> +     /* Only in success case we have valid conn_id */
>> +     ev.conn_id = ev.status == GATT_SUCCESS ? dev->conn_id : 0;
>> +
>> +     queue_foreach(listen_clients.clients, send_client_connect_notify, &ev);
>> +
>> +     if (ev.status != GATT_SUCCESS)
>> +             return;
>> +
>> +     /*copy list of clients to device and clear listen */
>> +     queue_foreach(listen_clients.clients, copy_client_to_dev, dev);
>> +
>> +     queue_remove_all(listen_clients.clients, NULL, NULL, NULL);
>> +     listen_clients.att_io = NULL;
>
> This NULL assignment looks strange.

Yes, this is stupid. .
>
>> +
>> +     /*TODO: Attach to attrib db */
>> +}
>> +
>>  static void handle_client_listen(const void *buf, uint16_t len)
>>  {
>> +     const struct hal_cmd_gatt_client_listen *cmd = buf;
>> +     struct hal_ev_gatt_client_listen ev;
>> +     uint8_t status;
>> +     GError *gerr;
>> +
>>       DBG("");
>>
>> +     if (!queue_push_tail(listen_clients.clients,
>> +                                             INT_TO_PTR(cmd->client_if))) {
>> +             error("gatt: Could not put client on the listen list");
>> +             status = HAL_STATUS_FAILED;
>> +             goto reply;
>> +     }
>> +
>> +     /* Do not be confused with server_if here. This is some typo in android
>> +      * headers.
>> +      */
>> +     ev.server_if = cmd->client_if;
>> +
>> +     if (listen_clients.att_io) {
>> +             /* There is already listening socket on. just return success */
>> +             status = HAL_STATUS_SUCCESS;
>> +             ev.status = GATT_SUCCESS;
>> +             goto reply;
>> +     }
>> +
>> +     status = HAL_STATUS_SUCCESS;
>> +
>> +     listen_clients.att_io = bt_io_listen(connect_event, NULL,
>> +                                     &listen_clients.att_io, NULL, &gerr,
>> +                                     BT_IO_OPT_SOURCE_BDADDR, adapter_addr,
>> +                                     BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
>> +                                     BT_IO_OPT_CID, ATT_CID,
>> +                                     BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
>> +                                     BT_IO_OPT_INVALID);
>> +
>> +     if (listen_clients.att_io == NULL) {
>
> if (!io) ..
>
>> +             error("%s", gerr->message);
>> +             g_error_free(gerr);
>> +             ev.status = GATT_FAILURE;
>> +     }
>> +
>> +     /*TODO: Start advertising */
>> +reply:
>>       ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_LISTEN,
>> -                                                     HAL_STATUS_FAILED);
>> +                                                             status);
>> +
>> +     /* If listen command succeed, send listen notification as well.
>> +      * Android expects that.
>> +     */
>> +     if (!status)
>> +             ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
>> +                                             HAL_EV_GATT_CLIENT_LISTEN,
>> +                                             sizeof(ev), &ev);
>> +
>>  }
>>
>>  static void handle_client_refresh(const void *buf, uint16_t len)
>>
>
> --
> Best regards,
> Szymon Janc

Anyway, will move creating this socket to some better place as
discussed offline.

\Lukasz

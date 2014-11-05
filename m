Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415196669-582-2-git-send-email-luiz.dentz@gmail.com>
References: <1415196669-582-1-git-send-email-luiz.dentz@gmail.com>
	<1415196669-582-2-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 5 Nov 2014 14:11:46 -0800
Message-ID: <CAHrH25QQQZCT4x9M8CVhTS_XgVNjgYAXJy56n5OA7r8Fi2EXAA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] shared/gatt-db: Rework API
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Wed, Nov 5, 2014 at 6:11 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This rework the API to use gatt_db_attribute whenever possible which
> simplify the code adn reduces the number of lookups.
> ---
>  android/gatt.c           | 603 +++++++++++++++++++++++++----------------------
>  src/shared/gatt-db.c     | 445 +++++++++++++++-------------------
>  src/shared/gatt-db.h     |  87 ++++---
>  src/shared/gatt-server.c |  37 ++-
>  4 files changed, 582 insertions(+), 590 deletions(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index b3dd6d3..7a7be6d 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -94,6 +94,8 @@ static const char *device_state_str[] = {
>  struct pending_trans_data {
>         unsigned int id;
>         uint8_t opcode;
> +       struct gatt_db_attribute *attrib;
> +       unsigned int serial_id;
>  };
>
>  struct gatt_app {
> @@ -199,7 +201,7 @@ static struct queue *services_sdp = NULL;
>  static struct queue *listen_apps = NULL;
>  static struct gatt_db *gatt_db = NULL;
>
> -static uint16_t service_changed_handle = 0;
> +static struct gatt_db_attribute *service_changed_attrib = NULL;
>
>  static GIOChannel *le_io = NULL;
>  static GIOChannel *bredr_io = NULL;
> @@ -676,7 +678,7 @@ enum pend_req_state {
>  };
>
>  struct pending_request {
> -       uint16_t handle;
> +       struct gatt_db_attribute *attrib;
>         int length;
>         uint8_t *value;
>         uint16_t offset;
> @@ -998,11 +1000,16 @@ static void send_exchange_mtu_request(struct gatt_device *device)
>  static void notify_att_range_change(struct gatt_device *dev,
>                                                         struct att_range *range)
>  {
> +       uint16_t handle;
>         uint16_t length = 0;
>         uint16_t ccc;
>         uint8_t *pdu;
>         size_t mtu;
>
> +       handle = gatt_db_attribute_get_handle(service_changed_attrib);
> +       if (!handle)
> +               return;
> +
>         ccc = bt_get_gatt_ccc(&dev->bdaddr);
>         if (!ccc)
>                 return;
> @@ -1011,14 +1018,12 @@ static void notify_att_range_change(struct gatt_device *dev,
>
>         switch (ccc) {
>         case 0x0001:
> -               length = enc_notification(service_changed_handle,
> -                                               (uint8_t *) range,
> +               length = enc_notification(handle, (uint8_t *) range,
>                                                 sizeof(*range), pdu, mtu);
>                 break;
>         case 0x0002:
> -               length = enc_indication(service_changed_handle,
> -                                       (uint8_t *) range, sizeof(*range), pdu,
> -                                       mtu);
> +               length = enc_indication(handle, (uint8_t *) range,
> +                                               sizeof(*range), pdu, mtu);
>                 break;
>         default:
>                 /* 0xfff4 reserved for future use */
> @@ -1475,7 +1480,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>          * constant all the time, thus they should be excluded from
>          * range indicating changes.
>          */
> -       range.start = service_changed_handle + 2;
> +       range.start = gatt_db_attribute_get_handle(service_changed_attrib) + 2;
>         range.end = 0xffff;
>
>         /*
> @@ -4210,6 +4215,7 @@ static void handle_server_add_service(const void *buf, uint16_t len)
>         const struct hal_cmd_gatt_server_add_service *cmd = buf;
>         struct hal_ev_gatt_server_service_added ev;
>         struct gatt_app *server;
> +       struct gatt_db_attribute *service;
>         uint8_t status;
>         bt_uuid_t uuid;
>
> @@ -4225,9 +4231,14 @@ static void handle_server_add_service(const void *buf, uint16_t len)
>
>         android2uuid(cmd->srvc_id.uuid, &uuid);
>
> -       ev.srvc_handle = gatt_db_add_service(gatt_db, &uuid,
> -                                                       cmd->srvc_id.is_primary,
> +       service = gatt_db_add_service(gatt_db, &uuid, cmd->srvc_id.is_primary,
>                                                         cmd->num_handles);
> +       if (!service) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       ev.srvc_handle = gatt_db_attribute_get_handle(service);
>         if (!ev.srvc_handle) {
>                 status = HAL_STATUS_FAILED;
>                 goto failed;
> @@ -4252,6 +4263,7 @@ static void handle_server_add_included_service(const void *buf, uint16_t len)
>         const struct hal_cmd_gatt_server_add_inc_service *cmd = buf;
>         struct hal_ev_gatt_server_inc_srvc_added ev;
>         struct gatt_app *server;
> +       struct gatt_db_attribute *service, *include;
>         uint8_t status;
>
>         DBG("");
> @@ -4264,10 +4276,20 @@ static void handle_server_add_included_service(const void *buf, uint16_t len)
>                 goto failed;
>         }
>
> -       ev.incl_srvc_handle = gatt_db_add_included_service(gatt_db,
> -                                                       cmd->service_handle,
> -                                                       cmd->included_handle);
> -       if (!ev.incl_srvc_handle) {
> +       service = gatt_db_get_attribute(gatt_db, cmd->service_handle);
> +       if (!service) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       include = gatt_db_get_attribute(gatt_db, cmd->included_handle);
> +       if (!service) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       service = gatt_db_service_add_included(service, include);
> +       if (!service) {
>                 status = HAL_STATUS_FAILED;
>                 goto failed;
>         }
> @@ -4360,8 +4382,11 @@ static void send_dev_complete_response(struct gatt_device *device,
>                 val = queue_pop_head(temp);
>                 while (val) {
>                         uint8_t *value = adl->data[iterator++];
> +                       uint16_t handle;
>
> -                       put_le16(val->handle, value);
> +                       handle = gatt_db_attribute_get_handle(val->attrib);
> +
> +                       put_le16(handle, value);
>                         memcpy(&value[2], val->value, val->length);
>
>                         destroy_pending_request(val);
> @@ -4426,12 +4451,13 @@ static void send_dev_complete_response(struct gatt_device *device,
>                 val = queue_pop_head(temp);
>                 while (val) {
>                         uint8_t *value = adl->data[iterator++];
> -                       uint16_t end_handle;
> +                       uint16_t start_handle, end_handle;
>
> -                       end_handle = gatt_db_get_end_handle(gatt_db,
> -                                                               val->handle);
> +                       gatt_db_attribute_get_service_handles(val->attrib,
> +                                                               &start_handle,
> +                                                               &end_handle);
>
> -                       put_le16(val->handle, value);
> +                       put_le16(start_handle, value);
>                         put_le16(end_handle, &value[2]);
>                         memcpy(&value[4], val->value, val->length);
>
> @@ -4471,14 +4497,17 @@ static void send_dev_complete_response(struct gatt_device *device,
>                                 break;
>                         }
>
> -                       range->start = val->handle;
> +                       range->start = gatt_db_attribute_get_handle(
> +                                                               val->attrib);
>                         range->end = range->start;
>
> -                       /* Get proper end handle if its group type */
> -                       type = gatt_db_get_attribute_type(gatt_db, val->handle);
> +                       type = gatt_db_attribute_get_type(val->attrib);
>                         if (is_service(type))
> -                               range->end = gatt_db_get_end_handle(gatt_db,
> -                                                               val->handle);
> +                               range->end =
> +                                       gatt_db_attribute_get_service_handles(
> +                                                               val->attrib,
> +                                                               NULL,
> +                                                               &range->end);
>
>                         list = g_slist_append(list, range);
>
> @@ -4515,17 +4544,22 @@ static void send_dev_complete_response(struct gatt_device *device,
>                 len = enc_write_resp(rsp);
>                 destroy_pending_request(val);
>                 break;
> -       case ATT_OP_PREP_WRITE_REQ:
> +       case ATT_OP_PREP_WRITE_REQ: {
> +               uint16_t handle;
> +
>                 val = queue_pop_head(device->pending_requests);
>                 if (val->error) {
>                         error = val->error;
>                         goto done;
>                 }
>
> -               len = enc_prep_write_resp(val->handle, val->offset, val->value,
> +               handle = gatt_db_attribute_get_handle(val->attrib);
> +
> +               len = enc_prep_write_resp(handle, val->offset, val->value,
>                                                         val->length, rsp, mtu);
>                 destroy_pending_request(val);
>                 break;
> +       }
>         default:
>                 break;
>         }
> @@ -4545,12 +4579,11 @@ struct request_processing_data {
>         struct gatt_device *device;
>  };
>
> -static bool match_dev_request_by_handle(const void *data, const void *user_data)
> +static bool match_dev_request_by_attrib(const void *data, const void *user_data)
>  {
>         const struct pending_request *handle_data = data;
> -       uint16_t handle = PTR_TO_UINT(user_data);
>
> -       return handle_data->handle == handle;
> +       return handle_data->attrib == user_data;
>  }
>
>  static uint8_t check_device_permissions(struct gatt_device *device,
> @@ -4623,11 +4656,12 @@ static uint8_t check_device_permissions(struct gatt_device *device,
>         return 0;
>  }
>
> -static void fill_gatt_response(struct pending_request *request, uint16_t handle,
> +static void fill_gatt_response(struct pending_request *request,
> +                                       struct gatt_db_attribute *attrib,
>                                         uint16_t offset, uint8_t status,
>                                         uint16_t len, const uint8_t *data)
>  {
> -       request->handle = handle;
> +       request->attrib = attrib;
>         request->offset = offset;
>         request->length = len;
>         request->state = REQUEST_DONE;
> @@ -4646,38 +4680,49 @@ static void fill_gatt_response(struct pending_request *request, uint16_t handle,
>         memcpy(request->value, data, len);
>  }
>
> -static void fill_gatt_response_by_handle(uint16_t handle, uint16_t offset,
> -                                               uint8_t status, uint16_t len,
> -                                               const uint8_t *data,
> -                                               struct gatt_device *dev)
> +static uint8_t err_to_att(int err)
>  {
> -       struct pending_request *entry;
> +       if (!err || (err > 0 && err < UINT8_MAX))
> +               return err;
>
> -       entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
> -                                                       UINT_TO_PTR(handle));
> -       if (!entry) {
> -               error("gatt: No pending response! Bogus android response?");
> -               return;
> +       switch (err) {
> +       case -ENOENT:
> +               return ATT_ECODE_INVALID_HANDLE;
> +       case -ENOMEM:
> +               return ATT_ECODE_INSUFF_RESOURCES;
> +       default:
> +               return ATT_ECODE_UNLIKELY;
>         }
> +}
> +
> +static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
> +                                       const uint8_t *value, size_t length,
> +                                       void *user_data)
> +{
> +       struct pending_request *resp_data = user_data;
> +       uint8_t error = err_to_att(err);
>
> -       fill_gatt_response(entry, handle, offset, status, len, data);
> +       fill_gatt_response(resp_data, attrib, resp_data->offset, error, length,
> +                                                                       value);
>  }
>
>  static void read_requested_attributes(void *data, void *user_data)
>  {
>         struct pending_request *resp_data = data;
>         struct request_processing_data *process_data = user_data;
> +       struct gatt_db_attribute *attrib;
>         uint32_t permissions;
> -       uint8_t *value = NULL, error;
> -       int value_len = 0;
> +       uint8_t error;
>
> -       if (!gatt_db_get_attribute_permissions(gatt_db, resp_data->handle,
> -                                                               &permissions)) {
> +       attrib = resp_data->attrib;
> +       if (!attrib) {
>                 resp_data->error = ATT_ECODE_ATTR_NOT_FOUND;
>                 resp_data->state = REQUEST_DONE;
>                 return;
>         }
>
> +       gatt_db_attribute_get_permissions(attrib, &permissions);
> +
>         /*
>          * Check if it is attribute we didn't declare permissions, like service
>          * declaration or included service. Set permissions to read only
> @@ -4696,18 +4741,9 @@ static void read_requested_attributes(void *data, void *user_data)
>
>         resp_data->state = REQUEST_PENDING;
>
> -       if (!gatt_db_read(gatt_db, resp_data->handle,
> -                                               resp_data->offset,
> -                                               process_data->opcode,
> -                                               &process_data->device->bdaddr,
> -                                               &value, &value_len))
> -               error = ATT_ECODE_UNLIKELY;
> -
> -       /* We have value here already if no callback will be called */
> -       if (value_len >= 0)
> -               fill_gatt_response(resp_data, resp_data->handle,
> -                                       resp_data->offset, error, value_len,
> -                                       value);
> +       gatt_db_attribute_read(attrib, resp_data->offset, process_data->opcode,
> +                                       &process_data->device->bdaddr,
> +                                       attribute_read_cb, resp_data);
>  }
>
>  static void process_dev_pending_requests(struct gatt_device *device,
> @@ -4729,7 +4765,9 @@ static void process_dev_pending_requests(struct gatt_device *device,
>  }
>
>  static struct pending_trans_data *conn_add_transact(struct app_connection *conn,
> -                                                               uint8_t opcode)
> +                                       uint8_t opcode,
> +                                       struct gatt_db_attribute *attrib,
> +                                       unsigned int serial_id)
>  {
>         struct pending_trans_data *transaction;
>         static int32_t trans_id = 1;
> @@ -4745,21 +4783,25 @@ static struct pending_trans_data *conn_add_transact(struct app_connection *conn,
>
>         transaction->id = trans_id++;
>         transaction->opcode = opcode;
> +       transaction->attrib = attrib;
> +       transaction->serial_id = serial_id;
>
>         return transaction;
>  }
>
> -static void read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
> -                                       bdaddr_t *bdaddr, void *user_data)
> +static void read_cb(struct gatt_db_attribute *attrib, unsigned int id,
> +                       uint16_t offset, uint8_t opcode, bdaddr_t *bdaddr,
> +                       void *user_data)
>  {
>         struct pending_trans_data *transaction;
>         struct hal_ev_gatt_server_request_read ev;
>         struct gatt_app *app;
>         struct app_connection *conn;
> -       int32_t id = PTR_TO_INT(user_data);
> -       struct gatt_device *dev;
> +       int32_t app_id = PTR_TO_INT(user_data);
>
> -       app = find_app_by_id(id);
> +       DBG("id %u", id);
> +
> +       app = find_app_by_id(app_id);
>         if (!app) {
>                 error("gatt: read_cb, cound not found app id");
>                 goto failed;
> @@ -4774,15 +4816,15 @@ static void read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
>         memset(&ev, 0, sizeof(ev));
>
>         /* Store the request data, complete callback and transaction id */
> -       transaction = conn_add_transact(conn, att_opcode);
> +       transaction = conn_add_transact(conn, opcode, attrib, id);
>         if (!transaction)
>                 goto failed;
>
>         bdaddr2android(bdaddr, ev.bdaddr);
>         ev.conn_id = conn->id;
> -       ev.attr_handle = handle;
> +       ev.attr_handle = gatt_db_attribute_get_handle(attrib);
>         ev.offset = offset;
> -       ev.is_long = att_opcode == ATT_OP_READ_BLOB_REQ;
> +       ev.is_long = opcode == ATT_OP_READ_BLOB_REQ;
>         ev.trans_id = transaction->id;
>
>         ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> @@ -4792,26 +4834,23 @@ static void read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
>         return;
>
>  failed:
> -       dev = find_device_by_addr(bdaddr);
> -       if (dev)
> -               fill_gatt_response_by_handle(handle, 0, ATT_ECODE_UNLIKELY, 0,
> -                                                       NULL, dev);
> +       gatt_db_attribute_read_result(attrib, id, -ENOENT, NULL, 0);
>  }
>
> -static void write_cb(uint16_t handle, uint16_t offset,
> -                                       const uint8_t *value, size_t len,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr,
> -                                       void *user_data)
> +static void write_cb(struct gatt_db_attribute *attrib, unsigned int id,
> +                       uint16_t offset, const uint8_t *value, size_t len,
> +                       uint8_t opcode, bdaddr_t *bdaddr, void *user_data)
>  {
>         uint8_t buf[IPC_MTU];
>         struct hal_ev_gatt_server_request_write *ev = (void *) buf;
>         struct pending_trans_data *transaction;
>         struct gatt_app *app;
> -       int32_t id = PTR_TO_INT(user_data);
> +       int32_t app_id = PTR_TO_INT(user_data);
>         struct app_connection *conn;
> -       struct gatt_device *dev;
>
> -       app = find_app_by_id(id);
> +       DBG("id %u", id);
> +
> +       app = find_app_by_id(app_id);
>         if (!app) {
>                 error("gatt: write_cb could not found app id");
>                 goto failed;
> @@ -4827,27 +4866,26 @@ static void write_cb(uint16_t handle, uint16_t offset,
>          * Remember that this application has ongoing prep write
>          * Need it later to find out where to send execute write
>          */
> -       if (att_opcode == ATT_OP_PREP_WRITE_REQ)
> +       if (opcode == ATT_OP_PREP_WRITE_REQ)
>                 conn->wait_execute_write = true;
>
>         /* Store the request data, complete callback and transaction id */
> -       transaction = conn_add_transact(conn, att_opcode);
> +       transaction = conn_add_transact(conn, opcode, attrib, id);
>         if (!transaction)
>                 goto failed;
>
>         memset(ev, 0, sizeof(*ev));
>
>         bdaddr2android(bdaddr, &ev->bdaddr);
> -       ev->attr_handle = handle;
> +       ev->attr_handle = gatt_db_attribute_get_handle(attrib);
>         ev->offset = offset;
>
>         ev->conn_id = conn->id;
>         ev->trans_id = transaction->id;
>
> -       ev->is_prep = att_opcode == ATT_OP_PREP_WRITE_REQ;
> +       ev->is_prep = opcode == ATT_OP_PREP_WRITE_REQ;
>
> -       if (att_opcode == ATT_OP_WRITE_REQ ||
> -                                       att_opcode == ATT_OP_PREP_WRITE_REQ)
> +       if (opcode == ATT_OP_WRITE_REQ || opcode == ATT_OP_PREP_WRITE_REQ)
>                 ev->need_rsp = 0x01;
>
>         ev->length = len;
> @@ -4859,10 +4897,7 @@ static void write_cb(uint16_t handle, uint16_t offset,
>         return;
>
>  failed:
> -       dev = find_device_by_addr(bdaddr);
> -       if (dev)
> -               fill_gatt_response_by_handle(handle, 0, ATT_ECODE_UNLIKELY, 0,
> -                                                               NULL, dev);
> +       gatt_db_attribute_write_result(attrib, id, ATT_ECODE_UNLIKELY);
>  }
>
>  static uint32_t android_to_gatt_permissions(int32_t hal_permissions)
> @@ -4904,6 +4939,7 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
>         const struct hal_cmd_gatt_server_add_characteristic *cmd = buf;
>         struct hal_ev_gatt_server_characteristic_added ev;
>         struct gatt_app *server;
> +       struct gatt_db_attribute *attrib;
>         bt_uuid_t uuid;
>         uint8_t status;
>         uint32_t permissions;
> @@ -4919,22 +4955,28 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
>                 goto failed;
>         }
>
> +       attrib = gatt_db_get_attribute(gatt_db, cmd->service_handle);
> +       if (!attrib) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
>         android2uuid(cmd->uuid, &uuid);
>         permissions = android_to_gatt_permissions(cmd->permissions);
>
> -       ev.char_handle = gatt_db_add_characteristic(gatt_db,
> -                                                       cmd->service_handle,
> +       attrib = gatt_db_service_add_characteristic(attrib,
>                                                         &uuid, permissions,
>                                                         cmd->properties,
>                                                         read_cb, write_cb,
>                                                         INT_TO_PTR(app_id));
> -       if (!ev.char_handle)
> +       if (!attrib)
>                 status = HAL_STATUS_FAILED;
>         else
>                 status = HAL_STATUS_SUCCESS;
>
>  failed:
>         ev.srvc_handle = cmd->service_handle;
> +       ev.char_handle = gatt_db_attribute_get_handle(attrib);
>         ev.status = status;
>         ev.server_if = app_id;
>         ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
> @@ -4952,6 +4994,7 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
>         const struct hal_cmd_gatt_server_add_descriptor *cmd = buf;
>         struct hal_ev_gatt_server_descriptor_added ev;
>         struct gatt_app *server;
> +       struct gatt_db_attribute *attrib;
>         bt_uuid_t uuid;
>         uint8_t status;
>         uint32_t permissions;
> @@ -4970,12 +5013,16 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
>         android2uuid(cmd->uuid, &uuid);
>         permissions = android_to_gatt_permissions(cmd->permissions);
>
> -       ev.descr_handle = gatt_db_add_char_descriptor(gatt_db,
> -                                                       cmd->service_handle,
> -                                                       &uuid, permissions,
> +       attrib = gatt_db_get_attribute(gatt_db, cmd->service_handle);
> +       if (!attrib) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       attrib = gatt_db_service_add_descriptor(attrib, &uuid, permissions,
>                                                         read_cb, write_cb,
>                                                         INT_TO_PTR(app_id));
> -       if (!ev.descr_handle)
> +       if (!attrib)
>                 status = HAL_STATUS_FAILED;
>         else
>                 status = HAL_STATUS_SUCCESS;
> @@ -4996,9 +5043,9 @@ failed:
>  static void notify_service_change(void *data, void *user_data)
>  {
>         struct att_range range;
> +       struct gatt_db_attribute *attrib = user_data;
>
> -       range.start = PTR_TO_UINT(user_data);
> -       range.end = gatt_db_get_end_handle(gatt_db, range.start);
> +       gatt_db_attribute_get_service_handles(attrib, &range.start, &range.end);
>
>         /* In case of db error */
>         if (!range.end)
> @@ -5105,13 +5152,18 @@ static struct service_sdp *new_service_sdp_record(int32_t service_handle)
>  {
>         bt_uuid_t uuid;
>         struct service_sdp *s;
> +       struct gatt_db_attribute *attrib;
>         uint16_t end_handle;
>
> -       end_handle = gatt_db_get_end_handle(gatt_db, service_handle);
> +       attrib = gatt_db_get_attribute(gatt_db, service_handle);
> +       if (!attrib)
> +               return NULL;
> +
> +       gatt_db_attribute_get_service_handles(attrib, NULL, &end_handle);
>         if (!end_handle)
>                 return NULL;
>
> -       if (!gatt_db_get_service_uuid(gatt_db, service_handle, &uuid))
> +       if (!gatt_db_attribute_get_service_uuid(attrib, &uuid))
>                 return NULL;
>
>         s = new0(struct service_sdp, 1);
> @@ -5177,6 +5229,7 @@ static void handle_server_start_service(const void *buf, uint16_t len)
>         const struct hal_cmd_gatt_server_start_service *cmd = buf;
>         struct hal_ev_gatt_server_service_started ev;
>         struct gatt_app *server;
> +       struct gatt_db_attribute *attrib;
>         uint8_t status;
>
>         DBG("");
> @@ -5204,7 +5257,13 @@ static void handle_server_start_service(const void *buf, uint16_t len)
>                 goto failed;
>         }
>
> -       if (!gatt_db_service_set_active(gatt_db, cmd->service_handle, true)) {
> +       attrib = gatt_db_get_attribute(gatt_db, cmd->service_handle);
> +       if (!attrib) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       if (!gatt_db_service_set_active(attrib, true)) {
>                 /*
>                  * no need to clean SDP since this can fail only if service
>                  * handle is invalid in which case add_sdp_record() also fails
> @@ -5213,8 +5272,7 @@ static void handle_server_start_service(const void *buf, uint16_t len)
>                 goto failed;
>         }
>
> -       queue_foreach(gatt_devices, notify_service_change,
> -                                       UINT_TO_PTR(cmd->service_handle));
> +       queue_foreach(gatt_devices, notify_service_change, attrib);
>
>         status = HAL_STATUS_SUCCESS;
>
> @@ -5235,6 +5293,7 @@ static void handle_server_stop_service(const void *buf, uint16_t len)
>         const struct hal_cmd_gatt_server_stop_service *cmd = buf;
>         struct hal_ev_gatt_server_service_stopped ev;
>         struct gatt_app *server;
> +       struct gatt_db_attribute *attrib;
>         uint8_t status;
>
>         DBG("");
> @@ -5247,7 +5306,13 @@ static void handle_server_stop_service(const void *buf, uint16_t len)
>                 goto failed;
>         }
>
> -       if (!gatt_db_service_set_active(gatt_db, cmd->service_handle, false)) {
> +       attrib = gatt_db_get_attribute(gatt_db, cmd->service_handle);
> +       if (!attrib) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       if (!gatt_db_service_set_active(attrib, false)) {
>                 status = HAL_STATUS_FAILED;
>                 goto failed;
>         }
> @@ -5256,8 +5321,7 @@ static void handle_server_stop_service(const void *buf, uint16_t len)
>
>         status = HAL_STATUS_SUCCESS;
>
> -       queue_foreach(gatt_devices, notify_service_change,
> -                                       UINT_TO_PTR(cmd->service_handle));
> +       queue_foreach(gatt_devices, notify_service_change, attrib);
>
>  failed:
>         ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
> @@ -5276,6 +5340,7 @@ static void handle_server_delete_service(const void *buf, uint16_t len)
>         const struct hal_cmd_gatt_server_delete_service *cmd = buf;
>         struct hal_ev_gatt_server_service_deleted ev;
>         struct gatt_app *server;
> +       struct gatt_db_attribute *attrib;
>         uint8_t status;
>
>         DBG("");
> @@ -5288,7 +5353,13 @@ static void handle_server_delete_service(const void *buf, uint16_t len)
>                 goto failed;
>         }
>
> -       if (!gatt_db_remove_service(gatt_db, cmd->service_handle)) {
> +       attrib = gatt_db_get_attribute(gatt_db, cmd->service_handle);
> +       if (!attrib) {
> +               status = HAL_STATUS_FAILED;
> +               goto failed;
> +       }
> +
> +       if (!gatt_db_remove_service(gatt_db, attrib)) {
>                 status = HAL_STATUS_FAILED;
>                 goto failed;
>         }
> @@ -5377,7 +5448,6 @@ static void handle_server_send_response(const void *buf, uint16_t len)
>  {
>         const struct hal_cmd_gatt_server_send_response *cmd = buf;
>         struct pending_trans_data *transaction;
> -       uint16_t handle = cmd->handle;
>         struct app_connection *conn;
>         uint8_t status;
>
> @@ -5405,17 +5475,22 @@ static void handle_server_send_response(const void *buf, uint16_t len)
>                 if (pending_execute_write())
>                         goto done;
>
> -               /* Make sure handle is 0. We need it to find pending request */
> -               handle = 0;
> -
>                 /*
>                  * FIXME: Handle situation when not all server applications
>                  * respond with a success.
>                  */
>         }
>
> -       fill_gatt_response_by_handle(handle, cmd->offset, cmd->status, cmd->len,
> -                                               cmd->data, conn->device);
> +       if (transaction->opcode < ATT_OP_WRITE_REQ)
> +               gatt_db_attribute_read_result(transaction->attrib,
> +                                               transaction->serial_id,
> +                                               cmd->status,
> +                                               cmd->data, cmd->len);
> +       else
> +               gatt_db_attribute_write_result(transaction->attrib,
> +                                               transaction->serial_id,
> +                                               cmd->status);
> +
>         send_dev_complete_response(conn->device, transaction->opcode);
>
>  done:
> @@ -5564,7 +5639,7 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
>         }
>
>         while (queue_peek_head(q)) {
> -               uint16_t handle = PTR_TO_UINT(queue_pop_head(q));
> +               struct gatt_db_attribute *attrib = queue_pop_head(q);
>                 struct pending_request *entry;
>
>                 entry = new0(struct pending_request, 1);
> @@ -5573,7 +5648,7 @@ static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
>                         return ATT_ECODE_UNLIKELY;
>                 }
>
> -               entry->handle = handle;
> +               entry->attrib = attrib;
>                 entry->state = REQUEST_INIT;
>
>                 if (!queue_push_tail(device->pending_requests, entry)) {
> @@ -5621,7 +5696,7 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
>
>         while (queue_peek_head(q)) {
>                 struct pending_request *data;
> -               uint16_t handle = PTR_TO_UINT(queue_pop_head(q));
> +               struct gatt_db_attribute *attrib = queue_pop_head(q);
>
>                 data = new0(struct pending_request, 1);
>                 if (!data) {
> @@ -5630,7 +5705,7 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
>                 }
>
>                 data->state = REQUEST_INIT;
> -               data->handle = handle;
> +               data->attrib = attrib;
>                 queue_push_tail(device->pending_requests, data);
>         }
>
> @@ -5644,6 +5719,7 @@ static uint8_t read_by_type(const uint8_t *cmd, uint16_t cmd_len,
>  static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
>                                                         struct gatt_device *dev)
>  {
> +       struct gatt_db_attribute *attrib;
>         uint16_t handle;
>         uint16_t len;
>         uint16_t offset;
> @@ -5668,7 +5744,8 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
>                 return ATT_ECODE_REQ_NOT_SUPP;
>         }
>
> -       if (handle == 0)
> +       attrib = gatt_db_get_attribute(gatt_db, handle);
> +       if (attrib == 0)
>                 return ATT_ECODE_INVALID_HANDLE;
>
>         data = new0(struct pending_request, 1);
> @@ -5676,7 +5753,7 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
>                 return ATT_ECODE_INSUFF_RESOURCES;
>
>         data->offset = offset;
> -       data->handle = handle;
> +       data->attrib = attrib;
>         data->state = REQUEST_INIT;
>         if (!queue_push_tail(dev->pending_requests, data)) {
>                 free(data);
> @@ -5775,14 +5852,16 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
>         while (queue_peek_head(q)) {
>                 uint8_t *value;
>                 const bt_uuid_t *type;
> -               uint16_t handle = PTR_TO_UINT(queue_pop_head(q));
> +               struct gatt_db_attribute *attrib = queue_pop_head(q);
> +               uint16_t handle;
>
> -               type = gatt_db_get_attribute_type(gatt_db, handle);
> +               type = gatt_db_attribute_get_type(attrib);
>                 if (!type)
>                         break;
>
>                 value = adl->data[iterator++];
>
> +               handle = gatt_db_attribute_get_handle(attrib);
>                 put_le16(handle, value);
>                 memcpy(&value[2], &type->value.u16, bt_uuid_len(type));
>         }
> @@ -5805,7 +5884,6 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
>         uint8_t search_value[cmd_len];
>         size_t search_vlen;
>         uint16_t start, end;
> -       uint16_t handle;
>         struct queue *q;
>         bt_uuid_t uuid;
>         uint16_t len;
> @@ -5826,8 +5904,8 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
>
>         gatt_db_find_by_type(gatt_db, start, end, &uuid, q);
>
> -       handle = PTR_TO_UINT(queue_pop_head(q));
> -       while (handle) {
> +       while (queue_peek_head(q)) {
> +               struct gatt_db_attribute *attrib = queue_pop_head(q);
>                 struct pending_request *data;
>
>                 data = new0(struct pending_request, 1);
> @@ -5844,13 +5922,11 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
>                 }
>
>                 data->state = REQUEST_INIT;
> -               data->handle = handle;
> +               data->attrib = attrib;
>                 data->filter_vlen = search_vlen;
>                 memcpy(data->filter_value, search_value, search_vlen);
>
>                 queue_push_tail(device->pending_requests, data);
> -
> -               handle = PTR_TO_UINT(queue_pop_head(q));
>         }
>
>         queue_destroy(q, NULL);
> @@ -5864,6 +5940,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
>                                                 struct gatt_device *dev)
>  {
>         uint8_t value[cmd_len];
> +       struct gatt_db_attribute *attrib;
>         uint32_t permissions;
>         uint16_t handle;
>         uint16_t len;
> @@ -5876,13 +5953,18 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
>         if (handle == 0)
>                 return;
>
> -       if (!gatt_db_get_attribute_permissions(gatt_db, handle, &permissions))
> +       attrib = gatt_db_get_attribute(gatt_db, handle);
> +       if (!attrib)
> +               return;
> +
> +       if (!gatt_db_attribute_get_permissions(attrib, &permissions))
>                 return;
>
>         if (check_device_permissions(dev, cmd[0], permissions))
>                 return;
>
> -       gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0], &dev->bdaddr);
> +       gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0], &dev->bdaddr,
> +                                                               NULL, NULL);
>  }
>
>  static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
> @@ -5890,6 +5972,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
>  {
>         uint8_t value[ATT_DEFAULT_LE_MTU];
>         uint8_t s[ATT_SIGNATURE_LEN];
> +       struct gatt_db_attribute *attrib;
>         uint32_t permissions;
>         uint16_t handle;
>         uint16_t len;
> @@ -5919,9 +6002,12 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
>         if (handle == 0)
>                 return;
>
> -       if (!gatt_db_get_attribute_permissions(gatt_db, handle, &permissions))
> +       attrib = gatt_db_get_attribute(gatt_db, handle);
> +       if (!attrib)
>                 return;
>
> +       gatt_db_attribute_get_permissions(attrib, &permissions);
> +
>         if (check_device_permissions(dev, cmd[0], permissions))
>                 return;
>
> @@ -5949,16 +6035,28 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
>                 }
>                 /* Signature OK, proceed with write */
>                 bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK, r_sign_cnt);
> -               gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
> -                                                               &dev->bdaddr);
> +               gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
> +                                               &dev->bdaddr, NULL, NULL);
>         }
>  }
>
> +static void attribute_write_cb(struct gatt_db_attribute *attrib, int err,
> +                                                               void *user_data)
> +{
> +       struct pending_request *data = user_data;
> +       uint8_t error = err_to_att(err);
> +
> +       DBG("");
> +
> +       fill_gatt_response(data, attrib, data->offset, error, 0, NULL);
> +}
> +
>  static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
>                                                 struct gatt_device *dev)
>  {
>         uint8_t value[cmd_len];
>         struct pending_request *data;
> +       struct gatt_db_attribute *attrib;
>         uint32_t permissions;
>         uint16_t handle;
>         uint16_t len;
> @@ -5972,9 +6070,12 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
>         if (handle == 0)
>                 return ATT_ECODE_INVALID_HANDLE;
>
> -       if (!gatt_db_get_attribute_permissions(gatt_db, handle, &permissions))
> +       attrib = gatt_db_get_attribute(gatt_db, handle);
> +       if (!attrib)
>                 return ATT_ECODE_ATTR_NOT_FOUND;
>
> +       gatt_db_attribute_get_permissions(attrib, &permissions);
> +
>         error = check_device_permissions(dev, cmd[0], permissions);
>         if (error)
>                 return error;
> @@ -5983,7 +6084,7 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
>         if (!data)
>                 return ATT_ECODE_INSUFF_RESOURCES;
>
> -       data->handle = handle;
> +       data->attrib = attrib;
>         data->state = REQUEST_PENDING;
>
>         if (!queue_push_tail(dev->pending_requests, data)) {
> @@ -5991,8 +6092,9 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
>                 return ATT_ECODE_INSUFF_RESOURCES;
>         }
>
> -       if (!gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
> -                                                               &dev->bdaddr)) {
> +       if (!gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
> +                                       &dev->bdaddr, attribute_write_cb,
> +                                       data)) {
>                 queue_remove(dev->pending_requests, data);
>                 free(data);
>                 return ATT_ECODE_UNLIKELY;
> @@ -6008,6 +6110,7 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
>  {
>         uint8_t value[cmd_len];
>         struct pending_request *data;
> +       struct gatt_db_attribute *attrib;
>         uint32_t permissions;
>         uint16_t handle;
>         uint16_t offset;
> @@ -6023,9 +6126,12 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
>         if (handle == 0)
>                 return ATT_ECODE_INVALID_HANDLE;
>
> -       if (!gatt_db_get_attribute_permissions(gatt_db, handle, &permissions))
> +       attrib = gatt_db_get_attribute(gatt_db, handle);
> +       if (!attrib)
>                 return ATT_ECODE_ATTR_NOT_FOUND;
>
> +       gatt_db_attribute_get_permissions(attrib, &permissions);
> +
>         error = check_device_permissions(dev, cmd[0], permissions);
>         if (error)
>                 return error;
> @@ -6034,7 +6140,7 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
>         if (!data)
>                 return ATT_ECODE_INSUFF_RESOURCES;
>
> -       data->handle = handle;
> +       data->attrib = attrib;
>         data->offset = offset;
>         data->state = REQUEST_PENDING;
>
> @@ -6043,8 +6149,8 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
>                 return ATT_ECODE_INSUFF_RESOURCES;
>         }
>
> -       if (!gatt_db_write(gatt_db, handle, offset, value, vlen, cmd[0],
> -                                                               &dev->bdaddr))
> +       if (!gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
> +                                       &dev->bdaddr, attribute_write_cb, data))
>                 return ATT_ECODE_UNLIKELY;
>
>         return 0;
> @@ -6061,7 +6167,7 @@ static void send_server_write_execute_notify(void *data, void *user_data)
>
>         ev->conn_id = conn->id;
>
> -       transaction = conn_add_transact(conn, ATT_OP_EXEC_WRITE_REQ);
> +       transaction = conn_add_transact(conn, ATT_OP_EXEC_WRITE_REQ, NULL, 0);
>         if (!transaction) {
>                 conn->wait_execute_write = false;
>                 return;
> @@ -6258,12 +6364,12 @@ drop:
>  }
>
>  struct gap_srvc_handles {
> -       uint16_t srvc;
> +       struct gatt_db_attribute *srvc;
>
>         /* Characteristics */
> -       uint16_t dev_name;
> -       uint16_t appear;
> -       uint16_t priv;
> +       struct gatt_db_attribute *dev_name;
> +       struct gatt_db_attribute *appear;
> +       struct gatt_db_attribute *priv;
>  };
>
>  static struct gap_srvc_handles gap_srvc_data;
> @@ -6271,8 +6377,9 @@ static struct gap_srvc_handles gap_srvc_data;
>  #define APPEARANCE_GENERIC_PHONE 0x0040
>  #define PERIPHERAL_PRIVACY_DISABLE 0x00
>
> -static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
> -                                       bdaddr_t *bdaddr, void *user_data)
> +static void gap_read_cb(struct gatt_db_attribute *attrib, unsigned int id,
> +                       uint16_t offset, uint8_t opcode, bdaddr_t *bdaddr,
> +                       void *user_data)
>  {
>         struct pending_request *entry;
>         struct gatt_device *dev;
> @@ -6285,12 +6392,12 @@ static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
>                 return;
>         }
>
> -       entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
> -                                                       UINT_TO_PTR(handle));
> +       entry = queue_find(dev->pending_requests, match_dev_request_by_attrib,
> +                                                                       attrib);
>         if (!entry)
>                 return;
>
> -       if (handle == gap_srvc_data.dev_name) {
> +       if (attrib == gap_srvc_data.dev_name) {
>                 const char *name = bt_get_adapter_name();
>
>                 entry->value = malloc0(strlen(name));
> @@ -6301,7 +6408,7 @@ static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
>
>                 entry->length = strlen(name);
>                 memcpy(entry->value, bt_get_adapter_name(), entry->length);
> -       } else if (handle == gap_srvc_data.appear) {
> +       } else if (attrib == gap_srvc_data.appear) {
>                 entry->value = malloc0(2);
>                 if (!entry->value) {
>                         entry->error = ATT_ECODE_INSUFF_RESOURCES;
> @@ -6310,7 +6417,7 @@ static void gap_read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
>
>                 put_le16(APPEARANCE_GENERIC_PHONE, entry->value);
>                 entry->length = sizeof(uint8_t) * 2;
> -       } else if (handle == gap_srvc_data.priv) {
> +       } else if (attrib == gap_srvc_data.priv) {
>                 entry->value = malloc0(1);
>                 if (!entry->value) {
>                         entry->error = ATT_ECODE_INSUFF_RESOURCES;
> @@ -6341,7 +6448,7 @@ static void register_gap_service(void)
>         /* Device name characteristic */
>         bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
>         gap_srvc_data.dev_name =
> -                       gatt_db_add_characteristic(gatt_db, gap_srvc_data.srvc,
> +                       gatt_db_service_add_characteristic(gap_srvc_data.srvc,
>                                                         &uuid, GATT_PERM_READ,
>                                                         GATT_CHR_PROP_READ,
>                                                         gap_read_cb, NULL,
> @@ -6350,7 +6457,7 @@ static void register_gap_service(void)
>         /* Appearance */
>         bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
>         gap_srvc_data.appear =
> -                       gatt_db_add_characteristic(gatt_db, gap_srvc_data.srvc,
> +                       gatt_db_service_add_characteristic(gap_srvc_data.srvc,
>                                                         &uuid, GATT_PERM_READ,
>                                                         GATT_CHR_PROP_READ,
>                                                         gap_read_cb, NULL,
> @@ -6359,29 +6466,28 @@ static void register_gap_service(void)
>         /* Pripheral privacy flag */
>         bt_uuid16_create(&uuid, GATT_CHARAC_PERIPHERAL_PRIV_FLAG);
>         gap_srvc_data.priv =
> -                       gatt_db_add_characteristic(gatt_db, gap_srvc_data.srvc,
> +                       gatt_db_service_add_characteristic(gap_srvc_data.srvc,
>                                                         &uuid, GATT_PERM_READ,
>                                                         GATT_CHR_PROP_READ,
>                                                         gap_read_cb, NULL,
>                                                         NULL);
>
> -       gatt_db_service_set_active(gatt_db, gap_srvc_data.srvc , true);
> +       gatt_db_service_set_active(gap_srvc_data.srvc , true);
>
>         /* SDP */
>         bt_uuid16_create(&uuid, 0x1800);
> -       start = gap_srvc_data.srvc;
> -       end = gatt_db_get_end_handle(gatt_db, gap_srvc_data.srvc);
> +       gatt_db_attribute_get_service_handles(gap_srvc_data.srvc, &start, &end);
>         gap_sdp_handle = add_sdp_record(&uuid, start, end,
>                                                 "Generic Access Profile");
>         if (!gap_sdp_handle)
>                 error("gatt: Failed to register GAP SDP record");
>  }
>
> -static void device_info_read_cb(uint16_t handle, uint16_t offset,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr,
> +static void device_info_read_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
>                                         void *user_data)
>  {
> -       struct pending_request *entry;
>         struct gatt_device *dev;
>         char *buf = user_data;
>
> @@ -6391,31 +6497,16 @@ static void device_info_read_cb(uint16_t handle, uint16_t offset,
>                 return;
>         }
>
> -       entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
> -                                                       UINT_TO_PTR(handle));
> -       if (!entry)
> -               return;
> -
> -       entry->value = malloc0(strlen(buf));
> -       if (!entry->value) {
> -               entry->error = ATT_ECODE_UNLIKELY;
> -               goto done;
> -       }
> -
> -       entry->length = strlen(buf);
> -       memcpy(entry->value, buf, entry->length);
> -       entry->offset = offset;
> -
> -done:
> -       entry->state = REQUEST_DONE;
> +       gatt_db_attribute_read_result(attrib, id, 0, user_data, strlen(buf));
>  }
>
> -static void device_info_read_system_id_cb(uint16_t handle, uint16_t offset,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr,
> +static void device_info_read_system_id_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
>                                         void *user_data)
>  {
> -       struct pending_request *entry;
>         struct gatt_device *dev;
> +       uint8_t pdu[8];
>
>         dev = find_device_by_addr(bdaddr);
>         if (!dev) {
> @@ -6423,31 +6514,18 @@ static void device_info_read_system_id_cb(uint16_t handle, uint16_t offset,
>                 return;
>         }
>
> -       entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
> -                                                       UINT_TO_PTR(handle));
> -       if (!entry)
> -               return;
> -
> -       entry->value = malloc0(sizeof(uint64_t));
> -       if (!entry->value) {
> -               entry->error = ATT_ECODE_UNLIKELY;
> -               goto done;
> -       }
> -
> -       entry->length = sizeof(uint64_t);
> -       put_le64(bt_config_get_system_id(), entry->value);
> -       entry->offset = offset;
> +       put_le64(bt_config_get_system_id(), pdu);
>
> -done:
> -       entry->state = REQUEST_DONE;
> +       gatt_db_attribute_read_result(attrib, id, 0, pdu, sizeof(pdu));
>  }
>
> -static void device_info_read_pnp_id_cb(uint16_t handle, uint16_t offset,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr,
> +static void device_info_read_pnp_id_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
>                                         void *user_data)
>  {
> -       struct pending_request *entry;
>         struct gatt_device *dev;
> +       uint8_t pdu[7];
>
>         dev = find_device_by_addr(bdaddr);
>         if (!dev) {
> @@ -6455,34 +6533,19 @@ static void device_info_read_pnp_id_cb(uint16_t handle, uint16_t offset,
>                 return;
>         }
>
> -       entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
> -                                                       UINT_TO_PTR(handle));
> -       if (!entry)
> -               return;
> -
> -       entry->value = malloc0(sizeof(uint8_t) + 3 * sizeof(uint16_t));
> -       if (!entry->value) {
> -               entry->error = ATT_ECODE_UNLIKELY;
> -               goto done;
> -       }
> -
> -       entry->length = sizeof(uint8_t) + 3 * sizeof(uint16_t);
> -
> -       entry->value[0] = bt_config_get_pnp_source();
> -       put_le16(bt_config_get_pnp_vendor(), entry->value + 1);
> -       put_le16(bt_config_get_pnp_product(), entry->value + 3);
> -       put_le16(bt_config_get_pnp_version(), entry->value + 5);
> -
> -       entry->offset = offset;
> +       pdu[0] = bt_config_get_pnp_source();
> +       put_le16(bt_config_get_pnp_vendor(), &pdu[1]);
> +       put_le16(bt_config_get_pnp_product(), &pdu[3]);
> +       put_le16(bt_config_get_pnp_version(), &pdu[5]);
>
> -done:
> -       entry->state = REQUEST_DONE;
> +       gatt_db_attribute_read_result(attrib, id, 0, pdu, sizeof(pdu));
>  }
>
>  static void register_device_info_service(void)
>  {
>         bt_uuid_t uuid;
> -       uint16_t srvc_handle, end_handle;
> +       struct gatt_db_attribute *service;
> +       uint16_t start_handle, end_handle;
>         const char *data;
>         uint32_t enc_perm = GATT_PERM_READ | GATT_PERM_READ_ENCRYPTED;
>
> @@ -6490,13 +6553,13 @@ static void register_device_info_service(void)
>
>         /* Device Information Service */
>         bt_uuid16_create(&uuid, 0x180a);
> -       srvc_handle = gatt_db_add_service(gatt_db, &uuid, true, 15);
> +       service = gatt_db_add_service(gatt_db, &uuid, true, 15);
>
>         /* User data are not const hence (void *) cast is used */
>         data = bt_config_get_name();
>         if (data) {
>                 bt_uuid16_create(&uuid, GATT_CHARAC_MODEL_NUMBER_STRING);
> -               gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
> +               gatt_db_service_add_characteristic(service, &uuid,
>                                                 GATT_PERM_READ,
>                                                 GATT_CHR_PROP_READ,
>                                                 device_info_read_cb, NULL,
> @@ -6506,7 +6569,7 @@ static void register_device_info_service(void)
>         data = bt_config_get_serial();
>         if (data) {
>                 bt_uuid16_create(&uuid, GATT_CHARAC_SERIAL_NUMBER_STRING);
> -               gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
> +               gatt_db_service_add_characteristic(service, &uuid,
>                                                 enc_perm, GATT_CHR_PROP_READ,
>                                                 device_info_read_cb, NULL,
>                                                 (void *) data);
> @@ -6514,7 +6577,7 @@ static void register_device_info_service(void)
>
>         if (bt_config_get_system_id()) {
>                 bt_uuid16_create(&uuid, GATT_CHARAC_SYSTEM_ID);
> -               gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
> +               gatt_db_service_add_characteristic(service, &uuid,
>                                                 enc_perm, GATT_CHR_PROP_READ,
>                                                 device_info_read_system_id_cb,
>                                                 NULL, NULL);
> @@ -6523,7 +6586,7 @@ static void register_device_info_service(void)
>         data = bt_config_get_fw_rev();
>         if (data) {
>                 bt_uuid16_create(&uuid, GATT_CHARAC_FIRMWARE_REVISION_STRING);
> -               gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
> +               gatt_db_service_add_characteristic(service, &uuid,
>                                                 GATT_PERM_READ,
>                                                 GATT_CHR_PROP_READ,
>                                                 device_info_read_cb, NULL,
> @@ -6533,7 +6596,7 @@ static void register_device_info_service(void)
>         data = bt_config_get_hw_rev();
>         if (data) {
>                 bt_uuid16_create(&uuid, GATT_CHARAC_HARDWARE_REVISION_STRING);
> -               gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
> +               gatt_db_service_add_characteristic(service, &uuid,
>                                                 GATT_PERM_READ,
>                                                 GATT_CHR_PROP_READ,
>                                                 device_info_read_cb, NULL,
> @@ -6541,14 +6604,14 @@ static void register_device_info_service(void)
>         }
>
>         bt_uuid16_create(&uuid, GATT_CHARAC_SOFTWARE_REVISION_STRING);
> -       gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, GATT_PERM_READ,
> +       gatt_db_service_add_characteristic(service, &uuid, GATT_PERM_READ,
>                                         GATT_CHR_PROP_READ, device_info_read_cb,
>                                         NULL, VERSION);
>
>         data = bt_config_get_vendor();
>         if (data) {
>                 bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
> -               gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
> +               gatt_db_service_add_characteristic(service, &uuid,
>                                                 GATT_PERM_READ,
>                                                 GATT_CHR_PROP_READ,
>                                                 device_info_read_cb, NULL,
> @@ -6557,31 +6620,31 @@ static void register_device_info_service(void)
>
>         if (bt_config_get_pnp_source()) {
>                 bt_uuid16_create(&uuid, GATT_CHARAC_PNP_ID);
> -               gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid,
> +               gatt_db_service_add_characteristic(service, &uuid,
>                                                 GATT_PERM_READ,
>                                                 GATT_CHR_PROP_READ,
>                                                 device_info_read_pnp_id_cb,
>                                                 NULL, NULL);
>         }
>
> -       gatt_db_service_set_active(gatt_db, srvc_handle, true);
> +       gatt_db_service_set_active(service, true);
>
>         /* SDP */
>         bt_uuid16_create(&uuid, 0x180a);
> -       end_handle = gatt_db_get_end_handle(gatt_db, srvc_handle);
> -       dis_sdp_handle = add_sdp_record(&uuid, srvc_handle, end_handle,
> +       gatt_db_attribute_get_service_handles(service, &start_handle,
> +                                                               &end_handle);
> +       dis_sdp_handle = add_sdp_record(&uuid, start_handle, end_handle,
>                                                 "Device Information Service");
>         if (!dis_sdp_handle)
>                 error("gatt: Failed to register DIS SDP record");
>  }
>
> -static void gatt_srvc_change_write_cb(uint16_t handle, uint16_t offset,
> -                                               const uint8_t *val, size_t len,
> -                                               uint8_t att_opcode,
> -                                               bdaddr_t *bdaddr,
> -                                               void *user_data)
> +static void gatt_srvc_change_write_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       const uint8_t *value, size_t len,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
> +                                       void *user_data)
>  {
> -       struct pending_request *entry;
>         struct gatt_device *dev;
>
>         dev = find_device_by_addr(bdaddr);
> @@ -6590,29 +6653,25 @@ static void gatt_srvc_change_write_cb(uint16_t handle, uint16_t offset,
>                 return;
>         }
>
> -       entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
> -                                                       UINT_TO_PTR(handle));
> -       if (!entry)
> -               return;
> -
> -       entry->state = REQUEST_DONE;
> -
>         if (!bt_device_is_bonded(bdaddr)) {
> -               entry->error = ATT_ECODE_AUTHORIZATION;
> +               gatt_db_attribute_write_result(attrib, id,
> +                                               ATT_ECODE_AUTHORIZATION);
>                 return;
>         }
>
>         /* Set services changed indication value */
> -       bt_store_gatt_ccc(bdaddr, *val);
> +       bt_store_gatt_ccc(bdaddr, *value);
> +
> +       gatt_db_attribute_write_result(attrib, id, 0);
>  }
>
> -static void gatt_srvc_change_read_cb(uint16_t handle, uint16_t offset,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr,
> +static void gatt_srvc_change_read_cb(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
>                                         void *user_data)
>  {
> -       struct pending_request *entry;
>         struct gatt_device *dev;
> -       uint16_t ccc = 0;
> +       uint8_t pdu[2];
>
>         dev = find_device_by_addr(bdaddr);
>         if (!dev) {
> @@ -6620,53 +6679,41 @@ static void gatt_srvc_change_read_cb(uint16_t handle, uint16_t offset,
>                 return;
>         }
>
> -       entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
> -                                                       UINT_TO_PTR(handle));
> -       if (!entry)
> -               return;
> -
> -       ccc = bt_get_gatt_ccc(&dev->bdaddr);
> -       entry->state = REQUEST_DONE;
> -
> -       entry->value = new0(uint8_t, 2);
> -       if (!entry->value) {
> -               entry->error = ATT_ECODE_INSUFF_RESOURCES;
> -
> -               return;
> -       }
> +       put_le16(bt_get_gatt_ccc(&dev->bdaddr), pdu);
>
> -       entry->length = sizeof(uint16_t);
> -       memcpy(entry->value, &ccc, sizeof(ccc));
> +       gatt_db_attribute_read_result(attrib, id, 0, pdu, sizeof(pdu));
>  }
>
>  static void register_gatt_service(void)
>  {
> -       uint16_t srvc_handle, end_handle;
> +       struct gatt_db_attribute *service;
> +       uint16_t start_handle, end_handle;
>         bt_uuid_t uuid;
>
>         DBG("");
>
>         bt_uuid16_create(&uuid, 0x1801);
> -       srvc_handle = gatt_db_add_service(gatt_db, &uuid, true, 4);
> +       service = gatt_db_add_service(gatt_db, &uuid, true, 4);
>
>         bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
> -       service_changed_handle =  gatt_db_add_characteristic(gatt_db,
> -                                       srvc_handle, &uuid, GATT_PERM_NONE,
> -                                       GATT_CHR_PROP_INDICATE, NULL, NULL,
> -                                       NULL);
> +       service_changed_attrib = gatt_db_service_add_characteristic(service,
> +                                                       &uuid, GATT_PERM_NONE,
> +                                                       GATT_CHR_PROP_INDICATE,
> +                                                       NULL, NULL, NULL);
>
>         bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
> -       gatt_db_add_char_descriptor(gatt_db, srvc_handle, &uuid,
> +       gatt_db_service_add_descriptor(service, &uuid,
>                                         GATT_PERM_READ | GATT_PERM_WRITE,
>                                         gatt_srvc_change_read_cb,
>                                         gatt_srvc_change_write_cb, NULL);
>
> -       gatt_db_service_set_active(gatt_db, srvc_handle, true);
> +       gatt_db_service_set_active(service, true);
>
>         /* SDP */
>         bt_uuid16_create(&uuid, 0x1801);
> -       end_handle = gatt_db_get_end_handle(gatt_db, srvc_handle);
> -       gatt_sdp_handle = add_sdp_record(&uuid, srvc_handle, end_handle,
> +       gatt_db_attribute_get_service_handles(service, &start_handle,
> +                                                               &end_handle);
> +       gatt_sdp_handle = add_sdp_record(&uuid, start_handle, end_handle,
>                                                 "Generic Attribute Profile");
>
>         if (!gatt_sdp_handle)
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 5855f5d..bab1202 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -45,6 +45,18 @@ struct gatt_db {
>         struct queue *services;
>  };
>
> +struct pending_read {
> +       unsigned int id;
> +       gatt_db_attribute_read_t func;
> +       void *user_data;
> +};
> +
> +struct pending_write {
> +       unsigned int id;
> +       gatt_db_attribute_write_t func;
> +       void *user_data;
> +};
> +
>  struct gatt_db_attribute {
>         struct gatt_db_service *service;
>         uint16_t handle;
> @@ -56,6 +68,12 @@ struct gatt_db_attribute {
>         gatt_db_read_t read_func;
>         gatt_db_write_t write_func;
>         void *user_data;
> +
> +       unsigned int read_id;
> +       struct queue *pending_reads;
> +
> +       unsigned int write_id;
> +       struct queue *pending_writes;
>  };
>
>  struct gatt_db_service {
> @@ -64,11 +82,17 @@ struct gatt_db_service {
>         struct gatt_db_attribute **attributes;
>  };
>
> -static bool match_service_by_handle(const void *data, const void *user_data)
> +static void attribute_destroy(struct gatt_db_attribute *attribute)
>  {
> -       const struct gatt_db_service *service = data;
> +       /* Attribute was not initialized by user */
> +       if (!attribute)
> +               return;
> +
> +       queue_destroy(attribute->pending_reads, free);
> +       queue_destroy(attribute->pending_writes, free);
>
> -       return service->attributes[0]->handle == PTR_TO_UINT(user_data);
> +       free(attribute->value);
> +       free(attribute);
>  }
>
>  static struct gatt_db_attribute *new_attribute(struct gatt_db_service *service,
> @@ -87,25 +111,25 @@ static struct gatt_db_attribute *new_attribute(struct gatt_db_service *service,
>         attribute->value_len = len;
>         if (len) {
>                 attribute->value = malloc0(len);
> -               if (!attribute->value) {
> -                       free(attribute);
> -                       return NULL;
> -               }
> +               if (!attribute->value)
> +                       goto failed;
>
>                 memcpy(attribute->value, val, len);
>         }
>
> -       return attribute;
> -}
> +       attribute->pending_reads = queue_new();
> +       if (!attribute->pending_reads)
> +               goto failed;
>
> -static void attribute_destroy(struct gatt_db_attribute *attribute)
> -{
> -       /* Attribute was not initialized by user */
> -       if (!attribute)
> -               return;
> +       attribute->pending_writes = queue_new();
> +       if (!attribute->pending_reads)
> +               goto failed;
>
> -       free(attribute->value);
> -       free(attribute);
> +       return attribute;
> +
> +failed:
> +       attribute_destroy(attribute);
> +       return NULL;
>  }
>
>  struct gatt_db *gatt_db_new(void)
> @@ -162,8 +186,10 @@ static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
>         return bt_uuid_len(&uuid128);
>  }
>
> -uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
> -                                       bool primary, uint16_t num_handles)
> +struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
> +                                               const bt_uuid_t *uuid,
> +                                               bool primary,
> +                                               uint16_t num_handles)
>  {
>         struct gatt_db_service *service;
>         const bt_uuid_t *type;
> @@ -209,18 +235,21 @@ uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
>         db->next_handle += num_handles;
>         service->num_handles = num_handles;
>
> -       return service->attributes[0]->handle;
> +       return service->attributes[0];
>  }
>
> -bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle)
> +bool gatt_db_remove_service(struct gatt_db *db,
> +                                       struct gatt_db_attribute *attrib)
>  {
>         struct gatt_db_service *service;
>
> -       service = queue_remove_if(db->services, match_service_by_handle,
> -                                                       UINT_TO_PTR(handle));
> -       if (!service)
> +       if (!db || !attrib)
>                 return false;
>
> +       service = attrib->service;
> +
> +       queue_remove(db->services, service);
> +
>         gatt_db_service_destroy(service);
>
>         return true;
> @@ -245,8 +274,8 @@ static uint16_t get_handle_at_index(struct gatt_db_service *service,
>         return service->attributes[index]->handle;
>  }
>
> -static uint16_t update_attribute_handle(struct gatt_db_service *service,
> -                                                               int index)
> +static struct gatt_db_attribute *
> +attribute_update(struct gatt_db_service *service, int index)
>  {
>         uint16_t previous_handle;
>
> @@ -256,7 +285,7 @@ static uint16_t update_attribute_handle(struct gatt_db_service *service,
>         previous_handle = service->attributes[index - 1]->handle;
>         service->attributes[index]->handle = previous_handle + 1;
>
> -       return service->attributes[index]->handle;
> +       return service->attributes[index];
>  }
>
>  static void set_attribute_data(struct gatt_db_attribute *attribute,
> @@ -271,27 +300,28 @@ static void set_attribute_data(struct gatt_db_attribute *attribute,
>         attribute->user_data = user_data;
>  }
>
> -uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
> -                                               const bt_uuid_t *uuid,
> -                                               uint32_t permissions,
> -                                               uint8_t properties,
> -                                               gatt_db_read_t read_func,
> -                                               gatt_db_write_t write_func,
> -                                               void *user_data)
> +struct gatt_db_attribute *
> +gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
> +                                       const bt_uuid_t *uuid,
> +                                       uint32_t permissions,
> +                                       uint8_t properties,
> +                                       gatt_db_read_t read_func,
> +                                       gatt_db_write_t write_func,
> +                                       void *user_data)
>  {
> -       uint8_t value[MAX_CHAR_DECL_VALUE_LEN];
>         struct gatt_db_service *service;
> +       uint8_t value[MAX_CHAR_DECL_VALUE_LEN];
>         uint16_t len = 0;
>         int i;
>
> -       service = queue_find(db->services, match_service_by_handle,
> -                                                       UINT_TO_PTR(handle));
> -       if (!service)
> -               return 0;
> +       if (!attrib)
> +               return NULL;
> +
> +       service = attrib->service;
>
>         i = get_attribute_index(service, 1);
>         if (!i)
> -               return 0;
> +               return NULL;
>
>         value[0] = properties;
>         len += sizeof(properties);
> @@ -303,96 +333,96 @@ uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
>         service->attributes[i] = new_attribute(service, &characteristic_uuid,
>                                                                 value, len);
>         if (!service->attributes[i])
> -               return 0;
> +               return NULL;
>
> -       update_attribute_handle(service, i++);
> +       attribute_update(service, i++);
>
>         service->attributes[i] = new_attribute(service, uuid, NULL, 0);
>         if (!service->attributes[i]) {
>                 free(service->attributes[i - 1]);
> -               return 0;
> +               return NULL;
>         }
>
>         set_attribute_data(service->attributes[i], read_func, write_func,
>                                                         permissions, user_data);
>
> -       return update_attribute_handle(service, i);
> +       return attribute_update(service, i);
>  }
>
> -uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
> -                                               const bt_uuid_t *uuid,
> -                                               uint32_t permissions,
> -                                               gatt_db_read_t read_func,
> -                                               gatt_db_write_t write_func,
> -                                               void *user_data)
> +struct gatt_db_attribute *
> +gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
> +                                       const bt_uuid_t *uuid,
> +                                       uint32_t permissions,
> +                                       gatt_db_read_t read_func,
> +                                       gatt_db_write_t write_func,
> +                                       void *user_data)
>  {
>         struct gatt_db_service *service;
>         int i;
>
> -       service = queue_find(db->services, match_service_by_handle,
> -                                                       UINT_TO_PTR(handle));
> -       if (!service)
> -               return 0;
> +       if (!attrib)
> +               return false;
> +
> +       service = attrib->service;
>
>         i = get_attribute_index(service, 0);
>         if (!i)
> -               return 0;
> +               return NULL;
>
>         service->attributes[i] = new_attribute(service, uuid, NULL, 0);
>         if (!service->attributes[i])
> -               return 0;
> +               return NULL;
>
>         set_attribute_data(service->attributes[i], read_func, write_func,
>                                                         permissions, user_data);
>
> -       return update_attribute_handle(service, i);
> +       return attribute_update(service, i);
>  }
>
> -uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
> -                                               uint16_t included_handle)
> +struct gatt_db_attribute *
> +gatt_db_service_add_included(struct gatt_db_attribute *attrib,
> +                                       struct gatt_db_attribute *include)
>  {
> -       struct gatt_db_service *included_service;
> +       struct gatt_db_service *service, *included;
>         uint8_t value[MAX_INCLUDED_VALUE_LEN];
> -       uint16_t len = 0;
> -       struct gatt_db_service *service;
> +       uint16_t included_handle, len = 0;
>         int index;
>
> -       service = queue_find(db->services, match_service_by_handle,
> -                                                       UINT_TO_PTR(handle));
> -       if (!service)
> -               return 0;
> +       if (!attrib || !include)
> +               return NULL;
>
> -       included_service = queue_find(db->services, match_service_by_handle,
> -                                               UINT_TO_PTR(included_handle));
> +       service = attrib->service;
> +       included = include->service;
>
> -       if (!included_service)
> -               return 0;
> +       /* Adjust include to point to the first attribute */
> +       if (include != included->attributes[0])
> +               include = included->attributes[0];
> +
> +       included_handle = include->handle;
>
>         put_le16(included_handle, &value[len]);
>         len += sizeof(uint16_t);
>
> -       put_le16(included_handle + included_service->num_handles - 1,
> -                                                               &value[len]);
> +       put_le16(included_handle + included->num_handles - 1, &value[len]);
>         len += sizeof(uint16_t);
>
>         /* The Service UUID shall only be present when the UUID is a 16-bit
>          * Bluetooth UUID. Vol 2. Part G. 3.2
>          */
> -       if (included_service->attributes[0]->value_len == sizeof(uint16_t)) {
> -               memcpy(&value[len], included_service->attributes[0]->value,
> -                               included_service->attributes[0]->value_len);
> -               len += included_service->attributes[0]->value_len;
> +       if (include->value_len == sizeof(uint16_t)) {
> +               memcpy(&value[len], include->value, include->value_len);
> +               len += include->value_len;
>         }
>
>         index = get_attribute_index(service, 0);
>         if (!index)
> -               return 0;
> +               return NULL;
>
>         service->attributes[index] = new_attribute(service,
>                                                         &included_service_uuid,
>                                                         value, len);
>         if (!service->attributes[index])
> -               return 0;
> +               return NULL;
>
>         /* The Attribute Permissions shall be read only and not require
>          * authentication or authorization. Vol 2. Part G. 3.2
> @@ -401,20 +431,15 @@ uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
>          */
>         set_attribute_data(service->attributes[index], NULL, NULL, 0, NULL);
>
> -       return update_attribute_handle(service, index);
> +       return attribute_update(service, index);
>  }
>
> -bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
> -                                                               bool active)
> +bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool active)
>  {
> -       struct gatt_db_service *service;
> -
> -       service = queue_find(db->services, match_service_by_handle,
> -                                                       UINT_TO_PTR(handle));
> -       if (!service)
> +       if (!attrib)
>                 return false;
>
> -       service->active = active;
> +       attrib->service->active = active;
>
>         return true;
>  }
> @@ -465,8 +490,7 @@ static void read_by_group_type(void *data, void *user_data)
>                 return;
>         }
>
> -       queue_push_tail(search_data->queue,
> -                       UINT_TO_PTR(service->attributes[0]->handle));
> +       queue_push_tail(search_data->queue, service->attributes[0]);
>  }
>
>  void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
> @@ -516,8 +540,7 @@ static void find_by_type(void *data, void *user_data)
>                 if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
>                         continue;
>
> -               queue_push_tail(search_data->queue,
> -                                               UINT_TO_PTR(attribute->handle));
> +               queue_push_tail(search_data->queue, attribute);
>         }
>  }
>
> @@ -567,8 +590,7 @@ static void read_by_type(void *data, void *user_data)
>                 if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
>                         continue;
>
> -               queue_push_tail(search_data->queue,
> -                                               UINT_TO_PTR(attribute->handle));
> +               queue_push_tail(search_data->queue, attribute);
>         }
>  }
>
> @@ -619,8 +641,7 @@ static void find_information(void *data, void *user_data)
>                 if (attribute->handle > search_data->end_handle)
>                         return;
>
> -               queue_push_tail(search_data->queue,
> -                                               UINT_TO_PTR(attribute->handle));
> +               queue_push_tail(search_data->queue, attribute);
>         }
>  }
>
> @@ -649,164 +670,6 @@ static bool find_service_for_handle(const void *data, const void *user_data)
>         return (start <= handle) && (handle < end);
>  }
>
> -bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
> -                               uint8_t att_opcode, bdaddr_t *bdaddr,
> -                               uint8_t **value, int *length)
> -{
> -       struct gatt_db_service *service;
> -       uint16_t service_handle;
> -       struct gatt_db_attribute *a;
> -
> -       if (!value || !length)
> -               return false;
> -
> -       service = queue_find(db->services, find_service_for_handle,
> -                                               UINT_TO_PTR(handle));
> -       if (!service)
> -               return false;
> -
> -       service_handle = service->attributes[0]->handle;
> -
> -       a = service->attributes[handle - service_handle];
> -       if (!a)
> -               return false;
> -
> -       /*
> -        * We call callback, and set length to -1, to notify user that callback
> -        * has been called. Otherwise we set length to value length in database.
> -        */
> -       if (a->read_func) {
> -               *value = NULL;
> -               *length = -1;
> -               a->read_func(handle, offset, att_opcode, bdaddr, a->user_data);
> -       } else {
> -               if (offset > a->value_len)
> -                       return false;
> -
> -               *value = &a->value[offset];
> -               *length = a->value_len - offset;
> -       }
> -
> -       return true;
> -}
> -
> -bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
> -                                       const uint8_t *value, size_t len,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr)
> -{
> -       struct gatt_db_service *service;
> -       uint16_t service_handle;
> -       struct gatt_db_attribute *a;
> -
> -       service = queue_find(db->services, find_service_for_handle,
> -                                               UINT_TO_PTR(handle));
> -       if (!service)
> -               return false;
> -
> -       service_handle = service->attributes[0]->handle;
> -
> -       a = service->attributes[handle - service_handle];
> -       if (!a || !a->write_func)
> -               return false;
> -
> -       a->write_func(handle, offset, value, len, att_opcode, bdaddr,
> -                                                               a->user_data);
> -
> -       return true;
> -}
> -
> -const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
> -                                                       uint16_t handle)
> -{
> -       struct gatt_db_service *service;
> -       struct gatt_db_attribute *attribute;
> -       uint16_t service_handle;
> -
> -       service = queue_find(db->services, find_service_for_handle,
> -                                               UINT_TO_PTR(handle));
> -       if (!service)
> -               return NULL;
> -
> -       service_handle = service->attributes[0]->handle;
> -
> -       attribute = service->attributes[handle - service_handle];
> -       if (!attribute)
> -               return NULL;
> -
> -       return &attribute->uuid;
> -}
> -
> -uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle)
> -{
> -       struct gatt_db_service *service;
> -
> -       service = queue_find(db->services, find_service_for_handle,
> -                                               UINT_TO_PTR(handle));
> -       if (!service)
> -               return 0;
> -
> -       return service->attributes[0]->handle + service->num_handles - 1;
> -}
> -
> -bool gatt_db_get_service_uuid(struct gatt_db *db, uint16_t handle,
> -                                                               bt_uuid_t *uuid)
> -{
> -       struct gatt_db_service *service;
> -
> -       service = queue_find(db->services, find_service_for_handle,
> -                                               UINT_TO_PTR(handle));
> -       if (!service)
> -               return false;
> -
> -       if (service->attributes[0]->value_len == 2) {
> -               uint16_t value;
> -
> -               value = get_le16(service->attributes[0]->value);
> -               bt_uuid16_create(uuid, value);
> -
> -               return true;
> -       }
> -
> -       if (service->attributes[0]->value_len == 16) {
> -               uint128_t value;
> -
> -               bswap_128(service->attributes[0]->value, &value);
> -               bt_uuid128_create(uuid, value);
> -
> -               return true;
> -       }
> -
> -       return false;
> -}
> -
> -bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
> -                                                       uint32_t *permissions)
> -{
> -       struct gatt_db_attribute *attribute;
> -       struct gatt_db_service *service;
> -       uint16_t service_handle;
> -
> -       service = queue_find(db->services, find_service_for_handle,
> -                                                       UINT_TO_PTR(handle));
> -       if (!service)
> -               return false;
> -
> -       service_handle = service->attributes[0]->handle;
> -
> -       /*
> -        * We can safely get attribute from attributes array with offset,
> -        * because find_service_for_handle() check if given handle is
> -        * in service range.
> -        */
> -       attribute = service->attributes[handle - service_handle];
> -       if (!attribute)
> -               return false;
> -
> -       *permissions = attribute->permissions;
> -       return true;
> -
> -}
> -
>  struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
>                                                         uint16_t handle)
>  {
> @@ -920,8 +783,19 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>                 return false;
>
>         if (attrib->read_func) {
> -               /* TODO: Pass callback function to read_func */
> -               attrib->read_func(attrib->handle, offset, opcode, bdaddr,
> +               struct pending_read *p;
> +
> +               p = new0(struct pending_read, 1);
> +               if (!p)
> +                       return false;
> +
> +               p->id = ++attrib->read_id;
> +               p->func = func;
> +               p->user_data = user_data;
> +
> +               queue_push_tail(attrib->pending_reads, p);
> +
> +               attrib->read_func(attrib, p->id, offset, opcode, bdaddr,
>                                                         attrib->user_data);
>                 return true;
>         }
> @@ -938,6 +812,35 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>         return true;
>  }
>
> +static bool find_pending(const void *a, const void *b)
> +{
> +       const struct pending_read *p = a;
> +       unsigned int id = PTR_TO_UINT(b);
> +
> +       return p->id == id;
> +}
> +
> +bool gatt_db_attribute_read_result(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, int err,
> +                                       const uint8_t *value, size_t length)
> +{
> +       struct pending_read *p;
> +
> +       if (!attrib || !id)
> +               return false;
> +
> +       p = queue_remove_if(attrib->pending_reads, find_pending,
> +                                                       UINT_TO_PTR(id));
> +       if (!p)
> +               return false;
> +
> +       p->func(attrib, err, value, length, p->user_data);
> +
> +       free(p);
> +
> +       return true;
> +}
> +
>  bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>                                         const uint8_t *value, size_t len,
>                                         uint8_t opcode, bdaddr_t *bdaddr,
> @@ -948,7 +851,19 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>                 return false;
>
>         if (attrib->write_func) {
> -               attrib->write_func(attrib->handle, offset, value, len, opcode,
> +               struct pending_write *p;
> +
> +               p = new0(struct pending_write, 1);
> +               if (!p)
> +                       return false;
> +
> +               p->id = ++attrib->write_id;
> +               p->func = func;
> +               p->user_data = user_data;
> +
> +               queue_push_tail(attrib->pending_writes, p);
> +
> +               attrib->write_func(attrib, p->id, offset, value, len, opcode,
>                                                 bdaddr, attrib->user_data);
>                 return true;
>         }
> @@ -971,3 +886,23 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>
>         return true;
>  }
> +
> +bool gatt_db_attribute_write_result(struct gatt_db_attribute *attrib,
> +                                               unsigned int id, int err)
> +{
> +       struct pending_write *p;
> +
> +       if (!attrib || !id)
> +               return false;
> +
> +       p = queue_remove_if(attrib->pending_writes, find_pending,
> +                                                       UINT_TO_PTR(id));
> +       if (!p)
> +               return false;
> +
> +       p->func(attrib, err, p->user_data);
> +
> +       free(p);
> +
> +       return true;
> +}
> diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
> index 15be67f..9c71814 100644
> --- a/src/shared/gatt-db.h
> +++ b/src/shared/gatt-db.h
> @@ -22,43 +22,52 @@
>   */
>
>  struct gatt_db;
> +struct gatt_db_attribute;
>
>  struct gatt_db *gatt_db_new(void);
>  void gatt_db_destroy(struct gatt_db *db);
>
> -uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
> -                                       bool primary, uint16_t num_handles);
> -bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
> +struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
> +                                               const bt_uuid_t *uuid,
> +                                               bool primary,
> +                                               uint16_t num_handles);
> +
> +bool gatt_db_remove_service(struct gatt_db *db,
> +                                       struct gatt_db_attribute *attrib);
>
> -typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t offset,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr,
> +typedef void (*gatt_db_read_t) (struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
>                                         void *user_data);
>
> -typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t offset,
> +typedef void (*gatt_db_write_t) (struct gatt_db_attribute *attrib,
> +                                       unsigned int id, uint16_t offset,
>                                         const uint8_t *value, size_t len,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr,
> +                                       uint8_t opcode, bdaddr_t *bdaddr,
>                                         void *user_data);
>
> -uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
> -                                               const bt_uuid_t *uuid,
> -                                               uint32_t permissions,
> -                                               uint8_t properties,
> -                                               gatt_db_read_t read_func,
> -                                               gatt_db_write_t write_func,
> -                                               void *user_data);
> +struct gatt_db_attribute *
> +gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
> +                                       const bt_uuid_t *uuid,
> +                                       uint32_t permissions,
> +                                       uint8_t properties,
> +                                       gatt_db_read_t read_func,
> +                                       gatt_db_write_t write_func,
> +                                       void *user_data);
>
> -uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
> -                                               const bt_uuid_t *uuid,
> -                                               uint32_t permissions,
> -                                               gatt_db_read_t read_func,
> -                                               gatt_db_write_t write_func,
> -                                               void *user_data);
> +struct gatt_db_attribute *
> +gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
> +                                       const bt_uuid_t *uuid,
> +                                       uint32_t permissions,
> +                                       gatt_db_read_t read_func,
> +                                       gatt_db_write_t write_func,
> +                                       void *user_data);
>
> -uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
> -                                               uint16_t included_handle);
> +struct gatt_db_attribute *
> +gatt_db_service_add_included(struct gatt_db_attribute *attrib,
> +                                       struct gatt_db_attribute *include);
>
> -bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
> -                                                               bool active);
> +bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool active);
>
>  void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
>                                                         uint16_t end_handle,
> @@ -79,25 +88,6 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
>                                                         uint16_t end_handle,
>                                                         struct queue *queue);
>
> -bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr,
> -                                       uint8_t **value, int *length);
> -
> -bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
> -                                       const uint8_t *value, size_t len,
> -                                       uint8_t att_opcode, bdaddr_t *bdaddr);
> -
> -const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
> -                                                       uint16_t handle);
> -
> -uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
> -bool gatt_db_get_service_uuid(struct gatt_db *db, uint16_t handle,
> -                                                       bt_uuid_t *uuid);
> -
> -bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
> -                                                       uint32_t *permissions);
> -
> -struct gatt_db_attribute;
>
>  struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
>                                                         uint16_t handle);
> @@ -117,13 +107,17 @@ bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
>                                                         uint32_t *permissions);
>
>  typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
> -                                       int err, uint8_t *value, size_t length,
> -                                       void *user_data);
> +                                               int err, const uint8_t *value,
> +                                               size_t length, void *user_data);
>
>  bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>                                 uint8_t opcode, bdaddr_t *bdaddr,
>                                 gatt_db_attribute_read_t func, void *user_data);
>
> +bool gatt_db_attribute_read_result(struct gatt_db_attribute *attrib,
> +                                       unsigned int id, int err,
> +                                       const uint8_t *value, size_t length);
> +
>  typedef void (*gatt_db_attribute_write_t) (struct gatt_db_attribute *attrib,
>                                                 int err, void *user_data);
>
> @@ -132,3 +126,6 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>                                         uint8_t opcode, bdaddr_t *bdaddr,
>                                         gatt_db_attribute_write_t func,
>                                         void *user_data);
> +
> +bool gatt_db_attribute_write_result(struct gatt_db_attribute *attrib,
> +                                               unsigned int id, int err);
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 657b564..18f82c4 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -21,6 +21,8 @@
>   *
>   */
>
> +#include <sys/uio.h>
> +
>  #include "src/shared/att.h"
>  #include "lib/uuid.h"
>  #include "src/shared/queue.h"
> @@ -91,31 +93,41 @@ static bool get_uuid_le(const uint8_t *uuid, size_t len, bt_uuid_t *out_uuid)
>         return false;
>  }
>
> +static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
> +                                       const uint8_t *value, size_t length,
> +                                       void *user_data)
> +{
> +       struct iovec *iov = user_data;
> +
> +       iov->iov_base = (void *) value;
> +       iov->iov_len = length;
> +}
> +
>  static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
>                                                 uint16_t mtu,
>                                                 uint8_t *pdu, uint16_t *len)
>  {
>         int iter = 0;
>         uint16_t start_handle, end_handle;
> -       uint8_t *value;
> -       int value_len;
> +       struct iovec value;
>         uint8_t data_val_len;
>
>         *len = 0;
>
>         while (queue_peek_head(q)) {
> -               start_handle = PTR_TO_UINT(queue_pop_head(q));
> -               value = NULL;
> -               value_len = 0;
> +               struct gatt_db_attribute *attrib = queue_pop_head(q);
> +
> +               value.iov_base = NULL;
> +               value.iov_len = 0;
>
>                 /*
>                  * This should never be deferred to the read callback for
>                  * primary/secondary service declarations.
>                  */
> -               if (!gatt_db_read(db, start_handle, 0,
> +               if (!gatt_db_attribute_read(attrib, 0,
>                                                 BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
> -                                               NULL, &value,
> -                                               &value_len) || value_len < 0)
> +                                               NULL, attribute_read_cb,
> +                                               &value) || !value.iov_len)
>                         return false;
>
>                 /*
> @@ -124,21 +136,22 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
>                  * value is seen.
>                  */
>                 if (iter == 0) {
> -                       data_val_len = value_len;
> +                       data_val_len = value.iov_len;
>                         pdu[0] = data_val_len + 4;
>                         iter++;
> -               } else if (value_len != data_val_len)
> +               } else if (value.iov_len != data_val_len)
>                         break;
>
>                 /* Stop if this unit would surpass the MTU */
>                 if (iter + data_val_len + 4 > mtu)
>                         break;
>
> -               end_handle = gatt_db_get_end_handle(db, start_handle);
> +               gatt_db_attribute_get_service_handles(attrib, &start_handle,
> +                                                               &end_handle);
>
>                 put_le16(start_handle, pdu + iter);
>                 put_le16(end_handle, pdu + iter + 2);
> -               memcpy(pdu + iter + 4, value, value_len);
> +               memcpy(pdu + iter + 4, value.iov_base, value.iov_len);
>
>                 iter += data_val_len + 4;
>         }
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

This one looks good to me. I'll start rebasing on top of this.

Cheers,
Arman

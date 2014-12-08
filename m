Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418026960-21104-3-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418026960-21104-1-git-send-email-jakub.tyszkowski@tieto.com>
	<1418026960-21104-3-git-send-email-jakub.tyszkowski@tieto.com>
Date: Mon, 8 Dec 2014 10:55:28 +0200
Message-ID: <CABBYNZKn6uTjSZzPkWkLoy5Qqwtxiyaa2L5bz67RJMCabmYYRw@mail.gmail.com>
Subject: Re: [PATCH 3/5] android/gatt: Fix write commands being not handled
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Dec 8, 2014 at 10:22 AM, Jakub Tyszkowski
<jakub.tyszkowski@tieto.com> wrote:
> Registering for GATTRIB_ALL_REQS now means only requests and not commands
> or other type of att operations. Those needs their own handlers to be
> registered.

Is this something we break while with the internal changes to use
bt_gatt* internally? Maybe we should have it fixed there instead since
it perhaps breaks the core daemon as well. Going forward this code
will transition to use bt_gatt* directly.

> ---
>  android/gatt.c | 475 +++++++++++++++++++++++++++++----------------------------
>  1 file changed, 245 insertions(+), 230 deletions(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index cb87810..766aae9 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -161,7 +161,9 @@ struct gatt_device {
>         bool partial_srvc_search;
>
>         guint watch_id;
> -       guint server_id;
> +       guint req_handler_id;
> +       guint write_cmd_handler_id;
> +       guint sign_write_cmd_handler_id;
>
>         int ref;
>         int conn_cnt;
> @@ -630,8 +632,15 @@ static void connection_cleanup(struct gatt_device *device)
>         if (device->attrib) {
>                 GAttrib *attrib = device->attrib;
>
> -               if (device->server_id > 0)
> -                       g_attrib_unregister(device->attrib, device->server_id);
> +               if (device->req_handler_id > 0)
> +                       g_attrib_unregister(device->attrib,
> +                                                       device->req_handler_id);
> +               if (device->write_cmd_handler_id > 0)
> +                       g_attrib_unregister(device->attrib,
> +                                               device->write_cmd_handler_id);
> +               if (device->sign_write_cmd_handler_id > 0)
> +                       g_attrib_unregister(device->attrib,
> +                                       device->sign_write_cmd_handler_id);
>
>                 device->attrib = NULL;
>                 g_attrib_cancel_all(attrib);
> @@ -943,7 +952,8 @@ static gboolean disconnected_cb(GIOChannel *io, GIOCondition cond,
>         return FALSE;
>  }
>
> -static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data);
> +static void att_req_handler(const uint8_t *ipdu, uint16_t len,
> +                                                       gpointer user_data);
>
>  static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
>                                                         gpointer user_data)
> @@ -1431,6 +1441,222 @@ static void create_app_connection(void *data, void *user_data)
>                 create_connection(dev, app);
>  }
>
> +static void write_confirm(struct gatt_db_attribute *attrib,
> +                                               int err, void *user_data)
> +{
> +       if (!err)
> +               return;
> +
> +       error("Error writting attribute %p", attrib);
> +}
> +
> +static uint8_t check_device_permissions(struct gatt_device *device,
> +                                       uint8_t opcode, uint32_t permissions)
> +{
> +       GIOChannel *io;
> +       int sec_level;
> +
> +       io = g_attrib_get_channel(device->attrib);
> +
> +       if (!bt_io_get(io, NULL, BT_IO_OPT_SEC_LEVEL, &sec_level,
> +                                                       BT_IO_OPT_INVALID))
> +               return ATT_ECODE_UNLIKELY;
> +
> +       DBG("opcode %u permissions %u sec_level %u", opcode, permissions,
> +                                                               sec_level);
> +
> +       switch (opcode) {
> +       case ATT_OP_SIGNED_WRITE_CMD:
> +               if (!(permissions & GATT_PERM_WRITE_SIGNED))
> +                               return ATT_ECODE_WRITE_NOT_PERM;
> +
> +               if ((permissions & GATT_PERM_WRITE_SIGNED_MITM) &&
> +                                               sec_level < BT_SECURITY_HIGH)
> +                       return ATT_ECODE_AUTHENTICATION;
> +               break;
> +       case ATT_OP_READ_BY_TYPE_REQ:
> +       case ATT_OP_READ_REQ:
> +       case ATT_OP_READ_BLOB_REQ:
> +       case ATT_OP_READ_MULTI_REQ:
> +       case ATT_OP_READ_BY_GROUP_REQ:
> +       case ATT_OP_FIND_BY_TYPE_REQ:
> +       case ATT_OP_FIND_INFO_REQ:
> +               if (!(permissions & GATT_PERM_READ))
> +                       return ATT_ECODE_READ_NOT_PERM;
> +
> +               if ((permissions & GATT_PERM_READ_MITM) &&
> +                                               sec_level < BT_SECURITY_HIGH)
> +                       return ATT_ECODE_AUTHENTICATION;
> +
> +               if ((permissions & GATT_PERM_READ_ENCRYPTED) &&
> +                                               sec_level < BT_SECURITY_MEDIUM)
> +                       return ATT_ECODE_INSUFF_ENC;
> +
> +               if (permissions & GATT_PERM_READ_AUTHORIZATION)
> +                       return ATT_ECODE_AUTHORIZATION;
> +               break;
> +       case ATT_OP_WRITE_REQ:
> +       case ATT_OP_WRITE_CMD:
> +       case ATT_OP_PREP_WRITE_REQ:
> +       case ATT_OP_EXEC_WRITE_REQ:
> +               if (!(permissions & GATT_PERM_WRITE))
> +                       return ATT_ECODE_WRITE_NOT_PERM;
> +
> +               if ((permissions & GATT_PERM_WRITE_MITM) &&
> +                                               sec_level < BT_SECURITY_HIGH)
> +                       return ATT_ECODE_AUTHENTICATION;
> +
> +               if ((permissions & GATT_PERM_WRITE_ENCRYPTED) &&
> +                                               sec_level < BT_SECURITY_MEDIUM)
> +                       return ATT_ECODE_INSUFF_ENC;
> +
> +               if (permissions & GATT_PERM_WRITE_AUTHORIZATION)
> +                       return ATT_ECODE_AUTHORIZATION;
> +               break;
> +       default:
> +               return ATT_ECODE_UNLIKELY;
> +       }
> +
> +       return 0;
> +}
> +
> +static int get_cid(struct gatt_device *dev)
> +{
> +       GIOChannel *io;
> +       uint16_t cid;
> +
> +       io = g_attrib_get_channel(dev->attrib);
> +
> +       if (!bt_io_get(io, NULL, BT_IO_OPT_CID, &cid, BT_IO_OPT_INVALID)) {
> +               error("gatt: Failed to get CID");
> +               return -1;
> +       }
> +
> +       return cid;
> +}
> +
> +static int get_sec_level(struct gatt_device *dev)
> +{
> +       GIOChannel *io;
> +       int sec_level;
> +
> +       io = g_attrib_get_channel(dev->attrib);
> +
> +       if (!bt_io_get(io, NULL, BT_IO_OPT_SEC_LEVEL, &sec_level,
> +                                                       BT_IO_OPT_INVALID)) {
> +               error("gatt: Failed to get sec_level");
> +               return -1;
> +       }
> +
> +       return sec_level;
> +}
> +
> +static void att_write_cmd_handler(const uint8_t *cmd, uint16_t cmd_len,
> +                                                       gpointer user_data)
> +{
> +       struct gatt_device *dev = user_data;
> +       uint8_t value[cmd_len];
> +       struct gatt_db_attribute *attrib;
> +       uint32_t permissions;
> +       uint16_t handle;
> +       uint16_t len;
> +       size_t vlen;
> +
> +       len = dec_write_cmd(cmd, cmd_len, &handle, value, &vlen);
> +       if (!len)
> +               return;
> +
> +       if (handle == 0)
> +               return;
> +
> +       attrib = gatt_db_get_attribute(gatt_db, handle);
> +       if (!attrib)
> +               return;
> +
> +       if (!gatt_db_attribute_get_permissions(attrib, &permissions))
> +               return;
> +
> +       if (check_device_permissions(dev, cmd[0], permissions))
> +               return;
> +
> +       gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0], &dev->bdaddr,
> +                                                       write_confirm, NULL);
> +}
> +
> +static void att_sign_write_cmd_handler(const uint8_t *cmd, uint16_t cmd_len,
> +                                                       gpointer user_data)
> +{
> +       struct gatt_device *dev = user_data;
> +       uint8_t value[cmd_len];
> +       uint8_t s[ATT_SIGNATURE_LEN];
> +       struct gatt_db_attribute *attrib;
> +       uint32_t permissions;
> +       uint16_t handle;
> +       uint16_t len;
> +       size_t vlen;
> +       uint8_t csrk[16];
> +       uint32_t sign_cnt;
> +
> +       if (get_cid(dev) != ATT_CID) {
> +               error("gatt: Remote tries write signed on BR/EDR bearer");
> +               connection_cleanup(dev);
> +               return;
> +       }
> +
> +       if (get_sec_level(dev) != BT_SECURITY_LOW) {
> +               error("gatt: Remote tries write signed on encrypted link");
> +               connection_cleanup(dev);
> +               return;
> +       }
> +
> +       if (!bt_get_csrk(&dev->bdaddr, REMOTE_CSRK, csrk, &sign_cnt)) {
> +               error("gatt: No valid csrk from remote device");
> +               return;
> +       }
> +
> +       len = dec_signed_write_cmd(cmd, cmd_len, &handle, value, &vlen, s);
> +
> +       if (handle == 0)
> +               return;
> +
> +       attrib = gatt_db_get_attribute(gatt_db, handle);
> +       if (!attrib)
> +               return;
> +
> +       gatt_db_attribute_get_permissions(attrib, &permissions);
> +
> +       if (check_device_permissions(dev, cmd[0], permissions))
> +               return;
> +
> +       if (len) {
> +               uint8_t t[ATT_SIGNATURE_LEN];
> +               uint32_t r_sign_cnt = get_le32(s);
> +
> +               if (r_sign_cnt < sign_cnt) {
> +                       error("gatt: Invalid sign counter (%d<%d)",
> +                                                       r_sign_cnt, sign_cnt);
> +                       return;
> +               }
> +
> +               /* Generate signature and verify it */
> +               if (!bt_crypto_sign_att(crypto, csrk, cmd,
> +                                               cmd_len - ATT_SIGNATURE_LEN,
> +                                               r_sign_cnt, t)) {
> +                       error("gatt: Error when generating att signature");
> +                       return;
> +               }
> +
> +               if (memcmp(t, s, ATT_SIGNATURE_LEN)) {
> +                       error("gatt: signature does not match");
> +                       return;
> +               }
> +               /* Signature OK, proceed with write */
> +               bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK, r_sign_cnt);
> +               gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
> +                                       &dev->bdaddr, write_confirm, NULL);
> +       }
> +}
> +
>  static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>  {
>         struct gatt_device *dev = user_data;
> @@ -1475,10 +1701,20 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>         dev->watch_id = g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
>                                                         disconnected_cb, dev);
>
> -       dev->server_id = g_attrib_register(attrib, GATTRIB_ALL_REQS,
> +       dev->req_handler_id = g_attrib_register(attrib, GATTRIB_ALL_REQS,
> +                                               GATTRIB_ALL_HANDLES,
> +                                               att_req_handler, dev, NULL);
> +       dev->write_cmd_handler_id = g_attrib_register(attrib, ATT_OP_WRITE_CMD,
> +                                                       GATTRIB_ALL_HANDLES,
> +                                                       att_write_cmd_handler,
> +                                                       dev, NULL);
> +       dev->sign_write_cmd_handler_id = g_attrib_register(attrib,
> +                                               ATT_OP_SIGNED_WRITE_CMD,
>                                                 GATTRIB_ALL_HANDLES,
> -                                               att_handler, dev, NULL);
> -       if (dev->server_id == 0)
> +                                               att_sign_write_cmd_handler,
> +                                               dev, NULL);
> +       if ((dev->req_handler_id && dev->write_cmd_handler_id &&
> +                                       dev->sign_write_cmd_handler_id) == 0)
>                 error("gatt: Could not attach to server");
>
>         device_set_state(dev, DEVICE_CONNECTED);
> @@ -2989,37 +3225,6 @@ static void read_char_cb(guint8 status, const guint8 *pdu, guint16 len,
>         free(data);
>  }
>
> -static int get_cid(struct gatt_device *dev)
> -{
> -       GIOChannel *io;
> -       uint16_t cid;
> -
> -       io = g_attrib_get_channel(dev->attrib);
> -
> -       if (!bt_io_get(io, NULL, BT_IO_OPT_CID, &cid, BT_IO_OPT_INVALID)) {
> -               error("gatt: Failed to get CID");
> -               return -1;
> -       }
> -
> -       return cid;
> -}
> -
> -static int get_sec_level(struct gatt_device *dev)
> -{
> -       GIOChannel *io;
> -       int sec_level;
> -
> -       io = g_attrib_get_channel(dev->attrib);
> -
> -       if (!bt_io_get(io, NULL, BT_IO_OPT_SEC_LEVEL, &sec_level,
> -                                                       BT_IO_OPT_INVALID)) {
> -               error("gatt: Failed to get sec_level");
> -               return -1;
> -       }
> -
> -       return sec_level;
> -}
> -
>  static bool set_security(struct gatt_device *device, int req_sec_level)
>  {
>         int sec_level;
> @@ -4612,76 +4817,6 @@ struct request_processing_data {
>         struct gatt_device *device;
>  };
>
> -static uint8_t check_device_permissions(struct gatt_device *device,
> -                                       uint8_t opcode, uint32_t permissions)
> -{
> -       GIOChannel *io;
> -       int sec_level;
> -
> -       io = g_attrib_get_channel(device->attrib);
> -
> -       if (!bt_io_get(io, NULL, BT_IO_OPT_SEC_LEVEL, &sec_level,
> -                                                       BT_IO_OPT_INVALID))
> -               return ATT_ECODE_UNLIKELY;
> -
> -       DBG("opcode %u permissions %u sec_level %u", opcode, permissions,
> -                                                               sec_level);
> -
> -       switch (opcode) {
> -       case ATT_OP_SIGNED_WRITE_CMD:
> -               if (!(permissions & GATT_PERM_WRITE_SIGNED))
> -                               return ATT_ECODE_WRITE_NOT_PERM;
> -
> -               if ((permissions & GATT_PERM_WRITE_SIGNED_MITM) &&
> -                                               sec_level < BT_SECURITY_HIGH)
> -                       return ATT_ECODE_AUTHENTICATION;
> -               break;
> -       case ATT_OP_READ_BY_TYPE_REQ:
> -       case ATT_OP_READ_REQ:
> -       case ATT_OP_READ_BLOB_REQ:
> -       case ATT_OP_READ_MULTI_REQ:
> -       case ATT_OP_READ_BY_GROUP_REQ:
> -       case ATT_OP_FIND_BY_TYPE_REQ:
> -       case ATT_OP_FIND_INFO_REQ:
> -               if (!(permissions & GATT_PERM_READ))
> -                       return ATT_ECODE_READ_NOT_PERM;
> -
> -               if ((permissions & GATT_PERM_READ_MITM) &&
> -                                               sec_level < BT_SECURITY_HIGH)
> -                       return ATT_ECODE_AUTHENTICATION;
> -
> -               if ((permissions & GATT_PERM_READ_ENCRYPTED) &&
> -                                               sec_level < BT_SECURITY_MEDIUM)
> -                       return ATT_ECODE_INSUFF_ENC;
> -
> -               if (permissions & GATT_PERM_READ_AUTHORIZATION)
> -                       return ATT_ECODE_AUTHORIZATION;
> -               break;
> -       case ATT_OP_WRITE_REQ:
> -       case ATT_OP_WRITE_CMD:
> -       case ATT_OP_PREP_WRITE_REQ:
> -       case ATT_OP_EXEC_WRITE_REQ:
> -               if (!(permissions & GATT_PERM_WRITE))
> -                       return ATT_ECODE_WRITE_NOT_PERM;
> -
> -               if ((permissions & GATT_PERM_WRITE_MITM) &&
> -                                               sec_level < BT_SECURITY_HIGH)
> -                       return ATT_ECODE_AUTHENTICATION;
> -
> -               if ((permissions & GATT_PERM_WRITE_ENCRYPTED) &&
> -                                               sec_level < BT_SECURITY_MEDIUM)
> -                       return ATT_ECODE_INSUFF_ENC;
> -
> -               if (permissions & GATT_PERM_WRITE_AUTHORIZATION)
> -                       return ATT_ECODE_AUTHORIZATION;
> -               break;
> -       default:
> -               return ATT_ECODE_UNLIKELY;
> -       }
> -
> -       return 0;
> -}
> -
>  static uint8_t err_to_att(int err)
>  {
>         if (!err || (err > 0 && err < UINT8_MAX))
> @@ -6180,119 +6315,6 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
>         return 0;
>  }
>
> -static void write_confirm(struct gatt_db_attribute *attrib,
> -                                               int err, void *user_data)
> -{
> -       if (!err)
> -               return;
> -
> -       error("Error writting attribute %p", attrib);
> -}
> -
> -static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
> -                                               struct gatt_device *dev)
> -{
> -       uint8_t value[cmd_len];
> -       struct gatt_db_attribute *attrib;
> -       uint32_t permissions;
> -       uint16_t handle;
> -       uint16_t len;
> -       size_t vlen;
> -
> -       len = dec_write_cmd(cmd, cmd_len, &handle, value, &vlen);
> -       if (!len)
> -               return;
> -
> -       if (handle == 0)
> -               return;
> -
> -       attrib = gatt_db_get_attribute(gatt_db, handle);
> -       if (!attrib)
> -               return;
> -
> -       if (!gatt_db_attribute_get_permissions(attrib, &permissions))
> -               return;
> -
> -       if (check_device_permissions(dev, cmd[0], permissions))
> -               return;
> -
> -       gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0], &dev->bdaddr,
> -                                                       write_confirm, NULL);
> -}
> -
> -static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
> -                                               struct gatt_device *dev)
> -{
> -       uint8_t value[cmd_len];
> -       uint8_t s[ATT_SIGNATURE_LEN];
> -       struct gatt_db_attribute *attrib;
> -       uint32_t permissions;
> -       uint16_t handle;
> -       uint16_t len;
> -       size_t vlen;
> -       uint8_t csrk[16];
> -       uint32_t sign_cnt;
> -
> -       if (get_cid(dev) != ATT_CID) {
> -               error("gatt: Remote tries write signed on BR/EDR bearer");
> -               connection_cleanup(dev);
> -               return;
> -       }
> -
> -       if (get_sec_level(dev) != BT_SECURITY_LOW) {
> -               error("gatt: Remote tries write signed on encrypted link");
> -               connection_cleanup(dev);
> -               return;
> -       }
> -
> -       if (!bt_get_csrk(&dev->bdaddr, REMOTE_CSRK, csrk, &sign_cnt)) {
> -               error("gatt: No valid csrk from remote device");
> -               return;
> -       }
> -
> -       len = dec_signed_write_cmd(cmd, cmd_len, &handle, value, &vlen, s);
> -
> -       if (handle == 0)
> -               return;
> -
> -       attrib = gatt_db_get_attribute(gatt_db, handle);
> -       if (!attrib)
> -               return;
> -
> -       gatt_db_attribute_get_permissions(attrib, &permissions);
> -
> -       if (check_device_permissions(dev, cmd[0], permissions))
> -               return;
> -
> -       if (len) {
> -               uint8_t t[ATT_SIGNATURE_LEN];
> -               uint32_t r_sign_cnt = get_le32(s);
> -
> -               if (r_sign_cnt < sign_cnt) {
> -                       error("gatt: Invalid sign counter (%d<%d)",
> -                                                       r_sign_cnt, sign_cnt);
> -                       return;
> -               }
> -
> -               /* Generate signature and verify it */
> -               if (!bt_crypto_sign_att(crypto, csrk, cmd,
> -                                               cmd_len - ATT_SIGNATURE_LEN,
> -                                               r_sign_cnt, t)) {
> -                       error("gatt: Error when generating att signature");
> -                       return;
> -               }
> -
> -               if (memcmp(t, s, ATT_SIGNATURE_LEN)) {
> -                       error("gatt: signature does not match");
> -                       return;
> -               }
> -               /* Signature OK, proceed with write */
> -               bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK, r_sign_cnt);
> -               gatt_db_attribute_write(attrib, 0, value, vlen, cmd[0],
> -                                       &dev->bdaddr, write_confirm, NULL);
> -       }
> -}
> -
>  static void attribute_write_cb(struct gatt_db_attribute *attrib, int err,
>                                                                 void *user_data)
>  {
> @@ -6481,7 +6503,8 @@ static uint8_t write_execute_request(const uint8_t *cmd, uint16_t cmd_len,
>         return 0;
>  }
>
> -static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
> +static void att_req_handler(const uint8_t *ipdu, uint16_t len,
> +                                                       gpointer user_data)
>  {
>         struct gatt_device *dev = user_data;
>         uint8_t status;
> @@ -6518,14 +6541,6 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
>                 if (!status)
>                         return;
>                 break;
> -       case ATT_OP_WRITE_CMD:
> -               write_cmd_request(ipdu, len, dev);
> -               /* No response on write cmd */
> -               return;
> -       case ATT_OP_SIGNED_WRITE_CMD:
> -               write_signed_cmd_request(ipdu, len, dev);
> -               /* No response on write signed cmd */
> -               return;
>         case ATT_OP_PREP_WRITE_REQ:
>                 status = write_prep_request(ipdu, len, dev);
>                 if (!status)
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180516135230.7182-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20180516135230.7182-4-grzegorz.kolodziejczyk@codecoup.pl> <CABBYNZJkkzAG_Mfrs4PXzFDdzokEJDYi41p=SB6Ype0QVULg1w@mail.gmail.com>
In-Reply-To: <CABBYNZJkkzAG_Mfrs4PXzFDdzokEJDYi41p=SB6Ype0QVULg1w@mail.gmail.com>
From: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Date: Mon, 21 May 2018 11:58:09 +0200
Message-ID: <CALevQMa1FJ_ACEQ9BoULVo8VYvXwFDnGn4_Hj8WspKtM=6tz4g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/5] shared/gatt-server: Request authorization
 for prepare writes.
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

pon., 21 maj 2018 o 11:51 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
napisa=C5=82(a):

> Hi Grzegorz,

> On Wed, May 16, 2018 at 4:52 PM, Grzegorz Kolodziejczyk
> <grzegorz.kolodziejczyk@codecoup.pl> wrote:
> > This patch adds gatt-server possibility to request authorization from
> > application if needed and previously wasn't authorized. Authorization i=
s
> > requested by sending message with set prepare write authorization reqes=
t
> > to client.
> > ---
> >  src/gatt-database.c      | 86
++++++++++++++++++++++++++++++++++++++++--------
> >  src/shared/gatt-server.c | 64 ++++++++++++++++++++++++++++++-----
> >  2 files changed, 127 insertions(+), 23 deletions(-)
> >
> > diff --git a/src/gatt-database.c b/src/gatt-database.c
> > index 0ac5b75b0..3326b40db 100644
> > --- a/src/gatt-database.c
> > +++ b/src/gatt-database.c
> > @@ -133,6 +133,7 @@ struct external_chrc {
> >         struct queue *pending_reads;
> >         struct queue *pending_writes;
> >         unsigned int ntfy_cnt;
> > +       bool authorized;
> >  };
> >
> >  struct external_desc {
> > @@ -144,6 +145,7 @@ struct external_desc {
> >         bool handled;
> >         struct queue *pending_reads;
> >         struct queue *pending_writes;
> > +       bool authorized;
> >  };
> >
> >  struct pending_op {
> > @@ -154,6 +156,8 @@ struct pending_op {
> >         struct gatt_db_attribute *attrib;
> >         struct queue *owner_queue;
> >         struct iovec data;
> > +       bool is_characteristic;
> > +       bool authorize;
> >  };
> >
> >  struct notify {
> > @@ -1937,6 +1941,9 @@ static void append_options(DBusMessageIter *iter,
void *user_data)
> >                                                         &op->offset);
> >         if (link)
> >                 dict_append_entry(iter, "link", DBUS_TYPE_STRING,
&link);
> > +       if (op->authorize)
> > +               dict_append_entry(iter, "authorize", DBUS_TYPE_BOOLEAN,
> > +                                                       &op->authorize)=
;
> >  }
> >
> >  static void read_setup_cb(DBusMessageIter *iter, void *user_data)
> > @@ -2008,6 +2015,8 @@ static void write_setup_cb(DBusMessageIter *iter,
void *user_data)
> >  static void write_reply_cb(DBusMessage *message, void *user_data)
> >  {
> >         struct pending_op *op =3D user_data;
> > +       struct external_chrc *chrc;
> > +       struct external_desc *desc;
> >         DBusError err;
> >         DBusMessageIter iter;
> >         uint8_t ecode =3D 0;
> > @@ -2027,6 +2036,16 @@ static void write_reply_cb(DBusMessage *message,
void *user_data)
> >                 goto done;
> >         }
> >
> > +       if (op->authorize) {
> > +               if (op->is_characteristic) {
> > +                       chrc =3D
gatt_db_attribute_get_user_data(op->attrib);
> > +                       chrc->authorized =3D true;
> > +               } else {
> > +                       desc =3D
gatt_db_attribute_get_user_data(op->attrib);
> > +                       desc->authorized =3D true;
> > +               }
> > +       }
> > +
> >         dbus_message_iter_init(message, &iter);
> >         if (dbus_message_iter_has_next(&iter)) {
> >                 /*
> > @@ -2045,9 +2064,10 @@ static struct pending_op
*pending_write_new(struct btd_device *device,
> >                                         struct queue *owner_queue,
> >                                         struct gatt_db_attribute
*attrib,
> >                                         unsigned int id,
> > -                                       const uint8_t *value,
> > -                                       size_t len,
> > -                                       uint16_t offset, uint8_t
link_type)
> > +                                       const uint8_t *value, size_t
len,
> > +                                       uint16_t offset, uint8_t
link_type,
> > +                                       bool is_characteristic,
> > +                                       bool authorize)
> >  {
> >         struct pending_op *op;
> >
> > @@ -2062,6 +2082,8 @@ static struct pending_op
*pending_write_new(struct btd_device *device,
> >         op->id =3D id;
> >         op->offset =3D offset;
> >         op->link_type =3D link_type;
> > +       op->is_characteristic =3D is_characteristic;
> > +       op->authorize =3D authorize;
> >         queue_push_tail(owner_queue, op);
> >
> >         return op;
> > @@ -2073,12 +2095,15 @@ static struct pending_op *send_write(struct
btd_device *device,
> >                                         struct queue *owner_queue,
> >                                         unsigned int id,
> >                                         const uint8_t *value, size_t
len,
> > -                                       uint16_t offset, uint8_t
link_type)
> > +                                       uint16_t offset, uint8_t
link_type,
> > +                                       bool is_characteristic,
> > +                                       bool authorize)
> >  {
> >         struct pending_op *op;
> >
> >         op =3D pending_write_new(device, owner_queue, attrib, id, value=
,
len,
> > -                                                       offset,
link_type);
> > +                                       offset, link_type,
is_characteristic,
> > +                                       authorize);
> >
> >         if (g_dbus_proxy_method_call(proxy, "WriteValue",
write_setup_cb,
> >                                         owner_queue ? write_reply_cb :
NULL,
> > @@ -2191,7 +2216,7 @@ static void acquire_write_reply(DBusMessage
*message, void *user_data)
> >  retry:
> >         send_write(op->device, op->attrib, chrc->proxy, NULL, op->id,
> >                                 op->data.iov_base, op->data.iov_len, 0,
> > -                               op->link_type);
> > +                               op->link_type, false, false);
> >  }
> >
> >  static void acquire_write_setup(DBusMessageIter *iter, void *user_data=
)
> > @@ -2229,7 +2254,7 @@ static struct pending_op *acquire_write(struct
external_chrc *chrc,
> >         struct pending_op *op;
> >
> >         op =3D pending_write_new(device, NULL, attrib, id, value, len, =
0,
> > -                                                       link_type);
> > +                                               link_type, false,
false);
> >
> >         if (g_dbus_proxy_method_call(chrc->proxy, "AcquireWrite",
> >                                         acquire_write_setup,
> > @@ -2520,6 +2545,7 @@ static void desc_write_cb(struct
gatt_db_attribute *attrib,
> >  {
> >         struct external_desc *desc =3D user_data;
> >         struct btd_device *device;
> > +       DBusMessageIter iter;
> >
> >         if (desc->attrib !=3D attrib) {
> >                 error("Read callback called with incorrect attribute");
> > @@ -2532,8 +2558,25 @@ static void desc_write_cb(struct
gatt_db_attribute *attrib,
> >                 goto fail;
> >         }
> >
> > +       if (opcode =3D=3D BT_ATT_OP_PREP_WRITE_REQ) {
> > +               if (!desc->authorized &&
g_dbus_proxy_get_property(desc->proxy,
> > +                                                       "Authorize",
&iter))
> > +                       send_write(device, attrib, desc->proxy,
> > +                                       desc->pending_writes, id,
value, len,
> > +                                       offset,
bt_att_get_link_type(att),
> > +                                       false, true);
> > +               else
> > +                       gatt_db_attribute_write_result(attrib, id, 0);
> > +
> > +               return;
> > +       }
> > +
> > +       if (opcode =3D=3D BT_ATT_OP_EXEC_WRITE_REQ)
> > +               desc->authorized =3D false;
> > +
> >         if (send_write(device, attrib, desc->proxy,
desc->pending_writes, id,
> > -                               value, len, offset,
bt_att_get_link_type(att)))
> > +                       value, len, offset, bt_att_get_link_type(att),
false,
> > +                       false))
> >                 return;
> >
> >  fail:
> > @@ -2614,6 +2657,26 @@ static void chrc_write_cb(struct
gatt_db_attribute *attrib,
> >                 goto fail;
> >         }
> >
> > +       if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
> > +               queue =3D chrc->pending_writes;
> > +       else
> > +               queue =3D NULL;
> > +
> > +       if (opcode =3D=3D BT_ATT_OP_PREP_WRITE_REQ) {
> > +               if (!chrc->authorized &&
g_dbus_proxy_get_property(chrc->proxy,
> > +                                                       "Authorize",
&iter))
> > +                       send_write(device, attrib, chrc->proxy, queue,
> > +                                       id, value, len, offset,
> > +                                       bt_att_get_link_type(att),
true, true);
> > +               else
> > +                       gatt_db_attribute_write_result(attrib, id, 0);
> > +
> > +               return;
> > +       }
> > +
> > +       if (id =3D=3D BT_ATT_OP_EXEC_WRITE_REQ)
> > +               chrc->authorized =3D false;
> > +

> I guess you meant opcode =3D=3D BT_ATT_OP_EXEC_WRITE_REQ.
Right - good catch.

> >         if (chrc->write_io) {
> >                 if (pipe_io_send(chrc->write_io, value, len) < 0) {
> >                         error("Unable to write: %s", strerror(errno));
> > @@ -2630,13 +2693,8 @@ static void chrc_write_cb(struct
gatt_db_attribute *attrib,
> >                         return;
> >         }
> >
> > -       if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
> > -               queue =3D chrc->pending_writes;
> > -       else
> > -               queue =3D NULL;
> > -
> >         if (send_write(device, attrib, chrc->proxy, queue, id, value,
len,
> > -                                       offset,
bt_att_get_link_type(att)))
> > +                       offset, bt_att_get_link_type(att), false,
false))
> >                 return;
> >
> >  fail:
> > diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> > index 4b554f665..cdade76f8 100644
> > --- a/src/shared/gatt-server.c
> > +++ b/src/shared/gatt-server.c
> > @@ -1208,6 +1208,45 @@ static bool store_prep_data(struct
bt_gatt_server *server,
> >         return prep_data_new(server, handle, offset, length, value);
> >  }
> >
> > +struct prep_write_complete_data {
> > +       void *pdu;
> > +       uint16_t length;
> > +       struct bt_gatt_server *server;
> > +};
> > +
> > +static void prep_write_complete_cb(struct gatt_db_attribute *attr, int
err,
> > +                                                               void
*user_data)
> > +{
> > +       struct prep_write_complete_data *pwcd =3D user_data;
> > +       uint16_t handle =3D 0;
> > +       uint16_t offset;
> > +
> > +       handle =3D get_le16(pwcd->pdu);
> > +
> > +       if (err) {
> > +               bt_att_send_error_rsp(pwcd->server->att,
> > +                                       BT_ATT_OP_PREP_WRITE_REQ,
handle, err);
> > +               free(pwcd->pdu);
> > +               free(pwcd);
> > +
> > +               return;
> > +       }
> > +
> > +       offset =3D get_le16(pwcd->pdu + 2);
> > +
> > +       if (!store_prep_data(pwcd->server, handle, offset, pwcd->length
- 4,
> > +                                               &((uint8_t *)
pwcd->pdu)[4]))
> > +               bt_att_send_error_rsp(pwcd->server->att,
> > +                                       BT_ATT_OP_PREP_WRITE_RSP,
handle,
> > +
BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
> > +
> > +       bt_att_send(pwcd->server->att, BT_ATT_OP_PREP_WRITE_RSP,
pwcd->pdu,
> > +                                               pwcd->length, NULL,
NULL, NULL);
> > +
> > +       free(pwcd->pdu);
> > +       free(pwcd);
> > +}
> > +
> >  static void prep_write_cb(uint8_t opcode, const void *pdu,
> >                                         uint16_t length, void
*user_data)
> >  {
> > @@ -1215,7 +1254,8 @@ static void prep_write_cb(uint8_t opcode, const
void *pdu,
> >         uint16_t handle =3D 0;
> >         uint16_t offset;
> >         struct gatt_db_attribute *attr;
> > -       uint8_t ecode;
> > +       struct prep_write_complete_data *pwcd;
> > +       uint8_t ecode, status;
> >
> >         if (length < 4) {
> >                 ecode =3D BT_ATT_ERROR_INVALID_PDU;
> > @@ -1245,15 +1285,21 @@ static void prep_write_cb(uint8_t opcode, const
void *pdu,
> >         if (ecode)
> >                 goto error;
> >
> > -       if (!store_prep_data(server, handle, offset, length - 4,
> > -                                               &((uint8_t *) pdu)[4]))
{
> > -               ecode =3D BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
> > -               goto error;
> > -       }
> > +       pwcd =3D new0(struct prep_write_complete_data, 1);
> > +       pwcd->pdu =3D malloc(length);
> > +       memcpy(pwcd->pdu, pdu, length);
> > +       pwcd->length =3D length;
> > +       pwcd->server =3D server;
> >
> > -       bt_att_send(server->att, BT_ATT_OP_PREP_WRITE_RSP, pdu, length,
NULL,
> > -                                                               NULL,
NULL);
> > -       return;
> > +       status =3D gatt_db_attribute_write(attr, offset, NULL, 0,
> > +
BT_ATT_OP_PREP_WRITE_REQ,
> > +                                               server->att,
> > +                                               prep_write_complete_cb,
pwcd);
> > +
> > +       if (status)
> > +               return;
> > +
> > +       ecode =3D BT_ATT_ERROR_UNLIKELY;
> >
> >  error:
> >         bt_att_send_error_rsp(server->att, opcode, handle, ecode);
> > --
> > 2.13.6
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html



> --
> Luiz Augusto von Dentz

Regards,
Grzegorz

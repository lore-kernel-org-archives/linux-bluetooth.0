Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yunhanw@nestlabs.com
In-Reply-To: <CABBYNZ+DNnr8KkSQzKrEnbZjdEmbDC47hrO7VQ185+mOwuOn3g@mail.gmail.com>
References: <20170920074417.30435-1-luiz.dentz@gmail.com> <20170920074417.30435-7-luiz.dentz@gmail.com>
 <CALvjcs-THH_Mmuvj7TGDdJOSuhCqPWOPAfCfon=ady8oJ=vCCQ@mail.gmail.com> <CABBYNZ+DNnr8KkSQzKrEnbZjdEmbDC47hrO7VQ185+mOwuOn3g@mail.gmail.com>
From: Yunhan Wang <yunhanw@nestlabs.com>
Date: Fri, 29 Sep 2017 00:14:22 -0700
Message-ID: <CALvjcs9PLGbPEqN3oz9ndJnBz57Ymiw0mWAF++SSEV1ChNT_hA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] gatt: Implement AcquireWrite for server
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz

For server, what is the benefit to use fd instead of DBUS to pass
write value? Isn't it better that we put all bluez client and server
only chat via DBUS upon bluetoothd? For mtu, definitely we can do it
using DBUS message, if we use current acquire_write, in server
application side, we will have to implement callback for
"AcquireWrite" instead of "WriteValue=E2=80=9C=E3=80=81

Thanks
Best wishes
Yunhan

On Thu, Sep 28, 2017 at 11:54 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Yunhan,
>
> On Fri, Sep 29, 2017 at 8:04 AM, Yunhan Wang <yunhanw@nestlabs.com> wrote=
:
>> Hi, Luiz
>>
>> May I ask several questions about acquire write implementation?
>>
>> On Wed, Sep 20, 2017 at 12:44 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> This enables IO via file descriptors using AcquireWrite if server
>>> implements it.
>>> ---
>>>  src/gatt-database.c | 142 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>>  1 file changed, 142 insertions(+)
>>>
>>> diff --git a/src/gatt-database.c b/src/gatt-database.c
>>> index 61eed71d6..239fe5384 100644
>>> --- a/src/gatt-database.c
>>> +++ b/src/gatt-database.c
>>> @@ -33,6 +33,7 @@
>>>  #include "gdbus/gdbus.h"
>>>  #include "src/shared/util.h"
>>>  #include "src/shared/queue.h"
>>> +#include "src/shared/io.h"
>>>  #include "src/shared/att.h"
>>>  #include "src/shared/gatt-db.h"
>>>  #include "src/shared/gatt-server.h"
>>> @@ -117,6 +118,7 @@ struct external_chrc {
>>>         uint8_t props;
>>>         uint8_t ext_props;
>>>         uint32_t perm;
>>> +       struct io *write_io;
>>>         struct gatt_db_attribute *attrib;
>>>         struct gatt_db_attribute *ccc;
>>>         struct queue *pending_reads;
>>> @@ -325,6 +327,8 @@ static void chrc_free(void *data)
>>>  {
>>>         struct external_chrc *chrc =3D data;
>>>
>>> +       io_destroy(chrc->write_io);
>>> +
>>>         queue_destroy(chrc->pending_reads, cancel_pending_read);
>>>         queue_destroy(chrc->pending_writes, cancel_pending_write);
>>>
>>> @@ -1789,6 +1793,128 @@ static struct pending_op *send_write(struct btd=
_device *device,
>>>         return NULL;
>>>  }
>>>
>>> +static bool pipe_hup(struct io *io, void *user_data)
>>> +{
>>> +       struct external_chrc *chrc =3D user_data;
>>> +
>>> +       DBG("%p closed\n", io);
>>> +
>>> +       if (io =3D=3D chrc->write_io)
>>> +               chrc->write_io =3D NULL;
>>> +
>>> +       io_destroy(io);
>>> +
>>> +       return false;
>>> +}
>>> +
>>> +static struct io *pipe_io_new(int fd, void *user_data)
>>> +{
>>> +       struct io *io;
>>> +
>>> +       io =3D io_new(fd);
>>> +
>>> +       io_set_close_on_destroy(io, true);
>>> +
>>> +       io_set_disconnect_handler(io, pipe_hup, user_data, NULL);
>>> +
>>> +       return io;
>>> +}
>>> +
>>> +static int pipe_io_send(struct io *io, const void *data, size_t len)
>>> +{
>>> +       struct iovec iov;
>>> +
>>> +       iov.iov_base =3D (void *) data;
>>> +       iov.iov_len =3D len;
>>> +
>>> +       return io_send(io, &iov, 1);
>>> +}
>>> +
>>> +static void acquire_write_reply(DBusMessage *message, void *user_data)
>>> +{
>>> +       struct pending_op *op =3D user_data;
>>> +       struct external_chrc *chrc;
>>> +       DBusError err;
>>> +       int fd;
>>> +       uint16_t mtu;
>>> +
>>> +       chrc =3D gatt_db_attribute_get_user_data(op->attrib);
>>> +       dbus_error_init(&err);
>>> +
>>> +       if (dbus_set_error_from_message(&err, message) =3D=3D TRUE) {
>>> +               error("Failed to acquire write: %s\n", err.name);
>>> +               dbus_error_free(&err);
>>> +               goto retry;
>>> +       }
>>> +
>>> +       if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &f=
d,
>>> +                                       DBUS_TYPE_UINT16, &mtu,
>>> +                                       DBUS_TYPE_INVALID) =3D=3D false=
)) {
>>> +               error("Invalid AcquireWrite response\n");
>>> +               goto retry;
>>> +       }
>>> +
>>> +       DBG("AcquireWrite success: fd %d MTU %u\n", fd, mtu);
>>> +
>>> +       chrc->write_io =3D pipe_io_new(fd, chrc);
>>> +
>>> +       if (pipe_io_send(chrc->write_io, op->data.iov_base,
>>> +                               op->data.iov_len) < 0)
>>> +               goto retry;
>>> +
>>> +       return;
>>> +
>>> +retry:
>>> +       send_write(op->device, op->attrib, chrc->proxy, NULL, op->id,
>>> +                               op->data.iov_base, op->data.iov_len, 0)=
;
>>> +}
>>> +
>>> +static void acquire_write_setup(DBusMessageIter *iter, void *user_data=
)
>>> +{
>>> +       struct pending_op *op =3D user_data;
>>> +       DBusMessageIter dict;
>>> +       struct bt_gatt_server *server;
>>> +       uint16_t mtu;
>>> +
>>> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
>>> +                                       DBUS_DICT_ENTRY_BEGIN_CHAR_AS_S=
TRING
>>> +                                       DBUS_TYPE_STRING_AS_STRING
>>> +                                       DBUS_TYPE_VARIANT_AS_STRING
>>> +                                       DBUS_DICT_ENTRY_END_CHAR_AS_STR=
ING,
>>> +                                       &dict);
>>> +
>>> +       append_options(&dict, op);
>>> +
>>> +       server =3D btd_device_get_gatt_server(op->device);
>>> +
>>> +       mtu =3D bt_gatt_server_get_mtu(server);
>>> +
>>> +       dict_append_entry(&dict, "MTU", DBUS_TYPE_UINT16, &mtu);
>>> +
>>> +       dbus_message_iter_close_container(iter, &dict);
>>> +}
>>> +
>>> +static struct pending_op *acquire_write(struct external_chrc *chrc,
>>> +                                       struct btd_device *device,
>>> +                                       struct gatt_db_attribute *attri=
b,
>>> +                                       unsigned int id,
>>> +                                       const uint8_t *value, size_t le=
n)
>>> +{
>>> +       struct pending_op *op;
>>> +
>>> +       op =3D pending_write_new(device, NULL, attrib, id, value, len, =
0);
>>> +
>>> +       if (g_dbus_proxy_method_call(chrc->proxy, "AcquireWrite",
>>> +                                       acquire_write_setup,
>>> +                                       acquire_write_reply,
>>> +                                       op, pending_op_free))
>>> +               return op;
>>> +
>>> +       pending_op_free(op);
>>> +
>>> +       return NULL;
>>> +}
>>> +
>>>  static uint8_t ccc_write_cb(uint16_t value, void *user_data)
>>>  {
>>>         struct external_chrc *chrc =3D user_data;
>>> @@ -2090,6 +2216,7 @@ static void chrc_write_cb(struct gatt_db_attribut=
e *attrib,
>>>         struct external_chrc *chrc =3D user_data;
>>>         struct btd_device *device;
>>>         struct queue *queue;
>>> +       DBusMessageIter iter;
>>>
>>>         if (chrc->attrib !=3D attrib) {
>>>                 error("Write callback called with incorrect attribute")=
;
>>> @@ -2102,6 +2229,21 @@ static void chrc_write_cb(struct gatt_db_attribu=
te *attrib,
>>>                 goto fail;
>>>         }
>>>
>>> +       if (chrc->write_io) {
>>> +               if (pipe_io_send(chrc->write_io, value, len) < 0) {
>>> +                       error("Unable to write: %s", strerror(errno));
>>> +                       goto fail;
>>> +               }
>>> +
>>> +               gatt_db_attribute_write_result(attrib, id, 0);
>>> +               return;
>>> +       }
>>> +
>> Could you elaborate more about this part of codes, why are you using
>> pipe_io_send to update value instead of dbus?
>
> This is doing the write via fd if write_io has been acquired, the
> whole point is avoiding D-Bus.
>
>>> +       if (g_dbus_proxy_get_property(chrc->proxy, "WriteAcquired", &it=
er)) {
>>> +               if (acquire_write(chrc, device, attrib, id, value, len)=
)
>>> +                       return;
>>> +       }
>>> +
>>
>> Currently my expected scenario is to get MTU when first Gatt Write(
>> write with response) comes in specific characteristic, for example, I
>> use iphone as ble central and write value in Characteristic A on Bluez
>> peripheral, Bluez peripheral get negotiated MTU when first write comes
>> in. From this part of codes, it seems it return immediately after
>> acquire_write is called, how can we move forward and write value to
>> peripheral application? What is the design idea here?
>
> After AcquireWrite the data is sent via fd as well:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database=
.c#n1891
>
>> The below is earlier draft idea for this MTU acquisition in server side.
>> https://www.spinics.net/lists/linux-bluetooth/msg71961.html
>>
>>>         if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
>>>                 queue =3D chrc->pending_writes;
>>>         else
>>> --
>>> 2.13.5
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoo=
th" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALvjcs_cpF3ZAKjLNdGq+U_+2F43rJQNiF2042dbAVawum+nMw@mail.gmail.com>
References: <20170920074417.30435-1-luiz.dentz@gmail.com> <20170920074417.30435-9-luiz.dentz@gmail.com>
 <CALvjcs_cpF3ZAKjLNdGq+U_+2F43rJQNiF2042dbAVawum+nMw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 29 Sep 2017 10:03:14 +0300
Message-ID: <CABBYNZ+40gCRshXM8x1NHc88BJo50JR38g3Qm6Up4DKNdB3ROw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] gatt: Implement AcquireNotify for server
To: Yunhan Wang <yunhanw@nestlabs.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Fri, Sep 29, 2017 at 7:47 AM, Yunhan Wang <yunhanw@nestlabs.com> wrote:
> Hi, Luiz
>
> May I have several questions about this feature?
>
> On Wed, Sep 20, 2017 at 12:44 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This enables IO via file descriptors using AcquireWrite if server
>> implements it.
>> ---
>>  src/gatt-database.c | 116 +++++++++++++++++++++++++++++++++++++++++++++=
++++---
>>  1 file changed, 111 insertions(+), 5 deletions(-)
>>
>> diff --git a/src/gatt-database.c b/src/gatt-database.c
>> index 239fe5384..4932568dd 100644
>> --- a/src/gatt-database.c
>> +++ b/src/gatt-database.c
>> @@ -24,6 +24,7 @@
>>  #include <stdint.h>
>>  #include <stdlib.h>
>>  #include <errno.h>
>> +#include <unistd.h>
>>
>>  #include "lib/bluetooth.h"
>>  #include "lib/sdp.h"
>> @@ -118,7 +119,9 @@ struct external_chrc {
>>         uint8_t props;
>>         uint8_t ext_props;
>>         uint32_t perm;
>> +       uint16_t mtu;
>>         struct io *write_io;
>> +       struct io *notify_io;
>>         struct gatt_db_attribute *attrib;
>>         struct gatt_db_attribute *ccc;
>>         struct queue *pending_reads;
>> @@ -152,7 +155,8 @@ struct device_state {
>>         struct queue *ccc_states;
>>  };
>>
>> -typedef uint8_t (*btd_gatt_database_ccc_write_t) (uint16_t value,
>> +typedef uint8_t (*btd_gatt_database_ccc_write_t) (struct bt_att *att,
>> +                                                       uint16_t value,
>>                                                         void *user_data)=
;
>>  typedef void (*btd_gatt_database_destroy_t) (void *data);
>>
>> @@ -328,6 +332,7 @@ static void chrc_free(void *data)
>>         struct external_chrc *chrc =3D data;
>>
>>         io_destroy(chrc->write_io);
>> +       io_destroy(chrc->notify_io);
>>
>>         queue_destroy(chrc->pending_reads, cancel_pending_read);
>>         queue_destroy(chrc->pending_writes, cancel_pending_write);
>> @@ -792,7 +797,8 @@ static void gatt_ccc_write_cb(struct gatt_db_attribu=
te *attrib,
>>                 goto done;
>>
>>         if (ccc_cb->callback)
>> -               ecode =3D ccc_cb->callback(get_le16(value), ccc_cb->user=
_data);
>> +               ecode =3D ccc_cb->callback(att, get_le16(value),
>> +                                               ccc_cb->user_data);
>>
>>         if (!ecode) {
>>                 ccc->value[0] =3D value[0];
>> @@ -1801,12 +1807,34 @@ static bool pipe_hup(struct io *io, void *user_d=
ata)
>>
>>         if (io =3D=3D chrc->write_io)
>>                 chrc->write_io =3D NULL;
>> +       else
>> +               chrc->notify_io =3D NULL;
>>
>>         io_destroy(io);
>>
>>         return false;
>>  }
>>
>> +static bool pipe_io_read(struct io *io, void *user_data)
>> +{
>> +       struct external_chrc *chrc =3D user_data;
>> +       uint8_t buf[512];
>> +       int fd =3D io_get_fd(io);
>> +       ssize_t bytes_read;
>> +
>> +       bytes_read =3D read(fd, buf, sizeof(buf));
>> +       if (bytes_read < 0)
>> +               return false;
>> +
>> +       send_notification_to_devices(chrc->service->app->database,
>> +                               gatt_db_attribute_get_handle(chrc->attri=
b),
>> +                               buf, bytes_read,
>> +                               gatt_db_attribute_get_handle(chrc->ccc),
>> +                               false, NULL);
>> +
>> +       return true;
>> +}
>> +
>>  static struct io *pipe_io_new(int fd, void *user_data)
>>  {
>>         struct io *io;
>> @@ -1815,6 +1843,8 @@ static struct io *pipe_io_new(int fd, void *user_d=
ata)
>>
>>         io_set_close_on_destroy(io, true);
>>
>> +       io_set_read_handler(io, pipe_io_read, user_data, NULL);
>> +
>>         io_set_disconnect_handler(io, pipe_hup, user_data, NULL);
>>
>>         return io;
>> @@ -1915,9 +1945,64 @@ static struct pending_op *acquire_write(struct ex=
ternal_chrc *chrc,
>>         return NULL;
>>  }
>>
>> -static uint8_t ccc_write_cb(uint16_t value, void *user_data)
>> +static void acquire_notify_reply(DBusMessage *message, void *user_data)
>>  {
>>         struct external_chrc *chrc =3D user_data;
>> +       DBusError err;
>> +       int fd;
>> +       uint16_t mtu;
>> +
>> +       dbus_error_init(&err);
>> +
>> +       if (dbus_set_error_from_message(&err, message) =3D=3D TRUE) {
>> +               error("Failed to acquire notify: %s\n", err.name);
>> +               dbus_error_free(&err);
>> +               goto retry;
>> +       }
>> +
>> +       if ((dbus_message_get_args(message, NULL, DBUS_TYPE_UNIX_FD, &fd=
,
>> +                                       DBUS_TYPE_UINT16, &mtu,
>> +                                       DBUS_TYPE_INVALID) =3D=3D false)=
) {
>> +               error("Invalid AcquirNotify response\n");
>> +               goto retry;
>> +       }
>> +
>> +       DBG("AcquireNotify success: fd %d MTU %u\n", fd, mtu);
>> +
>> +       chrc->notify_io =3D pipe_io_new(fd, chrc);
>
> Why do we need to use pipe and notify_io when implementing this
> feature? I think fd and mtu has been pass using dbus message. Could
> you clarify more details?

notify_io is the receiving end of the notification, the application
will write its notifications using the fd which is captured by
checking if the fd is readable.

>
>> +
>> +       __sync_fetch_and_add(&chrc->ntfy_cnt, 1);
>> +
>> +       return;
>> +
>> +retry:
>> +       g_dbus_proxy_method_call(chrc->proxy, "StartNotify", NULL, NULL,
>> +                                                       NULL, NULL);
>> +
>> +       __sync_fetch_and_add(&chrc->ntfy_cnt, 1);
>> +}
>> +
>> +static void acquire_notify_setup(DBusMessageIter *iter, void *user_data=
)
>> +{
>> +       DBusMessageIter dict;
>> +       struct external_chrc *chrc =3D user_data;
>> +
>> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
>> +                                       DBUS_DICT_ENTRY_BEGIN_CHAR_AS_ST=
RING
>> +                                       DBUS_TYPE_STRING_AS_STRING
>> +                                       DBUS_TYPE_VARIANT_AS_STRING
>> +                                       DBUS_DICT_ENTRY_END_CHAR_AS_STRI=
NG,
>> +                                       &dict);
>> +
>> +       dict_append_entry(&dict, "MTU", DBUS_TYPE_UINT16, &chrc->mtu);
>> +
>> +       dbus_message_iter_close_container(iter, &dict);
>> +}
>> +
>> +static uint8_t ccc_write_cb(struct bt_att *att, uint16_t value, void *u=
ser_data)
>> +{
>> +       struct external_chrc *chrc =3D user_data;
>> +       DBusMessageIter iter;
>>
>>         DBG("External CCC write received with value: 0x%04x", value);
>>
>> @@ -1929,6 +2014,12 @@ static uint8_t ccc_write_cb(uint16_t value, void =
*user_data)
>>                 if (__sync_sub_and_fetch(&chrc->ntfy_cnt, 1))
>>                         return 0;
>>
>> +               if (chrc->notify_io) {
>> +                       io_destroy(chrc->notify_io);
>> +                       chrc->notify_io =3D NULL;
>> +                       return 0;
>> +               }
>> +
>>                 /*
>>                  * Send request to stop notifying. This is best-effort
>>                  * operation, so simply ignore the return the value.
>> @@ -1949,12 +2040,27 @@ static uint8_t ccc_write_cb(uint16_t value, void=
 *user_data)
>>                 (value =3D=3D 2 && !(chrc->props & BT_GATT_CHRC_PROP_IND=
ICATE)))
>>                 return BT_ERROR_CCC_IMPROPERLY_CONFIGURED;
>>
>> +       if (chrc->notify_io) {
>> +               __sync_fetch_and_add(&chrc->ntfy_cnt, 1);
>> +               return 0;
>> +       }
> What is the purpose to call __sync_fetch_and_add when there is
> charc->notify_io? What is the scenario here=EF=BC=9F

This is using the number of subscribed client as a refcount so when
there is no client left we can drop the notify_io as well.

>
>> +
>> +       chrc->mtu =3D bt_att_get_mtu(att);
>> +
>> +       /* Make use of AcquireNotify if supported */
>> +       if (g_dbus_proxy_get_property(chrc->proxy, "NotifyAcquired", &it=
er)) {
>> +               if (g_dbus_proxy_method_call(chrc->proxy, "AcquireNotify=
",
>> +                                               acquire_notify_setup,
>> +                                               acquire_notify_reply,
>> +                                               chrc, NULL))
>> +                       return 0;
>> +       }
> When ble central subscribe this characteristic,  if NotifyAcquired is
> set in ble peripheral application, then it return, but how can we
> subscribe this characteristic? May we call "AcquireNotify" when ble
> central subscribe this characteristic or enable notification?

If NotifyAcquired is supported it will call AcquireNotify, or are you
saying you tried that? The bluetoothctl has code to utilize this
feature, you just have to register a characteristic with notify flag.

>> +
>>         /*
>>          * Always call StartNotify for an incoming enable and ignore the=
 return
>>          * value for now.
>>          */
>> -       if (g_dbus_proxy_method_call(chrc->proxy,
>> -                                               "StartNotify", NULL, NUL=
L,
>> +       if (g_dbus_proxy_method_call(chrc->proxy, "StartNotify", NULL, N=
ULL,
>>                                                 NULL, NULL) =3D=3D FALSE=
)
>>                 return BT_ATT_ERROR_UNLIKELY;
>>
>> --
>> 2.13.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz

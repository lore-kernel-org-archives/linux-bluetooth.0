Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALvjcs93x2uD_+ByTvd-bo=ZL+n+nEPH_0GW3=_0DKu0i5H9yg@mail.gmail.com>
References: <20170918124001.2617-1-luiz.dentz@gmail.com> <20170918124001.2617-8-luiz.dentz@gmail.com>
 <CALvjcs93x2uD_+ByTvd-bo=ZL+n+nEPH_0GW3=_0DKu0i5H9yg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 Sep 2017 12:57:14 +0300
Message-ID: <CABBYNZLxDt1-aJZOEdtn4qL-ReeZGg8O49y-LYYevVVgDi=UpA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 07/10] client: Implement AcquireWrite for server
To: Yunhan Wang <yunhanw@nestlabs.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Tue, Sep 19, 2017 at 7:14 AM, Yunhan Wang <yunhanw@nestlabs.com> wrote:
> Hi, Luiz
>
> On Mon, Sep 18, 2017 at 5:39 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This enables IO via file descriptors using AcquireWrite if server
>> implements it.
>> ---
>>  client/gatt.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 158 insertions(+), 8 deletions(-)
>>
>> diff --git a/client/gatt.c b/client/gatt.c
>> index ab74aa695..6401fbd1a 100644
>> --- a/client/gatt.c
>> +++ b/client/gatt.c
>> @@ -32,6 +32,7 @@
>>  #include <stdbool.h>
>>  #include <sys/uio.h>
>>  #include <wordexp.h>
>> +#include <fcntl.h>
>>
>>  #include <readline/readline.h>
>>  #include <readline/history.h>
>> @@ -73,6 +74,8 @@ struct chrc {
>>         GList *descs;
>>         int value_len;
>>         uint8_t *value;
>> +       uint16_t mtu;
>> +       struct io *write_io;
>>  };
>>
>>  struct service {
>> @@ -683,19 +686,25 @@ void gatt_write_attribute(GDBusProxy *proxy, const char *arg)
>>
>>  static bool pipe_read(struct io *io, void *user_data)
>>  {
>> +       struct chrc *chrc = user_data;
>>         uint8_t buf[512];
>>         int fd = io_get_fd(io);
>>         ssize_t bytes_read;
>>
>> -       if (io != notify_io.io)
>> +       if (io != notify_io.io && !chrc)
>>                 return true;
>>
>>         bytes_read = read(fd, buf, sizeof(buf));
>>         if (bytes_read < 0)
>>                 return false;
>>
>> -       rl_printf("[" COLORED_CHG "] %s Notification:\n",
>> -                       g_dbus_proxy_get_path(notify_io.proxy));
>> +       if (chrc)
>> +               rl_printf("[" COLORED_CHG "] Attribute %s written:\n",
>> +                                                       chrc->path);
>> +       else
>> +               rl_printf("[" COLORED_CHG "] %s Notification:\n",
>> +                               g_dbus_proxy_get_path(notify_io.proxy));
>> +
>>         rl_hexdump(buf, bytes_read);
>>
>>         return true;
>> @@ -703,6 +712,17 @@ static bool pipe_read(struct io *io, void *user_data)
>>
>>  static bool pipe_hup(struct io *io, void *user_data)
>>  {
>> +       struct chrc *chrc = user_data;
>> +
>> +       if (chrc) {
>> +               rl_printf("Attribute %s Write pipe closed\n", chrc->path);
>> +               if (chrc->write_io) {
>> +                       io_destroy(chrc->write_io);
>> +                       chrc->write_io = NULL;
>> +               }
>> +               return false;
>> +       }
>> +
>>         rl_printf("%s closed\n", io == notify_io.io ? "Notify" : "Write");
>>
>>         if (io == notify_io.io)
>> @@ -713,7 +733,7 @@ static bool pipe_hup(struct io *io, void *user_data)
>>         return false;
>>  }
>>
>> -static struct io *pipe_io_new(int fd)
>> +static struct io *pipe_io_new(int fd, void *user_data)
>>  {
>>         struct io *io;
>>
>> @@ -721,9 +741,9 @@ static struct io *pipe_io_new(int fd)
>>
>>         io_set_close_on_destroy(io, true);
>>
>> -       io_set_read_handler(io, pipe_read, NULL, NULL);
>> +       io_set_read_handler(io, pipe_read, user_data, NULL);
>>
>> -       io_set_disconnect_handler(io, pipe_hup, NULL, NULL);
>> +       io_set_disconnect_handler(io, pipe_hup, user_data, NULL);
>>
>>         return io;
>>  }
>> @@ -754,7 +774,7 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
>>
>>         rl_printf("AcquireWrite success: fd %d MTU %u\n", fd, write_io.mtu);
>>
>> -       write_io.io = pipe_io_new(fd);
>> +       write_io.io = pipe_io_new(fd, NULL);
>>  }
>>
>>  void gatt_acquire_write(GDBusProxy *proxy, const char *arg)
>> @@ -817,7 +837,7 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
>>
>>         rl_printf("AcquireNotify success: fd %d MTU %u\n", fd, notify_io.mtu);
>
> What is the difference about MTU obtained from acquire_write and
> acquire_notify? Same?

They should be the same if bearer is LE, and you can acquire them
individually so it is not required to acquire them both together.

>>
>> -       notify_io.io = pipe_io_new(fd);
>> +       notify_io.io = pipe_io_new(fd, NULL);
>>  }
>>
>>  void gatt_acquire_notify(GDBusProxy *proxy, const char *arg)
>> @@ -1302,12 +1322,41 @@ static gboolean chrc_get_flags(const GDBusPropertyTable *property,
>>         return TRUE;
>>  }
>>
>> +static gboolean chrc_get_write_acquired(const GDBusPropertyTable *property,
>> +                                       DBusMessageIter *iter, void *data)
>> +{
>> +       struct chrc *chrc = data;
>> +       dbus_bool_t value;
>> +
>> +       value = chrc->write_io ? TRUE : FALSE;
>> +
>> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
>> +
>> +       return TRUE;
>> +}
>> +
>> +static gboolean chrc_write_acquired_exists(const GDBusPropertyTable *property,
>> +                                                               void *data)
>> +{
>> +       struct chrc *chrc = data;
>> +       int i;
>> +
>> +       for (i = 0; chrc->flags[i]; i++) {
>> +               if (!strcmp("write-without-response", chrc->flags[i]))
>
> Why acquire_write only works with write-without-response? If my
> application is using characteristic with Write, how can I reuse this
> acquire_write?

The fd IO don't have a reply to confirm delivery, though for server we
may assume if the remote has WriteAcquired for an Attribute it means
it will accept any data written via fd, that is in fact what the
daemon is doing though the bluetoothctl only enables WriteAcquired
with write-without-response so we can state this in the documentation
so the server can tweak this to its needs.


>
>> +                       return TRUE;
>> +       }
>> +
>> +       return FALSE;
>> +}
>> +
>>  static const GDBusPropertyTable chrc_properties[] = {
>>         { "UUID", "s", chrc_get_uuid, NULL, NULL },
>>         { "Service", "o", chrc_get_service, NULL, NULL },
>>         { "Value", "ay", chrc_get_value, NULL, NULL },
>>         { "Notifying", "b", chrc_get_notifying, NULL, NULL },
>>         { "Flags", "as", chrc_get_flags, NULL, NULL },
>> +       { "WriteAcquired", "b", chrc_get_write_acquired, NULL,
>> +                                       chrc_write_acquired_exists },
>>         { }
>>  };
>>
>> @@ -1369,6 +1418,105 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
>>         return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>>  }
>>
>> +static int parse_options(DBusMessageIter *iter, struct chrc *chrc)
>> +{
>> +       DBusMessageIter dict;
>> +
>> +       if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
>> +               return -EINVAL;
>> +
>> +       dbus_message_iter_recurse(iter, &dict);
>> +
>> +       while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
>> +               const char *key;
>> +               DBusMessageIter value, entry;
>> +               int var;
>> +
>> +               dbus_message_iter_recurse(&dict, &entry);
>> +               dbus_message_iter_get_basic(&entry, &key);
>> +
>> +               dbus_message_iter_next(&entry);
>> +               dbus_message_iter_recurse(&entry, &value);
>> +
>> +               var = dbus_message_iter_get_arg_type(&value);
>> +               if (strcasecmp(key, "Device") == 0) {
>> +                       if (var != DBUS_TYPE_OBJECT_PATH)
>> +                               return -EINVAL;
>> +               } else if (strcasecmp(key, "MTU") == 0) {
>> +                       if (var != DBUS_TYPE_UINT16)
>> +                               return -EINVAL;
>> +                       dbus_message_iter_get_basic(&value, &chrc->mtu);
>> +               }
>> +
>> +               dbus_message_iter_next(&dict);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static DBusMessage *chrc_create_pipe(struct chrc *chrc, DBusMessage *msg)
>> +{
>> +       int pipefd[2];
>> +       struct io *io;
>> +       bool dir;
>> +       DBusMessage *reply;
>> +
>> +       if (pipe2(pipefd, O_DIRECT | O_NONBLOCK | O_CLOEXEC) < 0)
>> +               return g_dbus_create_error(msg, "org.bluez.Error.Failed", "%s",
>> +                                                       strerror(errno));
>> +
>> +       dir = dbus_message_has_member(msg, "AcquireWrite");
>> +
>> +       io = pipe_io_new(pipefd[!dir], chrc);
>> +       if (!io) {
>> +               close(pipefd[0]);
>> +               close(pipefd[1]);
>> +               return g_dbus_create_error(msg, "org.bluez.Error.Failed", "%s",
>> +                                                       strerror(errno));
>> +       }
>> +
>> +       reply = g_dbus_create_reply(msg, DBUS_TYPE_UNIX_FD, &pipefd[dir],
>> +                                       DBUS_TYPE_UINT16, &chrc->mtu,
>> +                                       DBUS_TYPE_INVALID);
>> +
>> +       close(pipefd[dir]);
>> +
>> +       chrc->write_io = io;
>> +
>> +       rl_printf("[" COLORED_CHG "] Attribute %s Write pipe acquired\n",
>> +                                                       chrc->path);
>> +
>> +       return reply;
>> +}
>> +
>> +static DBusMessage *chrc_acquire_write(DBusConnection *conn, DBusMessage *msg,
>> +                                                       void *user_data)
>> +{
>> +       struct chrc *chrc = user_data;
>> +       DBusMessageIter iter;
>> +       DBusMessage *reply;
>> +
>> +       dbus_message_iter_init(msg, &iter);
>> +
>> +       if (chrc->write_io)
>> +               return g_dbus_create_error(msg,
>> +                                       "org.bluez.Error.NotPermitted",
>> +                                       NULL);
>> +
>> +       if (parse_options(&iter, chrc))
>> +               return g_dbus_create_error(msg,
>> +                                       "org.bluez.Error.InvalidArguments",
>> +                                       NULL);
>> +
>> +       reply = chrc_create_pipe(chrc, msg);
>> +
>> +       if (chrc->write_io)
>> +               g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE,
>> +                                                       "WriteAcquired");
>> +
>> +       return reply;
>> +}
>> +
>>  static DBusMessage *chrc_start_notify(DBusConnection *conn, DBusMessage *msg,
>>                                                         void *user_data)
>>  {
>> @@ -1420,6 +1568,8 @@ static const GDBusMethodTable chrc_methods[] = {
>>         { GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" },
>>                                                 { "options", "a{sv}" }),
>>                                         NULL, chrc_write_value) },
>> +       { GDBUS_METHOD("AcquireWrite", GDBUS_ARGS({ "options", "a{sv}" }),
>> +                                       NULL, chrc_acquire_write) },
>>         { GDBUS_ASYNC_METHOD("StartNotify", NULL, NULL, chrc_start_notify) },
>>         { GDBUS_METHOD("StopNotify", NULL, NULL, chrc_stop_notify) },
>>         { GDBUS_METHOD("Confirm", NULL, NULL, chrc_confirm) },
>> --
>> 2.13.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

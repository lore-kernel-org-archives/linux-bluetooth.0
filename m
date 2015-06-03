Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLGgLoeu+-9SzYGdUm18Q0n6GwEP1=ffZDw9KGy8NUqwA@mail.gmail.com>
References: <1433296026-12149-1-git-send-email-jpawlowski@google.com>
	<CABBYNZLGgLoeu+-9SzYGdUm18Q0n6GwEP1=ffZDw9KGy8NUqwA@mail.gmail.com>
Date: Wed, 3 Jun 2015 10:40:51 -0700
Message-ID: <CAD0=r8y=VPn53CvLj0RUTi_NXNYW544SdC8a+AFdGEZ8oTFKbg@mail.gmail.com>
Subject: Re: [PATCH] core: Fix connection to already paired device.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jun 3, 2015 at 2:56 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jakub,
>
> On Wed, Jun 3, 2015 at 4:47 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> Currently, when BlueZ tries to connect to already paired device that
>> just rotated its RPA MAC address, it would use old address and fail
>> to connect. In order to fix that, "General Connection Establisment
>> Procedure" must be used. It is already implemented in kernel.
>>
>> This patch changes connection procedure behaviour for paired devices.
>> Instead of directly calling "connect" with last known RPA, it'll add
>> device to kernel whitelist and start scan. If advertisement is received,
>> it'll be compared against whitelist and then trigger connection if it
>> matches.
>>
>> Two new filds were added to btd_device structure:
>> paired_le_connect - if it's true, device was marked for autoconnect
>> because someone tried to connect to it. When the connection is
>> succesfully estabilished, or after timeout this field is cleared, and
>> device is removed from autoconnect whitelist.
>> paired_le_connect_timeout - keeps handle to timeout timer. If device
>> is not found for 10 seconds, we cancel connection procedure.
>> ---
>>  src/adapter.c |  2 ++
>>  src/device.c  | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>  src/device.h  |  2 ++
>>  3 files changed, 70 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 95b5349..7e6caba 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -7465,6 +7465,8 @@ static void connected_callback(uint16_t index, uint16_t length,
>>                 return;
>>         }
>>
>> +       device_process_connect(device);
>> +
>>         memset(&eir_data, 0, sizeof(eir_data));
>>         if (eir_len > 0)
>>                 eir_parse(&eir_data, ev->eir, eir_len);
>> diff --git a/src/device.c b/src/device.c
>> index ce96ab5..8ec323c 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -78,6 +78,7 @@
>>
>>  #define IO_CAPABILITY_NOINPUTNOOUTPUT  0x03
>>
>> +#define PAIRED_LE_CONNECT_TIMEOUT 10
>>  #define DISCONNECT_TIMER       2
>>  #define DISCOVERY_TIMER                1
>>
>> @@ -255,6 +256,9 @@ struct btd_device {
>>         gboolean        auto_connect;
>>         gboolean        disable_auto_connect;
>>         gboolean        general_connect;
>> +       gboolean        paired_le_connect;
>> +
>> +       guint           paired_le_connect_timeout;
>
> You probably don't need them both, you can use the timeout handle to
> identify a connection is ongoing.
>

done

>>
>>         bool            legacy;
>>         int8_t          rssi;
>> @@ -1408,7 +1412,7 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
>>                                                         device);
>>  }
>>
>> -static void device_set_auto_connect(struct btd_device *device, gboolean enable)
>> +void device_set_auto_connect(struct btd_device *device, gboolean enable)
>>  {
>>         char addr[18];
>>
>> @@ -4459,6 +4463,54 @@ static void att_error_cb(const GError *gerr, gpointer user_data)
>>         }
>>  }
>>
>> +void device_process_connect(struct btd_device *device)
>> +{
>> +       if (!device->paired_le_connect)
>> +               return;
>> +
>> +       device->paired_le_connect = FALSE;
>> +       g_source_remove(device->paired_le_connect_timeout);
>
> Here you should probably set paired_le_connect_timeout to 0, just call
> it le_connect_timeout, and you might need to remove it also when the
> Disconnect is called or the device is removed/freed. Btw, there is
> already a function to track connection called device_add_connection Im
> not sure why you had to another one?
>

I must have missed device_add_connection, now I'll put everything into it.

>> +       device_set_auto_connect(device, false);
>> +
>> +       if (device->connect) {
>> +               g_dbus_send_message(dbus_conn,
>> +                       dbus_message_new_method_return(device->connect));
>> +               dbus_message_unref(device->connect);
>> +               device->connect = NULL;
>> +       }
>> +}
>> +
>> +static gboolean paired_le_connect_timeout(gpointer user_data)
>> +{
>> +       struct btd_device *dev = user_data;
>> +       char addr[18];
>> +
>> +       ba2str(&dev->bdaddr, addr);
>> +       DBG("Connection attempt to: %s was aborted after timeout", addr);
>> +
>> +       if (dev->paired_le_connect == FALSE)
>> +               return FALSE;
>> +
>> +       dev->paired_le_connect = false;
>> +       device_set_auto_connect(dev, false);
>
> What happen is the device was already in the auto connect list? This
> would disable it when in fact it should leave as it was.
>

Fixed, added check in device_connect_le to test if device is on
auto-connection list.

>> +       if (!dev->connect)
>> +               return FALSE;
>> +
>> +       if (dbus_message_is_method_call(dev->connect, DEVICE_INTERFACE,
>> +                                                               "Connect")) {
>> +               DBG("returning response to %s",
>> +                                       dbus_message_get_sender(dev->connect));
>> +
>> +               g_dbus_send_message(dbus_conn,
>> +                               btd_error_failed(dev->connect, strerror(20)));
>> +               dbus_message_unref(dev->connect);
>> +               dev->connect = NULL;
>> +       }
>> +
>> +       return FALSE;
>> +}
>> +
>>  int device_connect_le(struct btd_device *dev)
>>  {
>>         struct btd_adapter *adapter = dev->adapter;
>> @@ -4466,16 +4518,27 @@ int device_connect_le(struct btd_device *dev)
>>         BtIOSecLevel sec_level;
>>         GIOChannel *io;
>>         GError *gerr = NULL;
>> -       char addr[18];
>>
>>         /* There is one connection attempt going on */
>> -       if (dev->att_io)
>> +       if ((dev->le_state.paired && dev->paired_le_connect == true)
>> +                                                               || dev->att_io)
>>                 return -EALREADY;
>>
>> +       char addr[18];
>>         ba2str(&dev->bdaddr, addr);
>>
>>         DBG("Connection attempt to: %s", addr);
>>
>> +       if (dev->le_state.paired) {
>> +               dev->paired_le_connect = true;
>> +               device_set_auto_connect(dev, true);
>> +               dev->paired_le_connect_timeout = g_timeout_add_seconds(
>> +                                               PAIRED_LE_CONNECT_TIMEOUT,
>> +                                               paired_le_connect_timeout,
>> +                                               dev);
>> +               return 0;
>> +       }
>
> As I said you need to check if there device was already marked to auto
> connect, if it wasn't then you add it and you have to remember to
> remove it once connected or the connection times out. Also perhaps
> this should only be done for devices using RPA since I think direct
> connecting will probably be faster than passive scanning + connect.
>

So I'm checking if device was paired, and then I assume it'll use RPA.
Is there a better way to recognize device with RPA ?
When I initially scan, I can see that iPhone have address
70:55:D2:90:5E:EC which is RPA, but after pairing it'll always keep
this address 2C:BE:08:D8:3A:5C  which looks like NRPA.

>>         attcb = g_new0(struct att_callbacks, 1);
>>         attcb->err = att_error_cb;
>>         attcb->user_data = dev;
>> diff --git a/src/device.h b/src/device.h
>> index 1955f54..d6de1d6 100644
>> --- a/src/device.h
>> +++ b/src/device.h
>> @@ -42,6 +42,8 @@ void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
>>                                                         uint8_t bdaddr_type);
>>  void device_set_bredr_support(struct btd_device *device);
>>  void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type);
>> +void device_set_auto_connect(struct btd_device *device, gboolean enable);
>> +void device_process_connect(struct btd_device *dev);
>>  void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type);
>>  void device_merge_duplicate(struct btd_device *dev, struct btd_device *dup);
>>  uint32_t btd_device_get_class(struct btd_device *device);
>> --
>> 2.2.0.rc0.207.ga3a616c
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz

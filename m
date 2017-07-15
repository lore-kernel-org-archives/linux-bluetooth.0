Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] gatt-server: Implement NegotiatedMTU property on Device1
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKZCEQvA7fxqc5JtmBGGarqPRCntwFkRy4GZns35F1zvQ@mail.gmail.com>
Date: Sat, 15 Jul 2017 20:03:37 +0200
Cc: Jonah Petri <jonah@sense.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <8E72D5C7-FA44-4B06-82D7-2FCB22E26778@holtmann.org>
References: <CF389661-A1F2-4A25-96CD-0070FE33A1DE@sense.com>
 <CABBYNZKZCEQvA7fxqc5JtmBGGarqPRCntwFkRy4GZns35F1zvQ@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> It can be useful for programs using GATT to be aware of the maximum
>> transmittable packet size, as negotiated by bluetoothd.  This change
>> exposes the negotiated MTU over D-Bus, if such a negotiation has
>> occurred.
>> ---
>> client/main.c            |  1 +
>> doc/device-api.txt       |  5 +++++
>> src/device.c             | 31 +++++++++++++++++++++++++++++++
>> src/shared/gatt-server.c | 15 +++++++++++++++
>> src/shared/gatt-server.h |  3 +++
>> 5 files changed, 55 insertions(+)
>> 
>> diff --git a/client/main.c b/client/main.c
>> index 255cbd5..6435674 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -1372,6 +1372,7 @@ static void cmd_info(const char *arg)
>>        print_property(proxy, "ServiceData");
>>        print_property(proxy, "RSSI");
>>        print_property(proxy, "TxPower");
>> +       print_property(proxy, "NegotiatedMTU");
>> }
>> 
>> static void pair_reply(DBusMessage *message, void *user_data)
>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>> index 13b2881..908616b 100644
>> --- a/doc/device-api.txt
>> +++ b/doc/device-api.txt
>> @@ -234,3 +234,8 @@ Properties  string Address [readonly]
>>                array{byte} AdvertisingFlags [readonly, experimental]
>> 
>>                        The Advertising Data Flags of the remote device.
>> +
>> +               int16 NegotiatedMTU [readonly, optional, experimental]
>> +
>> +                       The ATT MTU negotiated with the connected host.
>> +                       Available only once MTU negotiation is complete.
> 
> Despite being odd that we start exposing transport specific details on
> device interface, there maybe a chance this is useful if we can
> properly detect BR/EDR MTU not only LE, though this means checking the
> via bt_att API not bt_gatt_server. Obviously, this would have to be
> exposed even before it is negotiated since LE start with 23 but on
> BR/EDR this is negotiated via L2CAP signaling, and perhaps it should
> not really be MTU that we expose but the actual payload without the
> headers that bluetoothd takes care of adding.

I think that exposing max payload is a better idea.

>> diff --git a/src/device.c b/src/device.c
>> index 8693eb8..1b171ee 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -930,6 +930,35 @@ static gboolean dev_property_exists_tx_power(const GDBusPropertyTable *property,
>>        return TRUE;
>> }
>> 
>> +static gboolean dev_property_get_negotiated_mtu(
>> +                                       const GDBusPropertyTable * property,
>> +                                       DBusMessageIter *iter, void *data)
>> +{
>> +       const struct btd_device *dev = data;
>> +       dbus_int16_t val = 0;
>> +       int err;
>> +
>> +       err = bt_gatt_server_get_negotiated_mtu(dev->server, &val);
>> +       if (err != 0)
>> +               return FALSE;
>> +
>> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_INT16, &val);
>> +
>> +       return TRUE;
>> +}
>> +
>> +static gboolean dev_property_exists_negotiated_mtu(
>> +                                       const GDBusPropertyTable * property,
>> +                                       void *data)
>> +{
>> +       const struct btd_device *dev = data;
>> +       int err;
>> +
>> +       err = bt_gatt_server_get_negotiated_mtu(dev->server, NULL);
>> +
>> +       return err == 0;
>> +}
>> +
>> static gboolean
>> dev_property_get_svc_resolved(const GDBusPropertyTable *property,
>>                                        DBusMessageIter *iter, void *data)
>> @@ -2561,6 +2590,8 @@ static const GDBusPropertyTable device_properties[] = {
>>                                NULL, dev_property_service_data_exist },
>>        { "TxPower", "n", dev_property_get_tx_power, NULL,
>>                                        dev_property_exists_tx_power },
>> +       { "NegotiatedMTU", "n", dev_property_get_negotiated_mtu, NULL,
>> +                                       dev_property_exists_negotiated_mtu },
> 
> AttMTU or GattMTU would probably indicate better what this is for.

So why not MaxAttributePayload or something along the lines.

Regards

Marcel


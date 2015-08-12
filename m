Return-Path: <cyrus@holtmann.org>
From: "Urbani, Edmund" <edmund.urbani@lilandit.com>
Subject: Re: Registering a GATT service via DBus
To: linux-bluetooth@vger.kernel.org
References: <1439366568-17371-1-git-send-email-anupam.r@samsung.com>
Message-ID: <55CB0ED4.1000004@LilandIT.com>
Date: Wed, 12 Aug 2015 11:16:04 +0200
MIME-Version: 1.0
In-Reply-To: <1439366568-17371-1-git-send-email-anupam.r@samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/12/2015 10:02 AM, Anupam Roy wrote:
> Hi Edmund,
>   
>> Hello,
>>
>> my attempts to register a GATT service via DBus from Java have so far
>> been unsuccessful. The GattManager1.RegisterService method does not
>> return any reply, instead I simply get this timeout exception:
>> Exception in thread "main" org.freedesktop.DBus$Error$
>> NoReply: No reply within specified time
>>
> As I understand, RegisterService DBUS method in gatt-database replies back to
> client only when client is fully ready. It happens when service is successfully created
> by gatt-database and all managed objects are successfully retrieved from client
> service and parsed by gdbus/client.c.
>
>> Also, all I see in the logs is the registration attempt, but no error:
>> Aug 11 14:42:02 raspberrypi bluetoothd[5466]:
>> src/gatt-database.c:manager_register_service() Registering service -
>> path: /com/lilandit/iventcloud/skg/service
>>
> This print only only suggests that external service is created by gatt-database
>
>> Introspection of the service (with mdbus2 tool) shows this info (which
>> matches the specs as far as a DBus noob like I can tell):
>> [METHOD]   org.bluez.GattService1.GetPrimary() -> (b:arg_0)
>> [METHOD]   org.bluez.GattService1.GetDevice() -> (o:arg_0)
>> [METHOD]   org.bluez.GattService1.GetUUID() -> (s:arg_0)
>> [METHOD]   org.bluez.GattService1.GetCharacteristics() -> (ao:arg_0)
>> [METHOD]   org.bluez.GattService1.GetIncludes() -> (ao:arg_0)
>> [METHOD]   org.freedesktop.DBus.Introspectable.Introspect() -> (s:arg_0)
>> [METHOD]   org.freedesktop.DBus.Peer.Ping() -> ()
>>
>> The implementation of the service is incomplete (same applies to the
>> ObjectManager registered at "/"), however I was expecting to at least
>> get some feedback on registration and possibly see some of the service
>> methods being called at this point. Instead I get nothing.
>>
>> Any ideas what may be wrong or where I should be looking for the cause?
>>
> According to GATT API doc, client service should export ObjectManager interface
> on its client root path. If this is not done, then I think
> GetManagedObjects call from gdbus/client will fail and client ready
> will not be invoked and possibly DBUS timeout occurs.
>
> Is your service exporting ObjectManager interface on service root path?
>
>> Kind regards,
>> Edmund
>>
>> PS: I'm using BlueZ 5.32
>
I think I need to clarify that I have exported two objects. The ObjectManager 
(path "/" with interface org.freedesktop.DBus.ObjectManager), and the 
GattService (path "/com/lilandit/iventcloud/skg/service" with interface 
org.bluez.GattService1). Is this OK, or should I have one object that implements 
both interfaces?

Note that GetManagedObjects is never called (nor are any other methods I 
implemented, each of which has a log statement right there in the first line).


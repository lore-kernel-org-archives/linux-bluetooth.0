Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Kropf Johannes <Johannes.Kropf@ait.ac.at>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: Gatt Client - RegisterApplication options
Date: Tue, 5 Jul 2016 09:55:49 +0000
Message-ID: <E92610C73D6DE84EB154DC52F5ECCE541D740866@S0MSMAIL111.arc.local>
References: <E92610C73D6DE84EB154DC52F5ECCE541D73E0E8@S0MSMAIL111.arc.local>
 <E92610C73D6DE84EB154DC52F5ECCE541D73F131@S0MSMAIL111.arc.local>
 <CABBYNZKdT-ckFMzDEL9bz+pqsqttmnK5yg8gxCTTthOj+1JJGA@mail.gmail.com>
 <E92610C73D6DE84EB154DC52F5ECCE541D7401C9@S0MSMAIL111.arc.local>,<CABBYNZKXaich4vK5L=41_PqhayVHLzrEq3GevoPtrP2UAj6iCg@mail.gmail.com>
In-Reply-To: <CABBYNZKXaich4vK5L=41_PqhayVHLzrEq3GevoPtrP2UAj6iCg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>Hi Johannes,

>On Wed, Jun 29, 2016 at 2:50 PM, Kropf Johannes
><Johannes.Kropf@ait.ac.at> wrote:
>> Dear Luiz,
>>
>>Hi Johannes,
>>
>>>On Tue, Jun 28, 2016 at 12:24 PM, Kropf Johannes
>>><Johannes.Kropf@ait.ac.at> wrote:
>>>> Hi,
>>>>
>>>> I upgraded to the newest version of bluez (5.40) and noticed that the "RegisterService" method to register the services for a client application is not existing anymore.
>>>>
>>>> However, I have troubles using the "RegisterApplication" method since I don't know how to put the profile hierarchy into the requested dict object. It is not clear for me, even after checking doc/gatt->api.txt and the source code.
>>>> Whatever I try results in the error message "No object received", invoked by the method
>>>> static void client_ready_cb(GDBusClient *client, void *user_data) in gatt-database.c
>>
>>>I suspect that you don't have ObjectManager support, you can check
>>>tests/example-gatt-server how it is done in python, for other binding
>>>there should be a similar way to register the ObjectManager interface
>>>so bluetoothd is able to list the objects.
>>
>> The ObjectManager Interface is available under the root of org.bluez, it is used also for finding devices as far as I understand.

>Yep, but in this case we are looking for the ObjectManager in the
>application side not in bluetoothd.
Ah ok, I understand. I registered the ObjectManger interface on a separate bus for my application and provided the object. It seems to work so far, but now I get the error message

bluetoothd[4521]: src/gatt-database.c:manager_register_app() Registering application: :1.150:/homer/bluez/client
bluetoothd[4521]: src/gatt-database.c:proxy_added_cb() Object received: /homer/bluez/client, iface: org.bluez.GattProfile1
bluetoothd[4521]: Failed to create GATT service entry in local database

My problem is now that I don't know the hierarchy the object manager is expected to provide. I used the following:
{Path of objectmanager, { 'org.bluez.GattProfile1', {'name': name of profile' , 'UUIDs':, String array of UUIds of services }}},

for example
{'/homer/bluez/client': {'org.bluez.GattProfile1': {'name': 'WEIGHT_SCALE', 'UUIDs': ['0000181d-0000-1000-8000-00805f9b34fb', '0000180a-0000-1000-8000-00805f9b34fb', '0000181c-0000-1000-8000-00805f9b34fb', '0000181b-0000-1000-8000-00805f9b34fb', '0000180f-0000-1000-8000-00805f9b34fb', '00001805-0000-1000-8000-00805f9b34fb']}}}

What is the correct hierarchy for providing the supported profiles of a client application? I couldn't find it anywhere in the doc.

>> The GetManagedObjects() method also works.
>> Which kind of object does bluetoothd try to find when calling the RegisterApplication method?

>It does call GetManagedObjects, we use that to enumerate the services
>the application has and then proceed to register them.
Ok, but see above.

Regards,
Johannes
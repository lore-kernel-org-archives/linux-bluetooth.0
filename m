Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: GATT service object required in D-Bus ObjectManager result
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20151129020402.GB1912@lodi.internal.kspace.net>
 <565BF7B0.2020905@ubnt.com> <565BFE44.4060706@axis.com>
 <20151130075934.GA15562@t440s.lan>
 <CABBYNZ+Gx19ucU8tHZ9Xj8-PXyjGX6Y=pkghbsM+nbWr1suVdA@mail.gmail.com>
 <CABBYNZJrB9+xrs2KeioC+YGX8661nYEFTgyKRTFUJJCtPQF7nw@mail.gmail.com>
Cc: Jonas Holmberg <jonashg@axis.com>,
	Andrejs Hanins <andrejs.hanins@ubnt.com>,
	Ryan Kuester <rkuester@insymbols.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Jonas Holmberg <jonas.holmberg@axis.com>
Message-ID: <56936D9B.2010806@axis.com>
Date: Mon, 11 Jan 2016 09:53:47 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZJrB9+xrs2KeioC+YGX8661nYEFTgyKRTFUJJCtPQF7nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 01/10/2016 11:22 PM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Mon, Nov 30, 2015 at 6:12 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi,
>>
>> On Mon, Nov 30, 2015 at 9:59 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>>> Hi,
>>>
>>> On Mon, Nov 30, 2015, Jonas Holmberg wrote:
>>>> On 11/30/2015 08:16 AM, Andrejs Hanins wrote:
>>>>> Hi,
>>>>>
>>>>> On 11/29/2015 04:04 AM, Ryan Kuester wrote:
>>>>>> Hello everyone,
>>>>>>
>>>>>> When registering a GATT service via the D-Bus API, bluez-5.36
>>>>>> seems to expect the objects returned by the service's
>>>>>> GetManagedObjects method to include the service object itself,
>>>>>> the root of the managed object tree. Indeed, the included
>>>>>> test/example-gatt-server behaves this way[1].
>>>>>>
>>>>>> However, the D-Bus Specification seems to say an ObjectManager
>>>>>> should return the objects *under* the ObjectManager, i.e., only
>>>>>> the service's children---characteristics and descriptors. This
>>>>>> reading of the specification is in agreement with the
>>>>>> ObjectManager implementations in GDBus and Python's txdbus (I
>>>>>> didn't check other implementations).
>>>>>>
>>>>>> bluez's disagreement with the standard causes pain when trying to
>>>>>> use the ObjectManager implementations in the libraries, because
>>>>>> they don't return the ObjectManager itself, the service object,
>>>>>> as bluez expects. E.g., in txdbus, it's impossible to implement
>>>>>> the ObjectManager interface in application code (to get the
>>>>>> non-standard behavior) without patching the library.
>>>>>>
>>>>>> Does the expectation that the service object appear in the
>>>>>> GetManagedObjects result look like a disagreement with the D-Bus
>>>>>> standard to anyone else?
>>>>>
>>>>> The same to me. I'm using Glib/Glibmm to export GATT services and
>>>>> Glib D-Bus code asserts in debug mode when object path matches
>>>>> with object manager path. I'm currently blindly ignoring this, cause
>>>>> it doesn't seems to cause any functionality problems in release code.
>>>>
>>>> I was also bitten by that assert. I assumed it was a bug  so I wrote a
>>>> bug report about it: https://bugzilla.gnome.org/show_bug.cgi?id=758393
>>>> But after this discussion I'm not sure if it is a bug.
>>>
>>> It appears to be a bug in the BlueZ implementation and D-Bus API. It
>>> was already discussed many months ago, but no one seems to have
>>> submitted patches to fix it:
>>>
>>> http://comments.gmane.org/gmane.linux.bluez.kernel/63291
>>> https://bugs.freedesktop.org/show_bug.cgi?id=91283
>>> https://github.com/systemd/systemd/issues/525#issuecomment-126746787
>>
>> Yep, I guess we lost track of it in the mailing list but we should
>> definitely fix it. One idea that comes to me is to change the
>> RegisterService to RegisterApplication and then have all its services
>> registered at once:
>>
>> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
>> index d832c73..f1940ba 100644
>> --- a/doc/gatt-api.txt
>> +++ b/doc/gatt-api.txt
>> @@ -270,9 +270,9 @@ must be available on the root service path. An
>> example application hierarchy
>>  containing two separate GATT services may look like this:
>>
>>  -> /com/example
>> +  |   - org.freedesktop.DBus.ObjectManager
>>    |
>>    -> /com/example/service0
>> -  | |   - org.freedesktop.DBus.ObjectManager
>>    | |   - org.freedesktop.DBus.Properties
>>    | |   - org.bluez.GattService1
>>    | |
>> @@ -289,7 +289,6 @@ containing two separate GATT services may look like this:
>>    |       - org.bluez.GattDescriptor1
>>    |
>>    -> /com/example/service1
>> -    |   - org.freedesktop.DBus.ObjectManager
>>      |   - org.freedesktop.DBus.Properties
>>      |   - org.bluez.GattService1
>>      |
>> @@ -309,21 +308,21 @@ Service           org.bluez
>>  Interface      org.bluez.GattManager1 [Experimental]
>>  Object path    [variable prefix]/{hci0,hci1,...}
>>
>> -Methods                void RegisterService(object service, dict options)
>> +Methods                void RegisterApplication(object application,
>> dict options)
>>
>> -                       Registers a local GATT service hierarchy as described
>> +                       Registers a local GATT services hierarchy as described
>>                         above.
>>
>> -                       "service" object path together with the D-Bus system
>> -                       bus connection ID define the identification of the
>> -                       application registering a GATT based service.
>> +                       The application object path together with the D-Bus
>> +                       system bus connection ID define the identification of
>> +                       the application registering a GATT based service.
>>
>>                         Possible errors: org.bluez.Error.InvalidArguments
>>                                          org.bluez.Error.AlreadyExists
>>
>> -               void UnregisterService(object service)
>> +               void UnregisterApplication(object application)
>>
>> -                       This unregisters the service that has been
>> +                       This unregisters the services that has been
>>                         previously registered. The object path parameter
>>                         must match the same value that has been used
>>                         on registration.
> 
> Any comments to the patches Ive sent upstream, Id like to push them
> which will result in breaking the current (experimental) API so I hope
> it doesn't take anyone by surprise.
> 

It looks fine to me fwiw.

/J

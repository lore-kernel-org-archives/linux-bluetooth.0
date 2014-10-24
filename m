Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <68B9F3E4-5167-413F-9907-7733B8B404B2@kamama.com>
References: <35EC48BC-A069-4F13-94E8-32A1533BB15C@kamama.com>
	<CAHrH25SBUL+JtDN_YF-FHfMRa3jqkhZs1YSr5QL5K5Oe_+xJQQ@mail.gmail.com>
	<68B9F3E4-5167-413F-9907-7733B8B404B2@kamama.com>
Date: Fri, 24 Oct 2014 10:16:31 -0700
Message-ID: <CAHrH25RXFB+9nJkUf_=5hs+KvCMCtjPF0M-NS63Cca=-tLQK1g@mail.gmail.com>
Subject: Re: GATT + DBus API Questions
From: Arman Uguray <armansito@chromium.org>
To: Ryan Du Bois <rdub@kamama.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ryan,

On Thu, Oct 23, 2014 at 5:21 PM, Ryan Du Bois <rdub@kamama.com> wrote:
> Hey Arman,
>
> On Oct 23, 2014, at 5:00 PM, Arman Uguray <armansito@chromium.org> wrote:
>
>> Hi Ryan,
>>
>> On Thu, Oct 23, 2014 at 4:41 PM, Ryan Du Bois <rdub@kamama.com> wrote:
>>> Hey There,
>>>
>>> I've been trying to create a GATT service via the DBus BlueZ API (org.bluez.GattManager1 + org.bluez.GattService1/GattCharacteristic1).  I'm currently using dbus-python to do this.
>>>
>>> What I have been able to accomplish thus far (with much exploring of the source code, and additional DBG() messages added to illuminate where I had been going wrong) is the following:
>>>        - Created proper DBus Proxy objects for GattService1 & GattCharacteristic1
>>>                - Each object vends the org.freedesktop.DBus.Properties interface, to allow BlueZ to retrieve the UUID and other properties on each instance.
>>>        - Created a proper ObjectManager proxy object to allow BlueZ to retrieve the aforementioned GattService1 and GattCharacteristic1 objects.
>>>        - Called GattManager1's RegisterService() method with appropriate arguments.
>>>        - Observed that BlueZ's GattManager1 instance calls my ObjectManager's GetManagedObjects() method, and receives the appropriate object paths/handles/properties.
>>>        - Observed that BlueZ accomplishes all the internal machinery necessary to register the GATT Service in src/gatt-dbus.c (namely, I get the "Added GATT service /com/kamama/blargh..." printout on the console, when running in debug mode).
>>>
>>> What I'm not able to see is the GATT service being listed when I explore the GATT services on my device via a BTLE exploration tool (I'm using LightBlue on Mac OS X to explore this device).
>>>
>>> Looking closer at the code, it looks to me like src/gatt-dbus.c is not hooked up to attrib/gatt-service.c, which is probably why my GATT Service and Characteristic are not showing up when exploring the device.
>>>
>>> Am I missing something, or is this not yet implemented?
>>>
>>> Thanks!
>>> --
>>> +Ryan Du Bois
>>> rdub@kamama.com
>>>
>>
>> As far as I know, gatt-dbus isn't actually wired up to attrib-server
>> as you said. So it populates an internal linked list of attributes but
>> then doesn't actually do anything over the listening socket it
>> creates.
>>
>> The thing is, we're currently in the process of rewriting all of
>> bluez's internal GATT/ATT tools and we'll probably entirely rewrite
>> src/gatt-dbus as well. An experimental implementation should appear
>> for both GATT client and server roles in the upcoming months, but
>> until then there's no good way to host GATT services over D-Bus.
>>
>> Thanks,
>> Arman
>
> Okay, that correlates with what I'm seeing. Most examples I've seen online
> have been implemented in C, calling gatt_service_add().
>
> In the time between now and a working DBus GATT API, would that
> approach be the proper method to host a GATT service with BlueZ?
> I'm on 5.21 at the moment, but could easily upgrade to something else
> if it's better for GATT services.
>

Yes, until there's a working GATT DBus API, you can follow the C examples.


> Thanks!
> --
> +Ryan Du Bois
> rdub@kamama.com
>

Cheers,
Arman

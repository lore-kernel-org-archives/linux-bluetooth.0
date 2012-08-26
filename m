Return-Path: <cyrus@holtmann.org>
Message-ID: <5039CA72.6090906@ti.com>
Date: Sun, 26 Aug 2012 10:04:18 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v4 01/10] Battery: Add Battery Service Gatt Client
References: <1345109702-5698-1-git-send-email-chen.ganir@ti.com> <1345109702-5698-2-git-send-email-chen.ganir@ti.com> <20120816113941.GA20887@x220> <502CE43C.7040804@ti.com> <20120816124410.GB24627@x220> <502CEDA7.2040908@ti.com> <20120816192440.GC25826@x220.P-661HNU-F1> <CABBYNZ+bn__fjNMSwix3J7ntRyTahEQca+z9EeWg2PPEwt3S1A@mail.gmail.com>
In-Reply-To: <CABBYNZ+bn__fjNMSwix3J7ntRyTahEQca+z9EeWg2PPEwt3S1A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz,

On 08/20/2012 04:03 PM, Luiz Augusto von Dentz wrote:
> Hi Chen, Johan,
>
> On Thu, Aug 16, 2012 at 10:24 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Chen,
>>
>> On Thu, Aug 16, 2012, Chen Ganir wrote:
>>>>> However, i fail to understand why the object manager prevents this
>>>> >from getting accepted - do you have a time estimation when the
>>>>> object manager should be active or available ?
>>>>
>>>> By the time of our next release (as per the content under the BlueZ 5
>>>> section in our TODO file).
>>>
>>> Is there anywhere some documentation or instructions how to adapt
>>> the API for the new object manager ? Is it backward compatible to
>>> what we have today ? Do we really hold back DBUS additions until we
>>> change the DBUS API ?
>>
>> As an unrelated thing (but since I saw it in your commit messages too):
>> please spell D-Bus as D-Bus, not DBUS, DBus, or anything else in natural
>> written language. This keeps it consistent with the rest of our
>> documentation as well as how the D-Bus project itself spells the name.
>>
>> Regarding the Object Manager interface the implementation details you'd
>> get from Lucas and Luiz who are working on it whereas the API spec is
>> available here:
>>
>> http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager
>
> With object manager we have to keep 2 things in mind while designing
> new interfaces:
>
> 1. In case of returning new objects, as in CreateDevice, always
> include the interfaces and properties e.g. D-Bus signature oa{sa{sv}}
> (we will probably have a gdbus helper to do that) which is the
> equivalent to InterfacesAdded signal. This avoid having to call
> GetManagedObjects.
> 2. No need to keep a list of objects or emit signals when one is
> created/destroyed, gdbus will take care of this automatically.
>
> Now if this is really relevant here Im not sure.
>
Is there any current implementation of this object manager in the bluez 
tree ? Is it already implemented ?

>>>>> I prefer this way of putting the batteries below the device, since it
>>>>> is obvious which battery belongs to each device.
>>>>
>>>> I fully agree with this. It's not what I had an issue with. However, if
>>>> we really want to make this clear you could additionally have a "Device"
>>>> property for each battery object pointing back to the parent object.
>>> I can do that, if it helps. Although it is not necessary, since the
>>> object path for a battery already contains the device objec path in
>>> it :
>>> [variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX/BATT-NN-DDDD
>>> Adding a device object path as a property will be redundant.
>>
>> Even though we do have such a hierarchical construction of the paths I
>> don't think we should encourage this kind of magic tricks in trying look
>> into actual values of object paths to infer their relation to each
>> other. However, since the battery object paths would be discovered
>> through the device object there might not be any need for such a
>> backwards reference.
>>
>>>>> The other option i can think of is to have another interface
>>>>> registered on the device object path:
>>>>>
>>>>> Service             org.bluez
>>>>> Interface   org.bluez.Batteries
>>>>> Object path [variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX
>>>>>
>>>>> Methods     dict GetProperties()
>>>>>
>>>>>             Returns all properties for the interface. See the
>>>>>             Properties section for the available properties.
>>>>>
>>>>> Signals             ProperyChanged(string name, variant value)
>>>>>
>>>>>             This signal indicates a changed value of the given
>>>>>             property.
>>>>>
>>>>> Properties  array{object} Batteries [readonly]
>>>>>
>>>>>             List of device battery object paths that represents the available
>>>>> batteries on the remote devices.
>>>>>
>>>>>
>>>>> Service             org.bluez
>>>>> Interface   org.bluez.Battery
>>>>> Object path [variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX/BATT-NN-DDDD
>>>>>
>>>>>
>>>>> Methods     dict GetProperties()
>>>>>
>>>>>             Returns all properties for the interface. See the
>>>>>             Properties section for the available properties.
>>>>>
>>>>> Signals             PropertyChanged(string name, variant value)
>>>>>
>>>>>             This signal indicates a changed value of the given
>>>>>             property.
>>>>>
>>>>> Properties  byte Level [readonly]
>>>>>
>>>>>                     Battery level (0-100).
>>>>>
>>>>> Any other suggestion ?
>>>>
>>>> That would work, although both of these interfaces are rather
>>>> light-weight in that they only contain a single property which begs the
>>>> question whether this is a bit over-kill.
>>> I know. I believe so as well, but if you want to separate the
>>> interfaces, it is a must.
>>>
>>>>
>>>> Another option is to do away with the per-battery object somehow and
>>>> expose all batteries through a single interface. I'm not so sure that's
>>>> a good idea though since it could prevent future extensibility of the
>>>> API and doesn't reuse the common tools we have for object-like
>>>> abstractions (which a battery certainly is).
>>> If we do what you suggest, a battery name (namespace+descriptor)
>>> will be the property name, and the value should be the battery
>>> level. i'm not too comfortable with it, and it is different than
>>> what we used to do up until now.
>>>
>>> So where do we go from here ?
>>
>> Some extra opinions/view points could help. Maybe Marcel or Luiz have
>> some preferences/ideas on how to do this.
>
> Im trying to think how having multiple objects could be useful for the
> UI, most likely it only gonna show a single meter aggregating all the
> batteries.
>
So what do you suggest here ? Calculating an average ? How shoudl it be 
done ? If 2 batteries are available, first is 100% and the second is 
50%, we should simply set the value as 75%? I'm not so sure that we 
should make such decisions for the end user.

> Another thing that worth adding is that there are other profiles that
> do support battery status such as HFP and AVRCP, so I think this
> should be made generic enough so other sources could be supported.
>
The internal device API uses the device_add_battery(...) and 
device_remove_battery(...) to allow adding/removing batteries to the 
device battery list, but it is the responsibility of the profile to 
register a D-Bus interface, and update.

I could redesign this, to add a generic battery API, which will expose a 
new API, such as battery_add(battery_struct* batt), 
battery_remove(battery_struct* batt) and battery_update(battery_struct* 
batt) which will allow a more generic approach. This Battery module will 
be responsible for registering/unregistering the D-Bus API, and profiles 
which need to use it will simply use the exposed API to 
add/remove/update. The batt_structure will also include some callback 
functions to be called when a value is queried for example, or if a 
device is removed. The LE Battery plugin will use the GATT to 
read/write/receive notification, and use the Generic Battery interface 
to interface with the external world. What do you think about it ?


BR,
Chen Ganir


Return-Path: <cyrus@holtmann.org>
Message-ID: <502CE43C.7040804@ti.com>
Date: Thu, 16 Aug 2012 15:14:52 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v4 01/10] Battery: Add Battery Service Gatt Client
References: <1345109702-5698-1-git-send-email-chen.ganir@ti.com> <1345109702-5698-2-git-send-email-chen.ganir@ti.com> <20120816113941.GA20887@x220>
In-Reply-To: <20120816113941.GA20887@x220>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/16/2012 02:39 PM, Johan Hedberg wrote:
> Hi Chen,
>
> On Thu, Aug 16, 2012, chen.ganir@ti.com wrote:
>> --- a/doc/device-api.txt
>> +++ b/doc/device-api.txt
>> @@ -179,3 +179,8 @@ Properties	string Address [readonly]
>>   			Note that this property can exhibit false-positives
>>   			in the case of Bluetooth 2.1 (or newer) devices that
>>   			have disabled Extended Inquiry Response support.
>> +
>> +		array{string} Batteries [readonly]
>> +
>> +			List of device battery object paths that represents the available
>> +			batteries on the remote device.
>
> I don't think it's ok to pollute the Device interface or src/device.c
> with profile-specific details. That should happen in profile-specific
> plugins and interfaces. Since we're switching over to object manager
> maybe an interface/property like this isn't needed at all? (even if it
> would be needed the type should be array{object} and not array{string}
You are correct, the array should be object instead of string. However, 
i fail to understand why the object manager prevents this from getting 
accepted - do you have a time estimation when the object manager should 
be active or available ? I do not think this patch set should be 
deferred until we have changed the dbus API.

I prefer this way of putting the batteries below the device, since it is 
obvious which battery belongs to each device. The other option i can 
think of is to have another interface registered on the device object path:

Service		org.bluez
Interface	org.bluez.Batteries
Object path	[variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX

Methods	dict GetProperties()

		Returns all properties for the interface. See the
		Properties section for the available properties.

Signals		ProperyChanged(string name, variant value)

		This signal indicates a changed value of the given
		property.

Properties	array{object} Batteries [readonly]

		List of device battery object paths that represents the available 
batteries on the remote devices.


Service		org.bluez
Interface	org.bluez.Battery
Object path	[variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX/BATT-NN-DDDD


Methods	dict GetProperties()

		Returns all properties for the interface. See the
		Properties section for the available properties.

Signals		PropertyChanged(string name, variant value)

		This signal indicates a changed value of the given
		property.

Properties	byte Level [readonly]

			Battery level (0-100).

Any other suggestion ?


>
> Johan
>


-- 
BR,
Chen Ganir
Texas Instruments

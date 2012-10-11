Return-Path: <cyrus@holtmann.org>
Message-ID: <5076D9EF.4030102@linux.intel.com>
Date: Thu, 11 Oct 2012 16:38:39 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 01/10] doc: Add settings storage documentation
References: <1349878219-14359-1-git-send-email-frederic.danis@linux.intel.com>  <1349878219-14359-2-git-send-email-frederic.danis@linux.intel.com> <1349890310.27233.140.camel@aeonflux>
In-Reply-To: <1349890310.27233.140.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 10/10/2012 19:31, Marcel Holtmann wrote:
> Hi Fred,
>
>>   doc/settings-storage.txt |  102 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 102 insertions(+)
>>   create mode 100644 doc/settings-storage.txt
>>
>> diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
>> new file mode 100644
>> index 0000000..51d2220
>> --- /dev/null
>> +++ b/doc/settings-storage.txt
>> @@ -0,0 +1,102 @@
>> +Information related to local adapters and remote devices are stored in storage
>> +directory (default: /var/lib/bluetooth).
>> +Files are in ini-file format.
>> +
>> +There is one directory per adapter, named by its bluetooth address, which
>> +contains:
>> + - a settings file for the local adapter
>> + - an attribute_db file containing attributes of supported LE services
>> + - names file containing names of all devices already seen
>> + - one directory per remote device, named by remote device address, which
>> +   contains:
>> +    - a settings file
>> +    - a key file accessible only by root
>> +    - an attribute_db file containing attributes of remote LE services
>> +
>> +So the directory structure should be:
>> +    /var/lib/bluetooth/<adapter address>/
>> +        ./settings
>> +        ./attribute_db
>
> not sure this is a good name.

Are you OK with "attributes" name for this file?

>> +        ./names
>
> Lets call this one "cache". Since we could throw it away and it will be
> just rediscovered. And we can also stuff other cacheable details in
> there.

OK, I will replace it with cache directory, containing one file per 
remote device.

>> +        ./<remote device address>/
>> +            ./settings
>
> Besides the Alias, are they really settings. You can not configure much
> anyway.

Rename it "info"?

>> +            ./keys
>
> Not sure that I want the keys separated. That seems like a waste.

OK, I will merge it with previous file "info".

>> +            ./attribute_db
>> +        ./<remote device address>/
>> +            ./settings
>> +            ./keys
>> +            ./attribute_db
>> +        ...
>
> Why did we want directories for remote devices again? Can we not just
> put all in one big file with the name of the remote address?

Attribute_db (or whatever name we chose) stores the list of attributes 
advertised by the remote device.
In this file I use the handle value as group name (primary key) as we 
can get multiple entry with same UUID.

I think this should remain separated from "info" file, in order to parse 
it more easily (just need to parse all groups in it to retrieve complete 
attribute list).
That's why I think we should use one directory per remote device.

>> +
>> +Adapter directory files
>> +=======================
>> +
>> +Settings file contains 1 [General] group with adapter info:
>> +  [General]
>> +  Name=
>> +  Class=0x000000
>> +  Pairable=<true|false>
>> +  PairableTimeout=0
>> +  DiscoverableTimeout=0
>> +  Mode=<off|connectable|discoverable>
>> +  OnMode=<connectable|discoverable>
>
> Actually with management interface now being used, we can be a bit
> smarter here. The mode can be programmed even if the controller is not
> powered.
>
> So this might be better as Discoverable, Connectable, Pairable and
> Powered boolean options.

OK, I will replace Mode and OnMode keys by Discoverable, Connectable, 
Pairable and Powered keys.

> Also Pairable has no timeout in the kernel API anymore. Do we still need
> this?
>
>> +The attribute_db file is a list of handles (group name) with UUID and Value as
>> +keys, for example:
>> +  [0x0001]
>> +  UUID=00002800-0000-1000-8000-00805f9b34fb
>> +  Value=0018
>> +
>> +  [0x0004]
>> +  UUID=00002803-0000-1000-8000-00805f9b34fb
>> +  Value=020600002A
>> +
>> +  [0x0006]
>> +  UUID=00002a00-0000-1000-8000-00805f9b34fb
>> +  Value=4578616D706C6520446576696365
>
> Is this our primary key, the handle?
>
>> +
>> +Names file contains 1 [Names] group with device address as key:
>> +  [Names]
>> +  <nn:nn:nn:nn:nn:nn>=device name a
>> +  <mm:mm:mm:mm:mm:mm>=device name b
>
> I am not sure this is the best idea this way. Maybe just creating files
> for each address we ever see is a better idea. Details like LastSeen
> could be useful for unpaired devices.

OK
Regarding LastSeen key, is it interesting to keep it in device "info" 
file too?

So, we will open the corresponding cache/<device addr> file each time we 
need to resolve remote device name, right?

>
>> +
>> +Device directory files
>> +======================
>> +
>> +Remote device settings file will include a [General] group with device infos
>> +and a [DeviceID] group with related infos:
>> +  [General]
>> +  Alias=
>> +  Class=0x000000
>> +  Manufacturer=0
>> +  LmpVersion=
>> +  LmpSubversion=
>
> Take these 3 our. We were just storing them for statistic purposes.

Should I remove them?

>> +  Features=0000000000000000
>> +  AddressType=<BR/EDR|LE>
>> +  LEAddressType=<public|random>
>
> That is not needed. It is encoded in the address itself.
>
>> +  LastSeen=yyyy-mm-dd hh:mm:ss GMT
>> +  LastUsed=yyyy-mm-dd hh:mm:ss GMT
>> +  Trusted=<true|false>
>> +  Profiles=<128 bits UUID of profile 1>;<128 bits UUID of profile 2>;...
>> +
>> +  [DeviceID]
>> +  Assigner=0
>
> This is called Source.

OK, I will change this.

>> +  Vendor=0
>> +  Product=0
>> +  Version=0
>> +
>> +Keys file includes informations related to link key or long term link key:
>> +  [LinkKey]
>> +  Key=
>> +  Type=0
>> +  PINLength=0
>> +
>> +  [LongTermKey]
>> +  Key=
>> +  Authenticated=<true|false>
>> +  EncSize=0
>> +  EDiv=0
>> +  Rand=0
>
> Can be both in the same file about the device information.

OK, I will merge them.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

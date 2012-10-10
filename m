Return-Path: <cyrus@holtmann.org>
Message-ID: <1349890310.27233.140.camel@aeonflux>
Subject: Re: [PATCH v3 01/10] doc: Add settings storage documentation
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 19:31:50 +0200
In-Reply-To: <1349878219-14359-2-git-send-email-frederic.danis@linux.intel.com>
References: <1349878219-14359-1-git-send-email-frederic.danis@linux.intel.com>
	 <1349878219-14359-2-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>  doc/settings-storage.txt |  102 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 doc/settings-storage.txt
> 
> diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
> new file mode 100644
> index 0000000..51d2220
> --- /dev/null
> +++ b/doc/settings-storage.txt
> @@ -0,0 +1,102 @@
> +Information related to local adapters and remote devices are stored in storage
> +directory (default: /var/lib/bluetooth).
> +Files are in ini-file format.
> +
> +There is one directory per adapter, named by its bluetooth address, which
> +contains:
> + - a settings file for the local adapter
> + - an attribute_db file containing attributes of supported LE services
> + - names file containing names of all devices already seen
> + - one directory per remote device, named by remote device address, which
> +   contains:
> +    - a settings file
> +    - a key file accessible only by root
> +    - an attribute_db file containing attributes of remote LE services
> +
> +So the directory structure should be:
> +    /var/lib/bluetooth/<adapter address>/
> +        ./settings
> +        ./attribute_db

not sure this is a good name.

> +        ./names

Lets call this one "cache". Since we could throw it away and it will be
just rediscovered. And we can also stuff other cacheable details in
there.

> +        ./<remote device address>/
> +            ./settings

Besides the Alias, are they really settings. You can not configure much
anyway.

> +            ./keys

Not sure that I want the keys separated. That seems like a waste.

> +            ./attribute_db
> +        ./<remote device address>/
> +            ./settings
> +            ./keys
> +            ./attribute_db
> +        ...

Why did we want directories for remote devices again? Can we not just
put all in one big file with the name of the remote address?

> +
> +Adapter directory files
> +=======================
> +
> +Settings file contains 1 [General] group with adapter info:
> +  [General]
> +  Name=
> +  Class=0x000000
> +  Pairable=<true|false>
> +  PairableTimeout=0
> +  DiscoverableTimeout=0
> +  Mode=<off|connectable|discoverable>
> +  OnMode=<connectable|discoverable>

Actually with management interface now being used, we can be a bit
smarter here. The mode can be programmed even if the controller is not
powered.

So this might be better as Discoverable, Connectable, Pairable and
Powered boolean options.

Also Pairable has no timeout in the kernel API anymore. Do we still need
this?

> +The attribute_db file is a list of handles (group name) with UUID and Value as
> +keys, for example:
> +  [0x0001]
> +  UUID=00002800-0000-1000-8000-00805f9b34fb
> +  Value=0018
> +
> +  [0x0004]
> +  UUID=00002803-0000-1000-8000-00805f9b34fb
> +  Value=020600002A
> +
> +  [0x0006]
> +  UUID=00002a00-0000-1000-8000-00805f9b34fb
> +  Value=4578616D706C6520446576696365

Is this our primary key, the handle?

> +
> +Names file contains 1 [Names] group with device address as key:
> +  [Names]
> +  <nn:nn:nn:nn:nn:nn>=device name a
> +  <mm:mm:mm:mm:mm:mm>=device name b

I am not sure this is the best idea this way. Maybe just creating files
for each address we ever see is a better idea. Details like LastSeen
could be useful for unpaired devices.

> +
> +Device directory files
> +======================
> +
> +Remote device settings file will include a [General] group with device infos
> +and a [DeviceID] group with related infos:
> +  [General]
> +  Alias=
> +  Class=0x000000
> +  Manufacturer=0
> +  LmpVersion=
> +  LmpSubversion=

Take these 3 our. We were just storing them for statistic purposes.

> +  Features=0000000000000000
> +  AddressType=<BR/EDR|LE>
> +  LEAddressType=<public|random>

That is not needed. It is encoded in the address itself.

> +  LastSeen=yyyy-mm-dd hh:mm:ss GMT
> +  LastUsed=yyyy-mm-dd hh:mm:ss GMT
> +  Trusted=<true|false>
> +  Profiles=<128 bits UUID of profile 1>;<128 bits UUID of profile 2>;...
> +
> +  [DeviceID]
> +  Assigner=0

This is called Source.

> +  Vendor=0
> +  Product=0
> +  Version=0
> +
> +Keys file includes informations related to link key or long term link key:
> +  [LinkKey]
> +  Key=
> +  Type=0
> +  PINLength=0
> +
> +  [LongTermKey]
> +  Key=
> +  Authenticated=<true|false>
> +  EncSize=0
> +  EDiv=0
> +  Rand=0

Can be both in the same file about the device information.

> +
> +The attribute_db file is a list of handles (group name) with UUID and Value as
> +keys (cf. attribute_db in adapter directory).

Regards

Marcel



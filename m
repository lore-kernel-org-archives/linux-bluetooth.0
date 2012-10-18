Return-Path: <cyrus@holtmann.org>
Message-ID: <1350602001.2026.35.camel@aeonflux>
Subject: Re: [PATCH v6 01/16] doc: Add settings storage documentation
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 18 Oct 2012 16:13:21 -0700
In-Reply-To: <1350565311-18330-2-git-send-email-frederic.danis@linux.intel.com>
References: <1350565311-18330-1-git-send-email-frederic.danis@linux.intel.com>
	 <1350565311-18330-2-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> ---
>  doc/settings-storage.txt |   99 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 doc/settings-storage.txt
> 
> diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
> new file mode 100644
> index 0000000..73d4766
> --- /dev/null
> +++ b/doc/settings-storage.txt
> @@ -0,0 +1,99 @@
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

please fix the name of the attribute_db file.

And I would prefer if we are a bit more verbose. I would prefer if this
reads like a nice instruction manual in plain English on what we are
storing and how.

Adding different sections like introduction, details etc. is fine as
well. The easier it becomes to read, the easier it becomes to understand
by people not familiar what is going on. Look at some of the oFono
documents for examples.

> +So the directory structure should be:
> +    /var/lib/bluetooth/<adapter address>/
> +        ./settings
> +        ./attributes
> +        ./cache/
> +            ./<remote device address>
> +            ./<remote device address>
> +            ...
> +        ./<remote device address>/
> +            ./info
> +            ./attributes
> +        ./<remote device address>/
> +            ./info
> +            ./attributes
> +        ...

I am still debating if we not better keep a single directory structure
instead of a nested one. I have not made up my mind and going forth and
back on this.

/var/lib/bluetooth/<adapter>/<device>-info
/var/lib/bluetooth/<adapter>/<device>-attributes
/var/lib/bluetooth/<adapter>/cache-<device>-info

And for the profile specific ones, we could then have a function that
returns specific files based on the profile names.

/var/lib/bluetooth/<adapter>/<device>-audio

> +
> +Adapter directory files
> +=======================
> +
> +Settings file contains 1 [General] group with adapter info:
> +  [General]
> +  Name=
> +  Class=0x000000

Lets store this as MajorClass and MinorClass. Since that is how we are
programming it into the kernel.

And for simplicity, I would prefer that this document also has a section
listing the possible values. At least for the common used classes like
Computer, Phone etc.

We could also consider that we allow actually simple names like "phone",
"computer" etc. Just to make this simpler. Not sure if this is a really
great idea, but we could discuss this.

> +  Discoverable=<true|false>
> +  Connectable=<true|false>
> +  Pairable=<true|false>
> +  Powered=<true|false>
> +  PairableTimeout=0
> +  DiscoverableTimeout=0
> +
> +The attributes file is a list of handles (group name) with UUID and Value as
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

You need to mention that values are hex encoded strings. Just to be
clear here.

I am not 100% convinced that we want to keep the sections/handles in hex
value notation. Is that really a good idea?

> +Cache directory files
> +======================
> +
> +Each files, named by remote device address, contains 1 [General] group:
> +  [General]
> +  Name=device name a

Is this the only thing we are storing in these files? Or are we planning
to store additional information at some point.

> +Device directory files
> +======================
> +
> +Remote device info file will include a [General] group with device info,
> +[DeviceID], [LinkKey] and [LongTermKey] groups with related info:
> +  [General]
> +  Alias=

Are we just doing the Alias here? We are not keeping the Name? In theory
we have a short name and full name actually. If we ever only got the
short name, we need to know that. Then we have to request the long name
next time.

> +  Class=0x000000
> +  SupportedTechnologies=<BR/EDR|LE>;<BR/EDR|LE>

We could just store the Host features bits here. That would make it a
bit simpler to remember all the magic features.

> +  AddressType=<static|public>
> +  Trusted=<true|false>
> +  Profiles=<128 bits UUID of profile 1>;<128 bits UUID of profile 2>;...
> +
> +  [DeviceID]
> +  Source=0
> +  Vendor=0
> +  Product=0
> +  Version=0
> +
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
> +
> +The attribute_db file is a list of handles (group name) with UUID and Value as
> +keys (cf. attribute_db in adapter directory).

Regards

Marcel



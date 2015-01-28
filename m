Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [RFC BlueZ 1/1] doc: Add Advertising API documentation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422471136-18575-2-git-send-email-jamuraa@chromium.org>
Date: Wed, 28 Jan 2015 13:10:30 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <81C91E2D-16C2-429D-90CC-E4B1BE1E3FC5@holtmann.org>
References: <1422471136-18575-1-git-send-email-jamuraa@chromium.org> <1422471136-18575-2-git-send-email-jamuraa@chromium.org>
To: Michael Janssen <jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> doc/advertising-api.txt | 124 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 124 insertions(+)
> create mode 100644 doc/advertising-api.txt
> 
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> new file mode 100644
> index 0000000..6a325c7
> --- /dev/null
> +++ b/doc/advertising-api.txt
> @@ -0,0 +1,124 @@
> +LE Advertising Manager
> +======================
> +
> +LE Advertising Manager allows external applications to control the activity and
> +the content of LE Advertising Events.  Applications may use the properties of
> +this object to modify the advertising data elements included in Advertising
> +Events, and enable and disable advertising.
> +

I was looking into this the other day. And what we really want is multiple advertising instances. So that if you have hardware support, the kernel can map it to a hardware feature, if you don't, then the kernel will emulate it with rotating the advertising information.

>From a low-level LE link layer that is all valid since you can have multiple LL state machines active at the same time. It is just currently there is not HCI to actually handle this.

Where I am sitting right now, this should be done with the API that provides the support for GATT service application.

What this means is that when you want to use the D-Bus GATT API to write a GATT service in an application, then this service should be able to say, I want to advertise with these settings. And then bluetoothd and the kernel will manage this for the lifetime of this GATT service application.

>From the kernel side this means we just allow multiple combinations of advertising type, interval, address, advertising data, scan response data and something new I can not talk about in public yet.

I want to include advertising type here since you might want to use ADV_NONCONN_IND with a non-resolvable random address for some broadcast details every 10 minutes, but that should interfere with the details you might want to broadcast for your weight scale application that is looking for a master to reconnect.

While the kernel always has the default advertising data and scan response data as it does right now (which I would call application/service 0), we want to allow for multiple application/services in addition to that. And I do have a basic idea on how to do this from a mgmt API point of view. However there is some new Bluetooth SIG work ongoing that I might want to be prepared for before posting this.

On side note, we could go as far as allowing an application for peripheral type of task to provide a static random address and we ensure that the controller advertise with that address when in use. This is a bit advanced and crazy stuff, but it is in theory possible.

> +Service		org.bluez
> +Interface	org.bluez.LEAdvertisingManager1
> +Object path	/org/bluez/hciX
> +
> +Methods		bool Advertise(int duration)
> +
> +			Begins advertising this device according to the
> +			settings.  Advertisement is enabled for duration seconds
> +			from method invocation.  A duration of -1 will
> +			continuously advertise.  To disable advertisement early,
> +			set duration to 0.
> +
> +			Possible errors: org.bluez.Error.NoData
> +
> +		void AdvertiseServiceUUID(string)
> +
> +			This method adds a UUID to the set of services which
> +			should be included in the advertisement.  Use
> +			UnadvertiseServiceUUID to remove items from the list.
> +			GAP and GATT services cannot be added to the list.
> +
> +			Possible errors: org.bluez.Error.AlreadyExists
> +					 org.bluez.Error.InvalidArgument
> +
> +		void UnadvertiseServiceUUID(string)
> +			This method removes a UUID from the set of services
> +			which are included in the advertisement.
> +
> +			Possible errors: org.bluez.Error.DoesNotExist
> +
> +Properties	array{string} IncludedTypes
> +
> +			Indicates the data types which are included in the
> +			advertising data, and their order in the packet.  If the
> +			advertising data is too long, types that do not fit will
> +			be ignored, and the next type will be included if it
> +			does fit.  An exception to this is the "service-uuids"
> +			and the "local-name" type which will be shortened to fit
> +			as allowed by the specification.
> +
> +			The strings used for each type defined in the Core
> +			Specification Supplement and are indicated by these
> +			strings:
> +			* "service-uuids" - A list of Service UUIDs
> +			* "local-name" - Device name as defined by GAP
> +			* "flags" - the Advertising data flags
> +			* "manufacturer-data" - Manufacturer specific data
> +			* "tx-power" - TX Power Level
> +			* "slave-connection-interval" - Slave connection
> +				interval range for logical connections
> +			* "solicit-uuids" - Service Solicitation UUIDs
> +			* "service-data" - Service Data
> +			* "appearance" - Appearance as defined by GAP
> +			* "public-target-address" - Public Target Address
> +			* "random-target-address" - Random Target Address
> +			* "advertising-interval" - Advertising Interval
> +			* "le-address" - LE Device Address
> +			* "le-role" - LE Role
> +
> +			Defaults to: ["flags", "local-name"]
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +
> +		array(string) AdvertisedUUIDs (read-only)
> +
> +			Sorted List of UUIDs which are currently included in the
> +			"service-uuids" advertisement data type.
> +
> +		int Flags
> +
> +			bitfield of Boolean flags as defined in the Core
> +			Specification Supplement, Part A.1.3.2

There are actually pretty much controlled by the core settings of being discoverable or limited discoverable. So nothing really an application should control. Also the LE not supported one is something that always needs to be set and they are mandatory.

> +
> +		array(array{byte}) ManufacturerSpecificData
> +
> +			Manufacturer specific data.  Each entry is transmitted
> +			as a a separate advertisement data type.

You need to define the manufacturer ID here as well.

> +
> +		array(string) SolicitUUIDs
> +
> +			List of UUIDs to include in the
> +			"service-solicitation" advertisement data.
> +
> +		dict(string,array{byte}) ServiceData
> +
> +			Dictionary of Service UUIDs attached to data associated
> +			with that service to include in the "service-data"
> +			advertisement data.

If I remember this correctly, then this allows multiple instances for the same UUID.

> +
> +		array{byte} TargetAddress
> +
> +			Target Address to use in the "random-target-address" or
> +			"public-target-address"

The reason why the AD types have two here is that you need to worry about the actual address type in LE. And honestly I would not worry about this at all since it is not used in anywhere at the moment.

> +
> +		int AdvertisingInterval
> +
> +			The interval to advertise at, in 0.625ms units.  Minimum
> +			is 32 (20ms), maximum is 16384 (10.24s)
> +
> +			Possible Errors: org.bluez.Error.InvalidArgument

This is something that should be fundamentally taken from the basic input. If we are running multiple instances of advertising, then providing the min and max values are important. However this one has a big problem. The HCI side takes an interval so that they controller can move it. The AD expects to give you the exact one. This is not something that can be used successful.

And actually this has a technical change coming that I can not talk about in public.

However what we do want to provide is the slave connection interval (in case we want to allow connections with this instance), but right now we are not even utilizing this from the central side. Which is something we should be doing. However it means that we need to scan before calling LE connect. Hint hint hint ;)

> +
> +		array{byte} LEAddress
> +
> +			Address to advertise as the LE Address for this device.

This is for LE out-of-band pairing and has nothing to do with advertising.

> +
> +		string LEPreferred
> +
> +			The preferred role of this device if it supports both
> +			Central and Peripheral roles.  One of "central" or
> +			"peripheral".  This influences the advertised value of
> +			the "le-role" advertising data type when both modes are
> +			supported.

Same here. This is for LE out-of-band pairing.

> +
> +		int AdvertisingLength (read-only)
> +
> +			Calculated length of the Advertising Data packet.

Seems rather useless information. Also does not really factor in the case that some data might be in the scan response packet.

Regards

Marcel


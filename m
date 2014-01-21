Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH BlueZ v2 01/18] doc: Add GATT API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390310814-19880-2-git-send-email-claudio.takahasi@openbossa.org>
Date: Tue, 21 Jan 2014 08:50:56 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <B5AE7C1F-664D-4859-9793-E853DFF02FC5@holtmann.org>
References: <1390310814-19880-1-git-send-email-claudio.takahasi@openbossa.org> <1390310814-19880-2-git-send-email-claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> This patch proposes an unified GATT API for local and remote services.
> ---
> doc/gatt-api.txt | 145 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 145 insertions(+)
> create mode 100644 doc/gatt-api.txt
> 
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> new file mode 100644
> index 0000000..df60fb8
> --- /dev/null
> +++ b/doc/gatt-api.txt
> @@ -0,0 +1,145 @@
> +BlueZ D-Bus GATT API description
> +********************************
> +
> +GATT local and remote services share the same high-level D-Bus API. Local
> +refers to GATT based service exported by a BlueZ plugin or an external
> +application. Remote refers to GATT services exported by the peer.
> +
> +BlueZ acts as a proxy, translating ATT operations to D-Bus method calls and
> +Properties (or the opposite). Support for D-Bus Object Manager is mandatory for
> +external services to allow seamless GATT declarations (Service, Characteristic
> +and Descriptors) discovery.
> +
> +Service hierarchy
> +=================
> +
> +GATT remote and local service representation. Object path for local services
> +is freely definable.
> +
> +External applications implementing local services must register the services
> +using GattServiceManager1 registration method and must implement the methods
> +and properties defined in GattService1 interface.
> +
> +Service		org.bluez
> +Interface	org.bluez.GattService1 [Experimental]
> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX
> +
> +Methods		void Release()
> +
> +			Release this service. At this point, it will not be
> +			used by BlueZ anymore and can be destroyed by the
> +			owner. Method applicable to external GATT services
> +			implementations only (GATT servers).
> +
> +Properties	string UUID [read-only]
> +
> +			128-bit service UUID.
> +
> +		array{object} Includes [read-only]: Not implemented
> +
> +			Array of object paths representing the included
> +			services of this service.
> +
> +
> +Characteristic hierarchy
> +========================
> +
> +For local GATT defined services, the object paths need to follow the service
> +path hierarchy and are freely definable.
> +
> +Service		org.bluez
> +Interface	org.bluez.Characteristic1 [Experimental]
> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY

this is an all or nothing deal. So better GattCharacteristic1.

> +
> +Properties	string UUID [read-only]
> +
> +			128-bit characteristic UUID.
> +
> +		object Service [read-only]
> +
> +			Object path of the GATT service the characteristc
> +			belongs to.
> +
> +		array{byte} Value [read-write]
> +
> +			Value read from the remote Bluetooth device or from
> +			the external application implementing GATT services.
> +
> +		array{string} Flags [read-only, optional]
> +
> +			Defines how the characteristic value can be used. See
> +			Core spec page 1898, "Table 3.5: Characteristic
> +			Properties bit field" and page 1900, "Table 3.8:
> +			Characteristic Extended Properties bit field". Allowed
> +			values: "broadcast", "read", "write-without-response",
> +			"write", "notify", "indicate",
> +			"authenticated-signed-writes", "reliable-write", and
> +			"writable-auxiliaries".
> +
> +
> +Characteristic Descriptors hierarchy
> +====================================
> +
> +Local or remote GATT characteristic descriptors hierarchy.
> +
> +Service		org.bluez
> +Interface	org.bluez.Descriptor1 [Experimental]
> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY/descriptorZZZ

Same here. GattDescriptor1.

> +
> +Properties	string UUID [read-only]
> +
> +			128-bit descriptor UUID.
> +
> +		object Characteristic [read-only]
> +
> +			Object path of the GATT characteristc the descriptor
> +			belongs to.
> +
> +		array{byte} Value [read-write]
> +
> +			Raw characteristic descriptor value read from the
> +			remote Bluetooth device or from the external
> +			application implementing GATT services.
> +
> +		string Permissions [read-only]: To be defined
> +
> +			Defines read/write authentication and authorization
> +			requirements.
> +
> +Service Manager hierarchy
> +=============================
> +
> +Service Manager allows external applications to register GATT based
> +services. Services must follow the API for Service and Characteristic
> +described above.
> +
> +Local GATT services, characteristics and characteristic descriptors are
> +discovered automatically using the D-Bus Object Manager interface.
> +
> +Service		org.bluez
> +Interface	org.bluez.GattServiceManager1 [Experimental]
> +Object path	/org/bluez

Here we could discuss to use GattManager1 to make it shorter, but I am not sure if that actually helps. I currently tend to leave it as GattServiceManager1.

> +
> +Methods		RegisterService(object service, dict options)
> +
> +			Registers remote application service exported under
> +			interface GattService1. Characteristic objects must
> +			be hierarchical to their service and must use the
> +			interface Characteristic1. D-Bus Object Manager is
> +			used to fetch the exported objects.
> +
> +			"service" object path together with the D-Bus system
> +			bus connection ID define the identification of the
> +			application registering a GATT based service.
> +
> +			Possible errors: org.bluez.Error.InvalidArguments
> +					 org.bluez.Error.AlreadyExists
> +
> +		UnregisterService(object service)
> +
> +			This unregisters the service that has been
> +			previously registered. The object path parameter
> +			must match the same value that has been used
> +			on registration.
> +
> +			Possible errors: org.bluez.Error.DoesNotExist

Regards

Marcel


Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH BlueZ v4 01/18] doc: Add GATT API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390845656-29880-2-git-send-email-claudio.takahasi@openbossa.org>
Date: Mon, 27 Jan 2014 19:15:15 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <FC28B407-F3B2-4969-A5FD-35AB73316DF5@holtmann.org>
References: <1390398025-28340-1-git-send-email-claudio.takahasi@openbossa.org> <1390845656-29880-1-git-send-email-claudio.takahasi@openbossa.org> <1390845656-29880-2-git-send-email-claudio.takahasi@openbossa.org>
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
> index 0000000..2d92f03
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
> +using GattManager1 registration method and must implement the methods and
> +properties defined in GattService1 interface.
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

so this is the part I do not like that much. We should not define an interface that has a method that is valid and used only when this is a GATT server.

What I am thinking right now (and might need to discuss this a bit further), we leave GattService1 without any methods and use it for both GATT client and server.

Then we create some GattServiceAgent1 or GattServiceCollection1 or maybe even GattServer1 that we can register with GattManager1 for the purpose of providing a Release method so that bluetoothd stays in control and can inform applications if it decided to remove a service.

I am even fine with allowing to provide multiple services in a collection/server registration. Thoughts?

Regards

Marcel


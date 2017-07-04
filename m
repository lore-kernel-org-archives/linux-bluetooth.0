Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 01/10] doc/gatt-api: Add AcquireWrite and AcquireNotify
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170704150937.11701-2-luiz.dentz@gmail.com>
Date: Tue, 4 Jul 2017 18:01:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A08BE030-0BF7-4069-BA4A-49F4AF13A2B8@holtmann.org>
References: <20170704150937.11701-1-luiz.dentz@gmail.com>
 <20170704150937.11701-2-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This enables write and notify exclusive access via file descriptors in
> case the characteristic is actually trying to emulate a byte stream
> transfer or have a protocol on top of GATT.
> ---
> doc/gatt-api.txt | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 62 insertions(+)
> 
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index 6c98b87..3f4a3ca 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -91,6 +91,56 @@ Methods		array{byte} ReadValue(dict options)
> 					 org.bluez.Error.NotAuthorized
> 					 org.bluez.Error.NotSupported
> 
> +		fd, uint16 AcquireWrite() [experimental] (Client only)
> +
> +			Acquire write file descriptor and MTU and lock
> +			write access to the characteristic.

Aquire file descriptor and MTU for writing. Usage of WriteValue will be locked ..

Also you need to add an appropriate error code to WriteValue.

> +
> +			Only works with characteristic that has
> +			WriteAcquired property which relies on
> +			write-without-response Flag.
> +
> +			To release the lock the client shall close the file
> +			descriptor, a HUP is generated in case the device
> +			is disconnected.
> +
> +			Note: the MTU can only be negotiated once and is
> +			symmetric therefore this method may be delayed in
> +			order to have the exchange MTU completed, because of
> +			that the file descriptor is closed during
> +			reconnections as the MTU has to be renegotiated.
> +
> +			Possible Errors: org.bluez.Error.Failed
> +					 org.bluez.Error.NotSupported
> +
> +		fd, uint16 AcquireNotify() [experimental] (Client only)
> +
> +			Acquire notify file descriptor and MTU and lock
> +			notifications to the characteristic.

Same as above.

> +
> +			Only works with characteristic that has NotifyAcquired
> +			which relies on notify Flag and no other client have
> +			called StartNotify.
> +
> +			Notification are enabled during this procedure so
> +			StartNotify shall not be called, any notification
> +			will be dispatched via file descriptor therefore the
> +			Value property is no affected during the time where
> +			notify has been acquired.
> +
> +			To release the lock the client shall close the file
> +			descriptor, a HUP is generated in case the device
> +			is disconnected.
> +
> +			Note: the MTU can only be negotiated once and is
> +			symmetric therefore this method may be delayed in
> +			order to have the exchange MTU completed, because of
> +			that the file descriptor is closed during
> +			reconnections as the MTU has to be renegotiated.
> +
> +			Possible Errors: org.bluez.Error.Failed
> +					 org.bluez.Error.NotSupported
> +
> 		void StartNotify()
> 
> 			Starts a notification session from this characteristic
> @@ -125,6 +175,18 @@ Properties	string UUID [read-only]
> 			when a notification or indication is received, upon
> 			which a PropertiesChanged signal will be emitted.
> 
> +		boolean WriteAcquired [read-only, optional]
> +
> +			True, if this characteristic has been acquire by any

has been acquired ..

> +			client using AcquireWrite. This properties is ommited
> +			in case write-without-response flag is not set.
> +
> +		boolean NotifyAcquired [read-only, optional]
> +
> +			True, if this characteristic has been acquire by any

See above.

> +			client using AcquireNotify. This properties is ommited
> +			in case notify flag is not set.
> +
> 		boolean Notifying [read-only, optional]
> 
> 			True, if notifications or indications on this

Otherwise, looks good. Lets get this patch set merged.

Regards

Marcel


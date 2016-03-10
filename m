Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ] doc/device-api: Replace GattServices with Discovering property
In-Reply-To: <1457626604-5656-1-git-send-email-luiz.dentz@gmail.com>
References: <1457626604-5656-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 10 Mar 2016 15:04:52 -0300
Message-ID: <878u1qi4zf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> GattServices is not really doing was it was meant to do which was to
> track progress of service discovery since it only worked for the very
> first time a device is connected but since we no longer remove the
> attributes an application would have the false impression the service are
> all resolved by the time it reconnects when in fact the service may have
> changed.
>
> Futhermore object tracking like it is doing has been obsolete by
> ObjectManager so this propose to replace the service discovery tracking
> with a boolean property which works both with SDP as well as GATT
> discovery.
> ---
>  doc/device-api.txt |  9 +++------
>  src/device.c       | 58 +++++++++++-------------------------------------------
>  2 files changed, 14 insertions(+), 53 deletions(-)
>
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index a8076a2..9e58664 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -212,10 +212,7 @@ Properties	string Address [readonly]
>  			Service advertisement data. Keys are the UUIDs in
>  			string format followed by its byte array value.
>
> -		array{object} GattServices [readonly, optional]
> +		bool Discovering [readonly, optional, experimental]
>
> -			List of GATT service object paths. Each referenced
> -			object exports the org.bluez.GattService1 interface and
> -			represents a remote GATT service. This property will be
> -			updated once all remote GATT services of this device
> -			have been discovered and exported over D-Bus.
> +			Indicate whether or not service discovery is in
> +			progress.

I wonder how useful it's going to be.

What I expect from a client is that it made a GetManagedObjects() call
when it entered the bus and added listeners to the InterfacesAdded(),
InterfacesRemoved() and PropertiesChanged() signals, I am not seeing
what kind of value this property is adding to that kind of client.

But yeah, it is better than GattServices.


Cheers,
--
Vinicius

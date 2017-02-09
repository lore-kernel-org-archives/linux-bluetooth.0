Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] device: Add device type property
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170209010508.150518-1-mcchou@chromium.org>
Date: Thu, 9 Feb 2017 08:37:41 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        josephsih@chromium.org, ortuno@chromium.org,
        Eric Caruso <ejcaruso@chromium.org>
Message-Id: <3CF37350-C135-465D-9075-C1ED3B0D6F60@holtmann.org>
References: <20170209010508.150518-1-mcchou@chromium.org>
To: mcchou@chromium.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eric,

> This allows us to gather information about whether a device
> supports BR/EDR, BLE, or both. It appears as DBus Property
> "Type" on the org.bluez.Device1 interface.
> 
> This is tested with the following steps:
> Scan for devices and request the type property of a specific remote device,
> using:
>  # dbus-send --print-reply --system --dest=org.bluez <obj path> \
>    org.freedesktop.DBus.Properties.Get \
>      string:org.bluez.Device1 string:Type
> or request the type of all remote devices, using:
>  # dbus-send --print-reply --system --dest=org.bluez / \
>    org.freedesktop.DBus.ObjectManager.GetManagedObjects | \
>      grep -B1 -A2 Type
> and check for "BR/EDR", "LE", and "DUAL"
> ---
> doc/device-api.txt |  5 +++++
> src/device.c       | 31 +++++++++++++++++++++++++++++++
> 2 files changed, 36 insertions(+)
> 
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 13b28818e..2f3100cd5 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -141,6 +141,11 @@ Properties	string Address [readonly]
> 
> 			The Bluetooth class of device of the remote device.
> 
> +		string Type [readonly, optional]
> +
> +			The carriers supported by this remote device. If it
> +			exists, it can be one of "BR/EDR", "LE", or "DUAL".
> +

I don’t like upper-case for values of this type. We have kept them normally all lower-case.

Anyhow, actually you can deduct this information already from existing Class and Appearance values. If Class exists it is BR/EDR and if Appearance exists it is LE. If both exist it is dual-mode device. Only trick part might be that Appearance is optional, but we could just fill it in with some generic value. Would need to look that up.

Regards

Marcel


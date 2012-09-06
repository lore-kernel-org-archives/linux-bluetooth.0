Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346325980-11411-2-git-send-email-chen.ganir@ti.com>
References: <1346325980-11411-1-git-send-email-chen.ganir@ti.com>
	<1346325980-11411-2-git-send-email-chen.ganir@ti.com>
Date: Thu, 6 Sep 2012 16:34:20 -0300
Message-ID: <CAKT1EBdo=yJX+DZmnFJoMydE4D_sD-CzOpYFwdKTXwKmcHQgAw@mail.gmail.com>
Subject: Re: [PATCH RFC] battery: Add generic device battery interface
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen Ganir:

On Thu, Aug 30, 2012 at 8:26 AM,  <chen.ganir@ti.com> wrote:
> From: Chen Ganir <chen.ganir@ti.com>
>
> Add the D-Bus API documentation for the new generic device battery
> interface. This API provides generic access to peer devcice
> batteries.
> ---
>  doc/battery-api.txt |   34 ++++++++++++++++++++++++++++++++++
>  doc/device-api.txt  |    5 +++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 doc/battery-api.txt
>
> diff --git a/doc/battery-api.txt b/doc/battery-api.txt
> new file mode 100644
> index 0000000..da82024
> --- /dev/null
> +++ b/doc/battery-api.txt
> @@ -0,0 +1,34 @@
> +BlueZ D-Bus Battery API description
> +****************************************
> +
> +       Texas Instruments, Inc. <chen.ganir@ti.com>
> +
> +Device Battery hierarchy
> +=====================================
> +
> +Service                org.bluez
> +Interface      org.bluez.Battery
> +Object path    [variable prefix]/{hci0,..}/dev_XX_XX_XX_XX_XX_XX/BATTYYYY
> +YYYY is numeric value between 0 and 9999.
> +
> +Methods        dict GetProperties()
> +
> +                       Returns all properties for the interface. See the
> +                       Properties section for the available properties.
> +
> +Signals                PropertyChanged(string name, variant value)
> +
> +               This signal indicates a changed value of the given
> +               property.
> +
> +Properties     uint16 Level [readonly]
> +
> +                       Battery level (0-100).
> +
> +               uint16 Description [readonly]
> +
> +                       Battery description.
> +
> +               uint16 Namespace [readonly]
> +
> +                       Battery Namespace.

IMO "Description" and "Namespace" should be string:
http://developer.bluetooth.org/gatt/Pages/GattNamespaceDescriptors.aspx

For BLE Presentation Format is mandatory(Namespace and Description).
For AVRCP, probably it doesn't make sense. I recommend to include
additional description for these fields.

> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 1f0dc96..c98d539 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -179,3 +179,8 @@ Properties  string Address [readonly]
>                         Note that this property can exhibit false-positives
>                         in the case of Bluetooth 2.1 (or newer) devices that
>                         have disabled Extended Inquiry Response support.
> +
> +               array{object} Batteries [readonly]
> +
> +                       List of device battery object paths that represents the available
> +                       batteries on the remote device.
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Are you planning to implement the Battery Service on BlueZ? (using UPower)
It seems to be straightforward.

Regards,
Claudio

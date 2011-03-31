Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1301510036-17282-1-git-send-email-andre.dieb@signove.com>
References: <1301510036-17282-1-git-send-email-andre.dieb@signove.com>
Date: Thu, 31 Mar 2011 20:44:22 +0000
Message-ID: <AANLkTinpZ4OsJMVjpMX=VYUfzG=sgTVk9uUUGFW0t=4Q@mail.gmail.com>
Subject: Re: [RFC 1/2] Add Type property to Device
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Andre Dieb Martins <andre.dieb@signove.com>, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>, Johan Hedberg <johan.hedberg@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel/Johan/Luiz,

We need opinions for this change...

Why this information is needed: Appearance characteristic is not
available in the advertising. Currently, BlueZ implements interleaved
discovery: 5.12sec inquiring + 5.12sec scanning.
Found devices are reported through the DeviceFound() signal. The user
space needs to check the "Broadcaster" property inside the DeviceFound
signal to check if the device is Basic Rate or LE, which is not
acceptable(in my opinion). We need a meaningful property to
distinguish LE devices.

Before we push these patches upstream we need to define which
information it exposes: Operational Mode or host/controller
capability?

My opinion:
1. for the Adapter it should represent the operational mode, a
controller can support LE, but the host can disable it. Setting
EnableLE =3D false(main.conf) should "disable" LE functionalities.
2. for DeviceFound(), the UI needs this info only to distinguish LE
devices. In my opinion UUIDs and Broadcaster properties are not
enough/appropriated for this purpose. "Qualified" devices will not
enable inquiry scan and advertising at same time. Our main target is
to connect to LE only devices. "BR/EDR/LE" can be confusing in this
context. Suggestions here?
3. for the Device, I am not sure if we need to expose this information
to the users, appearance characteristic is mandatory, if a Device
"object" exists in the system the appearance value will be
available(it will be retrieved after discovery primary services)

Comments?

Andre:
You need to check the adapter features, old adapters doesn't support EDR.

Claudio.

On Wed, Mar 30, 2011 at 6:33 PM, Andre Dieb Martins
<andre.dieb@signove.com> wrote:
> ---
> =C2=A0doc/device-api.txt | =C2=A0 =C2=A04 ++++
> =C2=A0src/device.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 18 ++++++++++++++++++
> =C2=A0src/device.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 ++
> =C2=A03 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index d1feb18..a667296 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -130,6 +130,10 @@ Properties string Address [readonly]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Proposed icon name according to the freedesktop.org
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0icon naming specification.
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 string Type [readonly]
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Device type (BR/EDR, LE, BR/EDR/LE).
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32 Class [read=
only]
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0The Bluetooth class of device of the remote device.
> diff --git a/src/device.c b/src/device.c
> index d567952..96683de 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -228,6 +228,20 @@ static void device_free(gpointer user_data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(device);
> =C2=A0}
>
> +const char *devtype2str(device_type_t type)

If the plan is to use the same type(device_type_t) for devices and
adapters we should rename this type.


> +{
> + =C2=A0 =C2=A0 =C2=A0 switch (type) {
> + =C2=A0 =C2=A0 =C2=A0 case DEVICE_TYPE_BREDR:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "BR/EDR";
> + =C2=A0 =C2=A0 =C2=A0 case DEVICE_TYPE_LE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "LE";
> + =C2=A0 =C2=A0 =C2=A0 case DEVICE_TYPE_DUALMODE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "BR/EDR/LE";
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return "Unknown";
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> =C2=A0gboolean device_is_paired(struct btd_device *device)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return device->paired;
> @@ -302,6 +316,10 @@ static DBusMessage *get_properties(DBusConnection *c=
onn,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0DBUS_TYPE_STRING, &icon);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 /* Type */
> + =C2=A0 =C2=A0 =C2=A0 ptr =3D devtype2str(device->type);
> + =C2=A0 =C2=A0 =C2=A0 dict_append_entry(&dict, "Type", DBUS_TYPE_STRING,=
 &ptr);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Paired */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0boolean =3D device_is_paired(device);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dict_append_entry(&dict, "Paired", DBUS_TYPE_B=
OOLEAN, &boolean);
> diff --git a/src/device.h b/src/device.h
> index 3ce212b..b385070 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -41,6 +41,8 @@ typedef enum {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DEVICE_TYPE_DUALMODE
> =C2=A0} device_type_t;
>
> +const char *devtype2str(device_type_t type);
> +
> =C2=A0struct btd_device *device_create(DBusConnection *conn,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct btd_adapter *adapter,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const gchar *address, device_type_t t=
ype);
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>

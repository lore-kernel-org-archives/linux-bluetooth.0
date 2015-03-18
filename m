Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426636201-30057-2-git-send-email-jamuraa@chromium.org>
References: <1426636201-30057-1-git-send-email-jamuraa@chromium.org>
	<1426636201-30057-2-git-send-email-jamuraa@chromium.org>
Date: Wed, 18 Mar 2015 10:59:44 +0200
Message-ID: <CABBYNZLOUf0qa8updZONnOM=N2u7G+v-a5_dzTiCthyUj+PZjw@mail.gmail.com>
Subject: Re: [BlueZ v2 01/14] doc: Add LE Advertisement D-Bus API documentation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Wed, Mar 18, 2015 at 1:49 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> The LE Advertisement API allows external appications to define
> persistent LE Advertisement Data packets.
> ---
>  doc/advertising-api.txt | 98 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 doc/advertising-api.txt
>
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> new file mode 100644
> index 0000000..5c4eff8
> --- /dev/null
> +++ b/doc/advertising-api.txt
> @@ -0,0 +1,98 @@
> +BlueZ D-Bus LE Advertising API Description
> +******************************************
> +
> +Advertising packets are structured data which is broadcast on the LE Advertising
> +channels and available for all devices in range.  Because of the limited space
> +available in LE Advertising packets (32 bytes), each packet's contents must be
> +carefully controlled.
> +
> +BlueZ acts as a store for the Advertisement Data which is meant to be sent.
> +It constructs the correct Advertisement Data from the structured
> +data and configured the kernel to send the correct advertisement.
> +
> +Advertisement Data objects are registered freely and then referenced by BlueZ
> +when constructing the data sent to the kernel.
> +
> +LE Advertisement Data hierarchy
> +===============================
> +
> +Specifies the Advertisement Data to be broadcast and some advertising
> +parameters.  Properties which are not present will not be included in the
> +data.  Required advertisement data types will always be included.
> +All UUIDs are 128-bit versions in the API, and 16 or 32-bit
> +versions of the same UUID will be used in the advertising data as appropriate.
> +
> +Service                org.bluez
> +Interface      org.bluez.LEAdvertisement1
> +Object path    freely definable
> +
> +Properties     string Type
> +
> +                       Determines the type of advertising packet requested.
> +
> +                       Possible values: "broadcast" or "peripheral"
> +
> +               array{string} ServiceUUIDs
> +
> +                       List of UUIDs to include in the "Service UUID" field of
> +                       the Advertising Data.
> +
> +               dict ManufacturerSpecificData

I thought we decided to drop the Specific term and just use ManufacturerData.

> +
> +                       Manufactuer Specific Data fields to include in
> +                       the Advertising Data.  Keys are the Manufacturer ID
> +                       to associate with the data.
> +
> +               bool IncludePower
> +
> +                       If present and true, the TX Power Level will be included
> +                       in the Advertising Data.

This I guess we had dropped, the daemon can figure out if there is
space to include TX Power we should probably do it, anyway we can add
it later if there is something that we should really have.

> +               array{string} SolicitUUIDs
> +
> +                       Array of UUIDs to include in "Service Solicitation"
> +                       Advertisement Data.
> +
> +               dict ServiceData
> +
> +                       Service Data elements to include. The keys are the
> +                       UUID to associate with the data.
> +

Usually we have a Release method for agent interface so the daemon can
notify when an object has been unregistered.

> +LE Advertising Manager hierarchy
> +================================
> +
> +The Advertising Manager allows external applications to register Advertisement
> +Data which should be broadcast to devices.  Advertisement Data elements must
> +follow the API for LE Advertisement Data described above.
> +
> +Service                org.bluez
> +Interface      org.bluez.LEAdvertisingManager1 [Experimental]
> +Object path    /org/bluez/{hci0,hci1,...}
> +
> +Methods                RegisterAdvertisement(object advertisement, dict options)
> +
> +                       Registers an advertisement object to be sent over the LE
> +                       Advertising channel.  The service must be exported
> +                       under interface LEAdvertisement1. InvalidArguments
> +                       indicates that the object has invalid or conflicting
> +                       properties.  InvalidLength indicates that the data
> +                       provided generates a data packet which is too long.
> +                       The properties of this object are parser when it is
> +                       registered, and any changes are ignored.
> +                       Currently only one advertisement at a time is supported,
> +                       attempting to register two advertisements will result in
> +                       an AlreadyExists error.
> +
> +                       Possible errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.AlreadyExists
> +                                        org.bluez.Error.InvalidLength
> +
> +               UnregisterAdvertisement(object advertisement)
> +
> +                       This unregisters an advertisement that has been
> +                       prevously registered.  The object path parameter must
> +                       match the same value that has been used on registration.
> +
> +                       Possible errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.DoesNotExist

You need to include this in the EXTRA_DIST so it gets into the tarball.


-- 
Luiz Augusto von Dentz

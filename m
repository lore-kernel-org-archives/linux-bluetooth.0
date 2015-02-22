Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424212619-10062-2-git-send-email-jamuraa@chromium.org>
References: <1424212619-10062-1-git-send-email-jamuraa@chromium.org>
	<1424212619-10062-2-git-send-email-jamuraa@chromium.org>
Date: Sun, 22 Feb 2015 21:06:59 +0200
Message-ID: <CABBYNZLuyAjzNMuSdWzmDti_=Fvb+NeRMjKLJ9keP5+8vpwhnw@mail.gmail.com>
Subject: Re: [RFC BlueZ v3 1/1] doc: Add LE Advertisement Manager
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Wed, Feb 18, 2015 at 12:36 AM, Michael Janssen <jamuraa@chromium.org> wrote:
> Updates the documentation defining a service hierarchy which can be used
> for defining LE Advertisement data and registering these advertisements
> to be broadcast.
> ---
>  doc/advertising-api.txt | 113 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 doc/advertising-api.txt
>
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> new file mode 100644
> index 0000000..e7feea3
> --- /dev/null
> +++ b/doc/advertising-api.txt
> @@ -0,0 +1,113 @@
> +BlueZ D-Bus LE Advertising API Description
> +******************************************
> +
> +Advertising packets are structured data which is broadcast on the LE Advertising
> +channels and available for all devices in range.  Because of the limited space
> +available in LE Advertising packets (32 bytes) , each packet's contents must be
> +controllable.
> +
> +BlueZ acts as a store for the multiple sets of Advertisement Data which is meant
> +to be sent.  It constructs the correct Advertisement Data from the structured
> +data and communicates the sets of data to the kernel, where it is
> +multiplexed.
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
> +Properties     string AdvertisingType
> +
> +                       Determines the type of advertising packet requested.
> +                       Must be one of "connectable", "scannable", or
> +                       "nonconnectable".
> +
> +               bool RandomAddress
> +
> +                       If true, a random address of the adapter this
> +                       Advertisement Data is associated with will be used, or
> +                       the public address.  If this property is undefined, the
> +                       public device address is used.


We had a discussion about these properties some days in the IRC, and
Marcel was suggesting removing the Type and go for something implicit,
perhaps we could have as AdvertisingType Broadcast, Peripheral, etc.
As for the Address I think it is better to leave it out for now until
we have a better understanding when it would be necessary since
privacy is a big concern.

> +               array{string} ServiceUUIDs
> +
> +                       List of UUIDs to include in the "Service UUID" field of
> +                       the Advertising Data.
> +
> +               string LocalName
> +
> +                       If present, the local name will be included in the
> +                       Advertising Data. A partial name will be included if
> +                       enough space is not available.
> +
> +               map(uint16,array{byte}) ManufacturerSpecificData
> +
> +                       Array of Manufactuer Specific Data fields to include in
> +                       the Advertising Data.  Each struct includes the
> +                       Manufacturer ID and the raw bytes to include.
> +
> +               bool IncludePower
> +
> +                       If present and true, the TX Power Level will be included
> +                       in the Advertising Data.
> +
> +               array{string} SolicitUUIDs
> +
> +                       Array of UUIDs to include in "Service Solicitation"
> +                       Advertisement Data.
> +
> +               map(string,array{byte}) ServiceData
> +
> +                       Array of Service Data to include. The keys are the
> +                       UUID to associate with the data.
> +
> +               uint16 Appearance
> +
> +                       If present, this Appearance will be included
> +                       in the Advertising Data.  It must match an appearance
> +
> +
> +LE Advertising Manager hierarchy
> +================================
> +
> +The Advertising Manager allows external applications to register Advertisement
> +Data which should be broadcast to devices.  Advertisement Data elements must
> +follow the API for LE Advertisement Data described above.
> +
> +Service                org.bluez
> +Interface      org.bluez.LEAdvertisementManager1 [Experimental]
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
> +
> +                       Possible errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.AlreadyExists
> +                                        org.bluez.Error.InvalidLength
> +
> +               UnregisterAdvertisement(object advertisement)
> +
> +                       This unregisters the advertisement that has been
> +                       prevously registered.  The object path parameter must
> +                       match the same value that has been used on registration.
> +
> +                       Possible errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.DoesNotExist
> +
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ-KXN4hgs4pQvb1QfJwqZq7Eb2UJQTYW1SNvWzeDtvGA@mail.gmail.com>
References: <1422647582-12829-1-git-send-email-jamuraa@chromium.org>
	<1422647582-12829-2-git-send-email-jamuraa@chromium.org>
	<CABBYNZJ-KXN4hgs4pQvb1QfJwqZq7Eb2UJQTYW1SNvWzeDtvGA@mail.gmail.com>
Date: Mon, 16 Feb 2015 13:38:57 +0200
Message-ID: <CABBYNZLMhQCN_kL2NNzt8E-NTVps7vq+9QvPz2BtY1oW9Na0kA@mail.gmail.com>
Subject: Re: [RFC BlueZ v2 1/1] doc: Add LE Advertisements to Service Manager
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michael Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

On Mon, Feb 2, 2015 at 11:11 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Michael,
>
> On Fri, Jan 30, 2015 at 9:53 PM, Michael Janssen <jamuraa@chromium.org> wrote:
>> Updates the documentation defining a service hierarchy which can be used
>> for defining LE Advertisement data, and register these advertisements
>> to be broadcast.
>> ---
>>  doc/gatt-api.txt | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 85 insertions(+), 4 deletions(-)
>>
>> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
>> index bfeaf6d..7fa9883 100644
>> --- a/doc/gatt-api.txt
>> +++ b/doc/gatt-api.txt
>> @@ -205,18 +205,77 @@ Properties        string UUID [read-only]
>>                         which a PropertiesChanged signal will be emitted.
>>
>>
>> +LE Advertisement Data hierarchy
>> +===============================
>> +
>> +Advertisement Data to be broadcast and parameters for such.  Properties which
>> +are not present will not be included.  Required advertisement data types will
>> +always be included.
>> +
>> +Service                org.bluez
>> +Interface      org.bluez.LEAdvertisement1
>> +Object path    [variable prefix]/{hci0,hci1,...}/ad_XX_XX_XX_XX_XX_XX
>> +
>> +Properties     string AdvertisingType
>> +
>> +                       Determines the type of advertising packet requested.
>> +                       Must be one of "connectable", "scannable", or
>> +                       "nonconnectable".

I was chatting with Johan regarding AdvertisingType and perhaps we
could do try to figure the packet type implicitly, if there is a GATT
service it should probably became connectable. Also for SolicitUUIDs
there is the following restriction:

 "The Peripheral device should be in the undirected connectable mode
and in one of the discoverable modes."

Also if we have conflicts, such as one app want to be connectable but
another does want nonconnectable bluetoothd will need to resolve this
anyway

>> +               array{string} ServiceUUIDs
>> +
>> +                       List of UUIDs to include in the "Service UUID" field of
>> +                       the Advertising Data. These will be compressed to 16-bit
>> +                       or 32-bit addresses if appropriate to save space.
>> +
>> +               bool IncludeLocalName
>> +
>> +                       If present and true, the local name will be included in
>> +                       the Advertising Data. A partial name will be included if
>> +                       enough space is not available

Name is another thing that could conflict, Id say we can probably
leave this out for now.

>> +               array{struct(uint16,array{byte})} ManufacturerSpecificData
>> +
>> +                       Array of Manufactuer Specific Data fields to include in
>> +                       the Advertising Data.  Each struct includes the
>> +                       Manufacturer ID and the raw bytes to include.
>> +
>> +               bool IncludePower
>> +
>> +                       If present and true, the TX Power Level will be included
>> +                       in the Advertising Data.

Another thing that could conflict.

>> +               array{string} SolicitUUIDs
>> +
>> +                       Array of UUIDs to include in "Service Solicitation"
>> +                       Advertisement Data. These will be compressed to 16-bit
>> +                       or 32-bit addresses if appropriate to save space.
>> +
>> +               array{struct(string,array{byte})} ServiceData
>> +
>> +                       Array of Service Data to include.  The string is the
>> +                       UUID to include with the data, and will be compressed to
>> +                       16 or 32 bit length if applicable.
>> +
>> +               bool IncludeAppearance
>> +
>> +                       If present and true, the Appearance will be included
>> +                       in the Advertising Data.

And this one as well.

So in essence the API should not let application to interfere with
others services/advertisements, including bluetoothd and kernel.

>
>
> This looks much better, but I want to point out that most complex
> structs you have can actually be map to dict, the key element don't
> actually need to be a string:
>
> 'The restrictions are: it occurs only as an array element type; it has
> exactly two single complete types inside the curly braces; the first
> single complete type (the "key") must be a basic type rather than a
> container type.'
>
> So the key element just need to be a basic type, therefore you can use
> in ManufacturerData (I prefer it sorter like this) and in ServiceData
> as well. Another thing is that the UUID compression seems to be
> unaligned with the rest of the API which has always used 128 bits for
> client facing APIs such as D-Bus, while this can take more space I
> believe it might be simpler to handle in the clients.
>
>>  Service Manager hierarchy
>>  =============================
>>
>> -Service Manager allows external applications to register GATT based
>> -services. Services must follow the API for Service and Characteristic
>> -described above.
>> +The Service Manager allows external applications to register GATT based
>> +services and LE Advertisements. Services must follow the API for Service
>> +and Characteristic described above.  LE Advertisements must follow the API
>> +for LE Advertisement Data described above.
>>
>>  Local GATT services, characteristics and characteristic descriptors are
>>  discovered automatically using the D-Bus Object Manager interface.
>>
>>  Service                org.bluez
>> -Interface      org.bluez.GattManager1 [Experimental]
>> +Interface      org.bluez.ServiceManager1 [Experimental]
>>  Object path    /org/bluez
>>
>>  Methods                RegisterService(object service, dict options)
>> @@ -243,3 +302,25 @@ Methods            RegisterService(object service, dict options)
>>
>>                         Possible errors: org.bluez.Error.InvalidArguments
>>                                          org.bluez.Error.DoesNotExist
>> +
>> +               RegisterAdvertisement(object advertisement, dict options)
>> +
>> +                       Registers an advertisement object to be sent over the LE
>> +                       Advertising channel.  The service must be exported
>> +                       under interface LEAdvertisement1. The last segment of
>> +                       the object path determines the advertiser's address used
>> +                       and is assumed to be a random address unless it matches
>> +                       the public address.

The address to be used could also conflict, furthermore we should
never encode anything like that in the object path. The kernel should
be able to generate random addresses and do the proper privacy, we
should never let a user process control this.

>> +                       Possible errors: org.bluez.Error.InvalidArguments
>> +                                        org.bluez.Error.AlreadyExists
>> +                                        org.bluez.Error.InvalidLength
>> +
>> +               UnregisterAdvertisement(object advertisement)
>> +
>> +                       This unregisters the advertisement that has been
>> +                       prevously registered.  The object path parameter must
>> +                       match the same value that has been used on registration.
>> +
>> +                       Possible errors: org.bluez.Error.InvalidArguments
>> +                                        org.bluez.Error.DoesNotExist
>> --
>> 2.2.0.rc0.207.ga3a616c
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz

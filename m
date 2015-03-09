Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25Si0fHRUTx9D+i2HYg6B6VzEKV7woekuyywUKEijAa9kQ@mail.gmail.com>
References: <1425903978-24536-1-git-send-email-luiz.dentz@gmail.com>
	<CAHrH25Si0fHRUTx9D+i2HYg6B6VzEKV7woekuyywUKEijAa9kQ@mail.gmail.com>
Date: Mon, 9 Mar 2015 19:44:37 +0200
Message-ID: <CABBYNZK3u2xdT9tjjYQHi7m3t5W+i1AGOpnaq1r6QKTQLMqxhw@mail.gmail.com>
Subject: Re: [RFC BlueZ] doc: Add LE Advertisement Manager
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Mar 9, 2015 at 7:36 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
>> On Mon, Mar 9, 2015 at 5:26 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> Updates the documentation defining a service hierarchy which can be used
>> for defining LE Advertisement data and registering these advertisements
>> to be broadcast.
>>
>> Note: Ive made some modifications since the last proposal taking away a
>> good number of properties that could conflict if advertisement would be
>> combined, in case we cannot use different random addresses for each AD.
>> Also I include the intention to use the same interface for
>> central/client role so the interface would be exposed in the device
>> path.
>
> This is good, though should Michael maintain authorship of this commit
> since it was his proposal?

I have no problem either way.

>> ---
>>  doc/advertising-api.txt | 90 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>  create mode 100644 doc/advertising-api.txt
>>
>> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
>> new file mode 100644
>> index 0000000..3ab4691
>> --- /dev/null
>> +++ b/doc/advertising-api.txt
>> @@ -0,0 +1,90 @@
>> +BlueZ D-Bus LE Advertising API Description
>> +******************************************
>> +
>> +Advertising packets are structured data which is broadcast on the LE Advertising
>> +channels and available for all devices in range.  Because of the limited space
>> +available in LE Advertising packets (32 bytes) , each packet's contents must be
>> +controllable.
>> +
>> +BlueZ acts as a store for the multiple sets of Advertisement Data which is meant
>> +to be sent.  It constructs the correct Advertisement Data from the structured
>> +data and communicates the sets of data to the kernel, where it is
>> +multiplexed.
>> +
>> +Advertisement Data objects are registered freely and then referenced by BlueZ
>> +when constructing the data sent to the kernel.
>> +
>> +LE Advertisement Data hierarchy
>> +===============================
>> +
>> +Specifies the Advertisement Data to be broadcast and some advertising
>> +parameters.  Properties which are not present will not be included in the
>> +data.  Required advertisement data types will always be included.
>> +All UUIDs are 128-bit versions in the API, and 16 or 32-bit
>> +versions of the same UUID will be used in the advertising data as appropriate.
>> +
>> +Service                org.bluez
>> +Interface      org.bluez.LEAdvertisement1
>> +Object path    freely definable or
>> +               /org/bluez/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>> +
>> +Properties     string Type
>> +
>> +                       Determines the type of advertising packet requested.
>> +
>> +                       Possible values: "broadcaster" or "peripheral"
>> +
>> +               array{string} ServiceUUIDs [Optional]
>> +
>> +                       List of UUIDs to include in the "Service UUID" field of
>> +                       the Advertising Data.
>> +
>> +               dict ManufacturerData [Optional]
>> +
>> +                       Array of Manufactuer Specific Data fields to include in
>> +                       the Advertising Data.  Each dictionary entry includes
>> +                       the Manufacturer ID and the raw bytes to include.
>> +
>> +               array{string} SolicitUUIDs [Optional]
>> +
>> +                       Array of UUIDs to include in "Service Solicitation"
>> +                       Advertisement Data.
>> +
>> +               dict ServiceData [Optional]
>> +
>> +                       Array of Service Data to include. The keys are the
>> +                       UUID to associate with the data.
>> +
>> +LE Advertising Manager hierarchy
>> +================================
>> +
>> +The Advertising Manager allows external applications to register Advertisement
>> +Data which should be broadcast to devices.  Advertisement Data elements must
>> +follow the API for LE Advertisement Data described above.
>> +
>> +Service                org.bluez
>> +Interface      org.bluez.LEAdvertisementManager1 [Experimental]
>> +Object path    /org/bluez/{hci0,hci1,...}
>> +
>> +Methods                RegisterAdvertisement(object advertisement, dict options)
>> +
>> +                       Registers an advertisement object to be sent over the LE
>> +                       Advertising channel.  The service must be exported
>> +                       under interface LEAdvertisement1. InvalidArguments
>> +                       indicates that the object has invalid or conflicting
>> +                       properties.  InvalidLength indicates that the data
>> +                       provided generates a data packet which is too long.
>
> Will this also cause the controller to start advertising? Or would we
> want a separate Adapter1 API for this, e.g. StartAdvertising? We need
> a good story for switching between central/scanner and
> peripheral/broadcaster roles in general.

I guess we could do that following similar design as discovery, with
Advertising property, etc. We then should probably return an error if
a discovering session is ongoing and vice versa.

>> +
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
>> +
>> --
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Thanks,
> Arman



-- 
Luiz Augusto von Dentz

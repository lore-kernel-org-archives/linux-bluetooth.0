Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25QqYhKGYitV4oVDPibjpCte6ACgPigr_+rW0r5LYwOPwQ@mail.gmail.com>
References: <1429798808-24388-1-git-send-email-luiz.dentz@gmail.com>
	<CAHrH25QqYhKGYitV4oVDPibjpCte6ACgPigr_+rW0r5LYwOPwQ@mail.gmail.com>
Date: Thu, 23 Apr 2015 22:21:19 +0300
Message-ID: <CABBYNZJX4n-pJ56enQ6W2O2qxWWX4r6Gi9zUTXwG4-HXB4z9rQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] doc/gatt-api: Add encryption flags
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Apr 23, 2015 at 10:14 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
>> On Thu, Apr 23, 2015 at 7:20 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This add encryption flags which can be used when registering a service to
>> require encryption when accessing a characteristic.
>> ---
>>  doc/gatt-api.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
>> index 088d285..8db35f2 100644
>> --- a/doc/gatt-api.txt
>> +++ b/doc/gatt-api.txt
>> @@ -148,6 +148,10 @@ Properties string UUID [read-only]
>>                                 "authenticated-signed-writes"
>>                                 "reliable-write"
>>                                 "writable-auxiliaries"
>> +                               "encrypt-read"
>> +                               "encrypt-write"
>> +                               "encrypt-authenticated-read"
>> +                               "encrypt-authenticated-write"
>
> So I guess you decided not to go with a "Permissions" property? I
> guess that's fine but we need to handle this for descriptors as well.
> So probably add a "Flags" property to GattDescriptor1 also. There
> we'll want read, write, encrypt-*, and encrypt-authenticated-*.

Sure, will do that in the next set. What is more important now is
getting feedback if the API is good enough, I have been debating in
using secure instead of encrypt, what do you think?

>>
>>                 array{object} Descriptors [read-only]
>>
>> --
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Can you also update test/example-gatt-server with new characteristics
> and descriptors that demonstrate the permissions feature? You can add
> them as new vendor-specific test characteristics (there's a
> vendor-specific test service in there) and/or modify one of the other
> two example services (HR and Battery). Let's get that into this patch
> set so we know we have some way to test it.

Yep, I was thinking about that just now, will add this in the next version.


-- 
Luiz Augusto von Dentz

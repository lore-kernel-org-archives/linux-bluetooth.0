Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E43CE124327DEB448881DE4DD408A8A323E808C1E9@AUSX7MCPS308.AMER.DELL.COM>
References: <E43CE124327DEB448881DE4DD408A8A323E808BAD1@AUSX7MCPS308.AMER.DELL.COM>
	<6E7C05F9-DAAE-4AC1-B735-BB7B2E8D333B@holtmann.org>
	<E43CE124327DEB448881DE4DD408A8A323E808C1E9@AUSX7MCPS308.AMER.DELL.COM>
Date: Tue, 22 Sep 2015 10:22:54 +0300
Message-ID: <CABBYNZKzsqzKHoViQp4Y8OZigWzjwH5O+b2zZ5Q6b=3wZYqyLw@mail.gmail.com>
Subject: Re: BlueZ - LGPL dependency with GPL headers and sources
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Trey_Ramsay@dell.com
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Arulnambi_Raju@dell.com,
	Marie Janssen <jamuraa@google.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

+Marie

On Mon, Sep 21, 2015 at 8:58 PM,  <Trey_Ramsay@dell.com> wrote:
>> Hi Trey,
>>
>> > We are making a BLE only product for embedded system and cannot use
>> the whole bluez package due to lack of resources. We noticed that the BLE
>> specific code (src/shared) is licensed under LGPL and we are trying to
>> leverage the code as a shared library for our proprietary source BLE
>> application, similar to btgatt-server tool. While compiling, we noticed the
>> LPGL code has a dependency with the following header and source files
>> which are licensed as GPL.
>> >
>> > lib/bluetooth.h
>> > lib/hci.h
>> > lib/mgmt..h
>> > lib/uuid.c
>> > lib/uuid.h
>> > src/shared/ad.c
>> > src/shared/ad.h
>> >
>> > Are there plans to make the above files LGPL or LGPL compatible?
>>
>> the src/shared/ad.[ch] is actually a mistake. No code under GPL should have
>> been accepted into src/shared/ directory. That code is intentionally kept
>> LGPL only.
>>
>> > Are there any plans in the future to remove the GPL dependencies from
>> the LGPL code?
>>
>> The lib/uuid.[ch] is pretty old code and not really nicely abstracted in the first
>> place. However it has been used to speed up the development of the GATT
>> support. The plan is actually to replace that with a new implementation
>> src/shared/uuid.[ch] under LGPL that nicely integrates.
>>
> How soon will this happen?  Do you need any help making this LGPL code?

I guess we need to consent of the authors to change the ad.c.

@Marie: Do you agree to change to LGPL (I suppose this was a mistake
in the first place)? If you do, could you please send a patch to
changing it?

>> The other three are just a bunch of defines or structs. However they are
>> kernel defines and structs and should be most likely come directly from the
>> kernel as UAPI. However we have never gotten around it to clean these up.
>> Some of this is part of the old libbluetooth (which is still internally required).
>> We are talking about 13 year old code here.
>>
> Do you mean that it is ok for us to use the lib/*.h  files even though it's licensed as GPL?
> The kernel headers are not exactly the same and may not be able to compile with the bluez package.
>
>> Regards
>>
>> Marcel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGMzoHXK6K26g2n7p=a_i+fEdHT5SKRXdd4b7o8M=HBShw@mail.gmail.com>
References: <CAEZxfGMCA_A1RQVmxr6DWgweD5Qg6e34F-09Ws=stLpV=YU5=w@mail.gmail.com>
	<20160419172500.GA16645@t440s.P-661HNU-F1>
	<CAEZxfGNTYECk57B=32V8W-AKHFXQZH+5d916gsn2Ke8QEt8yzQ@mail.gmail.com>
	<CAEZxfGMzoHXK6K26g2n7p=a_i+fEdHT5SKRXdd4b7o8M=HBShw@mail.gmail.com>
Date: Wed, 20 Apr 2016 11:00:36 +0300
Message-ID: <CABBYNZKGyPX8kycqdEWUYx8Obeq4n9e2hPcY+nCtEFZNjEitSA@mail.gmail.com>
Subject: Re: Add Eddystone GATT Config Service to known UUIDs
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi François,

On Wed, Apr 20, 2016 at 9:49 AM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> Regarding my initial request, can someone point to me where to start
> if I wanted to code that?

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/monitor/uuid.c
you might need to add a table for known UUID 128 bits so
uuidstr_to_str don't return "Vendor specific" instead it lookup by
string.

> On Tue, Apr 19, 2016 at 8:09 PM, François Beaufort
> <beaufort.francois@gmail.com> wrote:
>> For info, I've asked this question at
>> https://github.com/google/eddystone/issues/138
>> Let's see what they say.
>>
>> On Tue, Apr 19, 2016 at 7:25 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>>> Hi François,
>>>
>>> On Tue, Apr 19, 2016, François Beaufort wrote:
>>>> I'd love to see the new Eddystone Configuration GATT Service
>>>> (https://github.com/google/eddystone/tree/master/configuration-service)
>>>> being recognized by BlueZ.
>>>> Could you guys make this happen?
>>>
>>> That'd indeed be nice! I'm not volunteering, but I do have a question
>>> about this part:
>>>
>>> "Where not explicitly stated, data written and read is defined in terms
>>> of big-endian arrays of signed bytes."
>>>
>>> Why on earth big-endian? GATT, like most other Bluetooth protocols, is
>>> little-endian. Can this still be fixed?
>>>
>>> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

Return-Path: <cyrus@holtmann.org>
Message-ID: <e91dafd20810150632m56ba981am28f3489c0661690b@mail.gmail.com>
Date: Wed, 15 Oct 2008 15:32:21 +0200
From: mcINEK <mcinek@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [ BUG ] acl sysfs entry remains after connection error
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1223479873.4397.0.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e91dafd20810080800o30fe2fb0v7a537715e14c44fa@mail.gmail.com>
	 <1223479873.4397.0.camel@californication>
List-ID: <linux-bluetooth.vger.kernel.org>

2008/10/8 Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>
>> I've found a bug in bluetooth stack.
>>
>> I use bluetooth on ARM Linux machine to simultaneously send pictures
>> to 2 or 3 devices.
>> In a L2CAP connection stage (socket L2CAP 'connect') sometimes I get a
>> 'Connection timeout error',
>> which is not a disaster because I can try to connect again. However
>> very often I get a kernel error,
>> which tells me that there is a duplicate entry in sysfs (acl...).
>>
>> I've checked, and indeed acl connection entries are not removed from
>> sysfs after a connection fail.
>>
>> How can I fix this?
>>
>> PS. I've got latest 2.6.26 kernel.
>
> the latest kernel is 2.6.27-rc9. Please confirm that this problem still
> exists.

I've updated and after some tests problem seems to be fixed!

Thanks.

Marcin

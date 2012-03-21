Return-Path: <cyrus@holtmann.org>
Message-id: <6F8C342E7F8248CA8DC36EB3B8316CA7@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
References: <CAB7rCTg4YLsE7uNbR8mRH_cubtMmBnTZUnJ3U4vL_AsyjA7xzA@mail.gmail.com>
 <20120319230436.GA27304@x220> <20120320173546.GA6307@samus>
 <20120321124517.GB8888@x220> <B81BBF97380548409643B2DD0175BDED@sisodomain.com>
 <CAJdJm_N1od26oRzE+k_T_TqPXBQ8vPH0z6KkCczj94v8zMZ2NQ@mail.gmail.com>
In-reply-to: <CAJdJm_N1od26oRzE+k_T_TqPXBQ8vPH0z6KkCczj94v8zMZ2NQ@mail.gmail.com>
Subject: Re: Query on attribute api service object path
Date: Wed, 21 Mar 2012 19:57:14 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

--------------------------------------------------
From: "Anderson Lizardo" <anderson.lizardo@openbossa.org>
Sent: Wednesday, March 21, 2012 7:48 PM
To: "Jaganath" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: Query on attribute api service object path

> Hi,
>
> On Wed, Mar 21, 2012 at 9:11 AM, Jaganath <jaganath.k@samsung.com> wrote:
>> Hello,
>>
>> I have a doubt in attribute-api.txt.
>> In Device service hierarchy object path is
>> "[prefix]/{hci0}/{device0}/{service0, service1, ...}.
>> which is device path + service"x".
>> When I checked the code "x" is "prim->start" which is service start 
>> handle.
>> But how user will get this handle to create object path?
>> Only uuids are passed to user in UUIDs signal afaik.
>
> Take a look on how to use the API on the test/test-attrib python
> script. You should not try to parse the path itself. it is returned by
> Methods and you simply use then with a D-Bus interface (e.g.
> Bluez.Attribute).
>
Thanks for your reply. Characteristic based Service object path is there in 
device properties.

Jaganath 


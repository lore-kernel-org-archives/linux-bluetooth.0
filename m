Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTinJt+K3sYOEbpBu8oqfZoC1ir3dxQ@mail.gmail.com>
References: <BANLkTinUNvtonVmErqwz-t=YufQha+k+HQ@mail.gmail.com>
	<BANLkTinJt+K3sYOEbpBu8oqfZoC1ir3dxQ@mail.gmail.com>
Date: Wed, 8 Jun 2011 14:44:34 -0300
Message-ID: <BANLkTimjqM7HL8yxb2pd8OC8q=MhyRZobg@mail.gmail.com>
Subject: Re: Generic Attribute API race condition
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Jaikumar Ganesh <jaikumarg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

On Wed, Jun 8, 2011 at 11:18 AM, Jaikumar Ganesh <jaikumarg@gmail.com> wrote:
> Hi Claudio:
>
> On Tue, Jun 7, 2011 at 11:41 PM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> Hi All,
>>
>> There is a potential race condition in the Generic Attribute API. I'd
>> like to collect opinions to avoid re-work later.
>>
>> How to reproduce:
>> - call CreateDevice() for a device which exports a GATT based service:
>> CreateDevice will discover all primary services
>>  and the Generic API will register the object paths for all found services
>> - Call DiscoverCharacteristics() of the primary service followed by
>> Characteristic GetProperties(), expected result: read all
>> characteristics properties outcome: partial characteristics properties
>> may appear.
>>
>> This problem happens because DiscoverCharacteristics() doesn't wait
>> for all characteristic VALUES, it returns after discovering all
>> characteristic DECLARATIONS.
>> Wait for characteristic values is a problem, attributes may require
>> authentication or authorization.
>>
>> Suggestions are:
>> 1. Report discovered characteristic values using PropertyChanged:
>> Returning empty properties values (for GetProperties) if the discovery
>> is in progress
>>
>> 2. Block GetProperties() if there is a discovery pending: returning
>> after discovery finishes. Timeout can still happen!
>>
>> 3. Return Busy for GetProperties() if there is a characteristic
>> discovery in progress
>>
>> Comments?
>
> I don't think we should read characteristic value till the application
> asks for it.
Are you suggesting to trigger the characteristic value and descriptors
read when Characteristic GetProperties() is called and block it?
Remember that GATT timeout is 30seconds and the default D-Bus message
reply timeout is smaller.

> DiscoverCharacteristics() should just return after getting the DECLARATIONS.
This is current behaviour.

> A client might not be interested in all the values and thus we should
> read them only
> when needed by the client. This will save both time and power and
> solve this problem too.

I don't think it is critical, we are not reading them on all
connections/re-connections and the profiles available at the moment
don't expose "complex" characteristics.

BR,
Claudio

>
> Thanks
> Jaikumar
>>
>> BR,
>> Claudio

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <59D501B9.9030602@digi.com>
References: <59CD26BE.8040803@digi.com> <CABBYNZLFyyNQmkAk5JZGWDii_hcx0n68yr-sjeXVUAEHVcOqcw@mail.gmail.com>
 <59CDEBDF.3090200@digi.com> <59D1E4B0.2000106@digi.com> <CABBYNZKuzJ4ueWufFSEZo7zhVdL5DCF=DuUYQLY-zV0OEuFYRA@mail.gmail.com>
 <59D3343B.6020103@digi.com> <59D501B9.9030602@digi.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 5 Oct 2017 12:40:26 +0300
Message-ID: <CABBYNZJUshJX5nK=bss3yJdvrREaoZ64hKt7zZJcjfB19++NBQ@mail.gmail.com>
Subject: Re: how to advertise a GATT service only for LE or BR/EDR?
To: "Hermida, Isaac" <Isaac.Hermida@digi.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Isaac,

On Wed, Oct 4, 2017 at 6:43 PM, Hermida, Isaac <Isaac.Hermida@digi.com> wrote:
> Hi Luiz,
>
> On 10/03/2017 08:54 AM, Hermida, Isaac wrote:
>> Hi Luiz,
>>
>> On 10/02/2017 06:00 PM, Luiz Augusto von Dentz wrote:
>>> Hi Isaac,
>>>
>>> On Mon, Oct 2, 2017 at 10:03 AM, Hermida, Isaac <Isaac.Hermida@digi.com> wrote:
>>>> Hi Luiz et all,
>>>>
>>>> On 09/29/2017 08:44 AM, Hermida, Isaac wrote:
>>>>> Hi Luiz,
>>>>>
>>>>> On 09/28/2017 08:21 PM, Luiz Augusto von Dentz wrote:
>>>>>> Hi Isaac,
>>>>>>
>>>>>> On Thu, Sep 28, 2017 at 7:43 PM, Hermida, Isaac <Isaac.Hermida@digi.com> wrote:
>>>>>>> Hi group,
>>>>>>>
>>>>>>> As part of the bluetooth SIG certification there are two test cases
>>>>>>> /TP/GAR/CL/BI-34-C and /TP/GAR/CL/BI-35-C (you can see they defined in
>>>>>>> unit/test-gatt.c).
>>>>>>> Currently I am able to run the "test/example-gatt-server" and see my
>>>>>>> custom services and characteristics, but I need to define an specific
>>>>>>> service/characteristic to be only accessible trough LE or BR/EDR
>>>>>>> transport parameter. I was digging into the code but I was unable to
>>>>>>> find how to set it for the GATT server.
>>>>>>>
>>>>>>> In other words, what I want to do is launch the gatt-server and then,
>>>>>>> when inspecting the services/characteristic with gatttool, the returned
>>>>>>> list should be different if I run gatttool with "-p 31" or not (notice
>>>>>>> how the gatttool prompt is set to LE or BR).
>>>>>>>
>>>>>>> # gatttool -I -b 00:40:9D:98:99:BD -p 0
>>>>>>> [00:40:9D:98:99:BD][LE]> connect
>>>>>>> Attempting to connect to 00:40:9D:98:99:BD
>>>>>>> Connection successful
>>>>>>> [00:40:9D:98:99:BD][LE]> primary
>>>>>>> attr handle: 0x0001, end grp handle: 0x0005 uuid:
>>>>>>> 00001800-0000-1000-8000-00805f9b34fb
>>>>>>> attr handle: 0x0006, end grp handle: 0x0009 uuid:
>>>>>>> 00001801-0000-1000-8000-00805f9b34fb
>>>>>>> attr handle: 0x000a, end grp handle: 0x000d uuid:
>>>>>>> 0000180f-0000-1000-8000-00805f9b34fb
>>>>>>> attr handle: 0x000e, end grp handle: 0x001d uuid:
>>>>>>> 12345678-1234-5678-1234-56789abcdef0
>>>>>>> attr handle: 0x001e, end grp handle: 0x0025 uuid:
>>>>>>> 0000180d-0000-1000-8000-00805f9b34fb
>>>>>>>
>>>>>>>
>>>>>>> # /tmp/gatttool -I -b 00:40:9D:98:99:BD -p 31
>>>>>>> [00:40:9D:98:99:BD][BR]> connect
>>>>>>> Attempting to connect to 00:40:9D:98:99:BD
>>>>>>> Connection successful
>>>>>>> [00:40:9D:98:99:BD][BR]> primary
>>>>>>> attr handle: 0x0001, end grp handle: 0x0005 uuid:
>>>>>>> 00001800-0000-1000-8000-00805f9b34fb
>>>>>>> attr handle: 0x0006, end grp handle: 0x0009 uuid:
>>>>>>> 00001801-0000-1000-8000-00805f9b34fb
>>>>>>> attr handle: 0x000a, end grp handle: 0x0019 uuid:
>>>>>>> 12345678-1234-5678-1234-56789abcdef0
>>>>>>> attr handle: 0x001a, end grp handle: 0x001d uuid:
>>>>>>> 0000180f-0000-1000-8000-00805f9b34fb
>>>>>>> attr handle: 0x001e, end grp handle: 0x0025 uuid:
>>>>>>> 0000180d-0000-1000-8000-00805f9b34fb
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I am using bluez 5.41. Is possible to advertise a service only for LE or
>>>>>>> BR? I guess it should because is part of the SIG certification and is
>>>>>>> part of the unit/test-gatt.
>>>>>> This might be because the spec was no clear about the database being
>>>>>> bearer specific, which in my opinion this is a oversight since then we
>>>>>> can't represent attributes of dual mode devices with a unified object,
>>>>>> and I really wonder if this has to be forced up into the API, if it
>>>>>> does then we would have to encode bearer information into the object
>>>>>> path (argh!) for client and for server would probably need a property
>>>>>> telling which bearer this would be available and encode this into to
>>>>>> the database which may leave gaps in the handles or just duplicate
>>>>>> everything, for server Id probably just hide the services based on the
>>>>>> bearer, but we still need to store the CCC configuration in a bearer
>>>>>> specific manner.
>>>>>>
>>>>>
>>>>> So, what can I do in order to pass that specific bluetooth SIG tests?
>>>>> That test cases need to ensure that an specific service/char in only
>>>>> accessible on LE or BR, so they had to be different.
>>>>> Do you have any idea or suggestion? It would be really welcome, if not I
>>>>> have no idea how to proceed to complete the SIG validation with bluez stuff.
>>>>> I was even trying to modify some files into the code, but I am not
>>>>> familiar with that and it obviously did not work.
>>>>
>>>> I understand the silent to this last question as a no. So I assume that
>>>> any user trying to pass this test will fail (at least if using bluez).
>>>> So should the specification be changed? Should bluez adapt to it? In the
>>>> current state that SIG certification can not be passed.
>>>
>>> That if you want to qualify with GATT over BR/EDR, something that we
>>> may actually have an option to disable in the future, or perhaps just
>>> remove it entirely given this tests would possible affect that GATT
>>> database layout, either by creating handle gaps or duplication. So
>>> perhaps you could give some feedback if you do intend to use GATT over
>>> BR/EDR or not? If it turn out no one benefit from it Id just remove
>>> it.
>>>
>>
>> Thanks for the quick reply. I do not know how any other people was able
>> to pass these SIG lab tests (BI-34-C and BI-35-C).
>> I do not plan to use GATT over BR/EDR. For me just removing it would be
>> enough. If you can point me where/how to do that it would be great so I
>> can dig in the code (I am not familiar with that code).
>>
>> Thx,
>>      Isaac
>
>
> Yesterday I did apply the patch (gatt: Remove support of ATT over
> BR/EDR) on bluez-5.41 (my current version) and passed it to the lab. I
> was waiting for their feedback but I did not get a reply yet, so just to
> let you know that I get the patch and applied it.
> As I see it, that patch removed the support for ATT over BR/EDR, so I
> guess that another way to pass that test is modifying the firmware of
> the bluetooth chip to disable it at a hw level.
> And, in order to pass the other test case (BI-35-C), I will need to do
> not apply the mentioned patch and create a similar one for ATT over LE,
> or is there another way to accomplish /TP/GAR/CL/BI-35-C?

Id assume you would not have to run those tests if ATT over BR/EDR is
not supported:

4.5.72 TP/GAR/CL/BI-35-C [Read Characteristic Value \u2013 Invalid
Transport Access over
LE]
Verify Generic Attribute Profile client behavior when an attempt to
use LE transport to execute
the Read Characteristic Value procedure on a characteristic contained
within a service defined
for use only over BR/EDR transport.

Without BR/EDR there is no reason to run this test as all the
attributes should be valid.

-- 
Luiz Augusto von Dentz

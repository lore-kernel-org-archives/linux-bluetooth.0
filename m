Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <59DB4D93.3050200@digi.com>
References: <59CD26BE.8040803@digi.com> <CABBYNZLFyyNQmkAk5JZGWDii_hcx0n68yr-sjeXVUAEHVcOqcw@mail.gmail.com>
 <59CDEBDF.3090200@digi.com> <59D1E4B0.2000106@digi.com> <CABBYNZKuzJ4ueWufFSEZo7zhVdL5DCF=DuUYQLY-zV0OEuFYRA@mail.gmail.com>
 <59D3343B.6020103@digi.com> <59D501B9.9030602@digi.com> <CABBYNZJUshJX5nK=bss3yJdvrREaoZ64hKt7zZJcjfB19++NBQ@mail.gmail.com>
 <59DB4D93.3050200@digi.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Oct 2017 14:30:45 +0300
Message-ID: <CABBYNZJ0+aTeFMBFVYq8p63zDAUfHcNUm9ritaUBDMmCnRaHZQ@mail.gmail.com>
Subject: Re: how to advertise a GATT service only for LE or BR/EDR?
To: "Hermida, Isaac" <Isaac.Hermida@digi.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Isaac,

On Mon, Oct 9, 2017 at 1:21 PM, Hermida, Isaac <Isaac.Hermida@digi.com> wro=
te:
> Hi Luiz,
>
> On 10/05/2017 11:40 AM, Luiz Augusto von Dentz wrote:
>> Hi Isaac,
>>
>> On Wed, Oct 4, 2017 at 6:43 PM, Hermida, Isaac <Isaac.Hermida@digi.com> =
wrote:
>>> Hi Luiz,
>>>
>>> On 10/03/2017 08:54 AM, Hermida, Isaac wrote:
>>>> Hi Luiz,
>>>>
>>>> On 10/02/2017 06:00 PM, Luiz Augusto von Dentz wrote:
>>>>> Hi Isaac,
>>>>>
>>>>> On Mon, Oct 2, 2017 at 10:03 AM, Hermida, Isaac <Isaac.Hermida@digi.c=
om> wrote:
>>>>>> Hi Luiz et all,
>>>>>>
>>>>>> On 09/29/2017 08:44 AM, Hermida, Isaac wrote:
>>>>>>> Hi Luiz,
>>>>>>>
>>>>>>> On 09/28/2017 08:21 PM, Luiz Augusto von Dentz wrote:
>>>>>>>> Hi Isaac,
>>>>>>>>
>>>>>>>> On Thu, Sep 28, 2017 at 7:43 PM, Hermida, Isaac <Isaac.Hermida@dig=
i.com> wrote:
>>>>>>>>> Hi group,
>>>>>>>>>
>>>>>>>>> As part of the bluetooth SIG certification there are two test cas=
es
>>>>>>>>> /TP/GAR/CL/BI-34-C and /TP/GAR/CL/BI-35-C (you can see they defin=
ed in
>>>>>>>>> unit/test-gatt.c).
>>>>>>>>> Currently I am able to run the "test/example-gatt-server" and see=
 my
>>>>>>>>> custom services and characteristics, but I need to define an spec=
ific
>>>>>>>>> service/characteristic to be only accessible trough LE or BR/EDR
>>>>>>>>> transport parameter. I was digging into the code but I was unable=
 to
>>>>>>>>> find how to set it for the GATT server.
>>>>>>>>>
>>>>>>>>> In other words, what I want to do is launch the gatt-server and t=
hen,
>>>>>>>>> when inspecting the services/characteristic with gatttool, the re=
turned
>>>>>>>>> list should be different if I run gatttool with "-p 31" or not (n=
otice
>>>>>>>>> how the gatttool prompt is set to LE or BR).
>>>>>>>>>
>>>>>>>>> # gatttool -I -b 00:40:9D:98:99:BD -p 0
>>>>>>>>> [00:40:9D:98:99:BD][LE]> connect
>>>>>>>>> Attempting to connect to 00:40:9D:98:99:BD
>>>>>>>>> Connection successful
>>>>>>>>> [00:40:9D:98:99:BD][LE]> primary
>>>>>>>>> attr handle: 0x0001, end grp handle: 0x0005 uuid:
>>>>>>>>> 00001800-0000-1000-8000-00805f9b34fb
>>>>>>>>> attr handle: 0x0006, end grp handle: 0x0009 uuid:
>>>>>>>>> 00001801-0000-1000-8000-00805f9b34fb
>>>>>>>>> attr handle: 0x000a, end grp handle: 0x000d uuid:
>>>>>>>>> 0000180f-0000-1000-8000-00805f9b34fb
>>>>>>>>> attr handle: 0x000e, end grp handle: 0x001d uuid:
>>>>>>>>> 12345678-1234-5678-1234-56789abcdef0
>>>>>>>>> attr handle: 0x001e, end grp handle: 0x0025 uuid:
>>>>>>>>> 0000180d-0000-1000-8000-00805f9b34fb
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> # /tmp/gatttool -I -b 00:40:9D:98:99:BD -p 31
>>>>>>>>> [00:40:9D:98:99:BD][BR]> connect
>>>>>>>>> Attempting to connect to 00:40:9D:98:99:BD
>>>>>>>>> Connection successful
>>>>>>>>> [00:40:9D:98:99:BD][BR]> primary
>>>>>>>>> attr handle: 0x0001, end grp handle: 0x0005 uuid:
>>>>>>>>> 00001800-0000-1000-8000-00805f9b34fb
>>>>>>>>> attr handle: 0x0006, end grp handle: 0x0009 uuid:
>>>>>>>>> 00001801-0000-1000-8000-00805f9b34fb
>>>>>>>>> attr handle: 0x000a, end grp handle: 0x0019 uuid:
>>>>>>>>> 12345678-1234-5678-1234-56789abcdef0
>>>>>>>>> attr handle: 0x001a, end grp handle: 0x001d uuid:
>>>>>>>>> 0000180f-0000-1000-8000-00805f9b34fb
>>>>>>>>> attr handle: 0x001e, end grp handle: 0x0025 uuid:
>>>>>>>>> 0000180d-0000-1000-8000-00805f9b34fb
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I am using bluez 5.41. Is possible to advertise a service only fo=
r LE or
>>>>>>>>> BR? I guess it should because is part of the SIG certification an=
d is
>>>>>>>>> part of the unit/test-gatt.
>>>>>>>> This might be because the spec was no clear about the database bei=
ng
>>>>>>>> bearer specific, which in my opinion this is a oversight since the=
n we
>>>>>>>> can't represent attributes of dual mode devices with a unified obj=
ect,
>>>>>>>> and I really wonder if this has to be forced up into the API, if i=
t
>>>>>>>> does then we would have to encode bearer information into the obje=
ct
>>>>>>>> path (argh!) for client and for server would probably need a prope=
rty
>>>>>>>> telling which bearer this would be available and encode this into =
to
>>>>>>>> the database which may leave gaps in the handles or just duplicate
>>>>>>>> everything, for server Id probably just hide the services based on=
 the
>>>>>>>> bearer, but we still need to store the CCC configuration in a bear=
er
>>>>>>>> specific manner.
>>>>>>>>
>>>>>>>
>>>>>>> So, what can I do in order to pass that specific bluetooth SIG test=
s?
>>>>>>> That test cases need to ensure that an specific service/char in onl=
y
>>>>>>> accessible on LE or BR, so they had to be different.
>>>>>>> Do you have any idea or suggestion? It would be really welcome, if =
not I
>>>>>>> have no idea how to proceed to complete the SIG validation with blu=
ez stuff.
>>>>>>> I was even trying to modify some files into the code, but I am not
>>>>>>> familiar with that and it obviously did not work.
>>>>>>
>>>>>> I understand the silent to this last question as a no. So I assume t=
hat
>>>>>> any user trying to pass this test will fail (at least if using bluez=
).
>>>>>> So should the specification be changed? Should bluez adapt to it? In=
 the
>>>>>> current state that SIG certification can not be passed.
>>>>>
>>>>> That if you want to qualify with GATT over BR/EDR, something that we
>>>>> may actually have an option to disable in the future, or perhaps just
>>>>> remove it entirely given this tests would possible affect that GATT
>>>>> database layout, either by creating handle gaps or duplication. So
>>>>> perhaps you could give some feedback if you do intend to use GATT ove=
r
>>>>> BR/EDR or not? If it turn out no one benefit from it Id just remove
>>>>> it.
>>>>>
>>>>
>>>> Thanks for the quick reply. I do not know how any other people was abl=
e
>>>> to pass these SIG lab tests (BI-34-C and BI-35-C).
>>>> I do not plan to use GATT over BR/EDR. For me just removing it would b=
e
>>>> enough. If you can point me where/how to do that it would be great so =
I
>>>> can dig in the code (I am not familiar with that code).
>>>>
>>>> Thx,
>>>>       Isaac
>>>
>>>
>>> Yesterday I did apply the patch (gatt: Remove support of ATT over
>>> BR/EDR) on bluez-5.41 (my current version) and passed it to the lab. I
>>> was waiting for their feedback but I did not get a reply yet, so just t=
o
>>> let you know that I get the patch and applied it.
>>> As I see it, that patch removed the support for ATT over BR/EDR, so I
>>> guess that another way to pass that test is modifying the firmware of
>>> the bluetooth chip to disable it at a hw level.
>>> And, in order to pass the other test case (BI-35-C), I will need to do
>>> not apply the mentioned patch and create a similar one for ATT over LE,
>>> or is there another way to accomplish /TP/GAR/CL/BI-35-C?
>>
>> Id assume you would not have to run those tests if ATT over BR/EDR is
>> not supported:
>>
>> 4.5.72 TP/GAR/CL/BI-35-C [Read Characteristic Value \u2013 Invalid
>> Transport Access over
>> LE]
>> Verify Generic Attribute Profile client behavior when an attempt to
>> use LE transport to execute
>> the Read Characteristic Value procedure on a characteristic contained
>> within a service defined
>> for use only over BR/EDR transport.
>>
>> Without BR/EDR there is no reason to run this test as all the
>> attributes should be valid.
>>
>
>
> Our product is dual so those tests are mandatory. Additionally, our
> product is 4.2, no 4.0.
> The patch you proposed (gatt: Remove support of ATT over BR/EDR) is not
> valid and will not work (if you want I can add details to the other
> thread) and it will break other tests needed for the certification. I
> would suggest to reject it.
> To put some light in tests BI-34-C and BI-35-C, it consists in define a
> characteristic only available through the transport layer LE or BR/EDR,
> so in one case the value can be read, and in the other case it is
> rejected. I can add more details if needed.

Im pretty sure it is possible since chrome OS has done it:

https://www.bluetooth.org/tpg/QLI_viewQDL.cfm?qid=3D22333

Though I can see the ATT over BR/EDR is in fact mandatory, the ICS says:

C.1: Mandatory IF (SUM ICS 12/2 =E2=80=9CBluetooth Basic Rate Core Host
Configuration=E2=80=9D OR SUM ICS 12/9
=E2=80=9CBluetooth Basic Rate and Low Energy Combined Core Host
Configuration=E2=80=9D) is supported,
otherwise Excluded.

> Currently the workaround that I am doing is record the type of
> connection (LE or BR/EDR) and return the error code for one specific
> characteristic (that I register in my gatt server application), so I
> customize my application. The lab did not confirm/dismiss it yet, but
> hopefully it is what they need.

Afaik any service not registered over SDP should not be available over
BR/EDR, which is perhaps why the current code only does expose GATT
and GAP service, nothing else. Now I haven't found anything
prohibiting GATT discovery to happen over BR/EDR, just exchange MTU,
but the SDP service already carries the handles which I assume is what
PTS uses given there are tests like:

4.4.15 TP/GAD/SR/BV-07-C [Discover Primary Services using SDP - from Server=
]

Anyway, the end result is that we cannot completely disable ATT over
BR/EDR, and might have to push the bearer details up to the
application.

Note that exposing the connected bearer is not enough in case a device
connects over both bearers the application will have no means to
distinguish in which bearer the command is coming from, this appears
to be a problem to Android HAL as well:

https://android.googlesource.com/platform/hardware/libhardware/+/master/inc=
lude/hardware/bt_gatt_server.h#71

So probably everyone is passing with a custom application which
detects, or asks the user input, when to return an error.

> Thanks for the support on this issue. Let me know if I can help in
> anything, if I need to provide more details, if you want a reply in the
> patch thread or any other stuff.
> Regards,
>    Isaac



--=20
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGXr9JEs_SUNBJhRqDoy90HqAkKs4NyamB4_q=qSNcLzyk8WsA@mail.gmail.com>
References: <CAGXr9JFjURuq0brgMGYYU+r_5XedXm4WgS_B-vKLZiWS4WKbrA@mail.gmail.com>
 <CABBYNZ+yMwgGN4+pv7dyog0P8LyME5zVz=RuD=sqXs6csYQBAQ@mail.gmail.com>
 <CAGXr9JHSmQs-wZenHAVCPqpe+jL8b5awywBQ-XtZtqYSVtmcpQ@mail.gmail.com>
 <CABBYNZ+cGzQcspVM0B3wbimsE5sjZS6t9Kk-TZ_qc324aO1Q2Q@mail.gmail.com>
 <CAGXr9JET_-mB1qtOryXpUMhQPTe_ecw84f4kFH+Wv9_WYp3iog@mail.gmail.com>
 <CAGXr9JGBGVy5P0BiGCer=RO4i9D_8qMabaSP0DufaTk3gx6Ryw@mail.gmail.com>
 <CABBYNZ+v7B6gkUZ-a=3maBUmFu-boOduiSDxvcyaJ=Y-HcktCQ@mail.gmail.com>
 <CABBYNZ+jYduJM-5j0tK7-TN0axQA_qdOfdrM+hZvm4_6raKK1g@mail.gmail.com> <CAGXr9JEs_SUNBJhRqDoy90HqAkKs4NyamB4_q=qSNcLzyk8WsA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 1 Dec 2016 10:21:56 +0200
Message-ID: <CABBYNZJNy918AqPxsp+Fm6-Sv7whX7nHGQZHHaroncw8jn6ecQ@mail.gmail.com>
Subject: Re: BlueZ 5.43: HoG peripheral services re-discovered again and again
 on every reconnect
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Thu, Dec 1, 2016 at 12:15 AM, Petri Gynther <pgynther@google.com> wrote:
> Hi Luiz,
>
> On Wed, Nov 30, 2016 at 1:37 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Petri,
>>
>> On Wed, Nov 30, 2016 at 10:36 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Petri,
>>>>
>>>> This primary services re-discovery on every reconnect is actually now
>>>> causing a problem for us.
>>>>
>>>> Basically, this is what happens:
>>>> 1. HoG remote control reconnects to BlueZ host for firmware update check.
>>>> 2. BlueZ starts re-discovering the services of the remote, but doesn't
>>>> yet complete it.
>>>> 3. The remote disconnects after being connected for 2 seconds (no
>>>> firmware update was available, so quickly disconnect to save battery).
>>>> 4. BlueZ declares the HoG remote "bad" since it couldn't complete step
>>>> (2). And then, BlueZ ends up removing the HoG remote services from its
>>>> GATT database completely.
>>>> 5. On the next reconnect attempt, the remote does not work. Re-pairing
>>>> is required.
>>>>
>>>> Obviously, this is bad for user experience. Therefore, I'm asking:
>>>> 1. Is there a way to avoid services re-discovery on every reconnect?
>>>> 2. If the remote control is successfully bonded previously, and BlueZ
>>>> experiences a problem during reconnect (services re-discovery), can we
>>>> avoid destroying the bonding and GATT info on BlueZ side? A failed
>>>> reconnect should not be a reason to remove a bonded device.
>>>
>>> The second point should definitely be fixed, but I wonder how the
>>> firmware update check does actually detects if the host is not doing
>>> something important before it decides it has to save power. Also if I
>>> recall this correctly dfu was exactly why some devices needed the
>>> database check, they boot in dfu mode which has a different database
>>> but they completely lost the state of service changed subscriptions so
>>> basically nothing works since all handles are invalid and even if
>>> service changed would work it would cause a rediscover anyway.
>>
>> Checking the code I did not find anything that could have break the
>> remote services, or perhaps it is the passive scanning/reconnection
>> logic that gets broken if we failed to discover the services?
>>
> 11/12,060343.698  bluez: bluetoothd[3980]: src/device.c:gatt_debug()
> Primary service discovery failed. ATT ECODE: 0x00

There is something wrong with your setup then, here it reconnect just fine:

https://paste.fedoraproject.org/494521/58036114/

But I do agree that we should not reset the db if that was populated
already, so I will try to fix that.

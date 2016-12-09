Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+LDafDDb9J--mg7EQ9bOY0DWHeDsZRrgOXCTEkBn4TESQK2Tw@mail.gmail.com>
References: <CAGXr9JFjURuq0brgMGYYU+r_5XedXm4WgS_B-vKLZiWS4WKbrA@mail.gmail.com>
 <CABBYNZ+yMwgGN4+pv7dyog0P8LyME5zVz=RuD=sqXs6csYQBAQ@mail.gmail.com>
 <CAGXr9JHSmQs-wZenHAVCPqpe+jL8b5awywBQ-XtZtqYSVtmcpQ@mail.gmail.com>
 <CABBYNZ+cGzQcspVM0B3wbimsE5sjZS6t9Kk-TZ_qc324aO1Q2Q@mail.gmail.com>
 <CAGXr9JET_-mB1qtOryXpUMhQPTe_ecw84f4kFH+Wv9_WYp3iog@mail.gmail.com>
 <CAGXr9JGBGVy5P0BiGCer=RO4i9D_8qMabaSP0DufaTk3gx6Ryw@mail.gmail.com>
 <CABBYNZ+v7B6gkUZ-a=3maBUmFu-boOduiSDxvcyaJ=Y-HcktCQ@mail.gmail.com>
 <CABBYNZ+jYduJM-5j0tK7-TN0axQA_qdOfdrM+hZvm4_6raKK1g@mail.gmail.com>
 <CAGXr9JEs_SUNBJhRqDoy90HqAkKs4NyamB4_q=qSNcLzyk8WsA@mail.gmail.com>
 <CABBYNZJNy918AqPxsp+Fm6-Sv7whX7nHGQZHHaroncw8jn6ecQ@mail.gmail.com>
 <CAGXr9JGXtwsMxfZd-VKNAtWa3M13oYBacxb7RW-skF5b7S1+1Q@mail.gmail.com>
 <CABBYNZKQ5nA2wr-9AeiGyBDoDiwdiABoTDLQtwv7cZgPMvBSWw@mail.gmail.com>
 <CAGXr9JGdZ_RezX45dqUNmeow--r+QnCQjc+4aggWu7m2uifKyw@mail.gmail.com> <CA+LDafDDb9J--mg7EQ9bOY0DWHeDsZRrgOXCTEkBn4TESQK2Tw@mail.gmail.com>
From: Petri Gynther <pgynther@google.com>
Date: Fri, 9 Dec 2016 09:38:54 -0800
Message-ID: <CAGXr9JE=i5u5XW=vNBQ4UXHrqCNKKj+J-SEztKtD35nV8dy73A@mail.gmail.com>
Subject: Re: BlueZ 5.43: HoG peripheral services re-discovered again and again
 on every reconnect
To: jose.bollo@iot.bzh
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jos=C3=A9,

On Fri, Dec 9, 2016 at 12:43 AM, Jos=C3=A9 Bollo <jose.bollo@iot.bzh> wrote=
:
> Hi Petri,
>
> This is perhaps related to the question I asked yesterday.
> Where can I find your 4 patches?
>

The patches are already applied on upstream BlueZ:
shared/gatt-client: Fix discover_primary_cb()
shared/gatt-client: Fix discover_secondary_cb()
shared/gatt-db: Make gatt_db_clear call gatt_db_clear_range
shared/gatt-client: Don't clear db in case of errors

> Best regards
> Jos=C3=A9 Bollo
> Jos=C3=A9 Bollo - Senior Software Engineer
> www.iot.bzh
>
>
>
> 2016-12-08 22:52 GMT+01:00 Petri Gynther <pgynther@google.com>:
>> Hi Luiz,
>>
>> On Fri, Dec 2, 2016 at 3:56 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Petri,
>>>
>>> On Thu, Dec 1, 2016 at 11:12 PM, Petri Gynther <pgynther@google.com> wr=
ote:
>>>> However, in this case, I think this handling is correct.
>>>> load_gatt_db() showed "No cache for LEFQAU", so BlueZ has to
>>>> re-discover everything from the device over BLE.
>>>> But, since the device disconnected in the middle of discovery, BlueZ
>>>> couldn't fully populate the GATT DB and has to clean it.
>>>> If the device didn't disconnect so quickly, this would have most likel=
y worked.
>>>>
>>>>> But I do agree that we should not reset the db if that was populated
>>>>> already, so I will try to fix that.
>>>>
>>>> Yes, once BlueZ does not reset the GATT DB on failed reconnects, this
>>>> problem will be solved.
>>>
>>> Please check if everything is alright when using upstream, it should
>>> clear the database anymore if we get an early disconnect.
>>
>> I applied my 2 patches and your 2 patches on top of 5.43.
>>
>> GATT DB is no longer destroyed on reconnection errors, so that's excelle=
nt.
>>
>> However, we are still seeing reconnect problems, but not GATT DB related=
:
>> bluez: bluetoothd[17780]:
>> src/gatt-client.c:btd_gatt_client_connected() Device connected.
>> bluez: bluetoothd[17780]: profiles/gap/gas.c:read_device_name_cb()
>> Reading device name failed with ATT error: 0
>> bluez: bluetoothd[17780]: profiles/gap/gas.c:read_appearance_cb()
>> Reading appearance failed with ATT error: 0
>> bluez: bluetoothd[17780]: Error reading PNP_ID value: Unexpected error c=
ode
>> bluez: bluetoothd[17780]: BATT level_read_char_cb failed: Request
>> attribute has encountered an unlikely error
>>
>> We are still investigating this. Likely a firmware issue on the remote.
>>
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

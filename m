Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGXr9JGXtwsMxfZd-VKNAtWa3M13oYBacxb7RW-skF5b7S1+1Q@mail.gmail.com>
References: <CAGXr9JFjURuq0brgMGYYU+r_5XedXm4WgS_B-vKLZiWS4WKbrA@mail.gmail.com>
 <CABBYNZ+yMwgGN4+pv7dyog0P8LyME5zVz=RuD=sqXs6csYQBAQ@mail.gmail.com>
 <CAGXr9JHSmQs-wZenHAVCPqpe+jL8b5awywBQ-XtZtqYSVtmcpQ@mail.gmail.com>
 <CABBYNZ+cGzQcspVM0B3wbimsE5sjZS6t9Kk-TZ_qc324aO1Q2Q@mail.gmail.com>
 <CAGXr9JET_-mB1qtOryXpUMhQPTe_ecw84f4kFH+Wv9_WYp3iog@mail.gmail.com>
 <CAGXr9JGBGVy5P0BiGCer=RO4i9D_8qMabaSP0DufaTk3gx6Ryw@mail.gmail.com>
 <CABBYNZ+v7B6gkUZ-a=3maBUmFu-boOduiSDxvcyaJ=Y-HcktCQ@mail.gmail.com>
 <CABBYNZ+jYduJM-5j0tK7-TN0axQA_qdOfdrM+hZvm4_6raKK1g@mail.gmail.com>
 <CAGXr9JEs_SUNBJhRqDoy90HqAkKs4NyamB4_q=qSNcLzyk8WsA@mail.gmail.com>
 <CABBYNZJNy918AqPxsp+Fm6-Sv7whX7nHGQZHHaroncw8jn6ecQ@mail.gmail.com> <CAGXr9JGXtwsMxfZd-VKNAtWa3M13oYBacxb7RW-skF5b7S1+1Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 2 Dec 2016 13:56:10 +0200
Message-ID: <CABBYNZKQ5nA2wr-9AeiGyBDoDiwdiABoTDLQtwv7cZgPMvBSWw@mail.gmail.com>
Subject: Re: BlueZ 5.43: HoG peripheral services re-discovered again and again
 on every reconnect
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Thu, Dec 1, 2016 at 11:12 PM, Petri Gynther <pgynther@google.com> wrote:
> However, in this case, I think this handling is correct.
> load_gatt_db() showed "No cache for LEFQAU", so BlueZ has to
> re-discover everything from the device over BLE.
> But, since the device disconnected in the middle of discovery, BlueZ
> couldn't fully populate the GATT DB and has to clean it.
> If the device didn't disconnect so quickly, this would have most likely worked.
>
>> But I do agree that we should not reset the db if that was populated
>> already, so I will try to fix that.
>
> Yes, once BlueZ does not reset the GATT DB on failed reconnects, this
> problem will be solved.

Please check if everything is alright when using upstream, it should
clear the database anymore if we get an early disconnect.


-- 
Luiz Augusto von Dentz

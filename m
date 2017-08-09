Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <521fe3ec-b1d8-1eda-183a-c2093568b7e3@cisco.com>
References: <20170809111859.10644-1-luiz.dentz@gmail.com> <521fe3ec-b1d8-1eda-183a-c2093568b7e3@cisco.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 9 Aug 2017 15:59:43 +0300
Message-ID: <CABBYNZJ5cF0Gy-8UBiCaD5P1B4rqbS8NWOQ2YwfYjKYckQBL3Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Fix crash when connecting ATT with BR/EDR
 only device
To: =?UTF-8?Q?Per_Waag=C3=B8?= <pwaago@cisco.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Per,

On Wed, Aug 9, 2017 at 3:17 PM, Per Waag=C3=B8 <pwaago@cisco.com> wrote:
> Hi Luiz,
>
>
> On 09. aug. 2017 13:18, Luiz Augusto von Dentz wrote:
>>
>> From: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
>>
>> The fix introduced in 006213cf4d231ce66de273e96619474bd516359b only
>> works for dual mode devices, if the device is BR/EDR the address type
>> would match the type on browsing_req so it still possible to crash.
>> ---
>>   src/device.c | 38 +++++++++++++++++++++++---------------
>>   1 file changed, 23 insertions(+), 15 deletions(-)
>
>
> I have tested the patch. I can't reproduce the crash anymore when it's in=
,
> so this solves the problem. Thank you!

Let check if it solves the crashes with other devices as well.


--=20
Luiz Augusto von Dentz

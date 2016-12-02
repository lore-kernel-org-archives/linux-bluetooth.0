Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+EGhkLiSogD4U_fDSHFt5bfW2haAiGP8Okv6TuddyW9Q@mail.gmail.com>
References: <1480623362-49499-1-git-send-email-pgynther@google.com> <CABBYNZ+EGhkLiSogD4U_fDSHFt5bfW2haAiGP8Okv6TuddyW9Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 2 Dec 2016 13:53:26 +0200
Message-ID: <CABBYNZ+ovpmccN2EPD7Py8aiDT3kOoqjjSz6ge7_L3+36BMw7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] shared/gatt-client: Fix discover_primary_cb()
To: Petri Gynther <pgynther@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Thu, Dec 1, 2016 at 10:46 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Petri,
>
> On Thu, Dec 1, 2016 at 10:16 PM, Petri Gynther <pgynther@google.com> wrote:
>> Fix the handling of primary services discovery failure.
>> ---
>>  src/shared/gatt-client.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> index 4386692..84145e7 100644
>> --- a/src/shared/gatt-client.c
>> +++ b/src/shared/gatt-client.c
>> @@ -1052,11 +1052,14 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
>>                                         "Primary service discovery failed."
>>                                         " ATT ECODE: 0x%02x", att_ecode);
>>                 /* Reset error in case of not found */
>> -               if (BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
>> +               switch (att_ecode) {
>> +               case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
>>                         success = true;
>>                         att_ecode = 0;
>> +                       goto secondary;
>> +               default:
>> +                       goto done;
>>                 }
>> -               goto secondary;
>>         }
>>
>>         if (!result || !bt_gatt_iter_init(&iter, result)) {
>> --
>> 2.8.0.rc3.226.g39d4020
>
> Looks like we had similar idea, although this is probably better as
> other errors shall be cause the discovery to be interrupted.

Applied, thanks

-- 
Luiz Augusto von Dentz

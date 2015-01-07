Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001501d02a60$02573100$07059300$@samsung.com>
References: <1418997054-16603-1-git-send-email-gowtham.ab@samsung.com>
	<001501d02a60$02573100$07059300$@samsung.com>
Date: Wed, 7 Jan 2015 11:34:39 -0200
Message-ID: <CABBYNZLGobEPvhakFL9Rpt-F9vedmXXVY0BD+B5oCPcxG_zVeA@mail.gmail.com>
Subject: Re: [PATCH] profiles/hog: Remove dead code
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jan 7, 2015 at 7:55 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Ping.
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
>> Sent: Friday, December 19, 2014 7:21 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: d.kasatkin@samsung.com; bharat.panda@samsung.com;
>> cpgs@samsung.com; Gowtham Anandha Babu
>> Subject: [PATCH] profiles/hog: Remove dead code
>>
>> warning: Value stored to 'attrib' is never read
>>               attrib = report->hogdev->attrib;
>>               ^        ~~~~~~~~~~~~~~~~~~~~~~
>> ---
>>  profiles/input/hog.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/profiles/input/hog.c b/profiles/input/hog.c index
>> fb51663..74351f3 100644
>> --- a/profiles/input/hog.c
>> +++ b/profiles/input/hog.c
>> @@ -221,7 +221,6 @@ static void discover_descriptor_cb(uint8_t status,
>> GSList *descs,
>>               switch (desc->uuid16) {
>>               case GATT_CLIENT_CHARAC_CFG_UUID:
>>                       report = user_data;
>> -                     attrib = report->hogdev->attrib;
>>                       write_ccc(desc->handle, report);
>>                       break;
>>               case GATT_REPORT_REFERENCE:
>> --
>> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz

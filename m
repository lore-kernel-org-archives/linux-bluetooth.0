Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <006b01d04789$306a5130$913ef390$@samsung.com>
References: <1411474757-22719-1-git-send-email-bharat.panda@samsung.com>
	<006b01d04789$306a5130$913ef390$@samsung.com>
Date: Fri, 13 Feb 2015 16:49:41 +0200
Message-ID: <CABBYNZL2+0ddP-fpzaCABHWOrQJHs2KToiavG_LWJNPBDn9QZQ@mail.gmail.com>
Subject: Re: [PATCH ] attrib: Fix condition check for attr delete
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Bhusan Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Fri, Feb 13, 2015 at 2:32 PM, Bharat Bhusan Panda
<bharat.panda@samsung.com> wrote:
> Ping
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Bharat Panda
>> Sent: Tuesday, September 23, 2014 5:49 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: cpgs@samsung.com; Bharat Panda
>> Subject: [PATCH ] attrib: Fix condition check for attr delete
>>
>> Checks handle value for non-zero as well as >= 0xffff, to avoid infinite
> loop
>> and deletion of unspecified attrib handles.
>> ---
>>  attrib/gatt-service.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c index
> 874552b..bcf360e
>> 100644
>> --- a/attrib/gatt-service.c
>> +++ b/attrib/gatt-service.c
>> @@ -295,7 +295,12 @@ static void service_attr_del(struct btd_adapter
>> *adapter, uint16_t start_handle,  {
>>       uint16_t handle;
>>
>> -     for (handle = start_handle; handle <= end_handle; handle++)
>> +     /* For a 128-bit category primary service below handle should be
>> checked
>> +      * for both non-zero as well as >= 0xffff. As on last iteration the
>> handle
>> +      * will turn to 0 from 0xffff and loop will be infinite.
>> +      */
>> +
>> +     for (handle = start_handle; (handle != 0 && handle <= end_handle);
>> +handle++)
>>               if (attrib_db_del(adapter, handle) < 0)
>>                       error("Can't delete handle 0x%04x", handle);  }
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html

Applied after fixing the coding style, thanks.


-- 
Luiz Augusto von Dentz

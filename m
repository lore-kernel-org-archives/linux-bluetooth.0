Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <8FC80CB5-4A7C-4F53-BFF6-7B679F21F3C4@holtmann.org>
References: <20170718164627.20114-1-luiz.dentz@gmail.com> <20170718164627.20114-3-luiz.dentz@gmail.com>
 <8FC80CB5-4A7C-4F53-BFF6-7B679F21F3C4@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Jul 2017 09:49:52 +0300
Message-ID: <CABBYNZ+FtXJSs7DFEy1pYVk90Ufui8444jE15y5PbWmzwQF3Fw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/7] monitor: Filter duplicated advertisements
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jul 18, 2017 at 10:04 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> This reduces the verbosity and give a precise picture of how unique
>> each report is.
>> ---
>> monitor/intel.c  |  28 +++---
>> monitor/packet.c | 277 ++++++++++++++++++++++++++++++++++++-------------------
>> monitor/vendor.h |   2 +-
>> 3 files changed, 198 insertions(+), 109 deletions(-)
>>
>> diff --git a/monitor/intel.c b/monitor/intel.c
>> index 1ca9a95..9da188a 100644
>> --- a/monitor/intel.c
>> +++ b/monitor/intel.c
>> @@ -499,11 +499,11 @@ const struct vendor_ocf *intel_vendor_ocf(uint16_t ocf)
>>       return NULL;
>> }
>>
>> -static void startup_evt(const void *data, uint8_t size)
>> +static void startup_evt(uint8_t index, const void *data, uint8_t size)
>> {
>> }
>
> NAK. I avoid this and want to keep avoiding it. There are different ways to get the actual index number if you need it. And also FYI, the index is a uint16_t.

I haven't figure out any other way to pass down the index number, or
do you want some like l2cap_frame so it can carry information such as
the index.

-- 
Luiz Augusto von Dentz

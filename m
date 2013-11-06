Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20131106080254.GA15573@x220.p-661hnu-f1>
References: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
	<1383657700-22313-5-git-send-email-marcin.kraglak@tieto.com>
	<20131106080254.GA15573@x220.p-661hnu-f1>
Date: Wed, 6 Nov 2013 09:27:11 +0100
Message-ID: <CABD6X-JvkNLMMgO_SZBybxu3_GdisVGrZxhHWyn6eHgsWr7AaQ@mail.gmail.com>
Subject: Re: [PATCHv2 4/6] android: Add supported uuids when adapter is initialized
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As I remember we agreed to have dynamic sdp records and static list of
uuids (to have correct service hint in class of device). Bluedroid
sets service hint once, and send new adapter uuids when specific
services starts (for example when you init hidhost,
adapter_property_callback will return with new uuid). But it doesn't
matter if you add them at start of bluetooth interface or specific
profile init - it happens at the same time. I've also checked if uuids
are removed when profiles are cleaned - and bluedroid doesn't remove
uuids which were added at start.

On 6 November 2013 09:02, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Marcin,
>
> On Tue, Nov 05, 2013, Marcin Kraglak wrote:
>> It will set class of device with proper service hints.
>> We set it statically because we want to keep code simple.
>>
>> ---
>>  android/adapter.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>
> I've applied patches 1-3, but am a bit confused about this one.
>
>> diff --git a/android/adapter.c b/android/adapter.c
>> index 0f24cac..70b9265 100644
>> --- a/android/adapter.c
>> +++ b/android/adapter.c
>> @@ -52,6 +52,29 @@ static GIOChannel *notification_io = NULL;
>>  /* This list contains addresses which are asked for records */
>>  static GSList *browse_reqs;
>>
>> +/*
>> + * This is an array of supported uuids and service hints. We add them via mgmt
>> + * interface when adapter is initialized. Uuids are in reverse orded.
>> + */
>> +static const struct mgmt_cp_add_uuid supported_services[] = {
>> +     /* OBEX_OPP_UUID */
>> +     { .uuid = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
>> +                     0x00, 0x10, 0x00, 0x00, 0x05, 0x11, 0x00, 0x00 },
>> +     .svc_hint = 0x10 },
>> +     /* HFP_AG_UUID */
>> +     { .uuid = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
>> +                     0x00, 0x10, 0x00, 0x00, 0x1f, 0x11, 0x00, 0x00 },
>> +     .svc_hint = 0x40 },
>> +     /* ADVANCED_AUDIO_UUID */
>> +     { .uuid = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
>> +                     0x00, 0x10, 0x00, 0x00, 0x0d, 0x11, 0x00, 0x00 },
>> +     .svc_hint = 0x08 },
>> +     /* PANU_UUID */
>> +     { .uuid = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
>> +                     0x00, 0x10, 0x00, 0x00, 0x15, 0x11, 0x00, 0x00 },
>> +     .svc_hint = 0x02 }
>> +};
>
> I seem to remember the discussion around this drifting back to doing the
> registration dynamically. Do I remember wrong? Wasn't it so that at
> least some UUIDs (such as PAN) with a bluedroid based system only appear
> when you actually enable support for the profile in the UI?
>
> Johan

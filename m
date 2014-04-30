Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140429081609.GJ21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1398734107-4793-34-git-send-email-lukasz.rymanowski@tieto.com>
	<20140429081609.GJ21742@t440s.lan>
Date: Wed, 30 Apr 2014 11:14:42 +0200
Message-ID: <CAN_7+YZHAdxyP5Y0o4+HzMO9QZaAaXtr_WBcLGd7ukuZQ5QM4A@mail.gmail.com>
Subject: Re: [PATCH 32/36] android/gatt: Add write callback to server
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 29, 2014 at 10:16 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
>> Write callback is now attached to characteristics and descriptors
>> registered by Android app.
>>
>> Transaction id is generated and stored in gatt_app together with request
>> data(device ptr, cmd opcode etc).
>> ---
>>  android/gatt.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 100 insertions(+), 2 deletions(-)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index 2eb5b18..09eae80 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -82,6 +82,10 @@ struct gatt_app {
>>
>>       /* Valid for client applications */
>>       struct queue *notifications;
>> +
>> +     /* Transaction data valid for server application */
>> +     int32_t pend_trans_id;
>
> Could we please be consistent with async operation id types. I.e. use an
> unsigned int here.
>

This one handled in v4

> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Lukasz

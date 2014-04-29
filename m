Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140429080504.GD21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1398734107-4793-15-git-send-email-lukasz.rymanowski@tieto.com>
	<20140429080504.GD21742@t440s.lan>
Date: Tue, 29 Apr 2014 13:15:04 +0200
Message-ID: <CAN_7+YbGTOZMDBO3MagkKyZ7UOqV2FcBMO0gFsuE_fGzzLQ9ew@mail.gmail.com>
Subject: Re: [PATCH 13/36] android/gatt: Add register GAP Service
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 29, 2014 at 10:05 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
>> Register GAP service with device name characteristic,
>> appearance and peripheral privacy flag
>> ---
>>  android/gatt.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 96 insertions(+)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index 5ca22e2..d2b1684 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -161,6 +161,8 @@ static struct gatt_db *gatt_db = NULL;
>>
>>  static GIOChannel *listening_sk = NULL;
>>
>> +static char device_name[249] = "BlueZ for Android";
>
> Shouldn't this be hooked up to adapter.name in android/bluetooth.c?
Yes, forgot to add todo but actually will do it now.
>
>> +struct gap_srvc_handles {
>> +     uint16_t srvc;
>> +
>> +     /*Characteristics */
>
> Space after /*
fix in v2
>
>> +     if (handle == gap_srvc_data.dev_name) {
>> +             len = enc_read_resp((uint8_t *)&device_name[0],
>
> Space after typecast (our user space coding style convention).
Not valid in v2 anymore
>
>> +static void register_gap_service(void)
>> +{
>> +     bt_uuid_t uuid;
>> +
>> +     /*GAP UUID */
>
> Space after /*

fix in v2
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
Lukasz

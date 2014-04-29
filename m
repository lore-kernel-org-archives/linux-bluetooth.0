Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140429080842.GE21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1398734107-4793-17-git-send-email-lukasz.rymanowski@tieto.com>
	<20140429080842.GE21742@t440s.lan>
Date: Tue, 29 Apr 2014 13:35:30 +0200
Message-ID: <CAN_7+YYcFkntSjygsuN9t24iZ-iBKNTqEsRyCd5L++ikxat+wA@mail.gmail.com>
Subject: Re: [PATCH 15/36] android/gatt: Register device information service
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>,
	Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 29, 2014 at 10:08 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
>> This adds placeholder data to device information service. To get
>> real data we should figure out the best way to get Android's system
>> properties and expose them to profiles for reading.
>> ---
>>  android/gatt.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index d2b1684..2ad5936 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -3811,6 +3811,95 @@ static void register_gap_service(void)
>>
>>       gatt_db_service_set_active(gatt_db, gap_srvc_data.srvc , true);
>>  }
>> +
>> +/* TODO: Figure out the best way for this to be not hard coded. */
>> +static struct device_info {
>> +     const char *manufacturer_name;
>> +     const char *system_id;
>> +     const char *model_number;
>> +     const char *serial_number;
>> +     const char *firmware_rev;
>> +     const char *hardware_rev;
>> +     const char *software_rev;
>> +} device_info = {
>> +     .manufacturer_name =    "BlueZ",
>> +     .system_id =            "BlueZ for Android",
>> +     .model_number =         "model no",
>> +     .serial_number =        "serial no",
>> +     .firmware_rev =         "firmware rev",
>> +     .hardware_rev =         "hardware rev",
>> +     .software_rev =         "software rev",
>> +};
>
> Again, you'll want to hook up at least some of these, like the system_id
> to information from android/bluetooth.c

We will handle it later on when adding customisation.
For now will put better todo comment .

>
>> +     bt_uuid16_create(&uuid, GATT_CHARAC_SYSTEM_ID);
>> +     gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
>> +                                     GATT_CHR_PROP_READ,
>> +                                     device_info_read_cb, NULL,
>> +                                     (void *)device_info.system_id);
>> +
>> +     bt_uuid16_create(&uuid, GATT_CHARAC_MODEL_NUMBER_STRING);
>> +     gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
>> +                                     GATT_CHR_PROP_READ,
>> +                                     device_info_read_cb, NULL,
>> +                                     (void *)device_info.model_number);
>> +
>> +     bt_uuid16_create(&uuid, GATT_CHARAC_SERIAL_NUMBER_STRING);
>> +     gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
>> +                                     GATT_CHR_PROP_READ,
>> +                                     device_info_read_cb, NULL,
>> +                                     (void *)device_info.serial_number);
>> +
>> +     bt_uuid16_create(&uuid, GATT_CHARAC_FIRMWARE_REVISION_STRING);
>> +     gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
>> +                                     GATT_CHR_PROP_READ,
>> +                                     device_info_read_cb, NULL,
>> +                                     (void *)device_info.firmware_rev);
>> +
>> +     bt_uuid16_create(&uuid, GATT_CHARAC_HARDWARE_REVISION_STRING);
>> +     gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
>> +                                     GATT_CHR_PROP_READ,
>> +                                     device_info_read_cb, NULL,
>> +                                     (void *) device_info.hardware_rev);
>> +
>> +     bt_uuid16_create(&uuid, GATT_CHARAC_SOFTWARE_REVISION_STRING);
>> +     gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
>> +                                     GATT_CHR_PROP_READ,
>> +                                     device_info_read_cb, NULL,
>> +                                     (void *) device_info.software_rev);
>> +
>> +     bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
>> +     gatt_db_add_characteristic(gatt_db, srvc_handle, &uuid, 0,
>> +                                     GATT_CHR_PROP_READ,
>> +                                     device_info_read_cb, NULL,
>> +                                     (void *)device_info.manufacturer_name);
>
> Space after all of the (void *) type casts here.

Fix in v2. BTW checkpatch did confusion :).

> You'll also probably
> want to add a comment why it's needed, i.e. because these variables are
> const while the user_data parameter is not.

fix in v2
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
\Łukasz

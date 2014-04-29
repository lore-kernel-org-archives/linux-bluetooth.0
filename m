Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140429081228.GG21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1398734107-4793-24-git-send-email-lukasz.rymanowski@tieto.com>
	<20140429081228.GG21742@t440s.lan>
Date: Tue, 29 Apr 2014 13:37:36 +0200
Message-ID: <CAN_7+YZvYs+OVcRUBrOrs8amewvY0Bn5wH-pkCMQnryEsC5C9w@mail.gmail.com>
Subject: Re: [PATCH 22/36] android/gatt: Add support for ATT read by type
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>,
	Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 29, 2014 at 10:12 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
>> +static void copy_to_att_list_type(void *data, void *user_data)
>> +{
>> +     struct copy_att_list_data *l = user_data;
>> +     struct gatt_db_handle_value *hdl_val = data;
>> +     uint8_t *value;
>> +
>> +     value = (void *)l->adl->data[l->iterator++];
>
> Same thing here with the type cast.

fix in v2
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
Łukasz

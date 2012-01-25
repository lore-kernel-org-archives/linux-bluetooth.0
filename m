Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OK8Xg-BaJsYzJRZP46fQN4vDTTZO6vo9dFMNpwbeHozw@mail.gmail.com>
References: <1327485790-26249-1-git-send-email-sancane@gmail.com>
	<1327485790-26249-2-git-send-email-sancane@gmail.com>
	<1327485790-26249-3-git-send-email-sancane@gmail.com>
	<1327485790-26249-4-git-send-email-sancane@gmail.com>
	<CAJdJm_OK8Xg-BaJsYzJRZP46fQN4vDTTZO6vo9dFMNpwbeHozw@mail.gmail.com>
Date: Wed, 25 Jan 2012 12:42:48 +0100
Message-ID: <CACLukzK-XxdZmu+yR4D94kfg5B9-Fvw1sv9LrPWoD7s5Bb-7Mg@mail.gmail.com>
Subject: Re: [PATCH 3/8] gatt-service: Provide service uuid in
 attrib_db_find_avail function
From: Santiago Carot <sancane@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

2012/1/25 Anderson Lizardo <anderson.lizardo@openbossa.org>:
> Hi Santiago,
>
> On Wed, Jan 25, 2012 at 6:03 AM, Santiago Carot-Nemesio
> <sancane@gmail.com> wrote:
>> @@ -436,8 +440,8 @@ static void register_weight_service(struct gatt_example_adapter *adapter,
>>        int len;
>>
>>        btoh128(&char_weight_uuid_btorder, &char_weight_uuid);
>> -
>> -       start_handle = attrib_db_find_avail(adapter->adapter, svc_size);
>> +       bt_uuid128_create(&uuid, prim_weight_uuid_btorder);
>> +       start_handle = attrib_db_find_avail(adapter->adapter, &uuid, svc_size);
>>        if (start_handle == 0) {
>>                error("Not enough free handles to register service");
>>                return;
>
> This is still not right. bt_uuid128_create() should receive a
> uint128_t in *host* order. In other words, you need to do:
>
> uint128_t prim_weight_uuid;
> ...
> btoh128(&prim_weight_uuid_btorder, &prim_weight_uuid);
> bt_uuid128_create(&uuid, prim_weight_uuid);
> ...

Ok, I see, I'm going to send a new set fixing that.
Regards.

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <C58178E2-35CE-4076-96B1-542D3EE15C15@holtmann.org>
References: <1406758441-10335-1-git-send-email-armansito@chromium.org>
	<C58178E2-35CE-4076-96B1-542D3EE15C15@holtmann.org>
Date: Wed, 30 Jul 2014 15:48:19 -0700
Message-ID: <CAHrH25RxrdcP0S4+vQw5=YfRnUCf+aW9t9KEeTGL8r98-FeUmw@mail.gmail.com>
Subject: Re: [PATCH v1] shared/gatt: Use iterator based discovery result structure.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> patch has been applied.
>

Thanks!

>> +bool bt_gatt_iter_init(struct bt_gatt_iter *iter, struct bt_gatt_result *result);
>> +bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
>> +                                     struct bt_gatt_service *service);
>
> One option here is to not bother with the interim struct bt_gatt_service. Especially since I think we will need that actually for an higher abstraction at some point.
>
>         bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
>                                         uint16_t *start_handle,
>                                         uint16_t *end_handle,
>                                         uint8_t *uuid[16]);
>

That makes sense. I think as bt_gatt_client starts taking shape I will
know what to do about these.


>> +typedef void (*bt_gatt_discovery_callback_t)(bool success, uint8_t att_code,
>> +                                             struct bt_gatt_result *result,
>>                                               void *user_data);
>
> It might be a good idea to shrink this to results + user_data. We could retrieve the ATT error code and general success status from bt_gatt_result pointer we give the callback function.
>

I'm fine with this idea, then again it's nice to be overall consistent
with the other callbacks. I don't know if we'd want to perhaps
generalize bt_gatt_result to contain more than just discovery results
(I kind of like the raw pointer for long value reads for instance).


Cheers,
Arman

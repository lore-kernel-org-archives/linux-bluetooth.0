Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000801d0477f$1a2adde0$4e8099a0$@samsung.com>
References: <1423226839-23935-1-git-send-email-gowtham.ab@samsung.com>
	<000801d0477f$1a2adde0$4e8099a0$@samsung.com>
Date: Fri, 13 Feb 2015 14:53:54 +0200
Message-ID: <CABBYNZJDKOSmrJ0iaPm3ZRBYTeJYR=e=RP8+YTZcBc9yA62xCA@mail.gmail.com>
Subject: Re: [PATCH] gatt-server: Fix mutlpile definition of same func
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Fri, Feb 13, 2015 at 1:20 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Ping.
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
>> Sent: Friday, February 06, 2015 6:17 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham Anandha
>> Babu
>> Subject: [PATCH] gatt-server: Fix mutlpile definition of same func
>>
>> Removed 'put_uuid_le' func from gatt-server, which was already defined in
>> gatt-helpers.
>> ---
>>  src/shared/gatt-helpers.c |  2 +-
>>  src/shared/gatt-helpers.h |  2 ++
>>  src/shared/gatt-server.c  | 21 ---------------------
>>  3 files changed, 3 insertions(+), 22 deletions(-)
>>
>> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c index
>> a33f960..6dfc24f 100644
>> --- a/src/shared/gatt-helpers.c
>> +++ b/src/shared/gatt-helpers.c
>> @@ -567,7 +567,7 @@ bool bt_gatt_exchange_mtu(struct bt_att *att,
>> uint16_t client_rx_mtu,
>>       return true;
>>  }
>>
>> -static void put_uuid_le(const bt_uuid_t *src, void *dst)
>> +void put_uuid_le(const bt_uuid_t *src, void *dst)
>>  {
>>       bt_uuid_t uuid;
>>
>> diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h index
>> 0217e82..7a2076b 100644
>> --- a/src/shared/gatt-helpers.h
>> +++ b/src/shared/gatt-helpers.h
>> @@ -105,3 +105,5 @@ bool bt_gatt_read_by_type(struct bt_att *att,
>> uint16_t start, uint16_t end,
>>                                       bt_gatt_discovery_callback_t
>> callback,
>>                                       void *user_data,
>>                                       bt_gatt_destroy_func_t destroy);
>> +
>> +void put_uuid_le(const bt_uuid_t *src, void *dst);
>> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c index
>> 8f7b5cd..0652d3d 100644
>> --- a/src/shared/gatt-server.c
>> +++ b/src/shared/gatt-server.c
>> @@ -499,27 +499,6 @@ error:
>>       queue_destroy(q, NULL);
>>  }
>>
>> -static void put_uuid_le(const bt_uuid_t *src, void *dst) -{
>> -     bt_uuid_t uuid;
>> -
>> -     switch (src->type) {
>> -     case BT_UUID16:
>> -             put_le16(src->value.u16, dst);
>> -             break;
>> -     case BT_UUID128:
>> -             bswap_128(&src->value.u128, dst);
>> -             break;
>> -     case BT_UUID32:
>> -             bt_uuid_to_uuid128(src, &uuid);
>> -             bswap_128(&uuid.value.u128, dst);
>> -             break;
>> -     case BT_UUID_UNSPEC:
>> -     default:
>> -             break;
>> -     }
>> -}
>> -
>>  static bool encode_find_info_rsp(struct gatt_db *db, struct queue *q,
>>                                               uint16_t mtu,
>>                                               uint8_t *pdu, uint16_t *len)
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html

Pushed, thansl


-- 
Luiz Augusto von Dentz

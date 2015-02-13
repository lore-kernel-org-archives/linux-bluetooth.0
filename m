Return-Path: <cyrus@holtmann.org>
Message-ID: <54DDFB4B.1050407@tieto.com>
Date: Fri, 13 Feb 2015 14:25:31 +0100
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 10/10] android/gatt: Avoid copying pointers in matching
 functions
References: <1423665248-5121-1-git-send-email-jakub.tyszkowski@tieto.com> <1423665248-5121-10-git-send-email-jakub.tyszkowski@tieto.com> <5088455.trWqmuhi6p@uw000953>
In-Reply-To: <5088455.trWqmuhi6p@uw000953>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 13.02.2015 12:48, Szymon Janc wrote:
> Hi Jakub,
>
> On Wednesday 11 of February 2015 15:34:08 Jakub Tyszkowski wrote:
>> This removes casting void* to struct pointers when there is no need to
>> do so (pointer comparison).
>> ---
>>   android/gatt.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/android/gatt.c b/android/gatt.c
>> index cd0825a..3076a02 100644
>> --- a/android/gatt.c
>> +++ b/android/gatt.c
>> @@ -350,9 +350,8 @@ static struct gatt_app *find_app_by_id(int32_t id)
>>   static bool match_device_by_bdaddr(const void *data, const void *user_data)
>>   {
>>   	const struct gatt_device *dev = data;
>> -	const bdaddr_t *addr = user_data;
>>
>> -	return !bacmp(&dev->bdaddr, addr);
>> +	return !bacmp(&dev->bdaddr, user_data);
>>   }
>>
>>   static bool match_device_by_state(const void *data, const void *user_data)
>> @@ -408,17 +407,15 @@ static struct app_connection *find_connection_by_id(int32_t conn_id)
>>   static bool match_connection_by_device(const void *data, const void *user_data)
>>   {
>>   	const struct app_connection *conn = data;
>> -	const struct gatt_device *dev = user_data;
>>
>> -	return conn->device == dev;
>> +	return conn->device == user_data;
>>   }
>>
>>   static bool match_connection_by_app(const void *data, const void *user_data)
>>   {
>>   	const struct app_connection *conn = data;
>> -	const struct gatt_app *app = user_data;
>>
>> -	return conn->app == app;
>> +	return conn->app == user_data;
>>   }
>>
>>   static struct gatt_device *find_device_by_addr(const bdaddr_t *addr)
>> @@ -469,9 +466,8 @@ static bool match_srvc_by_bt_uuid(const void *data, const void *user_data)
>>   static bool match_srvc_by_range(const void *data, const void *user_data)
>>   {
>>   	const struct service *srvc = data;
>> -	const struct att_range *range = user_data;
>>
>> -	return !memcmp(&srvc->prim.range, range, sizeof(srvc->prim.range));
>> +	return !memcmp(&srvc->prim.range, user_data, sizeof(srvc->prim.range));
>>   }
>>
>>   static bool match_char_by_higher_inst_id(const void *data,
>
> I prefer to have those as is so that one can easily see what the userdata
> is expected to be. And compiler will most likely optimize those assignments
> anyway.
>

Ok.

BR,
Jakub



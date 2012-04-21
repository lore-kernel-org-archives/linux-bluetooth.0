Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_N+pi8sWSPtSv+G9LmWg0bNEXgEK+LKxn8F0wv8ygoj7Q@mail.gmail.com>
References: <1334836112-25482-1-git-send-email-hemant.gupta@stericsson.com>
	<CAJdJm_N+pi8sWSPtSv+G9LmWg0bNEXgEK+LKxn8F0wv8ygoj7Q@mail.gmail.com>
Date: Sat, 21 Apr 2012 13:47:06 +0530
Message-ID: <CACj007mpjMuUe-q5DioAQJFhUM8mpzWXU93S111NOq075u_QZQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Store LE device address type with primary list
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Fri, Apr 20, 2012 at 11:09 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Hemant,
>
> On Thu, Apr 19, 2012 at 7:48 AM, Hemant Gupta
> <hemant.gupta@stericsson.com> wrote:
>> @@ -1920,13 +1920,17 @@ static void create_stored_device_from_primary(char *key, char *value,
>>        struct btd_adapter *adapter = user_data;
>>        struct btd_device *device;
>>        GSList *services, *uuids, *l;
>> +       addr_type_t addr_type;
>>
>>        if (g_slist_find_custom(adapter->devices,
>>                        key, (GCompareFunc) device_address_cmp))
>>                return;
>>
>> -       /* FIXME: Get the correct LE addr type (public/random) */
>> -       device = device_create(connection, adapter, key, ADDR_TYPE_LE_PUBLIC);
>> +       sscanf(value, "%d ", &addr_type);
>> +       /* Increment by 2 (address type and space) */
>> +       value += 2;
>
> I think it is a good idea to check for sscanf() return and if it
> fails, assume addr_type as ADDR_TYPE_LE_PUBLIC the value as primary
> data only. Remember that the system may have previously stored primary
> data in the old format.
>
Thanks, will update this in next patch.

>> +
>> +       device = device_create(connection, adapter, key, addr_type);
>>        if (!device)
>>                return;
>>
>
>
> Are you planning to add support for other address types in BlueZ GATT
> server? It would be nice if you could share your plans on this topic.

For the moment no. I was testing with Nordic device which has random
device address
type, and found this issue when trying to connect to nordic device
again after rebooting
our device. Since BlueZ creates the stored device from primary and was
taking address
type as Public, reconnection was not possible.

>
> Best Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Hemant Gupta
ST-Ericsson India

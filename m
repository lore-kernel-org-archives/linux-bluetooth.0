Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECBE15484
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oQy+byo0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704972612;
	bh=e8f64Uo0cW+y1Xmq572kSyBDIAvRQL0mkC+gpr4bsaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oQy+byo0nfv6Wt9VSwuKjYb7kni8fq9hoe7GUtLJ0da7M87wgTjVfXvlefPJv027C
	 gqKHmxsdFfhLYt6sjPkFSrOlrhNmqZOLdC6Hj42/SAaefrn20HycK88v7jk1vGBAgv
	 MluBjAgg6sfLtr0d81T2Hm7YbsFZD/VIrFazW/YV4EwauP2DFtHoSrnWT3qBOYg44e
	 wMPhMeUCIhpKH5zj3tsLxDwRcdnC06tAZBQ3kRze+PY428lq1/aKAh4+oBWldLwgC4
	 xywxHu/whaMkfAi0KvXX9W0hMEAsdKIflk6quOrYofEYtYvGtR3UXui5mXyRfB5mni
	 PY/difzA1xKBQ==
Received: from [100.72.96.248] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 809653781182;
	Thu, 11 Jan 2024 11:30:12 +0000 (UTC)
Message-ID: <41a872ab-52d6-4387-97e7-eae215592fac@collabora.com>
Date: Thu, 11 Jan 2024 12:30:11 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v3] shared/gatt-db: Fix munmap_chunk invalid pointer
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240105123404.151860-1-frederic.danis@collabora.com>
 <CABBYNZ+xUJ=XJOzOtq0inJmKA_MwxGaYokWqpDBjgBcmNc5koA@mail.gmail.com>
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZ+xUJ=XJOzOtq0inJmKA_MwxGaYokWqpDBjgBcmNc5koA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 05/01/2024 16:08, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Fri, Jan 5, 2024 at 7:34 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> PTS test GATT/CL/GAD/BV-03-C published a service starting at handle 0xfffd
>> and ending at 0xffff.
>> This resets the next_handle to 0 in gatt_db_insert_service() instead of
>> setting it to 0x10000. Other services are added later.
>> This could end-up by a crash in db_hash_update() if not enough space has
>> been allocated for hash.iov and some entries are overwritten.
>> ---
>> v1 -> v2: Replace next_handle by last_handle
>>            Check empty db using gatt_db_isempty(db) instead of
>>              next_handle == 0
>>            Add robustness unit test to check that gatt_db_get_hash()
>>              doesn't crash
>> v2 -> v3: Fix line length checkpatch errors
>> ---
>>   src/shared/gatt-db.c | 19 ++++++-----
>>   unit/test-gatt.c     | 80 +++++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 89 insertions(+), 10 deletions(-)
>>
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index 676f963ec..9559583d1 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -58,7 +58,7 @@ struct gatt_db {
>>          struct bt_crypto *crypto;
>>          uint8_t hash[16];
>>          unsigned int hash_id;
>> -       uint16_t next_handle;
>> +       uint16_t last_handle;
> Don't we have the last_handle already by doing queue_peek_tail, etc
> and look into the database? Perhaps we want to avoid this sort of
> lookup though, but I'd leave a comment in that case.

Ok, I will add a comment about it in the commit message.

>>          struct queue *services;
>>
>>          struct queue *notify_list;
>> @@ -255,7 +255,7 @@ struct gatt_db *gatt_db_new(void)
>>          db->crypto = bt_crypto_new();
>>          db->services = queue_new();
>>          db->notify_list = queue_new();
>> -       db->next_handle = 0x0001;
>> +       db->last_handle = 0x0000;
>>
>>          return gatt_db_ref(db);
>>   }
>> @@ -356,14 +356,15 @@ static bool db_hash_update(void *user_data)
>>
>>          db->hash_id = 0;
>>
>> -       if (!db->next_handle)
>> +       if (gatt_db_isempty(db))
>>                  return false;
>>
>> -       hash.iov = new0(struct iovec, db->next_handle);
>> +       hash.iov = new0(struct iovec, db->last_handle + 1);
>>          hash.i = 0;
>>
>>          gatt_db_foreach_service(db, NULL, service_gen_hash_m, &hash);
>> -       bt_crypto_gatt_hash(db->crypto, hash.iov, db->next_handle, db->hash);
>> +       bt_crypto_gatt_hash(db->crypto, hash.iov, db->last_handle + 1,
>> +                               db->hash);
>>
>>          for (i = 0; i < hash.i; i++)
>>                  free(hash.iov[i].iov_base);
>> @@ -624,7 +625,7 @@ bool gatt_db_clear_range(struct gatt_db *db, uint16_t start_handle,
>>
>>   done:
>>          if (gatt_db_isempty(db))
>> -               db->next_handle = 0;
>> +               db->last_handle = 0;
>>
>>          return true;
>>   }
>> @@ -700,7 +701,7 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
>>                  return NULL;
>>
>>          if (!handle)
>> -               handle = db->next_handle;
>> +               handle = db->last_handle + 1;
>>
>>          if (num_handles < 1 || (handle + num_handles - 1) > UINT16_MAX)
>>                  return NULL;
>> @@ -747,8 +748,8 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
>>          service->attributes[0]->handle = handle;
>>          service->num_handles = num_handles;
>>
>> -       /* Fast-forward next_handle if the new service was added to the end */
>> -       db->next_handle = MAX(handle + num_handles, db->next_handle);
>> +       /* Fast-forward last_handle if the new service was added to the end */
>> +       db->last_handle = MAX(handle + num_handles - 1, db->last_handle);
>>
>>          return service->attributes[0];
> Let's split the new test case into its own patch.

Ok

>> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
>> index f92d860c4..9457d9079 100644
>> --- a/unit/test-gatt.c
>> +++ b/unit/test-gatt.c
>> @@ -1908,6 +1908,67 @@ static struct gatt_db *make_test_spec_large_db_1(void)
>>          return make_db(specs);
>>   }
>>
>> +/*
>> + * Defined Test database 3:
>> + * Tiny database fits into a single minimum sized-pdu with services unordered.
>> + * Satisfies requirements:
>> + * 5. At least one characteristic at the MAX handle
>> + * 7. at least one service uuid with multiple instances
>> + * 8. Some simple services, some with included services
>> + * 9. an instance where handle of included service comes before the including
>> + * service
>> + * 11. Simple characteristics (no desc) and complex characteristics
>> + *     (multiple descriptors)
>> + * 12. Instances of complex chars with 16-bit and 128-bit uuids
>> + *     (although not in scrambled order)
>> + */
>> +
>> +static struct gatt_db *make_test_spec_unordered_db(void)
>> +{
>> +       const struct att_handle_spec specs[] = {
>> +               SECONDARY_SERVICE(0x0003, DEVICE_INFORMATION_UUID, 16),
>> +               CHARACTERISTIC_STR(GATT_CHARAC_MANUFACTURER_NAME_STRING,
>> +                                               BT_ATT_PERM_READ |
>> +                                               BT_ATT_PERM_WRITE,
>> +                                               BT_GATT_CHRC_PROP_READ |
>> +                                               BT_GATT_CHRC_PROP_NOTIFY |
>> +                                               BT_GATT_CHRC_PROP_INDICATE |
>> +                                               BT_GATT_CHRC_PROP_EXT_PROP,
>> +                                               "BlueZ"),
>> +               DESCRIPTOR(GATT_CLIENT_CHARAC_CFG_UUID, BT_ATT_PERM_READ |
>> +                                               BT_ATT_PERM_WRITE, 0x00, 0x00),
>> +               DESCRIPTOR_STR(GATT_CHARAC_USER_DESC_UUID, BT_ATT_PERM_READ,
>> +                                                       "Manufacturer Name"),
>> +               DESCRIPTOR(GATT_CHARAC_EXT_PROPER_UUID, BT_ATT_PERM_READ, 0x01,
>> +                                                                       0x00),
>> +               CHARACTERISTIC_STR(GATT_CHARAC_SOFTWARE_REVISION_STRING,
>> +                                               BT_ATT_PERM_READ,
>> +                                               BT_GATT_CHRC_PROP_READ |
>> +                                               BT_GATT_CHRC_PROP_INDICATE,
>> +                                               "5.59"),
>> +               DESCRIPTOR(GATT_CLIENT_CHARAC_CFG_UUID, BT_ATT_PERM_READ
>> +                       | BT_ATT_PERM_WRITE, 0x00, 0x00),
>> +
>> +               PRIMARY_SERVICE(0xFFFF - 9 + 1, GAP_UUID, 9),
>> +               INCLUDE(0x0003),
>> +               CHARACTERISTIC_STR(GATT_CHARAC_DEVICE_NAME, BT_ATT_PERM_READ,
>> +                                                       BT_GATT_CHRC_PROP_READ,
>> +                                                       "BlueZ Unit Tester"),
>> +               CHARACTERISTIC(0000B009-0000-0000-0123-456789abcdef,
>> +                                       BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
>> +                                       BT_GATT_CHRC_PROP_READ |
>> +                                       BT_GATT_CHRC_PROP_EXT_PROP, 0x09),
>> +               DESCRIPTOR(GATT_CHARAC_EXT_PROPER_UUID, BT_ATT_PERM_READ, 0x01,
>> +                                                                       0x00),
>> +               CHARACTERISTIC(GATT_CHARAC_APPEARANCE, BT_ATT_PERM_READ,
>> +                                       BT_GATT_CHRC_PROP_READ, 0x00, 0x00),
>> +               PRIMARY_SERVICE(0x0001, DEVICE_INFORMATION_UUID, 1),
>> +               { }
>> +       };
>> +
>> +       return make_db(specs);
>> +}
>> +
>>   static void test_client(gconstpointer data)
>>   {
>>          create_context(512, data);
>> @@ -2345,10 +2406,22 @@ static const struct test_step test_indication_server_1 = {
>>          .length = 0x03,
>>   };
>>
>> +static void test_hash_db(gconstpointer data)
>> +{
>> +       struct context *context = create_context(512, data);
>> +
>> +       /* test that gatt_db_get_hash is able to manage unordered db and
>> +        * doesn't crash
>> +        */
>> +       gatt_db_get_hash(context->server_db);
>> +
>> +       context_quit(context);
>> +}
>> +
>>   int main(int argc, char *argv[])
>>   {
>>          struct gatt_db *service_db_1, *service_db_2, *service_db_3;
>> -       struct gatt_db *ts_small_db, *ts_large_db_1;
>> +       struct gatt_db *ts_small_db, *ts_large_db_1, *ts_unordered_db;
>>
>>          tester_init(&argc, &argv);
>>
>> @@ -2357,6 +2430,7 @@ int main(int argc, char *argv[])
>>          service_db_3 = make_service_data_3_db();
>>          ts_small_db = make_test_spec_small_db();
>>          ts_large_db_1 = make_test_spec_large_db_1();
>> +       ts_unordered_db = make_test_spec_unordered_db();
> Afaik the db cannot be unordered, handles always must be in ascending
> order, what can happen is to have gaps in between, so I'd rename this
> to be something like ts_tail_db or something like that. Is there a
> specific test case in the test spec that does require this db though,
> looks like you are just introducing a custom one, which is valid, but
> I also want  to make use of this db on the standard tests as well if
> that is how they are intended.

Yes, the db is not unordered, the crash occurs when the db is setup in 
unordered way, e.g. if handle 0x0001 is added after handle 0xFFFF.
This is not defined in the specs, so I added a custom function to create 
the db and will update the comment on it.

>>          /*
>>           * Server Configuration
>> @@ -4487,5 +4561,9 @@ int main(int argc, char *argv[])
>>                          raw_pdu(0xff, 0x00),
>>                          raw_pdu());
>>
>> +       define_test_server("/robustness/hash-db",
>> +                       test_hash_db, ts_unordered_db, NULL,
>> +                       {});
>> +
>>          return tester_run();
>>   }
>> --
>> 2.34.1
>>
>>
>

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


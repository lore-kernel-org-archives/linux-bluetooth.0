Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6412E1D1
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215228; cv=none; b=uDNENx3lRRr+uEoQqTwwQrHsU7XDFYc3gu6wOzMVdguupucgT9k583vjfsesp+KQXjMTZU5Gm+QJgri3zmFdWx3aKhNK8qg7FushVLYU28KZhTWgj0d1fEIph/7WCkmHRFXIs9z1ydOCc6BtwjKiIByZ+Afxu2YhlL8cxtqAstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215228; c=relaxed/simple;
	bh=leO4IzQYBhVYNOIutwfoU2GXh9IMTt0oA8YSR6Nz6kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/9pETcdro2qzENra44pFuKPnbFxLPzcvXyy9Y8iMcGy1lj2Jmukmu/6ZECJtW1ItSHcUYmyusGNlPgLL+nkinzOXuQE6lYWPmjwKTVwG5Hsgu5mB+qvGJlLNgh9hD7oA7IBh5EJ/iobMBLol/Y30dZZmIFoMMXnfkIC4Tf4wc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TTfYt4vMkz9t4Y;
	Tue,  6 Feb 2024 11:26:58 +0100 (CET)
Message-ID: <e759875e-727d-4e62-9ab5-5b35a99f9293@v0yd.nl>
Date: Tue, 6 Feb 2024 11:26:57 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH BlueZ 1/4] mgmt-tester: Add a 0-opcode to expect_hci_list
 lists
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240129114900.92919-1-verdre@v0yd.nl>
 <20240129114900.92919-2-verdre@v0yd.nl>
 <CABBYNZKpUr+EZtKzPo-it3oojG2jrYT4iJMugZ2Y9LATrWPQag@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
In-Reply-To: <CABBYNZKpUr+EZtKzPo-it3oojG2jrYT4iJMugZ2Y9LATrWPQag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 29.01.24 14:40, Luiz Augusto von Dentz wrote:
> Hi Jonas,
> 
> On Mon, Jan 29, 2024 at 6:49 AM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>
>> In add_expect_hci_list() we iterate through the entries of the
>> expect_hci_list as long as there is an opcode, which means currently
>> this relies on overflowing the buffer to detect the end of the list.
>>
>> This is not great and when running with address sanitizer, the
>> out-of-bounds read gets detected and mgmt-tester aborts. Fix it by
>> adding a trailing 0-opcode to all those lists.
>> ---
>>   tools/mgmt-tester.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
>> index 7dfd1b0c7..ee12ed7d5 100644
>> --- a/tools/mgmt-tester.c
>> +++ b/tools/mgmt-tester.c
>> @@ -8798,6 +8798,9 @@ static const struct hci_cmd_data multi_ext_adv_add_second_hci_cmds[] = {
>>                  .len = sizeof(le_set_ext_adv_enable_inst_2),
>>                  .param = le_set_ext_adv_enable_inst_2,
>>          },
>> +       {
>> +               .opcode = 0,
>> +       },
> 
> Normally the compiler would put a NULL term when last member has ',',
> but we should either use {} to properly terminate the list or perhaps
> it would have been better to have a something like
> .expect_hci_list_len = ARRAY_SIZE(list) to ensure we never access past
> the end of the list.

Ahh good point, I'll add an {} entry to the lists instead. Yeah I also thought
a bit about adding expect_hci_list_len, but decided against it because that
could cause weird situations where the list is updated with a new HCI command
but increasing the expect_hci_list_len is forgotten. Then we silently wouldn't
test the new command, which seems to be a lot worse compared to a failing
address sanitizer.

Cheers,
Jonas

> 
>>   };
>>
>>   static const struct generic_data multi_ext_advertising_add_second_2 = {
>> @@ -8845,6 +8848,9 @@ static const struct hci_cmd_data multi_ext_adv_remove_adv_hci_cmds[] = {
>>                  .len = sizeof(advertising_instance1_param),
>>                  .param = advertising_instance1_param,
>>          },
>> +       {
>> +               .opcode = 0,
>> +       },
>>   };
>>
>>   static const struct generic_data multi_ext_advertising_remove = {
>> @@ -8877,6 +8883,9 @@ static const struct hci_cmd_data multi_ext_adv_remove_all_adv_hci_cmds[] = {
>>          {
>>                  .opcode = BT_HCI_CMD_LE_CLEAR_ADV_SETS,
>>          },
>> +       {
>> +               .opcode = 0,
>> +       },
>>   };
>>
>>   static const struct generic_data multi_ext_advertising_remove_all = {
>> @@ -8913,6 +8922,9 @@ static const struct hci_cmd_data multi_ext_adv_add_2_advs_hci_cmds[] = {
>>                  .len = sizeof(set_ext_adv_data_test1),
>>                  .param = set_ext_adv_data_test1,
>>          },
>> +       {
>> +               .opcode = 0,
>> +       },
>>   };
>>
>>   static const struct generic_data multi_ext_advertising_add_no_power = {
>> @@ -10378,6 +10390,9 @@ static const struct hci_cmd_data ll_privacy_add_device_3_hci_list[] = {
>>                  .param = set_resolv_on_param,
>>                  .len = sizeof(set_resolv_on_param),
>>          },
>> +       {
>> +               .opcode = 0,
>> +       },
>>   };
>>
>>   static const struct generic_data ll_privacy_add_device_3 = {
>> @@ -10495,6 +10510,9 @@ static const struct hci_cmd_data ll_privacy_add_device_9_hci_list[] = {
>>                  .len = sizeof(le_add_to_resolv_list_param),
>>                  .param = le_add_to_resolv_list_param
>>          },
>> +       {
>> +               .opcode = 0,
>> +       },
>>   };
>>
>>   static const struct generic_data ll_privacy_add_device_9 = {
>> @@ -10823,6 +10841,9 @@ static const struct hci_cmd_data ll_privacy_set_device_flags_1_hci_list[] = {
>>                  .param = set_resolv_on_param,
>>                  .len = sizeof(set_resolv_on_param),
>>          },
>> +       {
>> +               .opcode = 0,
>> +       },
>>   };
>>
>>   static const uint8_t device_flags_changed_params_1[] = {
>> --
>> 2.43.0
>>
> 
> 

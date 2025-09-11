Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9126220698
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611985; cv=pass; b=gfdRvl46lNIqr91sjoQ3KAOP8zlKB5zfmaZq+PXS+WsDTd0jJ7dkZnqFrBXQxvLT7/FI1JK5GtBdCXqoSTnQfGt7NRwSP5vD7ZwI7FPUueqkWV5wWe+g3ciWNnd+yWaJ5y3ND4ivSAGLgufCaoCs2amXe3MD2Qh4TCgTnr39s3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611985; c=relaxed/simple;
	bh=KBUO6xp/dbmiwgD8vtRnJUB6gvl4/Hk8H5/MqcLMqAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nG+JV63ff/e9gCH2EHBN8Nulkbk8fwNwjBTvmgVtK/a1urLS3gZhswfR99cACSDVS57RjwqumCM38li5gRF0jxO3yJsn1zeW8q+NtGXUSvr+4ynpLK3Yr82CPK+AkFGYxg5W84klcKkzKzrJ7mBLsJdY75k2Qq0NALWH06mLHno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=iaeR1TSI; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="iaeR1TSI"
ARC-Seal: i=1; a=rsa-sha256; t=1757611979; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G0viXzGabnLEQ2qDOsV+VDqF5t1jO8PQFP6QSvkc/BmlL0U5vgDtyXVE9jOQ55oBzJuytwUan+zno0Q24sQ0Rj99YfxDdtzi42AnkC0nZBRzGe/+1GADOlBfZGNj9gb7kgYx6pD7/8SJ25bkXs9dc/Ff9ntAwriOfVnUzbmVkV8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757611979; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wIGEPlqmVdt+6rqxK8VWf8g/ld5CE8cOHgaJAXGXKQM=; 
	b=aWsQGJ/VyKBTWMcwTN7JVrv0k97O0uZq22mRWOY6bzOKS3XIjgRDrG2tzzGot5hqvkPTJw8CwxIKLSJgarFkpuNxb6Mw6X3lQd9hDH88sGjGZkmwk3+l4ZJ8IYVY3SAf0LGwjraDLiKspV1R1MxyoFvJaahx8XVlSl7X5oiLcOM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757611979;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wIGEPlqmVdt+6rqxK8VWf8g/ld5CE8cOHgaJAXGXKQM=;
	b=iaeR1TSI8tL/p1Sm/TZN1KAdoVRUIEDdH4GPm5kKDoDx/tadMAt6Q1r4pH1i+7yq
	Hu5xzuge8G2tTcRdpjyb6bBRiSJfeiWrOxrib6CDag6DF/8Ndcu4lFdyc697JdprsEv
	GawhesGxPsORNAu/Kne+uLtPetHu1coBkC+23gvI=
Received: by mx.zohomail.com with SMTPS id 1757611977740307.97256053164074;
	Thu, 11 Sep 2025 10:32:57 -0700 (PDT)
Message-ID: <b4e36f0d-130e-49f8-b2b3-dde10a5ef3cb@collabora.com>
Date: Thu, 11 Sep 2025 19:32:55 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 2/4] unit/test-hfp: Add Operator name test for HF
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250911102840.2090361-1-frederic.danis@collabora.com>
 <20250911102840.2090361-2-frederic.danis@collabora.com>
 <CABBYNZ+fnsntwwbZY=u0_5J6O5oxCQhBq8Y-HcnaXXsDtTE-9A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZ+fnsntwwbZY=u0_5J6O5oxCQhBq8Y-HcnaXXsDtTE-9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 11/09/2025 19:28, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Thu, Sep 11, 2025 at 6:37 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> This add the following test:
>> - HFP/HF/PSI/BV-04-C
>>    Verify that the HF can query the currently selected operator name.
>>
>> Improve MINIMAL_SLC_SESSION macro to be able to set the service, call,
>> callsetup and callheld indicators at connection time.
>> ---
>>   unit/test-hfp.c | 50 +++++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 40 insertions(+), 10 deletions(-)
>>
>> diff --git a/unit/test-hfp.c b/unit/test-hfp.c
>> index 371415a68..8ab6c7bf5 100644
>> --- a/unit/test-hfp.c
>> +++ b/unit/test-hfp.c
>> @@ -699,7 +699,7 @@ static void test_hf_robustness(gconstpointer data)
>>          context_quit(context);
>>   }
>>
>> -#define MINIMAL_SLC_SESSION \
>> +#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
> WARNING:MACRO_ARG_UNUSED: Argument 'service' is not used in function-like macro
> #10: FILE: unit/test-hfp.c:702:
> +#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
>       raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
>           ' ', '0', '\r', '\n'), \
>       frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
>
> WARNING:MACRO_ARG_UNUSED: Argument 'call' is not used in function-like macro
> #10: FILE: unit/test-hfp.c:702:
> +#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
>       raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
>           ' ', '0', '\r', '\n'), \
>       frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
>
> WARNING:MACRO_ARG_UNUSED: Argument 'callsetup' is not used in
> function-like macro
> #10: FILE: unit/test-hfp.c:702:
> +#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
>       raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
>           ' ', '0', '\r', '\n'), \
>       frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
>
> WARNING:MACRO_ARG_UNUSED: Argument 'callheld' is not used in function-like macro
> #10: FILE: unit/test-hfp.c:702:
> +#define MINIMAL_SLC_SESSION(service, call, callsetup, callheld) \
>       raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
>           ' ', '0', '\r', '\n'), \
>       frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
>
> - total: 0 errors, 4 warnings, 108 lines checked

Yes, I saw this, it is due to argument usage is done in the next hunk, 
and checkpatch failsto parse it.
>>          raw_pdu('\r', '\n', '+', 'B', 'R', 'S', 'F', ':', \
>>                  ' ', '0', '\r', '\n'), \
>>          frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
>> @@ -722,10 +722,15 @@ static void test_hf_robustness(gconstpointer data)
>>          frg_pdu('\r', '\n'), \
>>          frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
>>          raw_pdu('\r', '\n', '+', 'C', 'I', 'N', 'D', ':', ' '), \
>> -       frg_pdu('0', ',', '0', ',', '0', ',', '0', ',', '5'), \
>> -       frg_pdu(',', '0', ',', '5', '\r', '\n'), \
>> +       frg_pdu(service, ',', call, ',', callsetup, ',', callheld, ','), \
>> +       frg_pdu('5', ',', '0', ',', '5', '\r', '\n'), \
>>          frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
>> -       raw_pdu('\r', '\n', 'O', 'K', '\r', '\n')
>> +       raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
>> +       raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
>> +       raw_pdu('\r', '\n', '+', 'C', 'O', 'P', 'S', ':', ' '), \
>> +       frg_pdu('0', ',', '0', ',', '\"', 'T', 'E', 'S', 'T'), \
>> +       frg_pdu('\"', '\r', '\n'), \
>> +       frg_pdu('\r', '\n', 'O', 'K', '\r', '\n')
>>
>>   static void hf_session_ready_cb(enum hfp_result res, enum hfp_error cme_err,
>>                                                          void *user_data)
>> @@ -745,7 +750,13 @@ static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
>>          if (!context->session.completed) {
>>                  switch (indicator) {
>>                  case HFP_INDICATOR_SERVICE:
>> -                       g_assert_cmpint(val, ==, 0);
>> +                       if (g_str_equal(test_name, "/HFP/HF/PSI/BV-03-C") ||
>> +                               g_str_equal(test_name, "/HFP/HF/TRS/BV-01-C") ||
>> +                               g_str_equal(test_name,
>> +                                               "/hfp_hf/test_session_minimal"))
>> +                               g_assert_cmpint(val, ==, 0);
>> +                       else
>> +                               g_assert_cmpint(val, ==, 1);
>>                          break;
>>                  case HFP_INDICATOR_CALL:
>>                          g_assert_cmpint(val, ==, 0);
>> @@ -789,9 +800,22 @@ static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
>>          }
>>   }
>>
>> +static void hf_update_operator(const char *operator_name, void *user_data)
>> +{
>> +       struct context *context = user_data;
>> +       const char *test_name = context->data->test_name;
>> +
>> +       if (tester_use_debug())
>> +               tester_debug("operator updated: %s", operator_name);
>> +
>> +       if (g_str_equal(test_name, "/HFP/HF/PSI/BV-04-C"))
>> +               g_assert_cmpstr(operator_name, ==, "TEST");
>> +}
>> +
>>   static struct hfp_hf_callbacks hf_session_callbacks = {
>>          .session_ready = hf_session_ready_cb,
>>          .update_indicator = hf_update_indicator,
>> +       .update_operator = hf_update_operator,
>>   };
>>
>>   static void test_hf_session_done(enum hfp_result res, enum hfp_error cme_err,
>> @@ -996,13 +1020,13 @@ int main(int argc, char *argv[])
>>
>>          define_hf_test("/hfp_hf/test_session_minimal", test_hf_session,
>>                          NULL, test_hf_session_done,
>> -                       MINIMAL_SLC_SESSION,
>> +                       MINIMAL_SLC_SESSION('0', '0', '0', '0'),
>>                          data_end());
>>
>>          /* Transfer Signal Strength Indication - HF */
>>          define_hf_test("/HFP/HF/PSI/BV-01-C", test_hf_session,
>>                          NULL, test_hf_session_done,
>> -                       MINIMAL_SLC_SESSION,
>> +                       MINIMAL_SLC_SESSION('1', '0', '0', '0'),
>>                          frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
>>                          frg_pdu(' ', '5', ',', '3', '\r', '\n'),
>>                          data_end());
>> @@ -1010,7 +1034,7 @@ int main(int argc, char *argv[])
>>          /* Transfer Roaming Status Indication - HF */
>>          define_hf_test("/HFP/HF/PSI/BV-02-C", test_hf_session,
>>                          NULL, test_hf_session_done,
>> -                       MINIMAL_SLC_SESSION,
>> +                       MINIMAL_SLC_SESSION('1', '0', '0', '0'),
>>                          frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
>>                          frg_pdu(' ', '6', ',', '1', '\r', '\n'),
>>                          frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
>> @@ -1020,15 +1044,21 @@ int main(int argc, char *argv[])
>>          /* Transfer Battery Level Indication - HF */
>>          define_hf_test("/HFP/HF/PSI/BV-03-C", test_hf_session,
>>                          NULL, test_hf_session_done,
>> -                       MINIMAL_SLC_SESSION,
>> +                       MINIMAL_SLC_SESSION('0', '0', '0', '0'),
>>                          frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
>>                          frg_pdu(' ', '7', ',', '3', '\r', '\n'),
>>                          data_end());
>>
>> +       /* Transfer Operator name - HF */
>> +       define_hf_test("/HFP/HF/PSI/BV-04-C", test_hf_session,
>> +                       NULL, test_hf_session_done,
>> +                       MINIMAL_SLC_SESSION('1', '0', '0', '0'),
>> +                       data_end());
>> +
>>          /* Transfer Registration Status - HF */
>>          define_hf_test("/HFP/HF/TRS/BV-01-C", test_hf_session,
>>                          NULL, test_hf_session_done,
>> -                       MINIMAL_SLC_SESSION,
>> +                       MINIMAL_SLC_SESSION('0', '0', '0', '0'),
>>                          frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
>>                          frg_pdu(' ', '1', ',', '1', '\r', '\n'),
>>                          frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':'),
>> --
>> 2.43.0
>>
>>
>
Regards,

Fred

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


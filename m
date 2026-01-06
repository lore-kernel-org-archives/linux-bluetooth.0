Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ADB1E487
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767679221; cv=none; b=VqyMp7eFeQKRcuw05biOODkyXN/i8pqy6trgsOFnPJEsEWYQUw3DzMhzZjEoUOaD4MsdEuhIHm7wgYrI7i/1unB0yV+tG/unH/ItPJ8AqZgBkudQ52Z0CLR5qC5Hltw8C2zIktCM99JW8e6ZEjA4k8RAFl37yp8v0obmQikxFbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767679221; c=relaxed/simple;
	bh=BqcM6aVpi+BOdv5HEUs+/dXcpTt2FxcpN0XDlZGakWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uL5JJ2if8qQfjW7LlUQ/La2sBxojn9YbPeAFcDxWaPX00o9Myz++Jr4wnFUCHNN2wAkcelP4wV9AgELF+++5n/Qb5WBsqg3XrnfKjldk26JP4hxukgQTyyF9HEXX835ReDBJuCFFnyJOEhWky47YlJa5AzuQ7n3TKKC+uIzrc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXRtxjCc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AFLie///; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXRtxjCc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AFLie///"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60649fhO2255371
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 06:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3qzLveUGd7E1V4Ht49VeN1ONrJ0tOJKDE0BX1amb+jY=; b=WXRtxjCcKMi5bM7/
	rlrr3O1nZ9TiWR48G9htQJ7ELDzChinl7f2ZTX6Ih9lF7fVj5C2ILPlM6BPWROBN
	hYTMh+AqxUVIhfAjNrYRJCxGAjEUuFIN6nw4TUqSzco3+ic6CpXTuuGtN2NxGHsO
	lFwjbVijWQxww6jNX2ITt2CdvuAYkJpXyZV4FEUK/6Fgn3OfuMTsFHi5c7u5jxKl
	IO1ZIcJreFAWq7myvAXTiFe20p1mZaqM0l6F4NMHdcBukZvTy6x0Xwv+9FAdlZiM
	x2a0vzRW9nZZzutsd5BNFZOjeH94elbR+mebeNuZuidSxgmNpL9ve332/Umckmql
	K2EMEA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgu4208cv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 06:00:18 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7ba92341f38so856595b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 22:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767679217; x=1768284017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qzLveUGd7E1V4Ht49VeN1ONrJ0tOJKDE0BX1amb+jY=;
        b=AFLie///E7BDXvwR0wC6+Tt2FCAjF+Ie5mKud1A2Y6zNb71r4tbTLbZ/IRM03Otzne
         mWGyIWHWhpeUXtE+zcdvg24oDkBIn1DqgOIjorq2PlpTl+SwjRYxlrkl4iNf/9upcMEm
         yq0QFvXkR8mZLPQvBNl0I9paSnQMctN/HwQWEW0lsbGSF0Urezk5VOOtb6q/szZDPer0
         tFIfFlhrtU1sm7rPS38Kwkw190MEZVHM06+2l+j/IN/udJjnZodyMsR+OYK9g0SrPGVO
         ghzNjoJ7ea82lPGxT3RUlFRM1wCizMDD/oGDR+6UNswUI3cjKtIB/OeqL5mh7rxGB24h
         hPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767679217; x=1768284017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qzLveUGd7E1V4Ht49VeN1ONrJ0tOJKDE0BX1amb+jY=;
        b=Nlcy7T/eZd484De0WGs2CrJBj0CATGJEi3ODMhY0lnejNDObyoPqerkFIcQURzJmZW
         yUDFVE5M1W4SvooS+ErnPaiASEg0my4b9ywSOuULZZwRX8OCzCvYuFkzw1f8ZZYHOEZq
         PR+8ux3n3XzvXQ7Drhhiv5IbPKFcoYURw+y2jbYL2456Q4vajLljFidCx1gRQ4QGGmgr
         aJkwpqlPICuWINrdhvmmiNwd4EDNZ2jSXR1W22WbW+tZPJgAUsK5VNWHHuxBpxkahkOP
         685MUruvzTtUQU3LPw1bfRARkZ3BUgXE3AiP6yuVxYyz54sPVBCe6lXMd8LDJCBP+5Z9
         GVvw==
X-Gm-Message-State: AOJu0YxJotaTMMUZYdb/oRO/9NMLtm5Xswx8y0u9MMk+/qW6GYGwab9y
	pzzdD6x9GOBPNpovxC3ixqtcYqxaIa3ZP07aIJ0AGkiqbKxV7o3K/ERxXaOG8RUrvzSyatSErlL
	XWN04Pe0CVdq9l55cqqgxKF73swFbS8hPFxHRQbPfllbpOUEse7ieHrWcjeuKcj1IuHQPBV8=
X-Gm-Gg: AY/fxX61nTOFrrcWPRJIlVN8QT6L1E3U0IgOtL8KyQlj5eVCaeGbMYUaaQaLF85LKqf
	VW61KhAiE4QU04IX56c1YdaETwUQcp50oahCqJw5pCVkW2RYrybY9jB21crnvIDWyy4nlhxHns2
	7xXQWUBYJFijcPumhwuNc/jpYvsN/XAkK9ABcqf97VdFaJfvHNb8VL1COnAYVjIisEJJjsv8XGH
	I6T5KHDWu2sTyic93vElTJQU/JjqECJymYqKM+75rdcYWq4WuAjRszrToxlpv8sV27GrBjZB6KX
	JzN+6WlFhye2ZFj3RTm4G3F4PV3KzwfOEJoAMO6HPW9oEyT1nm/LLwAXIPJK7dmgdtoxKJ/sinJ
	SvzL5BYe0dOgSvlL3emPpbqT4qpdYYmw6i8Y=
X-Received: by 2002:a05:6a00:2886:b0:7f0:d758:3145 with SMTP id d2e1a72fcca58-8187d8e1b50mr1916777b3a.6.1767679216938;
        Mon, 05 Jan 2026 22:00:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEE9WrJvRpuyFsdMnUs1okDgF+8myx5uBWSkwePpUgXjjyDDAyHV+Qhy5lsjZ+WEEiHa7j+Q==
X-Received: by 2002:a05:6a00:2886:b0:7f0:d758:3145 with SMTP id d2e1a72fcca58-8187d8e1b50mr1916738b3a.6.1767679216300;
        Mon, 05 Jan 2026 22:00:16 -0800 (PST)
Received: from [10.253.32.129] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bb0dfd29sm896747b3a.25.2026.01.05.22.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 22:00:15 -0800 (PST)
Message-ID: <77e146df-83af-418c-84e1-b5fdb8d33fce@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 14:00:10 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] gatt-client:Implement error handling for
 DB_OUT_OF_SYNC in GATT caching.
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
References: <20260105103828.105346-1-mengshi.wu@oss.qualcomm.com>
 <20260105103828.105346-2-mengshi.wu@oss.qualcomm.com>
 <CABBYNZLC=4gsvTQhWa4RgY_DAhJX0wbzpoHFRgYFCoSR7GquHQ@mail.gmail.com>
Content-Language: en-US
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
In-Reply-To: <CABBYNZLC=4gsvTQhWa4RgY_DAhJX0wbzpoHFRgYFCoSR7GquHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dYuNHHXe c=1 sm=1 tr=0 ts=695ca4f2 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=the27ulQIDW13KA2oj8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: ljmfzu0ZYnk4U5belQFc2CDsLBHl1rjx
X-Proofpoint-ORIG-GUID: ljmfzu0ZYnk4U5belQFc2CDsLBHl1rjx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA0OSBTYWx0ZWRfXwk+/Aq7jTPJz
 D28yfgg7ss91QV4BXe4Gc8FjI4BPpsWoYDQoxMrCgt2aETNFktimqFNuhguIbofx4JNZAYooYG7
 EX2stUP4yVkP3gLgI5lFfzAJE4VDCt35qCSCrsYOOMAq6MIm7OCz4PXRI/hvnssEXufxYnPG6dX
 zpSUCeTM9K+JzSIdRLj/DOSzwst3LJg5BfzXA0CDnJ+gb4aFzo3zKa0PEN2PZR6hXk34RnMn2sZ
 ogenIMBMYVOlu1r34pwyOf+3+EB+teR11USAWATwTrl5924eNQjdCize+UjqoAHtlwanybQz1n6
 tvUc+QDZWD9XF5WKValg6tHzWrtptWRYVwg8i4aGURGWdJcbqZTYFi/Lr0Sxf40unDVHgcXbFom
 d2q+h4ryRXR/Z3EU0nM/8uAWM0AS0Qto78kdezF/yx+gOBA7F+Jiefpjc1pV/4/U/y/s5rqLGZX
 t+hJ9Q8oWrCbOunEMmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060049

Hi Luiz,

Thanks for review and comments.

On 1/6/2026 3:21 AM, Luiz Augusto von Dentz wrote:
> Hi Mengshi,
> 
> On Mon, Jan 5, 2026 at 5:38 AM Mengshi Wu <mengshi.wu@oss.qualcomm.com> wrote:
>>
>> Implement automatic recovery when ATT_ECODE_DB_OUT_OF_SYNC error is
>> received from the remote device. The recovery mechanism:
>>
>> - Detects DB_OUT_OF_SYNC errors during GATT operations
>> - Extracts affected handles from the original request PDU
>> - Checks if Service Changed indications overlap with those handles
>> - Verifies database consistency using Database Hash characteristic
>> - Automatically retries the original request if DB is consistent
>> - Automatically retries the original request if handle is not affected
>>
>> This may prevent some application-level failures when the GATT database
>> changes on the remote device.
> 
> Some btmon traffic corresponding to the above would be great to see in
> the commit description.

OK, I will add some traffic traces in the next commit description.

> 
>>
>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
>> ---
>>  src/shared/gatt-client.c  | 376 +++++++++++++++++++++++++++++++++++++-
>>  src/shared/gatt-helpers.c |  16 ++
>>  src/shared/gatt-helpers.h |   3 +
>>  3 files changed, 392 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> index f8ebab3fa..22b6c5d1d 100644
>> --- a/src/shared/gatt-client.c
>> +++ b/src/shared/gatt-client.c
>> @@ -41,6 +41,9 @@
>>         gatt_log(_client, "[%p] %s:%s() " _format, _client, __FILE__, \
>>                 __func__, ## arg)
>>
>> +#define DB_OUT_OF_SYNC_HOLD_ON true
>> +#define DB_OUT_OF_SYNC_GO_ON false
> 
> This is a bad start, why do you have to use these defines for a boolean?

I added these macros for process_db_out_of_sync() to improve readability. I 
think this may make the code clearer than simply returning a boolean value.
If this is not considered appropriate usage, I will remove them.

> 
>>  struct ready_cb {
>>         bt_gatt_client_callback_t callback;
>>         bt_gatt_client_destroy_func_t destroy;
>> @@ -114,6 +117,9 @@ struct bt_gatt_client {
>>
>>         struct bt_gatt_request *discovery_req;
>>         unsigned int mtu_req_id;
>> +
>> +       /* Pending DB out of sync handling */
>> +       struct db_out_of_sync_data *pending_db_sync;
>>  };
>>
>>  struct request {
>> @@ -126,8 +132,31 @@ struct request {
>>         unsigned int att_id;
>>         void *data;
>>         void (*destroy)(void *);
>> +
>> +       /* For DB_OUT_OF_SYNC recovery capability */
>> +       uint8_t *sent_pdu;
>> +       uint16_t sent_pdu_len;
>> +       uint8_t sent_opcode;
>> +};
>> +
>> +struct db_out_of_sync_data {
>> +       struct bt_gatt_client *client;
>> +       struct request *original_req;
>> +       uint8_t opcode;
>> +       uint8_t *pdu;
>> +       uint16_t pdu_len;
>> +       bt_att_response_func_t att_callback;
>> +       uint16_t *handles;
>> +       uint8_t num_handles;
>> +       bool handle_overlaps;
>> +       bool svc_changed_arrived;
>> +       /* Store original error PDU */
>> +       struct bt_att_pdu_error_rsp error_pdu;
>>  };
> 
> This actually tells me the handling of such functionality shall really
> be in att.c not gat-client.c, since the former already does the
> handling of things like BT_ATT_ERROR_AUTHENTICATION so it just
> reschedules the att_send_op, perhaps we need a callback for the
> error_rsp to be processed by gatt-client.c as we handle things like
> gatt db hash, etc, there, but there retry logic we shall be able to
> use the att.c.

OK, I noticed that att.c already contains some resend logic. I will try 
moving the retry logic from gatt-client.c to att.c to avoid storing PDU 
data in both sides and to reuse the existing implementation.

> 
>> +static void db_out_of_sync_data_free(struct db_out_of_sync_data *data);
>> +static void call_original_callback_with_error(struct db_out_of_sync_data *data);
>> +
>>  static struct request *request_ref(struct request *req)
>>  {
>>         __sync_fetch_and_add(&req->ref_count, 1);
>> @@ -210,6 +239,7 @@ static void request_unref(void *data)
>>                         notify_client_idle(client);
>>         }
>>
>> +       free(req->sent_pdu);
>>         free(req);
>>  }
>>
>> @@ -1968,11 +1998,272 @@ fail:
>>                 "Failed to initiate service discovery after Service Changed");
>>  }
>>
>> +static void db_out_of_sync_recover(struct bt_gatt_client *client)
>> +{
>> +       struct db_out_of_sync_data *pending = client->pending_db_sync;
>> +       unsigned int new_att_id = 0;
>> +
>> +       assert(pending);
>> +
>> +       new_att_id = bt_att_send(client->att, pending->opcode, pending->pdu,
>> +                                pending->pdu_len, pending->att_callback,
>> +                                request_ref(pending->original_req),
>> +                                request_unref);
>> +       if (new_att_id)
>> +               pending->original_req->att_id = new_att_id;
>> +       else
>> +               call_original_callback_with_error(pending);
>> +       client->pending_db_sync = NULL;
>> +       db_out_of_sync_data_free(pending);
>> +}
>> +
>> +static void db_hash_check_read_cb(bool success, uint8_t att_ecode,
>> +                                 struct bt_gatt_result *result,
>> +                                 void *user_data)
>> +{
>> +       struct bt_gatt_client *client = user_data;
>> +       struct db_out_of_sync_data *pending = client->pending_db_sync;
>> +       const uint8_t *local_hash = NULL, *remote_hash;
>> +       struct gatt_db_attribute *hash_attr = NULL;
>> +       struct service_changed_op *op;
>> +       struct bt_gatt_iter iter;
>> +       bt_uuid_t uuid;
>> +       uint16_t handle, len;
>> +
>> +       assert(pending);
>> +
>> +       if (pending->svc_changed_arrived) {
>> +               if (!pending->handle_overlaps) {
>> +                       /* No overlap - resend original request */
>> +                       DBG(client, "Service changed range doesn't overlap");
>> +                       db_out_of_sync_recover(client);
>> +               }
>> +
>> +               return;
>> +       }
>> +
>> +       /* If read failed, fall back to full re-discovery */
>> +       if (!success)
>> +               goto trigger_rediscovery;
>> +
>> +       if (!result || !bt_gatt_iter_init(&iter, result))
>> +               goto trigger_rediscovery;
>> +
>> +       if (!bt_gatt_iter_next_read_by_type(&iter, &handle,
>> +                                       &len, &remote_hash))
>> +               goto trigger_rediscovery;
>> +
>> +       if (len != 16)
>> +               goto trigger_rediscovery;
>> +
>> +       bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
>> +       gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
>> +                            get_first_attribute, &hash_attr);
>> +
>> +       if (hash_attr) {
>> +               gatt_db_attribute_read(hash_attr, 0, BT_ATT_OP_READ_REQ, NULL,
>> +                                      db_hash_read_value_cb, &local_hash);
>> +       }
>> +
>> +       /* If hashes match, no need to trigger re-discovery */
>> +       if (local_hash && !memcmp(local_hash, remote_hash, 16)) {
>> +               db_out_of_sync_recover(client);
>> +               return;
>> +       }
>> +
>> +       DBG(client, "DB Hash mismatch: triggering re-discovery");
>> +
>> +trigger_rediscovery:
>> +       call_original_callback_with_error(pending);
>> +       client->pending_db_sync = NULL;
>> +       db_out_of_sync_data_free(pending);
>> +
>> +       process_service_changed(client, 0x0001, 0xffff);
>> +}
>> +
>> +static void db_out_of_sync_data_free(struct db_out_of_sync_data *data)
>> +{
>> +       if (!data)
>> +               return;
>> +
>> +       if (data->original_req)
>> +               request_unref(data->original_req);
>> +
>> +       free(data->pdu);
>> +       free(data->handles);
>> +       free(data);
>> +}
>> +
>> +static bool check_handle_overlap(uint16_t *handles, uint8_t num_handles,
>> +                                uint16_t start, uint16_t end)
>> +{
>> +       uint8_t i;
>> +
>> +       if (!handles)
>> +               return true;
>> +
>> +       for (i = 0; i < num_handles; i++) {
>> +               if (handles[i] >= start && handles[i] <= end)
>> +                       return true;
>> +       }
>> +
>> +       return false;
>> +}
>> +
>> +static uint8_t extract_handles_from_pdu(uint8_t opcode, const uint8_t *pdu,
>> +                                       uint16_t pdu_len, uint16_t **handles)
>> +{
>> +       uint8_t num_handles = 0;
>> +       uint16_t *handle_array;
>> +       uint16_t i;
>> +
>> +       switch (opcode) {
>> +       case BT_ATT_OP_READ_REQ:
>> +       case BT_ATT_OP_READ_BLOB_REQ:
>> +       case BT_ATT_OP_WRITE_REQ:
>> +       case BT_ATT_OP_WRITE_CMD:
>> +       case BT_ATT_OP_PREP_WRITE_REQ:
>> +               /* Single handle at offset 0 */
>> +               num_handles = 1;
>> +               handle_array = malloc(sizeof(uint16_t));
>> +               if (handle_array)
>> +                       handle_array[0] = get_le16(pdu);
>> +               break;
>> +
>> +       case BT_ATT_OP_READ_MULT_REQ:
>> +       case BT_ATT_OP_READ_MULT_VL_REQ:
>> +               /* Multiple handles, 2 bytes each */
>> +               num_handles = pdu_len / 2;
>> +               handle_array = malloc(num_handles * sizeof(uint16_t));
>> +               if (handle_array) {
>> +                       for (i = 0; i < num_handles; i++)
>> +                               handle_array[i] = get_le16(pdu + (i * 2));
>> +               }
>> +               break;
>> +
>> +       default:
>> +               return 0;
>> +       }
>> +
>> +       if (!handle_array)
>> +               return 0;
>> +
>> +       *handles = handle_array;
>> +       return num_handles;
>> +}
>> +
>> +static void call_original_callback_with_error(struct db_out_of_sync_data *data)
>> +{
>> +       struct request *req = data->original_req;
>> +
>> +       if (!req || !data->att_callback)
>> +               return;
>> +
>> +       data->att_callback(BT_ATT_OP_ERROR_RSP, &(data->error_pdu),
>> +                          sizeof(struct bt_att_pdu_error_rsp), req);
>> +}
>> +
>> +static bool process_db_out_of_sync(struct bt_gatt_client *client,
>> +                                  uint8_t att_ecode, const void *error_pdu,
>> +                                  struct request *req,
>> +                                  bt_att_response_func_t callback)
>> +{
>> +       struct db_out_of_sync_data *pending;
>> +       struct service_changed_op *op;
>> +       struct bt_gatt_request *gatt_req_op = client->discovery_req;
>> +       const struct bt_att_pdu_error_rsp *epdu = error_pdu;
>> +       bt_uuid_t uuid;
>> +       unsigned int new_att_id = 0;
>> +
>> +       if (att_ecode != BT_ATT_ERROR_DB_OUT_OF_SYNC)
>> +               return DB_OUT_OF_SYNC_GO_ON;
>> +
>> +       /* Check if we already have a pending operation */
>> +       if (client->pending_db_sync)
>> +               return DB_OUT_OF_SYNC_GO_ON;
>> +
>> +       /* Only handle if we have the necessary request info */
>> +       if (!req || !req->sent_pdu || !callback)
>> +               goto trigger_rediscovery;
>> +
>> +       /* Create pending structure */
>> +       pending = new0(struct db_out_of_sync_data, 1);
>> +       if (!pending)
>> +               goto trigger_rediscovery;
>> +
>> +       pending->client = client;
>> +       pending->original_req = request_ref(req);
>> +       pending->att_callback = callback;
>> +       pending->opcode = req->sent_opcode;
>> +       pending->pdu_len = req->sent_pdu_len;
>> +
>> +       /* Copy PDU */
>> +       pending->pdu = malloc(pending->pdu_len);
>> +       if (!pending->pdu) {
>> +               db_out_of_sync_data_free(pending);
>> +               goto trigger_rediscovery;
>> +       }
>> +       memcpy(pending->pdu, req->sent_pdu, pending->pdu_len);
>> +
>> +       /* Store original error PDU */
>> +       memcpy(&(pending->error_pdu), error_pdu,
>> +              sizeof(struct bt_att_pdu_error_rsp));
>> +
>> +       /* Extract handles from PDU */
>> +       pending->num_handles =
>> +               extract_handles_from_pdu(pending->opcode, pending->pdu,
>> +                                        pending->pdu_len, &pending->handles);
> 
> This doesn't sound right, the error response bt_att_pdu_error_rsp
> already contains the affected handle, why not use it instead of trying
> to extract from the request?

I will remove this and use handle in the bt_att_pdu_error_rsp directly.

> 
>> +       if (!pending->num_handles) {
>> +               db_out_of_sync_data_free(pending);
>> +               goto trigger_rediscovery;
>> +       }
>> +
>> +       /* Store pending operation */
>> +       client->pending_db_sync = pending;
>> +
>> +       /* Initiate hash read */
>> +       bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
>> +
>> +       if (bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
>> +                                db_hash_check_read_cb, client, NULL)) {
>> +               return DB_OUT_OF_SYNC_HOLD_ON;
>> +       }
>> +
>> +       client->pending_db_sync = NULL;
>> +       db_out_of_sync_data_free(pending);
>> +
>> +trigger_rediscovery:
>> +
>> +       if (client->in_svc_chngd) {
>> +               if (client->discovery_req && req && req->sent_pdu && callback &&
>> +                   (epdu->handle != 0) && gatt_req_op &&
>> +                   (bt_gatt_request_get_start_handle(gatt_req_op) >
>> +                            epdu->handle ||
>> +                    bt_gatt_request_get_end_handle(gatt_req_op) <
>> +                            epdu->handle)) {
>> +                       new_att_id = bt_att_send(client->att, req->sent_opcode,
>> +                                                req->sent_pdu,
>> +                                                req->sent_pdu_len, callback,
>> +                                                request_ref(req),
>> +                                                request_unref);
>> +                       if (new_att_id) {
>> +                               req->att_id = new_att_id;
>> +                               return DB_OUT_OF_SYNC_HOLD_ON;
>> +                       }
>> +               }
>> +               return DB_OUT_OF_SYNC_GO_ON;
>> +       }
>> +
>> +       process_service_changed(client, 0x0001, 0xffff);
>> +       return DB_OUT_OF_SYNC_GO_ON;
>> +}
>> +
>>  static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
>>                                         uint16_t length, void *user_data)
>>  {
>>         struct bt_gatt_client *client = user_data;
>>         struct service_changed_op *op;
>> +       struct db_out_of_sync_data *pending;
>>         uint16_t start, end;
>>
>>         if (length != 4)
>> @@ -1990,6 +2281,14 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
>>         DBG(client, "Service Changed received - start: 0x%04x end: 0x%04x",
>>                         start, end);
>>
>> +       /* Check if there's a pending DB out of sync operation */
>> +       pending = client->pending_db_sync;
>> +       if (pending) {
>> +               pending->svc_changed_arrived = true;
>> +               pending->handle_overlaps = check_handle_overlap(pending->handles,
>> +                                       pending->num_handles, start, end);
>> +       }
>> +
>>         if (!client->in_svc_chngd) {
>>                 process_service_changed(client, start, end);
>>                 return;
>> @@ -2332,6 +2631,10 @@ static void att_disconnect_cb(int err, void *user_data)
>>
>>         client->disc_id = 0;
>>
>> +       /* Cleanup pending DB out of sync operation */
>> +       db_out_of_sync_data_free(client->pending_db_sync);
>> +       client->pending_db_sync = NULL;
>> +
>>         bt_att_unref(client->att);
>>         client->att = NULL;
>>
>> @@ -2712,10 +3015,15 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>                         (!pdu && length)) {
>>                 success = false;
>>
>> -               if (opcode == BT_ATT_OP_ERROR_RSP)
>> +               if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                         att_ecode = process_error(pdu, length);
>> -               else
>> +                       if (process_db_out_of_sync(req->client, att_ecode,
>> +                                                  pdu, req,
>> +                                                  read_multiple_cb))
>> +                               return;
>> +               } else {
>>                         att_ecode = 0;
>> +               }
>>
>>                 pdu = NULL;
>>                 length = 0;
>> @@ -2799,6 +3107,13 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
>>                 BT_GATT_CHRC_CLI_FEAT_EATT ? BT_ATT_OP_READ_MULT_VL_REQ :
>>                 BT_ATT_OP_READ_MULT_REQ;
>>
>> +       /* Store PDU for potential resend on DB_OUT_OF_SYNC */
>> +       req->sent_opcode = opcode;
>> +       req->sent_pdu_len = num_handles * 2;
>> +       req->sent_pdu = malloc(req->sent_pdu_len);
>> +       if (req->sent_pdu)
>> +               memcpy(req->sent_pdu, pdu, req->sent_pdu_len);
>> +
>>         req->att_id = bt_att_send(client->att, opcode, pdu, num_handles * 2,
>>                                                         read_multiple_cb, req,
>>                                                         request_unref);
>> @@ -2867,6 +3182,10 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                 success = false;
>>                 att_ecode = process_error(pdu, length);
>> +               if (process_db_out_of_sync(req->client, att_ecode,
>> +                                          pdu, req,
>> +                                          read_long_cb))
>> +                       return;
>>                 goto done;
>>         }
>>
>> @@ -2975,6 +3294,13 @@ unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
>>                 att_op = BT_ATT_OP_READ_REQ;
>>         }
>>
>> +       /* Store PDU for potential resend on DB_OUT_OF_SYNC */
>> +       req->sent_opcode = att_op;
>> +       req->sent_pdu_len = pdu_len;
>> +       req->sent_pdu = malloc(req->sent_pdu_len);
>> +       if (req->sent_pdu)
>> +               memcpy(req->sent_pdu, pdu, req->sent_pdu_len);
>> +
>>         req->att_id = bt_att_send(client->att, att_op, pdu, pdu_len,
>>                                         read_long_cb, req, request_unref);
>>
>> @@ -3053,6 +3379,9 @@ static void write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                 success = false;
>>                 att_ecode = process_error(pdu, length);
>> +               if (process_db_out_of_sync(req->client, att_ecode,
>> +                                          pdu, req, write_cb))
>> +                       return;
>>                 goto done;
>>         }
>>
>> @@ -3096,6 +3425,13 @@ unsigned int bt_gatt_client_write_value(struct bt_gatt_client *client,
>>         put_le16(value_handle, pdu);
>>         memcpy(pdu + 2, value, length);
>>
>> +       /* Store PDU for potential resend on DB_OUT_OF_SYNC */
>> +       req->sent_opcode = BT_ATT_OP_WRITE_REQ;
>> +       req->sent_pdu_len = 2 + length;
>> +       req->sent_pdu = malloc(req->sent_pdu_len);
>> +       if (req->sent_pdu)
>> +               memcpy(req->sent_pdu, pdu, req->sent_pdu_len);
>> +
>>         req->att_id = bt_att_send(client->att, BT_ATT_OP_WRITE_REQ,
>>                                                         pdu, 2 + length,
>>                                                         write_cb, req,
>> @@ -3216,6 +3552,10 @@ static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                 success = false;
>>                 att_ecode = process_error(pdu, length);
>> +               if (process_db_out_of_sync(req->client, att_ecode,
>> +                                          pdu, req,
>> +                                          execute_write_cb))
>> +                       return;
>>         } else if (opcode != BT_ATT_OP_EXEC_WRITE_RSP || pdu || length)
>>                 success = false;
>>
>> @@ -3281,6 +3621,10 @@ static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                 success = false;
>>                 att_ecode = process_error(pdu, length);
>> +               if (process_db_out_of_sync(req->client, att_ecode,
>> +                                          pdu, req,
>> +                                          prepare_write_cb))
>> +                       return;
>>                 goto done;
>>         }
>>
>> @@ -3401,11 +3745,15 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
>>         put_le16(offset, pdu + 2);
>>         memcpy(pdu + 4, op->value, op->cur_length);
>>
>> +       /* Store PDU for potential resend on DB_OUT_OF_SYNC */
>> +       req->sent_opcode = BT_ATT_OP_PREP_WRITE_REQ;
>> +       req->sent_pdu_len = op->cur_length + 4;
>> +       req->sent_pdu = pdu;
>> +
>>         req->att_id = bt_att_send(client->att, BT_ATT_OP_PREP_WRITE_REQ,
>>                                                         pdu, op->cur_length + 4,
>>                                                         prepare_write_cb, req,
>>                                                         request_unref);
>> -       free(pdu);
>>
>>         if (!req->att_id) {
>>                 op->destroy = NULL;
>> @@ -3450,6 +3798,10 @@ static void prep_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>                 success = false;
>>                 reliable_error = false;
>>                 att_ecode = process_error(pdu, length);
>> +               if (process_db_out_of_sync(req->client, att_ecode,
>> +                                          pdu, req,
>> +                                          prep_write_cb))
>> +                       return;
>>                 goto done;
>>         }
>>
>> @@ -3566,6 +3918,13 @@ unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
>>         memcpy(op->pdu, pdu, length);
>>         op->pdu_len = length;
>>
>> +       /* Store PDU for potential resend on DB_OUT_OF_SYNC */
>> +       req->sent_opcode = BT_ATT_OP_PREP_WRITE_REQ;
>> +       req->sent_pdu_len = length;
>> +       req->sent_pdu = malloc(req->sent_pdu_len);
>> +       if (req->sent_pdu)
>> +               memcpy(req->sent_pdu, pdu, req->sent_pdu_len);
>> +
>>         /*
>>          * Now we are ready to send command
>>          * Note that request_unref will be done on write execute
>> @@ -3600,6 +3959,10 @@ static void exec_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                 success = false;
>>                 att_ecode = process_error(pdu, length);
>> +               if (process_db_out_of_sync(req->client, att_ecode,
>> +                                          pdu, req,
>> +                                          exec_write_cb))
>> +                       return;
>>                 goto done;
>>         }
>>
>> @@ -3659,6 +4022,13 @@ unsigned int bt_gatt_client_write_execute(struct bt_gatt_client *client,
>>         req->data = op;
>>         req->destroy = destroy_write_op;
>>
>> +       /* Store PDU for potential resend on DB_OUT_OF_SYNC */
>> +       req->sent_opcode = BT_ATT_OP_EXEC_WRITE_REQ;
>> +       req->sent_pdu_len = sizeof(pdu);
>> +       req->sent_pdu = malloc(req->sent_pdu_len);
>> +       if (req->sent_pdu)
>> +               memcpy(req->sent_pdu, &pdu, req->sent_pdu_len);
> 
> 
> This is sort of repeated in all requests thus why I think we are
> better off doing it in att.c, so we don't have to keep calling
> process_db_out_of_sync and then copy the requests which is actually a
> duplicating what att.c is doing with att_send_op.

Yes, I see that att.c has already stored requests. I will move this logic
to att.c.

> 
>>         req->att_id = bt_att_send(client->att, BT_ATT_OP_EXEC_WRITE_REQ, &pdu,
>>                                                 sizeof(pdu), exec_write_cb,
>>                                                 req, request_unref);
>> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
>> index c1cbbdc91..e3a6548c4 100644
>> --- a/src/shared/gatt-helpers.c
>> +++ b/src/shared/gatt-helpers.c
>> @@ -790,6 +790,22 @@ done:
>>         discovery_op_complete(op, success, att_ecode);
>>  }
>>
>> +uint16_t bt_gatt_request_get_start_handle(struct bt_gatt_request *request)
>> +{
>> +       if (!request)
>> +               return 0;
>> +
>> +       return request->start_handle;
>> +}
>> +
>> +uint16_t bt_gatt_request_get_end_handle(struct bt_gatt_request *request)
>> +{
>> +       if (!request)
>> +               return 0;
>> +
>> +       return request->end_handle;
>> +}
>> +
>>  static struct bt_gatt_request *discover_services(struct bt_att *att,
>>                                         bt_uuid_t *uuid,
>>                                         uint16_t start, uint16_t end,
>> diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
>> index 7623862e9..7a51ec619 100644
>> --- a/src/shared/gatt-helpers.h
>> +++ b/src/shared/gatt-helpers.h
>> @@ -101,3 +101,6 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
>>                                         bt_gatt_request_callback_t callback,
>>                                         void *user_data,
>>                                         bt_gatt_destroy_func_t destroy);
>> +
>> +uint16_t bt_gatt_request_get_end_handle(struct bt_gatt_request *request);
>> +uint16_t bt_gatt_request_get_start_handle(struct bt_gatt_request *request);
>> --
>> 2.34.1
>>
> 
> 

Best regards,
Mengshi Wu

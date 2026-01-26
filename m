Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99420FAAB
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424256; cv=none; b=h5yqfpJI7xGOpb29dIQHFiUzWdVzUWUuzUvBWr2k3OAcR90muLlzrm0Mg4CSZ6k1JMv1u+4Dth3JOwJYYoLv1EgjPRBBmNP0ZdAansjaN+ifrYXskog6sAC+3sd/mIx5EhI+qqO5vor/+UMLh9JQdMsPpm7AflIc0Qu8ktqocW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424256; c=relaxed/simple;
	bh=JGgJZF0ef3InJDrZiZd0Me8C51C/MhnAiO+kpoVV+8k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IYhVJqpb9z/eu8kDtUVD06n+0bgKbVUJsYVvbw3TM7ezcwxaFKKTWI/SixY9fY+knVClyLc1WUyfTLJXwP+m3B6t6UqmbP1reyEeqqjFbcRw5mftsZ0JhAkL1/eVVd7D6W0X5z6VgVxilyzW7yp2LalAo1AJlw0A0kajPJpCvFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GmVo5RZU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g4CC3uU0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GmVo5RZU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g4CC3uU0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q9brGD191832
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 10:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aTVwpwaShEDT9/C8cJixLyRoUqSCKXwutHrsqVPi4JY=; b=GmVo5RZUDNSqapPs
	W/RFYIXTPie+45FqAhxvVbDbgVOp+5JXxyXvucMsLdU8JKDkW7Ev5xmZXlECq2UN
	6q8sI+vpqiWZGLte83dFZjgOFZyJPrTcxlfVfEExWBfCzg6MsGCg5cnF+X5eWW7x
	hKIkYEGb2y8ZR7SMjCL2cejyG2NQrUqKqi/edNz/3S43P5V9MaI7bkBzRMGhKtR4
	Ku0WJVjJVPhj8qFIpP3mjqzaIgCcuESM4TqM5nyrSQbeCqF45lFh4O4zBugAPqv5
	QR41fP0ia7erc8FrO+A+QdQQspcJ73wW6SAZH++S/J64BV06MtrMBPXPDfRujECS
	vTx3bg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq6xv7kk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 10:44:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b6b9c1249fso7844496eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 02:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769424252; x=1770029052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aTVwpwaShEDT9/C8cJixLyRoUqSCKXwutHrsqVPi4JY=;
        b=g4CC3uU0+Z08dKzmhZXEozU94s0zfyHDiQerAUrt42aLBx4BOzkw+P/KgPCY8gLdyX
         v7DZBmxFVphOk/VfCnQZlXr+UShsYe0EB4CIChmBeP6S0OaT5LLkKoDtxaPXhWKlc2vu
         ujy9nQkNDJZ82VabvYRT9Oxdbx0AjqY4ptUveSwEpLn+JuAowt7HMsVzDxETc7jdWT/H
         v7ZQhk7Qt5vefFF6WOeHUgLKqcSIqGxq055e/bYl66FUKqcfAj0z5G4lXoSH97ZdY6sq
         oEcIOPLBvVbiYs+qx7sOFslAXDtApRilMDkWtJvX9QXfugAVGlBr0AGaCkoAnI0C+QZZ
         DIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424252; x=1770029052;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTVwpwaShEDT9/C8cJixLyRoUqSCKXwutHrsqVPi4JY=;
        b=ZS1eXOG2ia2tadz5OWA7cf+mttW2mU07Dm62wtrW/r2k7xjQcWOVl8u9oP58kj+fa3
         DO/5ent0C7NvGxdI+JsY8DPjrsdkb7cqIHXfHcQgSxABGssITRXP3cvW8/ylDZN5s/ML
         1YVRm5savfVDcJcDePzOINfZEDRSaM4Bcmg9Ov8AoBrrVHfMvsnzdgTIA99ewekn23hu
         xYzdIcsee+ZWdywfg7QJlzQyeHfMCVlUHaU5mLBGhkOA2QUQTe7xx2/1GM5CBdOxKIYS
         Jt6tnmd89ZVjcaaGpfuI5KMrSpu9+0Y8uq1cWE4JBjot4ZTwrmZEO6//lYjfunE9xDZR
         gFqA==
X-Gm-Message-State: AOJu0YxkboofJXJZBYJiA0b+EkgUiHZAfUV/Ti4BhIQ20UjM/zsJCOlO
	/cK8VKCmeh0G3miAJxlypZlVWbPMtmgaUJSrTHwclfvze3VCvPxP48K5Cz8FHkomD/PYEi1ek6g
	nXhW+v0a6BFdnDmnLaLGFu9pqeDsNfqA0980q3jCaMKsQSjTLVbzeSJLcapWIV9GMyGRUFIE=
X-Gm-Gg: AZuq6aJE4K3D0B9jYbiRW6b7M1JcT6OKlFOF3C0zirMUdGIu3+p34xcX54v9pqHP74T
	9dF3ql9ggo5vuEmPnlM+iyOqw9cO6c1HCBF92vD67G6nW6E4x5gfd+l57UqyZ/MFr8p8V/jJdx2
	3rl6DeNvVdD7rkfv1f7/urLzfkTkfOEa60F04CYOkWzFa0qZn+IxyhQx5lIiMlTo0Dq6AAc/cus
	COf1EpDQzxbCYHNYxeFhL4eTCORzudyA8wZYpqgJbd0B91hhqQmyDOCyOCgB3q0BknMdOIboYhO
	/vovG1+hBrYJ3ajdd8fRjlsCbRJpJnZDNi9sRnrss8aTuZX/MvLn6Jp5whBm5jrzFCGoQAfuNSo
	7IbFfYedw2CwCg5UnsT5PDPQ0AR8F2LK4Y+6X15qCZ8vSwEAv8ZyxSWJojc8w8TA=
X-Received: by 2002:a05:7300:8c85:b0:2a4:3593:c7e1 with SMTP id 5a478bee46e88-2b764525c3emr1585226eec.33.1769424251800;
        Mon, 26 Jan 2026 02:44:11 -0800 (PST)
X-Received: by 2002:a05:7300:8c85:b0:2a4:3593:c7e1 with SMTP id 5a478bee46e88-2b764525c3emr1585202eec.33.1769424251023;
        Mon, 26 Jan 2026 02:44:11 -0800 (PST)
Received: from [10.110.123.17] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa03fd0sm12940945eec.23.2026.01.26.02.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 02:44:10 -0800 (PST)
Message-ID: <80008178-352b-41ca-9a4f-65662a099b13@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 18:44:06 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] shared/att: Implement ATT error retry mechanism
 with callback support
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
References: <20260121083804.4010106-1-mengshi.wu@oss.qualcomm.com>
 <20260121083804.4010106-2-mengshi.wu@oss.qualcomm.com>
 <CABBYNZJwuqc3=scrzx+iqYBKr+7C4o5ARFy2V9KtOU4rqcL1ew@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZJwuqc3=scrzx+iqYBKr+7C4o5ARFy2V9KtOU4rqcL1ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: j-yP1kr4J5uz0ad38ys53AbfcSqDeQ5x
X-Proofpoint-ORIG-GUID: j-yP1kr4J5uz0ad38ys53AbfcSqDeQ5x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA5MSBTYWx0ZWRfX/RTpwvPBWHyr
 6gUjw1YUdcVP4KNp5ye0o8r6i2ySYqEN5aeNFaJZRKJbV9S4kKZcJ4V7gwKe5bKehMP5Oat5eTf
 BjLqjQsc2CAZTAOUuQfQPTcjQTwuyCRTTLHmgB9fWdVdexgLNqx8gEdESz17owEf7RhLAFk0xtb
 5aGnkOGWeLyab9VWPE7s38ddVQdgtM+AhNb4URzYuuhqjjLV/pSkgrah7zUrRouQ7sO8cIe0vZv
 8wT/+WnnlKSQsuoL9g66WUJ5qq8PdsLiMRDOgPirIG1fxb0eXBEXIMwd2sJ2aRA2qXy+hCKTLvt
 YbbCxK00w0Odfb0qua1yIsOghZka5rRewMIQCV8ENkC+7ZlZVpVcIG98cZEAb3aVz0VVmklV6iU
 AjF2nQ+MBnEke5nnz3gqMSCWnYYds++6tOkWLdn/rO8TlICHL5IACKRruolTNZ4au4/1DWtKIV4
 86Mru2qBEB9VGW0+X0Q==
X-Authority-Analysis: v=2.4 cv=Htd72kTS c=1 sm=1 tr=0 ts=6977457d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8YWPkPv-lYaeft8ZOAwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260091

Hi Luiz,

Thanks for your comments.

On 1/22/2026 2:15 AM, Luiz Augusto von Dentz wrote:
> Hi Mengshi,
> 
> On Wed, Jan 21, 2026 at 3:38 AM Mengshi Wu <mengshi.wu@oss.qualcomm.com> wrote:
>>
>> Add a retry mechanism for ATT operations that allows upper layers to
>> decide whether to retry failed requests. This includes:
>>
>> - Add retry callback registration (bt_att_set_retry_cb) to allow
>>   applications to handle retry decisions
>> - Implement pending_retry state tracking in att_send_op to store
>>   operations awaiting retry approval
>> - Add bt_att_retry_request() and bt_att_cancel_retry() functions to
>>   approve or reject retry attempts
>> - Store error PDUs during retry_pending state for callback inspection
>> - Modify handle_error_rsp() to return retry decision codes instead of
>>   boolean values
>> - Add BT_ATT_RETRY_* constants for retry decision handling
>> - Update GATT helpers to support retry callbacks for operations like
>>   discovery and read/write requests
>>
>> This enables more robust error handling by allowing the application
>> layer to implement custom retry logic based on ATT error codes.
>>
>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
>> ---
>>  src/shared/att.c | 182 +++++++++++++++++++++++++++++++++++++++++++++--
>>  src/shared/att.h |  16 +++++
>>  2 files changed, 191 insertions(+), 7 deletions(-)
>>
>> diff --git a/src/shared/att.c b/src/shared/att.c
>> index 77ca4aa24..4ae97530a 100644
>> --- a/src/shared/att.c
>> +++ b/src/shared/att.c
>> @@ -47,6 +47,7 @@ struct bt_att_chan {
>>
>>         struct att_send_op *pending_req;
>>         struct att_send_op *pending_ind;
>> +       struct att_send_op *pending_retry;
>>         bool writer_active;
>>
>>         bool in_req;                    /* There's a pending incoming request */
>> @@ -78,6 +79,10 @@ struct bt_att {
>>         bt_att_destroy_func_t timeout_destroy;
>>         void *timeout_data;
>>
>> +       bt_att_retry_func_t retry_callback;
>> +       bt_att_destroy_func_t retry_destroy;
>> +       void *retry_data;
> 
> Why do we need these fields? The bt_att_chan already have this data as
> part of pending_retry, so this sound duplicated to me, or is this this
> just to register for retry callback?

These fields serve different purposes. The callback in att_send_op
(pending_retry in bt_att_chan) is triggered too late to handle a deferred
retry. By the time this callback is executed, the retry opportunity has
already been lost. Therefore, I added this new callback that checks whether
a retry is pending beforehand.

> 
>> +
>>         uint8_t debug_level;
>>         bt_att_debug_func_t debug_callback;
>>         bt_att_destroy_func_t debug_destroy;
>> @@ -194,6 +199,9 @@ struct att_send_op {
>>         void *pdu;
>>         uint16_t len;
>>         bool retry;
>> +       bool retry_pending;  /* Waiting for approval to retry */
>> +       uint8_t *error_pdu;  /* Stored error PDU for retry_pending */
>> +       uint16_t error_pdu_len;
> 
> These fields are definitely not needed, juist reuse pdu, len and retry
> fields, you are already adding a dedicated field for them in
> bt_att_chan.pending_retry.

These fields store the received error‑response PDU, not the original ATT
request PDU, which is already kept in the pdu/len fields. We need to keep
the error information because, if recovery fails, the error will be
propagated to the upper layer.

> 
>>         bt_att_response_func_t callback;
>>         bt_att_destroy_func_t destroy;
>>         void *user_data;
>> @@ -210,6 +218,7 @@ static void destroy_att_send_op(void *data)
>>                 op->destroy(op->user_data);
>>
>>         free(op->pdu);
>> +       free(op->error_pdu);
>>         free(op);
>>  }
>>
>> @@ -644,6 +653,9 @@ static void bt_att_chan_free(void *data)
>>         if (chan->pending_ind)
>>                 destroy_att_send_op(chan->pending_ind);
>>
>> +       if (chan->pending_retry)
>> +               destroy_att_send_op(chan->pending_retry);
>> +
>>         queue_destroy(chan->queue, destroy_att_send_op);
>>
>>         io_destroy(chan->io);
>> @@ -682,6 +694,11 @@ static bool disconnect_cb(struct io *io, void *user_data)
>>                 chan->pending_ind = NULL;
>>         }
>>
>> +       if (chan->pending_retry) {
>> +               disc_att_send_op(chan->pending_retry);
>> +               chan->pending_retry = NULL;
>> +       }
>> +
>>         bt_att_chan_free(chan);
>>
>>         /* Don't run disconnect callback if there are channels left */
>> @@ -777,16 +794,17 @@ static bool change_security(struct bt_att_chan *chan, uint8_t ecode)
>>         return bt_att_chan_set_security(chan, security);
>>  }
>>
>> -static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
>> +static int handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
>>                                         ssize_t pdu_len, uint8_t *opcode)
>>  {
>>         struct bt_att *att = chan->att;
>>         const struct bt_att_pdu_error_rsp *rsp;
>>         struct att_send_op *op = chan->pending_req;
>> +       int should_retry = BT_ATT_RETRY_NO;
>>
>>         if (pdu_len != sizeof(*rsp)) {
>>                 *opcode = 0;
>> -               return false;
>> +               return should_retry;
>>         }
>>
>>         rsp = (void *) pdu;
>> @@ -797,11 +815,43 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
>>          * the security again.
>>          */
>>         if (op->retry)
>> -               return false;
>> +               return should_retry;
>>
>>         /* Attempt to change security */
>> -       if (!change_security(chan, rsp->ecode))
>> -               return false;
>> +       if (change_security(chan, rsp->ecode)) {
>> +               should_retry = BT_ATT_RETRY_YES;
>> +       } else if (att->retry_callback) {
>> +               should_retry = att->retry_callback(op->opcode, rsp->ecode,
>> +                                                  op->pdu + 1, op->len - 1,
>> +                                                  op->id, att->retry_data);
>> +
>> +               /* Check if callback wants to defer the retry decision */
>> +               if (should_retry == BT_ATT_RETRY_PENDING) {
>> +                       op->retry_pending = true;
>> +
>> +                       /* Store error PDU for later use */
>> +                       op->error_pdu = malloc(pdu_len);
>> +                       if (op->error_pdu) {
>> +                               memcpy(op->error_pdu, pdu, pdu_len);
>> +                               op->error_pdu_len = pdu_len;
>> +                       }
>> +
>> +                       /* Remove timeout since we're waiting for approval */
>> +                       if (op->timeout_id) {
>> +                               timeout_remove(op->timeout_id);
>> +                               op->timeout_id = 0;
>> +                       }
>> +
>> +                       /* Move from pending_req to pending_retry */
>> +                       chan->pending_retry = op;
>> +
>> +                       DBG(att, "(chan %p) Retry pending for operation %p",
>> +                           chan, op);
>> +               }
>> +       }
>> +
>> +       if (should_retry != BT_ATT_RETRY_YES)
>> +               return should_retry;
>>
>>         /* Remove timeout_id if outstanding */
>>         if (op->timeout_id) {
>> @@ -815,7 +865,8 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
>>         op->retry = true;
>>
>>         /* Push operation back to channel queue */
>> -       return queue_push_head(chan->queue, op);
>> +       return queue_push_head(chan->queue, op) ?
>> +               BT_ATT_RETRY_YES : BT_ATT_RETRY_NO;
>>  }
>>
>>  static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
>> @@ -845,9 +896,15 @@ static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
>>          */
>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                 /* Return if error response cause a retry */
>> -               if (handle_error_rsp(chan, pdu, pdu_len, &req_opcode)) {
>> +               switch (handle_error_rsp(chan, pdu, pdu_len, &req_opcode)) {
>> +               case BT_ATT_RETRY_PENDING:
>> +                       /* Operation moved to pending_retry, clear pending_req */
>> +                       chan->pending_req = NULL;
>> +               case BT_ATT_RETRY_YES:
>>                         wakeup_chan_writer(chan, NULL);
>>                         return;
>> +               default:
>> +                       break;
>>                 }
>>         } else if (!(req_opcode = get_req_opcode(opcode)))
>>                 goto fail;
>> @@ -1142,6 +1199,9 @@ static void bt_att_free(struct bt_att *att)
>>         if (att->timeout_destroy)
>>                 att->timeout_destroy(att->timeout_data);
>>
>> +       if (att->retry_destroy)
>> +               att->retry_destroy(att->retry_data);
>> +
>>         if (att->debug_destroy)
>>                 att->debug_destroy(att->debug_data);
>>
>> @@ -1473,6 +1533,23 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
>>         return true;
>>  }
>>
>> +bool bt_att_set_retry_cb(struct bt_att *att, bt_att_retry_func_t callback,
>> +                                               void *user_data,
>> +                                               bt_att_destroy_func_t destroy)
>> +{
>> +       if (!att)
>> +               return false;
>> +
>> +       if (att->retry_destroy)
>> +               att->retry_destroy(att->retry_data);
>> +
>> +       att->retry_callback = callback;
>> +       att->retry_destroy = destroy;
>> +       att->retry_data = user_data;
>> +
>> +       return true;
>> +}
>> +
>>  unsigned int bt_att_register_disconnect(struct bt_att *att,
>>                                         bt_att_disconnect_func_t callback,
>>                                         void *user_data,
>> @@ -2051,6 +2128,97 @@ bool bt_att_has_crypto(struct bt_att *att)
>>         return att->crypto ? true : false;
>>  }
>>
>> +bool bt_att_retry_request(struct bt_att *att, unsigned int id)
>> +{
>> +       const struct queue_entry *entry;
>> +       struct bt_att_chan *chan = NULL;
>> +       struct att_send_op *op;
>> +
>> +       if (!att || !id)
>> +               return false;
>> +
>> +       /* Find the channel with the pending retry operation */
>> +       for (entry = queue_get_entries(att->chans); entry;
>> +                                               entry = entry->next) {
>> +               struct bt_att_chan *c = entry->data;
>> +
>> +               if (c->pending_retry && c->pending_retry->id == id &&
>> +                   c->pending_retry->retry_pending) {
>> +                       chan = c;
>> +                       op = c->pending_retry;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       if (!chan || !op)
>> +               return false;
>> +
>> +       DBG(att, "(chan %p) Approving retry for operation %p", chan, op);
>> +
>> +       /* Clear pending retry state and mark for retry */
>> +       op->retry_pending = false;
>> +       op->retry = true;
>> +       chan->pending_retry = NULL;
>> +
>> +       /* Free stored error PDU as we're retrying */
>> +       free(op->error_pdu);
>> +       op->error_pdu = NULL;
>> +       op->error_pdu_len = 0;
>> +
>> +       /* Push operation back to channel queue for retry */
>> +       if (!queue_push_head(chan->queue, op))
>> +               return false;
>> +
>> +       /* Wake up writer to send the retry */
>> +       wakeup_chan_writer(chan, NULL);
>> +
>> +       return true;
>> +}
>> +
>> +bool bt_att_cancel_retry(struct bt_att *att, unsigned int id)
>> +{
>> +       const struct queue_entry *entry;
>> +       struct bt_att_chan *chan = NULL;
>> +       struct att_send_op *op;
>> +
>> +       if (!att || !id)
>> +               return false;
>> +
>> +       /* Find the channel with the pending retry operation */
>> +       for (entry = queue_get_entries(att->chans); entry;
>> +                                               entry = entry->next) {
>> +               struct bt_att_chan *c = entry->data;
>> +
>> +               if (c->pending_retry && c->pending_retry->id == id &&
>> +                   c->pending_retry->retry_pending) {
>> +                       chan = c;
>> +                       op = c->pending_retry;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       if (!chan || !op)
>> +               return false;
>> +
>> +       DBG(att, "(chan %p) Canceling retry for operation %p", chan, op);
>> +
>> +       /* Clear pending retry state */
>> +       op->retry_pending = false;
>> +       chan->pending_retry = NULL;
>> +
>> +       /* Call the callback with stored error PDU to notify upper layer */
>> +       if (op->callback)
>> +               op->callback(BT_ATT_OP_ERROR_RSP, op->error_pdu,
>> +                            op->error_pdu_len, op->user_data);
>> +
>> +       destroy_att_send_op(op);
>> +
>> +       /* Wake up writer in case there are other operations */
>> +       wakeup_chan_writer(chan, NULL);
>> +
>> +       return true;
>> +}
>> +
>>  bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry)
>>  {
>>         struct att_send_op *op;
>> diff --git a/src/shared/att.h b/src/shared/att.h
>> index 53a3f7a2a..6dc9944bb 100644
>> --- a/src/shared/att.h
>> +++ b/src/shared/att.h
>> @@ -46,6 +46,15 @@ typedef void (*bt_att_disconnect_func_t)(int err, void *user_data);
>>  typedef void (*bt_att_exchange_func_t)(uint16_t mtu, void *user_data);
>>  typedef bool (*bt_att_counter_func_t)(uint32_t *sign_cnt, void *user_data);
>>
>> +/* Return values for bt_att_retry_func_t */
>> +#define BT_ATT_RETRY_NO        0       /* Don't retry */
>> +#define BT_ATT_RETRY_YES       1       /* Retry immediately */
>> +#define BT_ATT_RETRY_PENDING   2       /* Defer retry decision */
>> +
>> +typedef int (*bt_att_retry_func_t)(uint8_t opcode, uint8_t error_code,
>> +                                       const void *pdu, uint16_t length,
>> +                                       unsigned int att_id, void *user_data);
>> +
>>  bool bt_att_set_debug(struct bt_att *att, uint8_t level,
>>                         bt_att_debug_func_t callback, void *user_data,
>>                         bt_att_destroy_func_t destroy);
>> @@ -58,6 +67,13 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
>>                                                 void *user_data,
>>                                                 bt_att_destroy_func_t destroy);
>>
>> +bool bt_att_set_retry_cb(struct bt_att *att, bt_att_retry_func_t callback,
>> +                                               void *user_data,
>> +                                               bt_att_destroy_func_t destroy);
>> +
>> +bool bt_att_retry_request(struct bt_att *att, unsigned int id);
>> +bool bt_att_cancel_retry(struct bt_att *att, unsigned int id);
> 
> Hmm, why are you not reusing bt_att_resend and bt_att_cancel? We may
> need to adapt bt_att_resend to locate the id in the pending_retry and
> then force pushing to the queue head but other than that it looks
> pretty similar to me, also I don't think it really needs to be sent
> over the same channel, since over the air it really is another request
> it can be enqueued in the session queue, rather than the channel
> queue, just as done with bt_att_resend.
> 

I did not reuse bt_att_resend() because it requires the original PDU and
respose callback as parameters, and these are not stored in the upper layer.
As discussed earlier, we moved these parts into att.c so that we can reuse
the relevant logic there.

bt_att_cancel() can be reused with a few adaptations. I will remove
bt_att_cancel_retry().

It does't need to be sent over the same channel, I just want to reuse an
existing op. I noticed that handle_error_rsp() does this.

>>  unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
>>                                         const void *pdu, uint16_t length,
>>                                         bt_att_response_func_t callback,
>> --
>> 2.34.1
>>
> 
> 

Best regards,
Mengshi Wu

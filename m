Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459CDEAC7
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004403; cv=none; b=k21HwyKg2AjAxZMU3olYeas3Hipql0GS+djudtEEVvC07CVPW4q+OmOYp9hpM6oIrTwhacawIbb9AeuASiXdzHiT4mNjF6/T0mLWduWKaXZLp/tvAQlQxFpsqKB9Z40C8HG5tayXa9HeEyc1uMhEKMYep+88D3CGY9aJSNFxUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004403; c=relaxed/simple;
	bh=tXt5okDESttFIcV4JFWioXugA2TXKk74M1LOCbzo0B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qj9SHsvJAz2ZJkDDSUK6sRpkTO/Z41IA6Timf1mHxYFe/NnsaoEr0g8XZuDwiduB8S50tgRmrbb+PuERrrCD1osvRM/LFtdFXlIHN+wLYeciCH5ULgJObCjdHdKhm1larFtVCO4X9jGfwDqX4o5rrn9vTnNtzKOeBfZjOFXUf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CHpxF1P2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HkL8kESv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CHpxF1P2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HkL8kESv"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P2HA3T4077696
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 07:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KQ2Fzv27e1/3/8/V/bE6PX7TuwoZn/JZdT9SzUi9A1w=; b=CHpxF1P24q/nVDj1
	pN3knkjSkBAIANzpNM/wYijNoVAVNzis1QPpMep2/P1aJJLc5ie+UntuUMiPeOzg
	EttFu8nWnqcQC3TDf+Vfzgct7il5JPjWCqCV2IMhwizSbeBmPowUc2ByT5XPwD0e
	AnFTXba2Ps0YKAEKHvQvlvI+sAiZ15BAVtbIouI1ZHitWeXqdtxy4j9CjRe+DIOV
	BONB4WfE7oO+CKzzD43mV7K5Q016HznxveE8q3s1MtkhxPg6QW0rsiobgSufQ9/Y
	8L7/XsZldzPcT0WxFwpDWWT9uh3DQl/OQDDlgluyMspYo8emA+sd6f9lV73yW3Iz
	szsZOw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chr5p8qcu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 07:26:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bd2a2028c5so9356112eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 23:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772004400; x=1772609200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KQ2Fzv27e1/3/8/V/bE6PX7TuwoZn/JZdT9SzUi9A1w=;
        b=HkL8kESvIVSkWT/4gblRuVD90m3wooQJmQy3gU4EbtUJz2Sn4xDYcvN7j7JXYbzq/M
         UigJ00fJus9VomLLgfqOZvgJCulec2ROcHtI9PjhlziOaCWClo3OqIA/NKyLJw/4y8dL
         S4alR12KSaRVIWSLZsvfYMWKs7BKZcfdGguYhLUaq/EKk4do6LhEVN12SqI+uXDWlUAn
         Qs2SyIPnnWIo3m24sekQ7ro+8EVHvBrnqC8VJCk5RbS3//4UC0y9l0N3yXSJqh+NUEi8
         7XhJYy/JH5h5fNxwEidbmaRTpObitkug+XkvkbpvIgIQtTjdXrUIh2Xfk3UqB6W1mxbA
         dUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004400; x=1772609200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQ2Fzv27e1/3/8/V/bE6PX7TuwoZn/JZdT9SzUi9A1w=;
        b=f/k81/462iVZ/u32HfL6Ffv8usprABkFEHHM0fISPqAN88OtV59A4NUCGGynxi2ZNA
         oR9FJGR3KrjfiBEjXIh5igpcINQhavTtp5QZEZGvI6EUD0CZEZXuzVkT94VpQ50a4U3P
         Uq2GQqtr2MY1QfNue5fU9NkNjiETSzgkLqnC49eWTcq3sNFpqbLrV6wp7+kjk6hpeony
         6wN7owaNVuWZuq23REdU03l7ilqLkqCPqox0UFvgvPOtKTU6QtLy19IE3ixG+r/2FJ5G
         oglF/8aD/mhuVtNApaFBKePGd/Jj8FyX6kRDU9SLqYVUpZyoQdoHR3f7I4LCOc5Utijx
         GSlA==
X-Forwarded-Encrypted: i=1; AJvYcCU7+u5ar6E183hm+RfrvoPVW0rwQW8YUd7F+oXQnoYMzleztDNDTZYZ4fa/+5QrPuSOtqEDQIALDPWc+lyx4Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Wp/RpW/lYPYdhQ4MWa3FO7LEObjbtvzLkPUpgsPJB8Q7qoAd
	7wKoFTugSGGsJzgWNz2Hpvm3JSialJtU8us6SInxdcrhasGDCLgfLxedR5GTyG54nRUf3IHuUuN
	1QVviySqiTF9cLyxbwILSdsfxXoTTcVj9eWy0iNv9sGJlEmZ6Y0hE3T4GDpDujAFhdYddwQf33t
	bLTnKJfmni
X-Gm-Gg: ATEYQzxT52NJoAvrUHN8V+QXulgvRRntqtu+LcmKsg4DMKbZhi5Xm6yIr7czMDgkZvj
	QO/jc/2+jBe6DyIVD4IQ1qPksRSw8DvemQMKiOKkJE9XKGpmaYEkt4G+1q23LhUgZ4q8J5IIkbA
	VFYw2nDa3We/TXcrlG+r68AWhPzFLQrG1/xjh7+ReM8LorRoHTyO/Kc3qn+Xp4mrJ4IuN6Jxi6w
	vt2051E1X3BGem4jhgL/t/kekj9BE+0yFVjYDNyL3o2L3DY0jXW5PdxHKzwv3ONBfCSiI2RXu+F
	OCCSrt4Rsivtwzo8Zdfykjxvcg+uNhVf0zVm2bnvCWYs1nAE9n5B9Ubr0PLAtfArr8HFB1PdIo/
	BhaZRnpX1pC3wjJCYy3gHk6WDIHX1G+iKumyy1CfPWIpogllvF4jwzeNWhMjJm5A6w362QIPYcw
	M=
X-Received: by 2002:a05:7300:a883:b0:2b7:da62:a5f9 with SMTP id 5a478bee46e88-2bdc33841bbmr520384eec.18.1772004399399;
        Tue, 24 Feb 2026 23:26:39 -0800 (PST)
X-Received: by 2002:a05:7300:a883:b0:2b7:da62:a5f9 with SMTP id 5a478bee46e88-2bdc33841bbmr520375eec.18.1772004398737;
        Tue, 24 Feb 2026 23:26:38 -0800 (PST)
Received: from [10.110.71.223] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe8198sm8342722eec.22.2026.02.24.23.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 23:26:38 -0800 (PST)
Message-ID: <cd95b358-5c1e-4d5f-89d4-e2133797c8ac@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 15:26:35 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v1] shared/att: Simplify logic of DB out of sync
 recovery
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20260224185524.4044679-1-luiz.dentz@gmail.com>
 <CABBYNZJAETpL_0XDVhZ7O6iKdQ+XPjdQdtydt0x99+BwUow4OA@mail.gmail.com>
Content-Language: en-US
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
In-Reply-To: <CABBYNZJAETpL_0XDVhZ7O6iKdQ+XPjdQdtydt0x99+BwUow4OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA3MCBTYWx0ZWRfX0h49MudxBvSO
 zkwahTEp2jrH4Eemye57tHyPpnDaMpfT9O0WJfFlEq3z6I2TKqYITDMFvrzjQohLSwH5BDRXuCF
 iq96Jo/+qOUsklsIxM4hrz/W0fzYgrF8iSJIyvLjWiNICHLVMOLXsM41FCcYwswR3PNYY7gbBI/
 nCC7ZO8gFrKmqtQx572NTl6doQyRfETxp8MVpFTGiGrrcO8Wy1SdrOf9JqUpRM4VkXV9/x7D1V2
 X6muNT5FftPU1mqndHootSNppY/9WeZRtA98pGY6omdm3rkFl10yghr4bxZQmYXqhFmLWRO+cMU
 ZknAfBxtWAyW6TBTAC9rxc6F9ive7Mg8boCqnUECZ806a+a23jF1nOpqoI8+tKSBzTv3zIrrOMr
 5G/yz3l8qpSP4MwWx7aBo4XMVnjlrYIShJjbMyeH/juDGjikndqjgnJayxOc9C8eeWzxwypS2la
 xxeHDn3W8eCSFo3fOsQ==
X-Authority-Analysis: v=2.4 cv=GstPO01C c=1 sm=1 tr=0 ts=699ea431 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=8iviselvqQs2hdz9KGoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: EHLDf4vFFpEGWGvxmXbXE1Ut0Yv3jT5B
X-Proofpoint-ORIG-GUID: EHLDf4vFFpEGWGvxmXbXE1Ut0Yv3jT5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250070

Hi Luiz,

On 2/25/2026 3:10 AM, Luiz Augusto von Dentz wrote:
> Hi Mengshi,
> 
> On Tue, Feb 24, 2026 at 1:55 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This removes struct pending_db_sync since it is not really necessary
>> to record all the field in bt_att_pdu_error_rsp, most of them can be
>> directly recovered from the original request and the ecode is meant
>> to be only BT_ATT_ERROR_DB_OUT_OF_SYNC.
>> ---
>>  src/shared/att.c | 101 ++++++++++++++---------------------------------
>>  1 file changed, 30 insertions(+), 71 deletions(-)
>>
>> diff --git a/src/shared/att.c b/src/shared/att.c
>> index f6236248874c..3d3c8cfa262a 100644
>> --- a/src/shared/att.c
>> +++ b/src/shared/att.c
>> @@ -35,7 +35,6 @@
>>  #define BT_ATT_SIGNATURE_LEN           12
>>
>>  struct att_send_op;
>> -struct pending_db_sync;
>>
>>  struct bt_att_chan {
>>         struct bt_att *att;
>> @@ -48,7 +47,7 @@ struct bt_att_chan {
>>
>>         struct att_send_op *pending_req;
>>         struct att_send_op *pending_ind;
>> -       struct pending_db_sync *pending_db_sync;
>> +       struct att_send_op *pending_db_sync;
>>         bool writer_active;
>>
>>         bool in_req;                    /* There's a pending incoming request */
>> @@ -205,11 +204,6 @@ struct att_send_op {
>>         void *user_data;
>>  };
>>
>> -struct pending_db_sync {
>> -       struct att_send_op *op;
>> -       struct bt_att_pdu_error_rsp error;
>> -};
>> -
>>  static void destroy_att_send_op(void *data)
>>  {
>>         struct att_send_op *op = data;
>> @@ -655,10 +649,8 @@ static void bt_att_chan_free(void *data)
>>         if (chan->pending_ind)
>>                 destroy_att_send_op(chan->pending_ind);
>>
>> -       if (chan->pending_db_sync) {
>> -               destroy_att_send_op(chan->pending_db_sync->op);
>> -               free(chan->pending_db_sync);
>> -       }
>> +       if (chan->pending_db_sync)
>> +               destroy_att_send_op(chan->pending_db_sync);
>>
>>         queue_destroy(chan->queue, destroy_att_send_op);
>>
>> @@ -699,8 +691,7 @@ static bool disconnect_cb(struct io *io, void *user_data)
>>         }
>>
>>         if (chan->pending_db_sync) {
>> -               disc_att_send_op(chan->pending_db_sync->op);
>> -               free(chan->pending_db_sync);
>> +               disc_att_send_op(chan->pending_db_sync);
>>                 chan->pending_db_sync = NULL;
>>         }
>>
>> @@ -828,15 +819,6 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
>>         /* Check if this is DB_OUT_OF_SYNC and we have a callback */
>>         if (rsp->ecode == BT_ATT_ERROR_DB_OUT_OF_SYNC &&
>>                                 att->db_sync_callback) {
>> -               struct pending_db_sync *pending;
>> -
>> -               pending = new0(struct pending_db_sync, 1);
>> -               if (!pending)
>> -                       return false;
>> -
>> -               pending->op = op;
>> -               pending->error = *rsp;
>> -
>>                 /* Remove timeout since we're waiting for approval */
>>                 if (op->timeout_id) {
>>                         timeout_remove(op->timeout_id);
>> @@ -844,13 +826,13 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
>>                 }
>>
>>                 /* Move to pending_db_sync */
>> -               chan->pending_db_sync = pending;
>> +               chan->pending_db_sync = op;
>>                 chan->pending_req = NULL;
>>
>>                 DBG(att, "(chan %p) DB out of sync for operation %p", chan, op);
>>
>>                 /* Notify upper layer */
>> -               att->db_sync_callback(&pending->error, op->pdu + 1, op->len - 1,
>> +               att->db_sync_callback(rsp, op->pdu + 1, op->len - 1,
>>                                       op->id, att->db_sync_data);
>>
>>                 return true;
>> @@ -1726,7 +1708,6 @@ int bt_att_resend(struct bt_att *att, unsigned int id, uint8_t opcode,
>>  {
>>         const struct queue_entry *entry;
>>         struct att_send_op *op;
>> -       bool from_db_sync = false;
>>         bool result;
>>
>>         if (!att || !id)
>> @@ -1741,40 +1722,18 @@ int bt_att_resend(struct bt_att *att, unsigned int id, uint8_t opcode,
>>                         break;
>>
>>                 /* Also check pending_db_sync */
>> -               if (chan->pending_db_sync &&
>> -                               chan->pending_db_sync->op->id == id) {
>> -                       from_db_sync = true;
>> -                       break;
>> +               if (chan->pending_db_sync && chan->pending_db_sync->id == id) {
>> +                       op = chan->pending_db_sync;
>> +                       chan->pending_db_sync = NULL;
>> +                       DBG(att, "(chan %p) Resending DB out of sync operation"
>> +                               " %p", chan, op);
>> +                       goto done;
>>                 }
>>         }
>>
>>         if (!entry)
>>                 return -ENOENT;
>>
>> -       /* If from pending_db_sync, extract operation details if not provided */
>> -       if (from_db_sync) {
>> -               struct bt_att_chan *chan = entry->data;
>> -               struct pending_db_sync *pending = chan->pending_db_sync;
>> -               struct att_send_op *stored_op = pending->op;
>> -
>> -               /* Auto-extract from stored operation if pdu is NULL */
>> -               if (!pdu) {
>> -                       opcode = stored_op->opcode;
>> -                       pdu = stored_op->pdu + 1;
>> -                       length = stored_op->len - 1;
>> -                       callback = stored_op->callback;
>> -                       user_data = stored_op->user_data;
>> -                       destroy = stored_op->destroy;
>> -               }
>> -
>> -               DBG(att, "(chan %p) Resending DB out of sync operation %p",
>> -                       chan, stored_op);
>> -
>> -               /* Clear pending_db_sync state */
>> -               chan->pending_db_sync = NULL;
>> -               free(pending);
>> -       }
>> -
>>         /* Only allow requests to be resend */
>>         if (get_op_type(opcode) != ATT_OP_TYPE_REQ)
>>                 return -EOPNOTSUPP;
>> @@ -1786,6 +1745,7 @@ int bt_att_resend(struct bt_att *att, unsigned int id, uint8_t opcode,
>>
>>         op->id = id;
>>
>> +done:
>>         switch (opcode) {
>>         /* Only prepend requests that could be a continuation */
>>         case BT_ATT_OP_READ_BLOB_REQ:
>> @@ -1873,30 +1833,29 @@ bool bt_att_chan_cancel(struct bt_att_chan *chan, unsigned int id)
>>
>>  static bool bt_att_db_sync_cancel(struct bt_att_chan *chan, unsigned int id)
>>  {
>> -       if (chan->pending_db_sync && chan->pending_db_sync->op->id == id) {
>> -               struct pending_db_sync *pending = chan->pending_db_sync;
>> -               struct att_send_op *op = pending->op;
>> -               uint8_t error_pdu[sizeof(struct bt_att_pdu_error_rsp)];
>> +       struct att_send_op *op = chan->pending_db_sync;
>> +       struct bt_att_pdu_error_rsp rsp;
>>
>> -               /* Build error response PDU */
>> -               memcpy(error_pdu, &pending->error, sizeof(pending->error));
>> +       if (!op || op->id != id)
>> +               return false;
>>
>> -               /* Clear pending state */
>> -               chan->pending_db_sync = NULL;
>> -               free(pending);
>> +       /* Build error response PDU */
>> +       memset(&rsp, 0, sizeof(rsp));
>> +       rsp.opcode = op->opcode;
>> +       rsp.ecode = BT_ATT_ERROR_DB_OUT_OF_SYNC;
>>
>> -               /* Notify callback with error */
>> -               if (op->callback)
>> -                       op->callback(BT_ATT_OP_ERROR_RSP, error_pdu,
>> -                                    sizeof(error_pdu), op->user_data);
>> +       /* Clear pending state */
>> +       chan->pending_db_sync = NULL;
>>
>> -               destroy_att_send_op(op);
>> -               wakeup_chan_writer(chan, NULL);
>> +       /* Notify callback with error */
>> +       if (op->callback)
>> +               op->callback(BT_ATT_OP_ERROR_RSP, &rsp, sizeof(rsp),
>> +                                               op->user_data);
>>
>> -               return true;
>> -       }
>> +       destroy_att_send_op(op);
>> +       wakeup_chan_writer(chan, NULL);
>>
>> -       return false;
>> +       return true;
>>  }
>>
>>  static bool bt_att_disc_cancel(struct bt_att *att, unsigned int id)
>> --
>> 2.52.0
> 
> Can you verify these changes don't break anything you were testing?
> 

I have verified these changes, and they work as expected. Thank you
for kindly helping to simplify and improve the implementation.


Hash Match Case:
------------------
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x000d
        Error: Database Out of Sync (0x12)
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 24
      ATT: Read By Type Response (0x09) len 19
        Attribute data length: 18
        Attribute data list: 1 entry
        Handle: 0x000f
        Value: f74347d19eef647d97f0b2f7af502e33
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 6
      ATT: Read Response (0x0b) len 1
-------------

Hash differ case:
-------------
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x000d
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x000d
        Error: Database Out of Sync (0x12)
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 24
      ATT: Read By Type Response (0x09) len 19
        Attribute data length: 18
        Attribute data list: 1 entry
        Handle: 0x000f
        Value: 3a6ba4cd08cf5b7f96e542822cb1b4e5
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 24
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x0007
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0008-0x0011
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0012-0x0014
        UUID: Device Information (0x180a)
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0015-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 26
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute group list: 1 entry
        Handle range: 0x0025-0x0028
        UUID: Vendor specific (12345678-1234-5678-1234-56789abcdef0)
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0029-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0029
        Error: Attribute Not Found (0x0a)
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Secondary Service (0x2801)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0015-0x0028
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0015
        Error: Attribute Not Found (0x0a)
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0015-0x0028
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 27
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 21
        Attribute data list: 1 entry
        Handle: 0x0026
        Value: 1a2700f1debc9a785634127856341278563412
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0027-0x0028
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0027
        Error: Attribute Not Found (0x0a)
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 24
      ATT: Read By Type Response (0x09) len 19
        Attribute data length: 18
        Attribute data list: 1 entry
        Handle: 0x000f
        Value: 3a6ba4cd08cf5b7f96e542822cb1b4e5
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
bluetoothd[17265]: < ACL Data TX: Handle 4 flags 0x00 dlen 9
      ATT: Write Request (0x12) len 4
        Handle: 0x000b
          Data: 0200
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 4
        Count: 1
> ACL Data RX: Handle 4 flags 0x02 dlen 5
      ATT: Write Response (0x13) len 0




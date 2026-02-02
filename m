Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E81D7E41
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Feb 2026 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770000397; cv=none; b=DAX37T68WjNpBP6/XGgIuD6HSbtvQRXzBR4mzxTyX8s2k6XlQdSulS9fAqQgk+eAv3vLetdUS06TfaRMLi5Va9G7NnpgTvKZspiK83ehrHB7TPmpHGGxsThg05pII/2/LX2Myd7OJDrVxPKDGtRAgK8eD1DW9J0V9Fube9PkK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770000397; c=relaxed/simple;
	bh=rMJjFoHgrz8FVSrbNq8GFOlKIkSgJ1ctHhPHtHOah/Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LIAw2/H1HucUIvNRmhHrqSPJxX1JpQYxN+eTouzhX4RrZCjE2PJrlPaoDaWngYVZ3V48HdaaRBDEFOidZywSN+aoJWfQOIPXODlUuLEZlEAWCIL8JCrHHFXXD4ht0X402fUyYTbh8pT4PJTEdBg5KFwSguCPM+OELLQIhXovRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RqfuaQQi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XJ/cBNRg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RqfuaQQi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XJ/cBNRg"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 611MmWMf2343019
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Feb 2026 02:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iou3CvbcVHvDHd5H6nwaOHH4j1nND+pDEkw/2wtwW/Q=; b=RqfuaQQi/EKUO5Vt
	4r/ZZJeS51oflVMEIhy6IfkWly2J3LYXz6BY5FV8T6zUS8pT+4KIqotNVNSnKXQl
	h7l/K3JwjwFseCMfkFhizqm84gULb3ZoRvYKHZFqAbNojOQOOqibWkgJ3J2PQMaJ
	P2obhBQK4t3T9QOrX6/YOLNbw0Td70lBcddaUkmGKwNGLPIT8JJqRpOEzOCemt2z
	esNIKT+80/eAiOrKPrc1Q9vVnTQYZiNvw70q8Ot1sULP02sQWenFT8By5gwsXIPZ
	qg3hZuiHXjjc0bVIIGpicQMvvZPpOrozJTNWvlPNrfw7yZhuKTIVHx5yYowz0NfR
	9LMFhQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1ard3nka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Feb 2026 02:46:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b71bdcd037so2884134eec.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Feb 2026 18:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770000394; x=1770605194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Iou3CvbcVHvDHd5H6nwaOHH4j1nND+pDEkw/2wtwW/Q=;
        b=XJ/cBNRg5kKLlLRqSc5/yE4zaJkQmc8u8vtiOEeQr2LLGGhmKtrt+/a4Cwc0TnkxqX
         fL0vPkEmAHehSWwx/4YXvwXVQVSJccX8kkdIeeyP28CB98HkxVKep+iy7utWOEowknWB
         kCNmBD4ITR57ppjm4xs55cr9TBT8wmRLmHes9As2cEYXUZEt9U+SfqVVkufEJ0gwZQ2m
         e5PAd1VTWE9uByt20e24Tmb6jtkbGHL4WtuVIVBicraKJ7L+cMMdzeWpz/ibJNW37Wsu
         ipdMIBE/2ykk6zo96SM6oVspNovW+olkhuniZKx8NMj2ipaQSkgI8GXhc6X/DA88EB38
         rQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770000394; x=1770605194;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iou3CvbcVHvDHd5H6nwaOHH4j1nND+pDEkw/2wtwW/Q=;
        b=nNh55FGdaZzuJL/uzzBQQiR8ZXmb+e8+TJiMuiLEcjRgGRXaxw+m8/mW7X/iQpSpqD
         XLWS6KZkv3A3+6yeMEAYSqYt8iITQ/q+Rc3RTWEnALdt51Rnt/tB+prBYCgUpQeW2nHo
         yfDNL2fobrSK5c7dp07EGrv+FF5mqHfEvytML7qcQ/OlYAOcAoMVvmGfcQ8HBqL58Ev5
         phvyXCovRzPUI69qwh2cUik+gwP/R9jrAzbj1B04Pc1ZnAtEcXlQ6QmmfFIZEX+q9xVz
         HOCv6JK2YewQfSUisjGfwSOAZZOI8lZJok3yBZZdcJyoaDZELKU3/nLJeby6ZpmSBKfU
         h5Bw==
X-Gm-Message-State: AOJu0YwRkMvkXGQQQfaOWWXlOxEYufawR2wTCDdOOhOKoDZsFvz9bxgn
	btHxvSArbzL0JTfWhXXtUjGS1p8d4ZRtT4f3vu46+xvGDTuwogXDlE3TWeFCDTeC745qVbNGTFW
	KmlkFgNZG+Ys0Yt9V/tc4KmzUkXUFpDtvBeTuRWUyTHjsY1Li/NR7I+lrAwFPQOGJx5wUZ6s=
X-Gm-Gg: AZuq6aLkfvqXivoTK6EXG81MLyjaPlDHkJMBwOoIEPWRlapjbMXzteFcw0RreVKu9YL
	E7L/EIbN5pFPgVNcNe+jcYZte4Zj9uNwu4T8Nj3v+VdQSM5xPaPia4jAith0K9qUKAMGpelbSP0
	3SiCLuJs1qMvuNKzdd2LFez7ZWDjeZQ6GdzQbc04kbO4ZDLvxeWOKpVxT3vl4YMrMPv0QYma1BV
	zMOf/KAd4gTD7axqLvgOX+vyZ7wlwg2nXFxZqTVVHIgPoym5P5bHJqtm8ofF5s043Z/D6Uejo2U
	pCmJ0F1FecInRB/WaCRqE2uPbo09hfSqyRf4oLSRM+cbqCNk9iedRvc5xq835yxnIdyLRioehMk
	9Yex35xK5r3smPsafjrf4Z9Sn5z95xkd02d5RtSLL7UQ7qfZ34Pwrl/XozObiUmI=
X-Received: by 2002:a05:7022:6182:b0:119:e569:f875 with SMTP id a92af1059eb24-125c19d7d33mr4723448c88.18.1770000393496;
        Sun, 01 Feb 2026 18:46:33 -0800 (PST)
X-Received: by 2002:a05:7022:6182:b0:119:e569:f875 with SMTP id a92af1059eb24-125c19d7d33mr4723435c88.18.1770000392777;
        Sun, 01 Feb 2026 18:46:32 -0800 (PST)
Received: from [10.110.23.229] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9de948esm18954335c88.9.2026.02.01.18.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 18:46:32 -0800 (PST)
Message-ID: <726efe12-1497-4faa-b6c9-07fac2e47972@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 10:46:28 +0800
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
 <80008178-352b-41ca-9a4f-65662a099b13@oss.qualcomm.com>
 <CABBYNZKrsOnkaRDD7AJSAPjgyXaFxCyksnvYZF6s23WfGs4nJA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZKrsOnkaRDD7AJSAPjgyXaFxCyksnvYZF6s23WfGs4nJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDAyMiBTYWx0ZWRfX/fDyDMzIOMk4
 ZavxLIyUcy8fPOjMXbSI9dUJ7q5EugIOZ2B8tYbCAcDxwUzYBkCz14l+bKxxsXzBc96Sbc0WhZG
 8t+HW+5qnAB+CTScF1r7whGH63KjhNABoB9P1YMSPA9TrHsqmo6w3zjdtnXRxRnf3xRtQuamSE+
 nVeGV/h8iIRI/1gD2W4c+2TfY8PPPm7lOnCWdkUI7ijgPFpXD1k+UwSA21p7m4eb9cKH1oJyhSy
 60EL8FdLmD7J1ORDMQzC2wcCYEt+8hddf0J0HMblQIoe8jJUbo1JTVIDXXL1+SOkClJd+rM5rlW
 HIWhmCN/N/QGmGHi+dL8nvoju/1y9NIEAww7d/RSfr2KK90SssPteIlGL7JBXVFWLpPqm2XFQ23
 wFw6A9Tv0zWRTj620Qu98TRqCBmqlV7eZ1z2u/0mi63NJ9BittsCF2qiiBaFqZLdmMnz6QXXNar
 9p0X3nIqeB1DdsyM8gQ==
X-Authority-Analysis: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=6980100a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=xtnd2KrZXPpRa2HEhkkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: gX1difuEzJXw4qS1dbDUfD3sHh4EDfI6
X-Proofpoint-GUID: gX1difuEzJXw4qS1dbDUfD3sHh4EDfI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_01,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020022

Hi Luiz,

On 1/27/2026 11:35 PM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Mon, Jan 26, 2026 at 5:44 AM Mengshi Wu <mengshi.wu@oss.qualcomm.com> wrote:
>>
>> Hi Luiz,
>>
>> Thanks for your comments.
>>
>> On 1/22/2026 2:15 AM, Luiz Augusto von Dentz wrote:
>>> Hi Mengshi,
>>>
>>> On Wed, Jan 21, 2026 at 3:38 AM Mengshi Wu <mengshi.wu@oss.qualcomm.com> wrote:
>>>>
>>>> Add a retry mechanism for ATT operations that allows upper layers to
>>>> decide whether to retry failed requests. This includes:
>>>>
>>>> - Add retry callback registration (bt_att_set_retry_cb) to allow
>>>>   applications to handle retry decisions
>>>> - Implement pending_retry state tracking in att_send_op to store
>>>>   operations awaiting retry approval
>>>> - Add bt_att_retry_request() and bt_att_cancel_retry() functions to
>>>>   approve or reject retry attempts
>>>> - Store error PDUs during retry_pending state for callback inspection
>>>> - Modify handle_error_rsp() to return retry decision codes instead of
>>>>   boolean values
>>>> - Add BT_ATT_RETRY_* constants for retry decision handling
>>>> - Update GATT helpers to support retry callbacks for operations like
>>>>   discovery and read/write requests
>>>>
>>>> This enables more robust error handling by allowing the application
>>>> layer to implement custom retry logic based on ATT error codes.
>>>>
>>>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
>>>> ---
>>>>  src/shared/att.c | 182 +++++++++++++++++++++++++++++++++++++++++++++--
>>>>  src/shared/att.h |  16 +++++
>>>>  2 files changed, 191 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/src/shared/att.c b/src/shared/att.c
>>>> index 77ca4aa24..4ae97530a 100644
>>>> --- a/src/shared/att.c
>>>> +++ b/src/shared/att.c
>>>> @@ -47,6 +47,7 @@ struct bt_att_chan {
>>>>
>>>>         struct att_send_op *pending_req;
>>>>         struct att_send_op *pending_ind;
>>>> +       struct att_send_op *pending_retry;
>>>>         bool writer_active;
>>>>
>>>>         bool in_req;                    /* There's a pending incoming request */
>>>> @@ -78,6 +79,10 @@ struct bt_att {
>>>>         bt_att_destroy_func_t timeout_destroy;
>>>>         void *timeout_data;
>>>>
>>>> +       bt_att_retry_func_t retry_callback;
>>>> +       bt_att_destroy_func_t retry_destroy;
>>>> +       void *retry_data;
>>>
>>> Why do we need these fields? The bt_att_chan already have this data as
>>> part of pending_retry, so this sound duplicated to me, or is this this
>>> just to register for retry callback?
>>
>> These fields serve different purposes. The callback in att_send_op
>> (pending_retry in bt_att_chan) is triggered too late to handle a deferred
>> retry. By the time this callback is executed, the retry opportunity has
>> already been lost. Therefore, I added this new callback that checks whether
>> a retry is pending beforehand.
> 
> Don't really understand, it seems to me that the retry callback here
> is not used for retrying but instead to check if a request needs
> retrying by upper layer (gatt-client).
> 

retry_callback is used for validation, not for performing the retry itself.
I should rename it to avoid confusion. As we discussed earlier, we need additional
information—such as the affected handle range and the DB hash value—to determine
whether an ATT request can be recovered. This is why I introduced this callback:
it allows the GATT layer to verify the DB hash and affected handle range when
available.

>>>
>>>> +
>>>>         uint8_t debug_level;
>>>>         bt_att_debug_func_t debug_callback;
>>>>         bt_att_destroy_func_t debug_destroy;
>>>> @@ -194,6 +199,9 @@ struct att_send_op {
>>>>         void *pdu;
>>>>         uint16_t len;
>>>>         bool retry;
>>>> +       bool retry_pending;  /* Waiting for approval to retry */
>>>> +       uint8_t *error_pdu;  /* Stored error PDU for retry_pending */
>>>> +       uint16_t error_pdu_len;
>>>
>>> These fields are definitely not needed, juist reuse pdu, len and retry
>>> fields, you are already adding a dedicated field for them in
>>> bt_att_chan.pending_retry.
>>
>> These fields store the received error‑response PDU, not the original ATT
>> request PDU, which is already kept in the pdu/len fields. We need to keep
>> the error information because, if recovery fails, the error will be
>> propagated to the upper layer.
> 
> Well, afaik there is only one error that needs this sort of handling,
> so this is suboptimal at best, I would assume if could just use the
> chan.pending_db_sync to store the pending op and that already tell
> exactly what it is for, rather than using a generic retry mechanism
> which we don't know we will need in the future.
> 

OK, this may not be a common retry mechanism. Should I pack them into a
new structure (such as chan.pending_db_sync)?

>>
>>>
>>>>         bt_att_response_func_t callback;
>>>>         bt_att_destroy_func_t destroy;
>>>>         void *user_data;
>>>> @@ -210,6 +218,7 @@ static void destroy_att_send_op(void *data)
>>>>                 op->destroy(op->user_data);
>>>>
>>>>         free(op->pdu);
>>>> +       free(op->error_pdu);
>>>>         free(op);
>>>>  }
>>>>
>>>> @@ -644,6 +653,9 @@ static void bt_att_chan_free(void *data)
>>>>         if (chan->pending_ind)
>>>>                 destroy_att_send_op(chan->pending_ind);
>>>>
>>>> +       if (chan->pending_retry)
>>>> +               destroy_att_send_op(chan->pending_retry);
>>>> +
>>>>         queue_destroy(chan->queue, destroy_att_send_op);
>>>>
>>>>         io_destroy(chan->io);
>>>> @@ -682,6 +694,11 @@ static bool disconnect_cb(struct io *io, void *user_data)
>>>>                 chan->pending_ind = NULL;
>>>>         }
>>>>
>>>> +       if (chan->pending_retry) {
>>>> +               disc_att_send_op(chan->pending_retry);
>>>> +               chan->pending_retry = NULL;
>>>> +       }
>>>> +
>>>>         bt_att_chan_free(chan);
>>>>
>>>>         /* Don't run disconnect callback if there are channels left */
>>>> @@ -777,16 +794,17 @@ static bool change_security(struct bt_att_chan *chan, uint8_t ecode)
>>>>         return bt_att_chan_set_security(chan, security);
>>>>  }
>>>>
>>>> -static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
>>>> +static int handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
>>>>                                         ssize_t pdu_len, uint8_t *opcode)
>>>>  {
>>>>         struct bt_att *att = chan->att;
>>>>         const struct bt_att_pdu_error_rsp *rsp;
>>>>         struct att_send_op *op = chan->pending_req;
>>>> +       int should_retry = BT_ATT_RETRY_NO;
>>>>
>>>>         if (pdu_len != sizeof(*rsp)) {
>>>>                 *opcode = 0;
>>>> -               return false;
>>>> +               return should_retry;
>>>>         }
>>>>
>>>>         rsp = (void *) pdu;
>>>> @@ -797,11 +815,43 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
>>>>          * the security again.
>>>>          */
>>>>         if (op->retry)
>>>> -               return false;
>>>> +               return should_retry;
>>>>
>>>>         /* Attempt to change security */
>>>> -       if (!change_security(chan, rsp->ecode))
>>>> -               return false;
>>>> +       if (change_security(chan, rsp->ecode)) {
>>>> +               should_retry = BT_ATT_RETRY_YES;
>>>> +       } else if (att->retry_callback) {
>>>> +               should_retry = att->retry_callback(op->opcode, rsp->ecode,
>>>> +                                                  op->pdu + 1, op->len - 1,
>>>> +                                                  op->id, att->retry_data);
>>>> +
>>>> +               /* Check if callback wants to defer the retry decision */
>>>> +               if (should_retry == BT_ATT_RETRY_PENDING) {
>>>> +                       op->retry_pending = true;
>>>> +
>>>> +                       /* Store error PDU for later use */
>>>> +                       op->error_pdu = malloc(pdu_len);
>>>> +                       if (op->error_pdu) {
>>>> +                               memcpy(op->error_pdu, pdu, pdu_len);
>>>> +                               op->error_pdu_len = pdu_len;
>>>> +                       }
>>>> +
>>>> +                       /* Remove timeout since we're waiting for approval */
>>>> +                       if (op->timeout_id) {
>>>> +                               timeout_remove(op->timeout_id);
>>>> +                               op->timeout_id = 0;
>>>> +                       }
>>>> +
>>>> +                       /* Move from pending_req to pending_retry */
>>>> +                       chan->pending_retry = op;
>>>> +
>>>> +                       DBG(att, "(chan %p) Retry pending for operation %p",
>>>> +                           chan, op);
>>>> +               }
>>>> +       }
>>>> +
>>>> +       if (should_retry != BT_ATT_RETRY_YES)
>>>> +               return should_retry;
>>>>
>>>>         /* Remove timeout_id if outstanding */
>>>>         if (op->timeout_id) {
>>>> @@ -815,7 +865,8 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
>>>>         op->retry = true;
>>>>
>>>>         /* Push operation back to channel queue */
>>>> -       return queue_push_head(chan->queue, op);
>>>> +       return queue_push_head(chan->queue, op) ?
>>>> +               BT_ATT_RETRY_YES : BT_ATT_RETRY_NO;
>>>>  }
>>>>
>>>>  static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
>>>> @@ -845,9 +896,15 @@ static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
>>>>          */
>>>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>                 /* Return if error response cause a retry */
>>>> -               if (handle_error_rsp(chan, pdu, pdu_len, &req_opcode)) {
>>>> +               switch (handle_error_rsp(chan, pdu, pdu_len, &req_opcode)) {
>>>> +               case BT_ATT_RETRY_PENDING:
>>>> +                       /* Operation moved to pending_retry, clear pending_req */
>>>> +                       chan->pending_req = NULL;
>>>> +               case BT_ATT_RETRY_YES:
>>>>                         wakeup_chan_writer(chan, NULL);
>>>>                         return;
>>>> +               default:
>>>> +                       break;
>>>>                 }
>>>>         } else if (!(req_opcode = get_req_opcode(opcode)))
>>>>                 goto fail;
>>>> @@ -1142,6 +1199,9 @@ static void bt_att_free(struct bt_att *att)
>>>>         if (att->timeout_destroy)
>>>>                 att->timeout_destroy(att->timeout_data);
>>>>
>>>> +       if (att->retry_destroy)
>>>> +               att->retry_destroy(att->retry_data);
>>>> +
>>>>         if (att->debug_destroy)
>>>>                 att->debug_destroy(att->debug_data);
>>>>
>>>> @@ -1473,6 +1533,23 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
>>>>         return true;
>>>>  }
>>>>
>>>> +bool bt_att_set_retry_cb(struct bt_att *att, bt_att_retry_func_t callback,
>>>> +                                               void *user_data,
>>>> +                                               bt_att_destroy_func_t destroy)
>>>> +{
>>>> +       if (!att)
>>>> +               return false;
>>>> +
>>>> +       if (att->retry_destroy)
>>>> +               att->retry_destroy(att->retry_data);
>>>> +
>>>> +       att->retry_callback = callback;
>>>> +       att->retry_destroy = destroy;
>>>> +       att->retry_data = user_data;
>>>> +
>>>> +       return true;
>>>> +}
>>>> +
>>>>  unsigned int bt_att_register_disconnect(struct bt_att *att,
>>>>                                         bt_att_disconnect_func_t callback,
>>>>                                         void *user_data,
>>>> @@ -2051,6 +2128,97 @@ bool bt_att_has_crypto(struct bt_att *att)
>>>>         return att->crypto ? true : false;
>>>>  }
>>>>
>>>> +bool bt_att_retry_request(struct bt_att *att, unsigned int id)
>>>> +{
>>>> +       const struct queue_entry *entry;
>>>> +       struct bt_att_chan *chan = NULL;
>>>> +       struct att_send_op *op;
>>>> +
>>>> +       if (!att || !id)
>>>> +               return false;
>>>> +
>>>> +       /* Find the channel with the pending retry operation */
>>>> +       for (entry = queue_get_entries(att->chans); entry;
>>>> +                                               entry = entry->next) {
>>>> +               struct bt_att_chan *c = entry->data;
>>>> +
>>>> +               if (c->pending_retry && c->pending_retry->id == id &&
>>>> +                   c->pending_retry->retry_pending) {
>>>> +                       chan = c;
>>>> +                       op = c->pending_retry;
>>>> +                       break;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       if (!chan || !op)
>>>> +               return false;
>>>> +
>>>> +       DBG(att, "(chan %p) Approving retry for operation %p", chan, op);
>>>> +
>>>> +       /* Clear pending retry state and mark for retry */
>>>> +       op->retry_pending = false;
>>>> +       op->retry = true;
>>>> +       chan->pending_retry = NULL;
>>>> +
>>>> +       /* Free stored error PDU as we're retrying */
>>>> +       free(op->error_pdu);
>>>> +       op->error_pdu = NULL;
>>>> +       op->error_pdu_len = 0;
>>>> +
>>>> +       /* Push operation back to channel queue for retry */
>>>> +       if (!queue_push_head(chan->queue, op))
>>>> +               return false;
>>>> +
>>>> +       /* Wake up writer to send the retry */
>>>> +       wakeup_chan_writer(chan, NULL);
>>>> +
>>>> +       return true;
>>>> +}
>>>> +
>>>> +bool bt_att_cancel_retry(struct bt_att *att, unsigned int id)
>>>> +{
>>>> +       const struct queue_entry *entry;
>>>> +       struct bt_att_chan *chan = NULL;
>>>> +       struct att_send_op *op;
>>>> +
>>>> +       if (!att || !id)
>>>> +               return false;
>>>> +
>>>> +       /* Find the channel with the pending retry operation */
>>>> +       for (entry = queue_get_entries(att->chans); entry;
>>>> +                                               entry = entry->next) {
>>>> +               struct bt_att_chan *c = entry->data;
>>>> +
>>>> +               if (c->pending_retry && c->pending_retry->id == id &&
>>>> +                   c->pending_retry->retry_pending) {
>>>> +                       chan = c;
>>>> +                       op = c->pending_retry;
>>>> +                       break;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       if (!chan || !op)
>>>> +               return false;
>>>> +
>>>> +       DBG(att, "(chan %p) Canceling retry for operation %p", chan, op);
>>>> +
>>>> +       /* Clear pending retry state */
>>>> +       op->retry_pending = false;
>>>> +       chan->pending_retry = NULL;
>>>> +
>>>> +       /* Call the callback with stored error PDU to notify upper layer */
>>>> +       if (op->callback)
>>>> +               op->callback(BT_ATT_OP_ERROR_RSP, op->error_pdu,
>>>> +                            op->error_pdu_len, op->user_data);
>>>> +
>>>> +       destroy_att_send_op(op);
>>>> +
>>>> +       /* Wake up writer in case there are other operations */
>>>> +       wakeup_chan_writer(chan, NULL);
>>>> +
>>>> +       return true;
>>>> +}
>>>> +
>>>>  bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry)
>>>>  {
>>>>         struct att_send_op *op;
>>>> diff --git a/src/shared/att.h b/src/shared/att.h
>>>> index 53a3f7a2a..6dc9944bb 100644
>>>> --- a/src/shared/att.h
>>>> +++ b/src/shared/att.h
>>>> @@ -46,6 +46,15 @@ typedef void (*bt_att_disconnect_func_t)(int err, void *user_data);
>>>>  typedef void (*bt_att_exchange_func_t)(uint16_t mtu, void *user_data);
>>>>  typedef bool (*bt_att_counter_func_t)(uint32_t *sign_cnt, void *user_data);
>>>>
>>>> +/* Return values for bt_att_retry_func_t */
>>>> +#define BT_ATT_RETRY_NO        0       /* Don't retry */
>>>> +#define BT_ATT_RETRY_YES       1       /* Retry immediately */
>>>> +#define BT_ATT_RETRY_PENDING   2       /* Defer retry decision */
>>>> +
>>>> +typedef int (*bt_att_retry_func_t)(uint8_t opcode, uint8_t error_code,
>>>> +                                       const void *pdu, uint16_t length,
>>>> +                                       unsigned int att_id, void *user_data);
>>>> +
>>>>  bool bt_att_set_debug(struct bt_att *att, uint8_t level,
>>>>                         bt_att_debug_func_t callback, void *user_data,
>>>>                         bt_att_destroy_func_t destroy);
>>>> @@ -58,6 +67,13 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
>>>>                                                 void *user_data,
>>>>                                                 bt_att_destroy_func_t destroy);
>>>>
>>>> +bool bt_att_set_retry_cb(struct bt_att *att, bt_att_retry_func_t callback,
>>>> +                                               void *user_data,
>>>> +                                               bt_att_destroy_func_t destroy);
>>>> +
>>>> +bool bt_att_retry_request(struct bt_att *att, unsigned int id);
>>>> +bool bt_att_cancel_retry(struct bt_att *att, unsigned int id);
>>>
>>> Hmm, why are you not reusing bt_att_resend and bt_att_cancel? We may
>>> need to adapt bt_att_resend to locate the id in the pending_retry and
>>> then force pushing to the queue head but other than that it looks
>>> pretty similar to me, also I don't think it really needs to be sent
>>> over the same channel, since over the air it really is another request
>>> it can be enqueued in the session queue, rather than the channel
>>> queue, just as done with bt_att_resend.
>>>
>>
>> I did not reuse bt_att_resend() because it requires the original PDU and
>> respose callback as parameters, and these are not stored in the upper layer.
>> As discussed earlier, we moved these parts into att.c so that we can reuse
>> the relevant logic there.
> 
> Well you can still use it internally though, instead of duplicating
> most of its logic in a new function, anyway why does it needs to be
> called from upper layer? I though the retry_callback would be used to
> communicate to the upper layer about an error and then depending on
> the return of the callback we could resend the request directly in
> att.c.
> 
> Maybe something like the following works better:
> 
> typedef bool (*bt_att_out_of_sync_func_t)(uint8_t opcode,
>                                       const void *pdu, uint16_t length,
>                                        unsigned int att_id, void *user_data);
> 
> So if the upper layer return true it means the request should be
> resend, otherwise bt_att_response_func_t should be called.
> 

The upper layer may not be able to decide on a retry immediately. The GATT
layer cannot determine whether the failed handle is affected until it checks
the DB hash value or receives a service‑changed indication.

>> bt_att_cancel() can be reused with a few adaptations. I will remove
>> bt_att_cancel_retry().
>>
>> It does't need to be sent over the same channel, I just want to reuse an
>> existing op. I noticed that handle_error_rsp() does this.
>>
>>>>  unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
>>>>                                         const void *pdu, uint16_t length,
>>>>                                         bt_att_response_func_t callback,
>>>> --
>>>> 2.34.1
>>>>
>>>
>>>
>>
>> Best regards,
>> Mengshi Wu
> 
> 
> 


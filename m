Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3A2C0286
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353579; cv=none; b=WQ9aQ7qvPAUE/Iiukbfe9Y1uGleyAcgi1XaOIxyghvsSW4j9/VKtZI2u3oinZLyDqUE23GWSm8KhuVoPbunldhHqkTeEz5ygHiNYT2udk9dT18LOR8zlMkA5IL8VQ9/6nl1sEkCXG5gCID5tgZ5xBCr+x4Lmtgcbw3D36PDmmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353579; c=relaxed/simple;
	bh=IkRhyT3aGCWjmk+qHRI4iFol30zjeB1LggJ7d4SHvzM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nb1FDjThBvO7LyxtT78zGDT0xRIKnZZhTPVuTeW06RzVBN8WlXiVL+zcIzX6VuBMIJ8po46uaYln0V/4HP1qtHN1Wx+tAixvtJb1MX8U7GIXM9/2uOoYYOAs4bLwheRO42dZ9oY3VGcmZFxq/QPT5JNoO3M8yjGfcTFopmy9qvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l615dnTD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dlnixvx/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l615dnTD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dlnixvx/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA6DtlW2460921
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 07:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bYG8MfvqQtOGqLtFlwUJHseb/gIMCjK932IIsHnbNAQ=; b=l615dnTDvhhcwbtf
	ocYLZ01IYW1QVCauzkDoUTaSPs0x1L7S1CXEhkGVhhHnSMykNQPeA/74chlW+/Yp
	COUGsl3NSkll0Va6pkEoNuqdMTG/hA/EL7mQ495HQfNkDx9dIG78OiJg2Jo40oWa
	uua8yfq1uFlm+YqRF52Kh4xBdSIKvxKYvZS4EDNTAX7DEn/BDhiyeuFdAC7iGO9f
	KdH+Fdw2+AJJmeXmWizNuWsLjR2Z+hmeohx8LeTgnzXGFgI+n9G7r7sACvWngPH9
	9HO3fdVC7CEYsZwxAj/gtEqVnbcuWQydcF0QTEOdTF38BA+clOV3wM2Ct9huX4oR
	62Th0Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axqu5agvq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 07:59:36 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7ba9c366057so16882015b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Dec 2025 23:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765353575; x=1765958375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bYG8MfvqQtOGqLtFlwUJHseb/gIMCjK932IIsHnbNAQ=;
        b=dlnixvx/q8M5Uj+0XQJpjWAdhfpzqr71oTdnlAXji5FsyoVPU0N3UAd8NMiWXlRDOY
         +D9OKevyTSPGJNdXtC1NF2QbsrekcgOvp/fuqEiyg9QCOhig/600G+83f1WQffj3EAml
         Iw79atmCO+qnVXXKAISYWS32eN937I0KKWEWb4PgOBvrRkDiXiGnzLKw8AxYjJ75ebxY
         HcSgfMYaW+OhXsT2CNwza1O8HEwqe79pN0JBI7eYTISJml+TeJr799g05g4fjo3bY5ZP
         nqM3hvwepGMWTbbwEtZIIsQA2Iqnyuac0DQyo+cwZBao7r3bu8Lw9O7LuwQGPaUAmlnS
         H48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765353575; x=1765958375;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bYG8MfvqQtOGqLtFlwUJHseb/gIMCjK932IIsHnbNAQ=;
        b=MqxVrvDRE3tRv2j/2wIdaXoEI2FMgj8XKahZ+9VPeIJktQHUo5WYyJiVCnFB+rwnJK
         BYy/DFDBcA176bIagsKoD1QA5H46XXcmsZYvD2ztu5F/CsLPT6Q2iEactdcgcl8ujwEU
         E3lDMvD6tv+RMbKsUINSUN1dNHZdUmJlQx4g4PSF82Ix7L30TwBSuFDdAyx0K6wejvkX
         ImD6u9vJHrApQoIXy+CbHJ3ww4+bvwt0JrzA4hKRcdl4MfHVxJQmNLn+yCcFDGMGoiO1
         YHUfNQBWkvZ1JaL1p7m9jumQTPuVeoW10VjbIo9BzR8bJ4Q/OMfVaQmtJe20oAdeLtLZ
         zXHw==
X-Gm-Message-State: AOJu0YwNqZnpewsdO2R0Dcaf7gcrcuz2fCGEC9tW8euKdTmG0czqZACv
	bIFzspQYYhmTjxOglnQtjjNi5c9//ps0ZY+mY/oBb8FeVyCtHQFR7XH+gpEQtYgKs0p4qNoF9Ni
	WA06V/jiwQIxa3hTa+Gu6r8FhbQ8rlbWNSa23IKqEpAwOuNAoXzeMvfCefUCXXKsa/5Cu3esdVd
	O6l2N3ONIE
X-Gm-Gg: ASbGncvnWRxixtmRjS5mgJdj8lOBFh7cxeA27ZHIYn6kXDECOfEnHQkJUj4Y60ITgLl
	uGCKvt3RaaSERPmbZSosVqYhHsdFrxWMs5XU+Baxrqc+tkhnQKiJACyX2oDXGbPYvPWPpUYaf58
	aoSpHkBuaW6JPjxULlhWMPPZ+AMf1vOIzbiNFhNcxWfPeufdBBO/+XnO/GsPUOX0RXIQugDfK50
	b7iq0oFpeBaF4kvr1y7AJj2ZXQD5g8QRjBdvaNKgRx+bG++uuCGxx8Iwkz6ZBaXmyloSXz2oUi8
	Jc5W+zcKNTsVt6KuXo6wNh16B2i4xMlvPaoT+lkwl/qXLEP1ldtTpYig5M5z5uRKT+DaaCd580d
	cnhOLOtEOfphboxr2JW2pYGyBOgH0csIGTEk1
X-Received: by 2002:a05:6a00:2448:b0:7e8:450c:618e with SMTP id d2e1a72fcca58-7f22e49093dmr1377938b3a.37.1765353574780;
        Tue, 09 Dec 2025 23:59:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfCIjY5aJ2KsACX3+1FJxyMyMfdLEyYvXAz5rEugG3dkWN/jByjrS8WKIf875s4hswxymupQ==
X-Received: by 2002:a05:6a00:2448:b0:7e8:450c:618e with SMTP id d2e1a72fcca58-7f22e49093dmr1377913b3a.37.1765353574291;
        Tue, 09 Dec 2025 23:59:34 -0800 (PST)
Received: from [10.231.216.118] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e42d6e7a4csm17763761b3a.18.2025.12.09.23.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 23:59:33 -0800 (PST)
Message-ID: <ee21c657-5120-4dbd-8660-d2a522f8578b@oss.qualcomm.com>
Date: Wed, 10 Dec 2025 15:59:23 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: Re: [PATCH v1] gatt-client:Implement error handling for
 DB_OUT_OF_SYNC in GATT caching.
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com
References: <20251208101915.247459-1-mengshi.wu@oss.qualcomm.com>
 <CABBYNZJ=S3LHcwyXAc=gxf0RptcOC+6TPaWvoEmJquar54b3dQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZJ=S3LHcwyXAc=gxf0RptcOC+6TPaWvoEmJquar54b3dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: O6y77Wik0_J0qDAph96mVKbB2ykLXQGN
X-Authority-Analysis: v=2.4 cv=Y7/1cxeN c=1 sm=1 tr=0 ts=69392868 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=a3tpYQ5gCbRvBMh9ShMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: O6y77Wik0_J0qDAph96mVKbB2ykLXQGN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA2OCBTYWx0ZWRfX9cPJBIBOm6BU
 anIirAXZnA0K/GGkayDD4Ok6jE3zCuKuk4LTso82ArvY9/4PZG8oJ/ZHrl8hrHjhkf1+jT4cf1L
 xGBgSAjdGLk6XMy3ADnTkllm5SaePdc5l+5GB7kYuhNLs7NHgL0Jj6e70uwOGib414A/OEEQm9S
 RkQ3qoL/NJX2WwdsmyZfehwJKMCOb1kts71wh/xiWUXQxAkh0JK7ZE1uIczvB/TyyOF5DaFrkt0
 iF0u6nMNoVjfuIGz8peTFhFWe8LQ2UPR2JaLaGKJg7W7PrPVE5ute9GJ1cO0z7pFTJcbZye/+Gb
 wrZRFfFI8Fma8G8maISmBCLu16fsq217fcDtNpFqQJE5Xd1TP4eXKqOfGWb2SEoaP4dCi1Q+nKQ
 wdSVXR8YcdzS6CVGYQxjdOCaf16oPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100068

Hi,

Thank you for your comments.

On 12/8/2025 11:35 PM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Mon, Dec 8, 2025 at 5:19 AM Mengshi Wu <mengshi.wu@oss.qualcomm.com> wrote:
>>
>> Add automatic DB re-discovery on receiving BT_ATT_ERROR_DB_OUT_OF_SYNC
>> error code from ATT operations. This ensures the local GATT database
>> stays synchronized with the remote device by triggering a full service
>> discovery (handles 0x0001-0xffff) when the database becomes out of sync.
>>
>> The process_db_out_of_sync() function is now called in all ATT error
>> response handlers (read_multiple, read_long, write, execute_write,
>> prepare_write, and prep_write callbacks) to handle this error condition
>> consistently.
>>
>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
>> ---
>>  src/shared/gatt-client.c | 35 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> index f6d5dc4b7..087d4e228 100644
>> --- a/src/shared/gatt-client.c
>> +++ b/src/shared/gatt-client.c
>> @@ -1965,6 +1965,29 @@ fail:
>>                 "Failed to initiate service discovery after Service Changed");
>>  }
>>
>> +static void process_db_out_of_sync(struct bt_gatt_client *client,
>> +                                  uint8_t att_ecode)
>> +{
>> +       struct service_changed_op *op;
>> +
>> +       if (att_ecode != BT_ATT_ERROR_DB_OUT_OF_SYNC)
>> +               return;
>> +
>> +       DBG(client, "Database Out of Sync - triggering full re-discovery");
>> +
>> +       if (!client->in_svc_chngd) {
>> +               process_service_changed(client, 0x0001, 0xffff);
>> +               return;
>> +       }
>> +
>> +       op = new0(struct service_changed_op, 1);
>> +
>> +       op->start_handle = 0x0001;
>> +       op->end_handle = 0xffff;
>> +
>> +       queue_push_tail(client->svc_chngd_queue, op);
>> +}
> 
> Id just change process_error to call into db_out_sync, that said this
> is not recovering at all, it just rediscovering but the original
> request will be lost, I wonder if we should implement some backoff
> logic wait to see if the server do a service changed, read the hash
> (in case we are not doing it already), and then redo the operation.
> Also we do need to make sure we don't end up in a loop rediscovery.

At the beginning, we considered implementing recovery for failed ATT 
requests caused by a Database Out of Sync error. However, we identified 
potential risks in retrying some ATT requests after the remote device’s 
services have changed. For example, the handle in the ATT_READ_REQ PDU, 
which identifies the target attribute, may have changed on the remote 
device. Even if the retry succeeds, it might operate on the wrong 
attribute.

As usual, any ATT response error will be propagated to the application 
layer, so the operation will not be lost but will fail. We did not modify 
this behavior.

It may not be appropriate to implement recovery logic for failed ATT 
requests at the BlueZ host layer. Therefore, we only do a rediscovery 
as required by the Core Spec, Vol. 3, Part G, Section 2.5.2.1,
after receiving a Database Out of Sync error.

For the suggestion about back-off logic,

We are considering reading the remote database hash and comparing it 
with the locally stored hash before initiating rediscovery. If reading 
the remote database hash fails, we will assume that the remote GATT 
database has changed and proceed with rediscovery immediately.

As shown below, the client checks the remote database hash after 
receiving a Database Out of Sync error. If the remote services have 
changed, the client initiates rediscovery.

btmon HCI Logs:
> ACL Data RX: Handle 2 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x000d
        Error: Database Out of Sync (0x12)
bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 24
      ATT: Read By Type Response (0x09) len 19
        Attribute data length: 18
        Attribute data list: 1 entry
        Handle: 0x000f
        Value: 10d6a00f95bb0eeec55a097ccf7dead8
bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0xffff
        Attribute type: Database Hash (0x2b2a)
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 2
        Count: 1
> ACL Data RX: Handle 2 flags 0x02 dlen 9
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)

> 
>>  static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
>>                                         uint16_t length, void *user_data)
>>  {
>> @@ -2709,10 +2732,12 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>                         (!pdu && length)) {
>>                 success = false;
>>
>> -               if (opcode == BT_ATT_OP_ERROR_RSP)
>> +               if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                         att_ecode = process_error(pdu, length);
>> -               else
>> +                       process_db_out_of_sync(req->client, att_ecode);
>> +               } else {
>>                         att_ecode = 0;
>> +               }
>>
>>                 pdu = NULL;
>>                 length = 0;
>> @@ -2864,6 +2889,7 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                 success = false;
>>                 att_ecode = process_error(pdu, length);
>> +               process_db_out_of_sync(req->client, att_ecode);
>>                 goto done;
>>         }
>>
>> @@ -3050,6 +3076,7 @@ static void write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                 success = false;
>>                 att_ecode = process_error(pdu, length);
>> +               process_db_out_of_sync(req->client, att_ecode);
>>                 goto done;
>>         }
>>
>> @@ -3213,6 +3240,7 @@ static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                 success = false;
>>                 att_ecode = process_error(pdu, length);
>> +               process_db_out_of_sync(req->client, att_ecode);
>>         } else if (opcode != BT_ATT_OP_EXEC_WRITE_RSP || pdu || length)
>>                 success = false;
>>
>> @@ -3278,6 +3306,7 @@ static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                 success = false;
>>                 att_ecode = process_error(pdu, length);
>> +               process_db_out_of_sync(req->client, att_ecode);
>>                 goto done;
>>         }
>>
>> @@ -3447,6 +3476,7 @@ static void prep_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>                 success = false;
>>                 reliable_error = false;
>>                 att_ecode = process_error(pdu, length);
>> +               process_db_out_of_sync(req->client, att_ecode);
>>                 goto done;
>>         }
>>
>> @@ -3597,6 +3627,7 @@ static void exec_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>                 success = false;
>>                 att_ecode = process_error(pdu, length);
>> +               process_db_out_of_sync(req->client, att_ecode);
>>                 goto done;
>>         }
>>
>> --
>> 2.34.1
>>
>>
> 
> 


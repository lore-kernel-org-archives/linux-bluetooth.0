Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0512DDA1
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 04:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765427569; cv=none; b=pw6h7h20bWmhI3zV2LtGhcKFxrnuPAUdWOrFet70toxY9VouXGnLoz72SpdU4nlvYdh0YLX9/g8pmB6vHWy9kGYWxghDxwTY8o+ck62yYK6uxc5FfPZ2pEINyLHHX0gdcUgoIR9UOVxLa16JkDs+ZV2FGiKHZeVrymLzXBoFAPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765427569; c=relaxed/simple;
	bh=ba0+CqIW6kO9S2BuMjkT87ZEF03C0KrP5LiChW+rXSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tB48BGW8Q6D4/L1IhIz94AaeDcCBc3UpoDthb9dnMCK3TYaV8YqhBfu3R6BxtaW2UtOG4fCEMrZ03m5Jmr8fw/v6N//v+3nGpvTPNuWuI1uoP3OM0+me7XJ3LA0cxmkq7oE1otFQSWK8GxZeooxe/dMcRpkgpRv+YhzLt73fKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gCiR3NHs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bZghTQLU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gCiR3NHs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZghTQLU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BALVcDv4062233
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 04:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5X9A/5IXgegiuTJCb3imH8rpe8yAg+5pjeqmHZk7dtE=; b=gCiR3NHs4LTg4yS/
	sfcvBbpgkjn3WhbAt8ZO876+RcU/XY5kINvx4VF9Iymhqc+YF2wWP6gin7Qc4uBk
	PlL6s5lb3XcCAd3MkwrsgrBglUEO1I8kuwlVt/K0GpZG9OKbFd3G84cTCYLEUvh/
	jp9chV9Tpw8ka2PRwvm4obkIunUUPja/OV8mw4dYJaNSU+ZhPyav8PvHEc95NmKw
	jh4KkolviL6q0U24uLp+NrPG3DAwbuzIZnToBIHlrOUIdKnu6RksChdpEiwmBVL+
	StBRO1thAFmGhPTRmXAxmmn1A+gWNA3cd9wBWvsJ+mgqzFeCh07TC9LSBEByYCHB
	kpr/UQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ayguqgw8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 04:32:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297ddb3c707so6499035ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 20:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765427565; x=1766032365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5X9A/5IXgegiuTJCb3imH8rpe8yAg+5pjeqmHZk7dtE=;
        b=bZghTQLUWCtBExr9eMY1KrYuK30DkQLFBCoY0xUNSqZL6F90Nym/Ge8qcdAB/OKs8I
         vyH8IRoejdiqsFMw2y3wojAHbybbPuoV7ibHkVsAsGgbo3F05QcMhZPuU/e/PEiik2o/
         G6bqoamXB5SXfnpdQMHJWl240VvnfBpffYe2+zj7qjvQC5yJmxuJjypoys8fjNQvYLrk
         KderHFn1QfSE9js8D7Gl/Jvcjk1OH2LOia0eL1gyPSLnCxcW2fX6XW4MuXCHWhOzCpZV
         oaa8TyrV03XI2cVyM1e2M8tQRSYM76CGYzfPHsZ2AawgnOGqvbpfWH1ps6cjaLtmsV8x
         j3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765427565; x=1766032365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5X9A/5IXgegiuTJCb3imH8rpe8yAg+5pjeqmHZk7dtE=;
        b=v9PmHwoTQoqR8nwtsiyEEHRcvN30pTgk7E4q6hF0WnzaY/A2jBTNfZPwBHpa3qkXXE
         858gqFs21IowlFrx4bNsYLy7rRD4KD4XsZ3MqKukEVRLVpPG5BIbnPWzK6EcxF51wONT
         0g+wZ21YTGeW8U7fXlyjNQ44gFu7XjjZkxuQOo3N7XJZM7yK8ogqjhpB/NFXQSepoLJM
         bgtUU2WRS4Us4e22oUAEwOGCkjl8+Gd1eAaF92mLzWet7r64pD0yu5CU0qVbHqCeIpZ4
         R4wfFct/NqTs9euUIg9cbV5HOZj0ZFDXT3rx7oxV6F5+cskGtUlLivoDG/npeFYjzPN2
         oGUQ==
X-Gm-Message-State: AOJu0YwcIPtcZTG+auULcRu6uv6l83IOD0/LsJB3cCLXnXxNkyxvuvkA
	qnN/dVnTrKU7eix6Vntz4JpqEWXkzqiWoSE59A3csa7AlYyg462jaw4DZzyT9tSWYfdx6E0g6Xo
	TjW0nmGvhtFEU52ofZWakNZoXbrbSyVUIiPp7MlacO6h2fQCJpKrB1cvAIErtTBRN6hJp6Tc=
X-Gm-Gg: AY/fxX5oq/s0/oWHsR0i27tYsN0axSwuuHJHVx7OmACo4xlm5mrFi/KoaZF0XygJme6
	AZvglOmhy+D0vaTt9XjKqEaJkD+8rKSLR0UZdN0s5ILmlSeR6v+oYMgl/pPkkm5n+XtgAh3AMiL
	p0H8fiU6ZcjeP3h/LraOQcyHsGLbaGXZ1aQpByAu47F84StDp/fESwJBXfQM7rm1ALbCRhDHK6w
	byh1d0n4tLycjljmQyRpRbJvBkGR9hTEbMUqJP21aEZhv4fOGKSrZ6M7kYq3UKDGq8pk+3Z88oB
	yycFAtVq24232Fut0AFpYFa851+FCH5Og+jZ+fl7Yw9yZIqoVTfJASVzWEwqxSeahHjIOdOBI72
	+97pJRVbPfqyqG/XbRY2GKYlQ/8YPNE5r28a5
X-Received: by 2002:a17:903:1aab:b0:298:5fde:5a90 with SMTP id d9443c01a7336-29ec280e3b8mr46980375ad.58.1765427564750;
        Wed, 10 Dec 2025 20:32:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEvCdXcWXt+AJQ3AkQBI6JT4wnuf/xDjOq6vjNa3pSvzssN9tQs3uUT0amssuoTGO7uGQk2g==
X-Received: by 2002:a17:903:1aab:b0:298:5fde:5a90 with SMTP id d9443c01a7336-29ec280e3b8mr46980235ad.58.1765427564198;
        Wed, 10 Dec 2025 20:32:44 -0800 (PST)
Received: from [10.231.216.118] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d38981sm8893855ad.28.2025.12.10.20.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 20:32:43 -0800 (PST)
Message-ID: <29919357-f843-4c28-8b54-001955f4f09e@oss.qualcomm.com>
Date: Thu, 11 Dec 2025 12:32:39 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] gatt-client:Implement error handling for
 DB_OUT_OF_SYNC in GATT caching.
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
References: <20251208101915.247459-1-mengshi.wu@oss.qualcomm.com>
 <CABBYNZJ=S3LHcwyXAc=gxf0RptcOC+6TPaWvoEmJquar54b3dQ@mail.gmail.com>
 <ee21c657-5120-4dbd-8660-d2a522f8578b@oss.qualcomm.com>
 <CABBYNZ+s3Oj5zM9uL-SPLQAmo3y+-06JLK4mn-YF-j-e196T8A@mail.gmail.com>
Content-Language: en-US
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+s3Oj5zM9uL-SPLQAmo3y+-06JLK4mn-YF-j-e196T8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDAyOCBTYWx0ZWRfX7yCXzfUVNroz
 IgpxYUlH64E3N3woADn9U1G+oKkufKXEmeBGkOwz7+cwFJILCo2yxTUo3QE5Jb1VN5LFnVH+JVv
 p033Lna4/vcZSDM/5AUvgWAErtHSOM/+TL8/yUR5PZYarpzGn5Fu543a9AKq31r42/sPPE5W7d2
 sNrunUE0jfMM2QJCK7ptBVVGVdqN1+/ircdIK7PIT8JJem222J82dOj7ZpiYUdv7/Vb6dAMY55/
 AHobMTJTyTfQRe3xfZKJKzvufXykf04Vl0Gqytz5nHSBf/R8nfOl4QsD04GGkwBhrcrH58NGUho
 hxi2aAQ5BaJN6xCpMid3DbaLsAyhSAKUH322fBR6AzW6HK4C0tUBInp6pLtBjzN+7wyxwKqkO2B
 7MDDrVDHwQNh/2mo5gYJQ6UlPwob5A==
X-Authority-Analysis: v=2.4 cv=deGNHHXe c=1 sm=1 tr=0 ts=693a496d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=UzzSKFl_qhgyq3-qZzYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: eSUSp_DschF3dftTgXyTP5KBsILQK4qI
X-Proofpoint-ORIG-GUID: eSUSp_DschF3dftTgXyTP5KBsILQK4qI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110028

Hi,

On 12/10/2025 10:41 PM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Wed, Dec 10, 2025 at 2:59 AM Mengshi Wu <mengshi.wu@oss.qualcomm.com> wrote:
>>
>> Hi,
>>
>> Thank you for your comments.
>>
>> On 12/8/2025 11:35 PM, Luiz Augusto von Dentz wrote:
>>> Hi,
>>>
>>> On Mon, Dec 8, 2025 at 5:19 AM Mengshi Wu <mengshi.wu@oss.qualcomm.com> wrote:
>>>>
>>>> Add automatic DB re-discovery on receiving BT_ATT_ERROR_DB_OUT_OF_SYNC
>>>> error code from ATT operations. This ensures the local GATT database
>>>> stays synchronized with the remote device by triggering a full service
>>>> discovery (handles 0x0001-0xffff) when the database becomes out of sync.
>>>>
>>>> The process_db_out_of_sync() function is now called in all ATT error
>>>> response handlers (read_multiple, read_long, write, execute_write,
>>>> prepare_write, and prep_write callbacks) to handle this error condition
>>>> consistently.
>>>>
>>>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
>>>> ---
>>>>  src/shared/gatt-client.c | 35 +++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>>>> index f6d5dc4b7..087d4e228 100644
>>>> --- a/src/shared/gatt-client.c
>>>> +++ b/src/shared/gatt-client.c
>>>> @@ -1965,6 +1965,29 @@ fail:
>>>>                 "Failed to initiate service discovery after Service Changed");
>>>>  }
>>>>
>>>> +static void process_db_out_of_sync(struct bt_gatt_client *client,
>>>> +                                  uint8_t att_ecode)
>>>> +{
>>>> +       struct service_changed_op *op;
>>>> +
>>>> +       if (att_ecode != BT_ATT_ERROR_DB_OUT_OF_SYNC)
>>>> +               return;
>>>> +
>>>> +       DBG(client, "Database Out of Sync - triggering full re-discovery");
>>>> +
>>>> +       if (!client->in_svc_chngd) {
>>>> +               process_service_changed(client, 0x0001, 0xffff);
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       op = new0(struct service_changed_op, 1);
>>>> +
>>>> +       op->start_handle = 0x0001;
>>>> +       op->end_handle = 0xffff;
>>>> +
>>>> +       queue_push_tail(client->svc_chngd_queue, op);
>>>> +}
>>>
>>> Id just change process_error to call into db_out_sync, that said this
>>> is not recovering at all, it just rediscovering but the original
>>> request will be lost, I wonder if we should implement some backoff
>>> logic wait to see if the server do a service changed, read the hash
>>> (in case we are not doing it already), and then redo the operation.
>>> Also we do need to make sure we don't end up in a loop rediscovery.
>>
>> At the beginning, we considered implementing recovery for failed ATT
>> requests caused by a Database Out of Sync error. However, we identified
>> potential risks in retrying some ATT requests after the remote device’s
>> services have changed. For example, the handle in the ATT_READ_REQ PDU,
>> which identifies the target attribute, may have changed on the remote
>> device. Even if the retry succeeds, it might operate on the wrong
>> attribute.
>>
>> As usual, any ATT response error will be propagated to the application
>> layer, so the operation will not be lost but will fail. We did not modify
>> this behavior.
> 
> We do recovery for encryption/pairing errors.

Sorry for the confusion. I meant that the Database Out of Sync error is 
directly propagated to the bluetoothctl console, whereas not all errors 
are.

> 
>> It may not be appropriate to implement recovery logic for failed ATT
>> requests at the BlueZ host layer. Therefore, we only do a rediscovery
>> as required by the Core Spec, Vol. 3, Part G, Section 2.5.2.1,
>> after receiving a Database Out of Sync error.
>>
>> For the suggestion about back-off logic,
>>
>> We are considering reading the remote database hash and comparing it
>> with the locally stored hash before initiating rediscovery. If reading
>> the remote database hash fails, we will assume that the remote GATT
>> database has changed and proceed with rediscovery immediately.
>>
>> As shown below, the client checks the remote database hash after
>> receiving a Database Out of Sync error. If the remote services have
>> changed, the client initiates rediscovery.
>>
>> btmon HCI Logs:
>>> ACL Data RX: Handle 2 flags 0x02 dlen 9
>>       ATT: Error Response (0x01) len 4
>>         Read Request (0x0a)
>>         Handle: 0x000d
>>         Error: Database Out of Sync (0x12)
>> bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
>>       ATT: Read By Type Request (0x08) len 6
>>         Handle range: 0x0001-0xffff
>>         Attribute type: Database Hash (0x2b2a)
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>         Num handles: 1
>>         Handle: 2
>>         Count: 1
>>> ACL Data RX: Handle 2 flags 0x02 dlen 24
>>       ATT: Read By Type Response (0x09) len 19
>>         Attribute data length: 18
>>         Attribute data list: 1 entry
>>         Handle: 0x000f
>>         Value: 10d6a00f95bb0eeec55a097ccf7dead8
>> bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
>>       ATT: Read By Type Request (0x08) len 6
>>         Handle range: 0x0010-0xffff
>>         Attribute type: Database Hash (0x2b2a)
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>         Num handles: 1
>>         Handle: 2
>>         Count: 1
>>> ACL Data RX: Handle 2 flags 0x02 dlen 9
>>       ATT: Error Response (0x01) len 4
>>         Read By Type Request (0x08)
>>         Handle: 0x0010
>>         Error: Attribute Not Found (0x0a)
> 
> I don't recall if we have this behavior earlier of using Read By Type
> request for hash in the beginning? We need to limit the results to one
> and not proceed to read it again since it is supposed to exist only
> once in the database. Anyway I don't see a problem if we do read the
> hash and that didn't change we should probably go ahead and resend the

I checked this and found that the stored hash value in the database 
would only be updated at the beginning of a connection, using Read By 
Type request. The process of service changed indication will not update 
the stored hash value.

I read cache file after a service changed indication done, it shows:
------------------
[Attributes]
.....
000e=2803:000f:02:f74347d19eef647d97f0b2f7af502e33: \
00002b2a-0000-1000-8000-00805f9b34fb
.....
------------------

Then I read database hash from remote device, it shows:
------------------
[:/service0008/char000e]# read
Attempting to read 
/org/bluez/hci0/dev_C8_A3_E8_DD_3D_cC/service0oo8/char000e
[:/service0008/char000e]# [CHG] Attribute 
/org/bluez/hci0/dev_C8_A3_E8_DD_3D_CC/service0008/char00e Value:
[:/service0008/char000e]# 0f 15 81 0b e0 c9 55 66 7e 2f f8 73 37 16 88 bc
[:/service0008/char000e]# 0f 15 81 0b e0 c9 55 66 7e 2f f8 73 37 16 88 bc
------------------

The stored hash value is not updated. Based on this, it seems to be safe 
to resend the original request if hash values are the same, since there 
are no risks of critical section operations between handling Service 
Changed Indication and handling Database Out of Sync error. We will add 
resend logic for this condition.


> original request, in the meantime if we receive a service changed we
> can narrow down the range that needs to be rediscovered and not use

Sure. Since we reuse the process_service_changed(), we are capable of 
knowing that the Service Changed Indication comes simultaneously under 
certain conditions. We will not append a full range rediscovery to the 
client->svc_chngd_queue if client->in_svc_chngd is true.

> 0x0001-0xffff as bellow, and we can actually perform recovery also in
> case the service changed don't affect the original operation handle.

Unlike the Service Changed indication, the Database Out of Sync error 
provides no information about the affected range. Consequently, we cannot 
determine whether the original operation handle is impacted. By the way, 
Service Changed characteristic is not readable, so we can not get effect 
from it either.

> 
>> bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
>>       ATT: Read By Group Type Request (0x10) len 6
>>         Handle range: 0x0001-0xffff
>>         Attribute group type: Primary Service (0x2800)
>>
>>>
>>>>  static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
>>>>                                         uint16_t length, void *user_data)
>>>>  {
>>>> @@ -2709,10 +2732,12 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>>>                         (!pdu && length)) {
>>>>                 success = false;
>>>>
>>>> -               if (opcode == BT_ATT_OP_ERROR_RSP)
>>>> +               if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>                         att_ecode = process_error(pdu, length);
>>>> -               else
>>>> +                       process_db_out_of_sync(req->client, att_ecode);
>>>> +               } else {
>>>>                         att_ecode = 0;
>>>> +               }
>>>>
>>>>                 pdu = NULL;
>>>>                 length = 0;
>>>> @@ -2864,6 +2889,7 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
>>>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>                 success = false;
>>>>                 att_ecode = process_error(pdu, length);
>>>> +               process_db_out_of_sync(req->client, att_ecode);
>>>>                 goto done;
>>>>         }
>>>>
>>>> @@ -3050,6 +3076,7 @@ static void write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>                 success = false;
>>>>                 att_ecode = process_error(pdu, length);
>>>> +               process_db_out_of_sync(req->client, att_ecode);
>>>>                 goto done;
>>>>         }
>>>>
>>>> @@ -3213,6 +3240,7 @@ static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>                 success = false;
>>>>                 att_ecode = process_error(pdu, length);
>>>> +               process_db_out_of_sync(req->client, att_ecode);
>>>>         } else if (opcode != BT_ATT_OP_EXEC_WRITE_RSP || pdu || length)
>>>>                 success = false;
>>>>
>>>> @@ -3278,6 +3306,7 @@ static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>                 success = false;
>>>>                 att_ecode = process_error(pdu, length);
>>>> +               process_db_out_of_sync(req->client, att_ecode);
>>>>                 goto done;
>>>>         }
>>>>
>>>> @@ -3447,6 +3476,7 @@ static void prep_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>>>                 success = false;
>>>>                 reliable_error = false;
>>>>                 att_ecode = process_error(pdu, length);
>>>> +               process_db_out_of_sync(req->client, att_ecode);
>>>>                 goto done;
>>>>         }
>>>>
>>>> @@ -3597,6 +3627,7 @@ static void exec_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>                 success = false;
>>>>                 att_ecode = process_error(pdu, length);
>>>> +               process_db_out_of_sync(req->client, att_ecode);
>>>>                 goto done;
>>>>         }
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>>
>>>
>>>
>>
> 
> 


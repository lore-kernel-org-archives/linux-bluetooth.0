Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850623C8C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766648611; cv=none; b=UsTTKL110eW+Hd8hkF5Iq6uleOAMIUuDz3oubtBT8BboZac3QZwKSkXZGT9g20lT+QaMG8uFgpV+90zLLD1MJZ0xa4hMm+Bb8dmO+9xuDj5GVbl8fJi4nxpASKg9YniR4ZHddxfDCJSwim5gh3fDmawZD2+Y5XdtBSp18aOr+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766648611; c=relaxed/simple;
	bh=5Z4zMEP0MM5LwNACRHy5zYY1PZL/j21HwXv7SWWK55k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R+1wq8fhq7ITMAWyO5xk75yQhIbynKltRpVE9DbcbE67PUS/Dx2opu684aCOXOCz/1wcdGkzn+MKTLU3vVwB0Wb4iPDjoWoahky9oqUgeUxCjkrovyxgofCVmCDOPJLwxYZIfVEe3KfVvYW64wdYB8myMwxz4edl9mUhqYXydfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MTsxhzYL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ihc8X8Nw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MTsxhzYL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ihc8X8Nw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BP2DxVS967813
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 07:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IsWhMZSzHBpOPNa67RtF76kFpdVwIG6DtPAA405+GF0=; b=MTsxhzYLYzMs7fRH
	qAL6MhcLrVwZKaDrSAGFeFTqYmL6r8rWddsFNpIx3BhrIOhd6cPKV6tPl68a0OQ3
	xqKLPcgsSRCVfisgsfJjweindOPbwebwdWZwmhz/ctsSCN0YzaExPZlrZfCAdhbR
	JzaDK+x17Z15vAFB0drwXYJtMKwHgx/KHd3klpL6dqdeVYMzSk9MP/sXhNrj8Z30
	MACxkDvTdBJ56ql8qwZ3eyZ7G0pMrAmTRgEvn1Q+IYaYK68WsUIjCAbEKdriGIS0
	sRb7qTS0zSy20WoYOlZPvqLRv7gQCGBxDAlXWRYabVMTXrn3Z+AFQcydotJBvZva
	/k3SCw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b8v9y0fn8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 07:43:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso11024142a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 23:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766648606; x=1767253406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IsWhMZSzHBpOPNa67RtF76kFpdVwIG6DtPAA405+GF0=;
        b=Ihc8X8Nw/gaipsUEGfmDDTlfeOMvr4SkUP+a369NvisdbKVeUe26VZohGs+z2ec+Pd
         7xeSsLfT8jOa7FuyD0m6gAd3ykjrswBPK1W2GfOjOT867KoKt5XfN3nEE2/H9RFzPU+8
         hdVSlPI5k9RrY1W/m1R/iJeXbcS705/vh5KYjmei4tWYB9CHGcZvRfXT5UERfTXsB09V
         7lyflpOAnVVqioJ3Z2ai9+OpGnLJVnVZazsR+7L4baUvYY/8AA51+8hkq/k0Y8BoM78T
         7QmQ71C9D8I/HRiMYmwW7Mu79GEh239JD1V8JJfbn1ylyZWSMSR8mnHFI72NtksY+cNB
         mjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766648606; x=1767253406;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsWhMZSzHBpOPNa67RtF76kFpdVwIG6DtPAA405+GF0=;
        b=l6S32fndU2vuaw69G85h6xB9582PGxXwtgew0Klh7T0exsg8j1ZL0a5Nhd8Ay6aSQh
         rNn+wpZ8zjnA0zgQWL5GqV9UQQ/9ghjl2WvZjN4eRXoBU+6Z0P1BpcWy4cmo73KjR06G
         5FFcT8WAWRwPBl3+KTpCjVD2KgDr1I3Zah542V4IITEVqdHn7LhbBv+UvpZXRrg5iYcO
         8LzR0CKn+1QHyC+lIoo1JVstbKUvjq5p1N87qLEe0urojPikR+fAp/3UgpoaFrN8AwaO
         07IDhmrDLFesEsZrft66H/NmeRDJSYyrMQtDvWVrhxhcPFytIkmNz941ol+jLI5A7gIq
         XGFw==
X-Gm-Message-State: AOJu0Yw5EB2lg4WyQSCFlHnLulmfoB5q3eEG6x2HBnkGh+4aMGRzLdJv
	8NO7uOygaKU3Z3bfy5YMTIIl+44A3vAxgiee9KkP3FxizB1jpcZVxPERa4BWeVJFFPuKxc1wUze
	qBTa9BE5gWwJ380tQo0mW06OhDdpeudYYjAP+nukTipELA5Za2n9drvHgfNaWGx/sGOA5wsg=
X-Gm-Gg: AY/fxX6DAB9OkwRdKgJ9qw7u1V/vixk9GjASGXHiI22RiCRRDWKyQBFezwRYcgUpRrZ
	2FkaX+QbsC2jO3LutXphX61oDq7PjdwtjKPgl8WUSBuU0gipgdIbF/mA32kxfR3b+lXbAtDGx31
	Ftxn1cy9lGd6dRHmIArQ3G82ylsNpS/UZHFoKNFxlrTa1TSf6OaSYEnVPUIL3SkUzV033K0AOaD
	lcmAGnk9tdq3ZFkDv3EeCHMaAxhULppAPjOKxgid2kAdQmA5aCZCoZZ1KFayH6PBjyjGJpZA9at
	qb1sdwvZ+foD2jHu+A94Li0fvDoDF216nSLFdhrCYJsvSk3uydWphOuRcxeA2xSkaJtH6yBl36g
	00+LgPsBz0eWlG5gxUsN8DvkdZVdJmztpM3JIqPnENrY/o9ZtVZTojsR4OCnn4os=
X-Received: by 2002:a05:7022:6886:b0:119:e56c:18a5 with SMTP id a92af1059eb24-121722b46c8mr19619177c88.13.1766648606088;
        Wed, 24 Dec 2025 23:43:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK5uU42atBfFw1IFXzH4Fme5RgmfKL/8KWKXqnE5IvSoTtQfMiEOclfR0waHC4m+tPvJoKSw==
X-Received: by 2002:a05:7022:6886:b0:119:e56c:18a5 with SMTP id a92af1059eb24-121722b46c8mr19619171c88.13.1766648605367;
        Wed, 24 Dec 2025 23:43:25 -0800 (PST)
Received: from [10.110.28.28] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254cd77sm76424700c88.14.2025.12.24.23.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 23:43:24 -0800 (PST)
Message-ID: <afdfc3c4-83a2-46f8-8848-6d61ac0fa422@oss.qualcomm.com>
Date: Thu, 25 Dec 2025 15:43:20 +0800
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
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
References: <20251208101915.247459-1-mengshi.wu@oss.qualcomm.com>
 <CABBYNZJ=S3LHcwyXAc=gxf0RptcOC+6TPaWvoEmJquar54b3dQ@mail.gmail.com>
 <ee21c657-5120-4dbd-8660-d2a522f8578b@oss.qualcomm.com>
 <CABBYNZ+s3Oj5zM9uL-SPLQAmo3y+-06JLK4mn-YF-j-e196T8A@mail.gmail.com>
 <29919357-f843-4c28-8b54-001955f4f09e@oss.qualcomm.com>
 <CABBYNZJZreb5oowVXJMVqsqsvgEGX9=yK7kFOJp8MhNrfBJGLw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZJZreb5oowVXJMVqsqsvgEGX9=yK7kFOJp8MhNrfBJGLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BRrQdzefsn4y8uFrHfFo8fstSZqxcvBi
X-Proofpoint-ORIG-GUID: BRrQdzefsn4y8uFrHfFo8fstSZqxcvBi
X-Authority-Analysis: v=2.4 cv=Uolu9uwB c=1 sm=1 tr=0 ts=694ceb1f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=CPDQ0gFoPrLk9G_76qYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI1MDA3MiBTYWx0ZWRfX02eTC5qTWuA/
 k7ieTbb7JughSdGcwa1de6+4wWuzReacCPoMVnoOf+P4KbkZWgwtDQmSTwnq8bGvl6TLWneWQcn
 NFF31Cak9ihkId8EU8CPvvkrthDFpPXr9JQKohYibh4C/BDFP3QLIc6hES38Lljj/V47UY47ahq
 8olz3bmrJeQ8/oBMRK0N81I9RWeWC02F2Zu1dt3K+yYgFrjkHt5UKrdUeQ5YVsBgvxDx0yKXSKO
 5N3VDJ7wbHxuvIcsL8qajBo96FAlol9z4Cy+tv92HLP23Y7sSJySSK3+iqlobrWN5xXPgp/nGkK
 kgld80G4DkLiliLfA0eAFcTnN33ys7mzP1UXC4FzuLUovnypsC/+L4CVpVI3DfGtJmFmeGsexnj
 3YeLhDTNm1huWI2oTTc0yp6r9rilHxTjZnoSkEFFrObGYM7O4jKuON2nAOBVbvM1x5QN19BIbu2
 2dM6iwchwN6HGly82bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512250072

Hi,

Sorry to bother. I am not sure that if I can update the patch based on the current 
discussion, or should I wait for some additional suggestions before proceeding?

On 12/12/2025 1:36 AM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Wed, Dec 10, 2025 at 11:32 PM Mengshi Wu <mengshi.wu@oss.qualcomm.com> wrote:
>>
>> Hi,
>>
>> On 12/10/2025 10:41 PM, Luiz Augusto von Dentz wrote:
>>> Hi,
>>>
>>> On Wed, Dec 10, 2025 at 2:59 AM Mengshi Wu <mengshi.wu@oss.qualcomm.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> Thank you for your comments.
>>>>
>>>> On 12/8/2025 11:35 PM, Luiz Augusto von Dentz wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon, Dec 8, 2025 at 5:19 AM Mengshi Wu <mengshi.wu@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> Add automatic DB re-discovery on receiving BT_ATT_ERROR_DB_OUT_OF_SYNC
>>>>>> error code from ATT operations. This ensures the local GATT database
>>>>>> stays synchronized with the remote device by triggering a full service
>>>>>> discovery (handles 0x0001-0xffff) when the database becomes out of sync.
>>>>>>
>>>>>> The process_db_out_of_sync() function is now called in all ATT error
>>>>>> response handlers (read_multiple, read_long, write, execute_write,
>>>>>> prepare_write, and prep_write callbacks) to handle this error condition
>>>>>> consistently.
>>>>>>
>>>>>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
>>>>>> ---
>>>>>>  src/shared/gatt-client.c | 35 +++++++++++++++++++++++++++++++++--
>>>>>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>>>>>> index f6d5dc4b7..087d4e228 100644
>>>>>> --- a/src/shared/gatt-client.c
>>>>>> +++ b/src/shared/gatt-client.c
>>>>>> @@ -1965,6 +1965,29 @@ fail:
>>>>>>                 "Failed to initiate service discovery after Service Changed");
>>>>>>  }
>>>>>>
>>>>>> +static void process_db_out_of_sync(struct bt_gatt_client *client,
>>>>>> +                                  uint8_t att_ecode)
>>>>>> +{
>>>>>> +       struct service_changed_op *op;
>>>>>> +
>>>>>> +       if (att_ecode != BT_ATT_ERROR_DB_OUT_OF_SYNC)
>>>>>> +               return;
>>>>>> +
>>>>>> +       DBG(client, "Database Out of Sync - triggering full re-discovery");
>>>>>> +
>>>>>> +       if (!client->in_svc_chngd) {
>>>>>> +               process_service_changed(client, 0x0001, 0xffff);
>>>>>> +               return;
>>>>>> +       }
>>>>>> +
>>>>>> +       op = new0(struct service_changed_op, 1);
>>>>>> +
>>>>>> +       op->start_handle = 0x0001;
>>>>>> +       op->end_handle = 0xffff;
>>>>>> +
>>>>>> +       queue_push_tail(client->svc_chngd_queue, op);
>>>>>> +}
>>>>>
>>>>> Id just change process_error to call into db_out_sync, that said this
>>>>> is not recovering at all, it just rediscovering but the original
>>>>> request will be lost, I wonder if we should implement some backoff
>>>>> logic wait to see if the server do a service changed, read the hash
>>>>> (in case we are not doing it already), and then redo the operation.
>>>>> Also we do need to make sure we don't end up in a loop rediscovery.
>>>>
>>>> At the beginning, we considered implementing recovery for failed ATT
>>>> requests caused by a Database Out of Sync error. However, we identified
>>>> potential risks in retrying some ATT requests after the remote device’s
>>>> services have changed. For example, the handle in the ATT_READ_REQ PDU,
>>>> which identifies the target attribute, may have changed on the remote
>>>> device. Even if the retry succeeds, it might operate on the wrong
>>>> attribute.
>>>>
>>>> As usual, any ATT response error will be propagated to the application
>>>> layer, so the operation will not be lost but will fail. We did not modify
>>>> this behavior.
>>>
>>> We do recovery for encryption/pairing errors.
>>
>> Sorry for the confusion. I meant that the Database Out of Sync error is
>> directly propagated to the bluetoothctl console, whereas not all errors
>> are.
>>
>>>
>>>> It may not be appropriate to implement recovery logic for failed ATT
>>>> requests at the BlueZ host layer. Therefore, we only do a rediscovery
>>>> as required by the Core Spec, Vol. 3, Part G, Section 2.5.2.1,
>>>> after receiving a Database Out of Sync error.
>>>>
>>>> For the suggestion about back-off logic,
>>>>
>>>> We are considering reading the remote database hash and comparing it
>>>> with the locally stored hash before initiating rediscovery. If reading
>>>> the remote database hash fails, we will assume that the remote GATT
>>>> database has changed and proceed with rediscovery immediately.
>>>>
>>>> As shown below, the client checks the remote database hash after
>>>> receiving a Database Out of Sync error. If the remote services have
>>>> changed, the client initiates rediscovery.
>>>>
>>>> btmon HCI Logs:
>>>>> ACL Data RX: Handle 2 flags 0x02 dlen 9
>>>>       ATT: Error Response (0x01) len 4
>>>>         Read Request (0x0a)
>>>>         Handle: 0x000d
>>>>         Error: Database Out of Sync (0x12)
>>>> bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
>>>>       ATT: Read By Type Request (0x08) len 6
>>>>         Handle range: 0x0001-0xffff
>>>>         Attribute type: Database Hash (0x2b2a)
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>         Num handles: 1
>>>>         Handle: 2
>>>>         Count: 1
>>>>> ACL Data RX: Handle 2 flags 0x02 dlen 24
>>>>       ATT: Read By Type Response (0x09) len 19
>>>>         Attribute data length: 18
>>>>         Attribute data list: 1 entry
>>>>         Handle: 0x000f
>>>>         Value: 10d6a00f95bb0eeec55a097ccf7dead8
>>>> bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
>>>>       ATT: Read By Type Request (0x08) len 6
>>>>         Handle range: 0x0010-0xffff
>>>>         Attribute type: Database Hash (0x2b2a)
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>         Num handles: 1
>>>>         Handle: 2
>>>>         Count: 1
>>>>> ACL Data RX: Handle 2 flags 0x02 dlen 9
>>>>       ATT: Error Response (0x01) len 4
>>>>         Read By Type Request (0x08)
>>>>         Handle: 0x0010
>>>>         Error: Attribute Not Found (0x0a)
>>>
>>> I don't recall if we have this behavior earlier of using Read By Type
>>> request for hash in the beginning? We need to limit the results to one
>>> and not proceed to read it again since it is supposed to exist only
>>> once in the database. Anyway I don't see a problem if we do read the
>>> hash and that didn't change we should probably go ahead and resend the
>>
>> I checked this and found that the stored hash value in the database
>> would only be updated at the beginning of a connection, using Read By
>> Type request. The process of service changed indication will not update
>> the stored hash value.
>>
>> I read cache file after a service changed indication done, it shows:
>> ------------------
>> [Attributes]
>> .....
>> 000e=2803:000f:02:f74347d19eef647d97f0b2f7af502e33: \
>> 00002b2a-0000-1000-8000-00805f9b34fb
>> .....
>> ------------------
>>
>> Then I read database hash from remote device, it shows:
>> ------------------
>> [:/service0008/char000e]# read
>> Attempting to read
>> /org/bluez/hci0/dev_C8_A3_E8_DD_3D_cC/service0oo8/char000e
>> [:/service0008/char000e]# [CHG] Attribute
>> /org/bluez/hci0/dev_C8_A3_E8_DD_3D_CC/service0008/char00e Value:
>> [:/service0008/char000e]# 0f 15 81 0b e0 c9 55 66 7e 2f f8 73 37 16 88 bc
>> [:/service0008/char000e]# 0f 15 81 0b e0 c9 55 66 7e 2f f8 73 37 16 88 bc
>> ------------------
>>
>> The stored hash value is not updated. Based on this, it seems to be safe
>> to resend the original request if hash values are the same, since there
>> are no risks of critical section operations between handling Service
>> Changed Indication and handling Database Out of Sync error. We will add
>> resend logic for this condition.
>>
>>
>>> original request, in the meantime if we receive a service changed we
>>> can narrow down the range that needs to be rediscovered and not use
>>
>> Sure. Since we reuse the process_service_changed(), we are capable of
>> knowing that the Service Changed Indication comes simultaneously under
>> certain conditions. We will not append a full range rediscovery to the
>> client->svc_chngd_queue if client->in_svc_chngd is true.
>>
>>> 0x0001-0xffff as bellow, and we can actually perform recovery also in
>>> case the service changed don't affect the original operation handle.
>>
>> Unlike the Service Changed indication, the Database Out of Sync error
>> provides no information about the affected range. Consequently, we cannot
>> determine whether the original operation handle is impacted. By the way,
>> Service Changed characteristic is not readable, so we can not get effect
>> from it either.
> 
> Service Changed must always be generated in case the database changes,
> otherwise it would be broken with legacy devices that don't use the db
> hash, and since the later is the reason for the server to send out of
> sync we can infer what is the affected range and either do the resend
> before or after handing the rediscover on the Service Changed range,
> either way it should be possible to recover from out of sync errors
> automatically. If the remote misbehaves, or is just playing tricks
> with out of sync error to force the stack to rediscover the whole db,
> we should just wait a short grace time and if it doesn't send the
> service changed on then we should initiate a full rediscover.
> 
>>>
>>>> bluetoothd[57993]: < ACL Data TX: Handle 2 flags 0x00 dlen 11
>>>>       ATT: Read By Group Type Request (0x10) len 6
>>>>         Handle range: 0x0001-0xffff
>>>>         Attribute group type: Primary Service (0x2800)
>>>>
>>>>>
>>>>>>  static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
>>>>>>                                         uint16_t length, void *user_data)
>>>>>>  {
>>>>>> @@ -2709,10 +2732,12 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>>>>>                         (!pdu && length)) {
>>>>>>                 success = false;
>>>>>>
>>>>>> -               if (opcode == BT_ATT_OP_ERROR_RSP)
>>>>>> +               if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>>>                         att_ecode = process_error(pdu, length);
>>>>>> -               else
>>>>>> +                       process_db_out_of_sync(req->client, att_ecode);
>>>>>> +               } else {
>>>>>>                         att_ecode = 0;
>>>>>> +               }
>>>>>>
>>>>>>                 pdu = NULL;
>>>>>>                 length = 0;
>>>>>> @@ -2864,6 +2889,7 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
>>>>>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>>>                 success = false;
>>>>>>                 att_ecode = process_error(pdu, length);
>>>>>> +               process_db_out_of_sync(req->client, att_ecode);
>>>>>>                 goto done;
>>>>>>         }
>>>>>>
>>>>>> @@ -3050,6 +3076,7 @@ static void write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>>>>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>>>                 success = false;
>>>>>>                 att_ecode = process_error(pdu, length);
>>>>>> +               process_db_out_of_sync(req->client, att_ecode);
>>>>>>                 goto done;
>>>>>>         }
>>>>>>
>>>>>> @@ -3213,6 +3240,7 @@ static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>>>>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>>>                 success = false;
>>>>>>                 att_ecode = process_error(pdu, length);
>>>>>> +               process_db_out_of_sync(req->client, att_ecode);
>>>>>>         } else if (opcode != BT_ATT_OP_EXEC_WRITE_RSP || pdu || length)
>>>>>>                 success = false;
>>>>>>
>>>>>> @@ -3278,6 +3306,7 @@ static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>>>>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>>>                 success = false;
>>>>>>                 att_ecode = process_error(pdu, length);
>>>>>> +               process_db_out_of_sync(req->client, att_ecode);
>>>>>>                 goto done;
>>>>>>         }
>>>>>>
>>>>>> @@ -3447,6 +3476,7 @@ static void prep_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>>>>>                 success = false;
>>>>>>                 reliable_error = false;
>>>>>>                 att_ecode = process_error(pdu, length);
>>>>>> +               process_db_out_of_sync(req->client, att_ecode);
>>>>>>                 goto done;
>>>>>>         }
>>>>>>
>>>>>> @@ -3597,6 +3627,7 @@ static void exec_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
>>>>>>         if (opcode == BT_ATT_OP_ERROR_RSP) {
>>>>>>                 success = false;
>>>>>>                 att_ecode = process_error(pdu, length);
>>>>>> +               process_db_out_of_sync(req->client, att_ecode);
>>>>>>                 goto done;
>>>>>>         }
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
> 
> 


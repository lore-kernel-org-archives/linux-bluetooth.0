Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E272D9EC8
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806888; cv=none; b=nGzpq6RlKa8H8sNZ4SSC5Ab0VnnZ1uT3eo0LX4JQTESCo9v9LHRvKKJFwDudFl4DCOUtfhA1RjL9F2TzvfJNh6TBX3AymTT8nnWCBjyu9jjTWdWeetmpGG18JXRKNV32TZVJz9gu0F3xmjRNxX6fGQmMY7yeakuLpUolZ8y+tdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806888; c=relaxed/simple;
	bh=5fPllbsOf7sccFo5RXhDhCDsCKJFQkF8T9XtQ7NNf2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAkMIiL5Bt4YAT8uJVmyWwrBbE+SWgfXkNAHUlkRWV0CxTQgnMyRQxlGzCj2qZeRgnVjv53tL7MgyuoZe1cOWtVfQYFM4P6eg+V8H0W8SOlUbdtW29QtZ+qDxxQAZ0H5LMeWVzX782qJyDhsWQPoVdyEf3YhjVBD5rQBlTRxZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B5bcQ3Bg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NOtTYEBq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5bcQ3Bg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NOtTYEBq"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60IMqlSm3345357
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 07:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5WfZUJN+4yyrEknLJ+I9YLz3L5ZjIyay+AUARwvRzZw=; b=B5bcQ3BghjX7/XIL
	kHDxyfbB4oy+Hn29hjlD1MQUkE0orp0YfSnWgJxAL0yFPEsGPs8wOrhKKu1J70hD
	p8a4AOIogHfI281bK4qrnL3ABK42Gowf5pcIzoc1HoMjRkaFghSL4cHFVBWZpW3k
	BjD+2XfRBJuIuhiEkcgC1Z/ruoO/ooMi+nh80jXCBGoLLunSgrRPC691QqUs4TsJ
	Jqhzhg3teFMcYnDN0gNpCtXW+3lkNxBShCJa++6iMBOswRmJsDTvcPfRRnZzQ+O6
	QYRFF8j4/D4GclDY/8KnW0D662F2ZoiZSIQ3j3DcCRwhwqAV5b9V70ulMC62c8Yz
	slEXrQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bs788135q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 07:14:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a377e15716so82389405ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jan 2026 23:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768806885; x=1769411685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WfZUJN+4yyrEknLJ+I9YLz3L5ZjIyay+AUARwvRzZw=;
        b=NOtTYEBql61bpuxuM3VikKcrqZXdEBdakj8U+74QU6Gul8dKfq5mBvGwhoIaeKIDH8
         G4xSr3jeXnJS4uUpQFZx4zl+9/5zTWiuw20yBWQyNWZHHnbdRN83Dyay35NwB7Q8iRmq
         abOZiEMirp/67o8MaMhwnBrOdXYdnWSBoRhG3kDz0EXFIcMiaDuuzQpHIiX5ji4zWhG5
         jPozlUlR6ReZdHgVmBMhLe2ohQHZoI+7or+HCfZRbLYtk70ZXLEHqoJRTSraPgL10b0J
         z8YAHFNP4w0raErWKwGr7WWgebMmX9tr596WxdoLShhmGGY0lC4QctqA1iIPhQNhid1L
         oPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768806885; x=1769411685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WfZUJN+4yyrEknLJ+I9YLz3L5ZjIyay+AUARwvRzZw=;
        b=Td4b8tEXQ3aqDrPA2C+TTbVt0+OrZuRcPunypl5jwVLNudflnWVVjobKoGql7i8VmR
         NOiBZsC4jNWD3PYf+bxz9kgJWMWZY2maUA8v2yKT1cHrkrETwaOUuwCBU41PN3Vgoi2F
         Cebd/e+2NMN7463/1yLbAt6I/jYwWNK+Dcgzg6rFN/z9qE4SRPD8VYhsAd3LS6SPgoed
         SbOem25fRVDAV0C3XS3jnUyMOtBKktPj9toeVGs5xEaq+I3zAJKTtrrAMyqEM0AlMzI/
         ibv8mnBNhADn8lksLp0H7wLHYUPKLIYJ7w+G0AqPCCpM64KmU1KWENmXA6TQBj/c8XGK
         r65Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3SUEgj8WNjtrDprvN0zlC0Ga/v9yb04MMYN+cuQQ7UjxaBtq2sw5cdR8dSsnHrP+KsxXM5stD6ki8R4Gjo7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfoAgh1UZ0LutMF4MFJf/MSPFN5eLiX39oUWh3ByexEAfkddqS
	JkA3jwmsFVQjtUZ5OPd9bW3IB0Mz4FlUk6Hb7aaeoPZr17AVKxeCtp/8QRe01KOSOyrX7ItnfCm
	Its4K5EHU0N8AbXzk9k+2kFluRDf7Buk1d28jRVLz2nONvgwB5sfichSAqIRzohWw7lxyC8o=
X-Gm-Gg: AZuq6aJpCzF7hQ7k/Hi1RHB1M9sUdO2PZzy11+gR96mmyzSps7sIquR8s4NQ1IACT8d
	9/9tKIJklWrrJT1oIqG7/g/V8B/DAKrqPSoJ32/J6muj40w+TZ05cv0JuxNjC5sp6StvzqTcM01
	oQjWXTYBDgli5uk+oxLSEsrGV4E43QiJ9TDBBMP+pRZYKzTFV1JOSvdZA8PaxOT0akmBRnEH699
	7/BTkueDqZglPIyFVz8sSGPDQXQebWFguVeRA6YjYjuorKR0KxApw447THr/1g0u1HzXthRpudi
	2po+Yp/l19In8iFbYYj/GSt0cWasD0RLhjzsiRMB0qaJyKgI9rRoAfaZFNlpsvzNvd8jQ+OY0UN
	ohoes7cxJC7GH9W9eEIdxMlsmAgVQfnISgR8=
X-Received: by 2002:a17:902:d549:b0:297:e69d:86ac with SMTP id d9443c01a7336-2a718914867mr106392605ad.39.1768806885177;
        Sun, 18 Jan 2026 23:14:45 -0800 (PST)
X-Received: by 2002:a17:902:d549:b0:297:e69d:86ac with SMTP id d9443c01a7336-2a718914867mr106392405ad.39.1768806884680;
        Sun, 18 Jan 2026 23:14:44 -0800 (PST)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193df75bsm67919475ad.54.2026.01.18.23.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 23:14:44 -0800 (PST)
Message-ID: <cdd9dd67-5281-472e-8e84-65a578f999a4@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 15:14:38 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Fix SSR unable to wake up bug
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Shuai Zhang <quic_shuaz@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20251107033924.3707495-1-quic_shuaz@quicinc.com>
 <CAMRc=Mce4KU_zWzbmM=gNzHi4XOGQWdA_MTPBRt15GfnSX5Crg@mail.gmail.com>
 <212ec89d-0acd-4759-a793-3f25a5fbe778@oss.qualcomm.com>
 <CAMRc=MdoUvcMrMga6nNYt8d-o8P-r3M_xY_JHznP3ffmZv8vkQ@mail.gmail.com>
 <96472b7c-9288-4f81-9673-d91376189a18@oss.qualcomm.com>
 <CABBYNZ+5ry0FWFSgOskw60jja9mE6WG5AwOi2pKxrkzqMn9bkQ@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+5ry0FWFSgOskw60jja9mE6WG5AwOi2pKxrkzqMn9bkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KLVXzVFo c=1 sm=1 tr=0 ts=696dd9e6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=oRiKqNWV6AETYgLPPlIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA1OCBTYWx0ZWRfX80Vkxnq2nWeI
 uX6JrPM8Sxb7pijWk+5Jv20ZmLkiB60Gg4sRdbmhXZW4+vCs/sUe1vFUWRpAmdReCBqGzwij6rp
 sLMch+bDJb3WKOqZGIXGBUDqGoDoNAVl3tGjhSX6NEXpgyaiZKnEWqV98x9X8V6DptwoYxN18oQ
 vH+rkfKNSQ4f0j7aj3nkU9j7/IM5hsVUKoWh4Cxgnlzx46JQ1cZrPUCgFbxqF0NZ/0jk5DCr/QJ
 9xURM8XWPpp3wobM/OVFX5EDsfjK5NWlVqJ6ajHrKcjgUoxqKnnYts+tO7nClxcDJnb9/2Xdbzd
 WB95kjEsMGIRXOwzW+M/3wnBDbqoN47bjQ4Y6cABUm7rGlGDaAvwdqS6Naye2e9Iplj6+2aecDI
 yN1opzcaMOxqJlYrnU+9LBX2+4xPR/vVd4zlwsno6Wk462y8DFWcgMtLlfumeu+o81/kwqNWOY9
 19zZdJXLafQfH8IYJoA==
X-Proofpoint-GUID: HkuH2fnqBWpDfkybHpzH713O6-3js9he
X-Proofpoint-ORIG-GUID: HkuH2fnqBWpDfkybHpzH713O6-3js9he
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190058

Hi Luiz

On 1/16/2026 10:42 PM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Fri, Jan 16, 2026 at 4:48 AM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
>> Hi Luiz, Marcel
>>
>> On 1/16/2026 5:20 PM, Bartosz Golaszewski wrote:
>>> On Fri, Jan 16, 2026 at 9:37 AM Shuai Zhang
>>> <shuai.zhang@oss.qualcomm.com> wrote:
>>>> Hi Bartosz
>>>>
>>>> On 11/7/2025 11:37 PM, Bartosz Golaszewski wrote:
>>>>> On Fri, 7 Nov 2025 04:39:22 +0100, Shuai Zhang <quic_shuaz@quicinc.com> said:
>>>>>> This patch series fixes delayed hw_error handling during SSR.
>>>>>>
>>>>>> Patch 1 adds a wakeup to ensure hw_error is processed promptly after coredump collection.
>>>>>> Patch 2 corrects the timeout unit from jiffies to ms.
>>>>>>
>>>>>> Changes v3:
>>>>>> - patch2 add Fixes tag
>>>>>> - Link to v2
>>>>>>      https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
>>>>>>
>>>>>> Changes v2:
>>>>>> - Split timeout conversion into a separate patch.
>>>>>> - Clarified commit messages and added test case description.
>>>>>> - Link to v1
>>>>>>      https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
>>>>>>
>>>>>> Shuai Zhang (2):
>>>>>>      Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup
>>>>>>        during SSR
>>>>>>      Bluetooth: hci_qca: Convert timeout from jiffies to ms
>>>>>>
>>>>>>     drivers/bluetooth/hci_qca.c | 6 +++---
>>>>>>     1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> --
>>>>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>     Just a gentle ping. This patch series has been Acked but I haven’t
>>>> seen it picked up by linux-next.
>>>>
>>>> Do you need anything else from me?
>>> I don't pick up bluetooth patches, Luiz or Marcel do.
>>>
>>> Thanks,
>>> Bartosz
>> Could you please help clarify this?
> There were no Fixes: or Cc: Stable in your changes to indicate they
> need to be applied to the currently RC and stable trees, in which case
> it will only be merged to next-next at a later stage.
>
> If that is not correct then lets us know if that needs either a Fixes
> or stable tag so I can send a pull request immediately.


I will add Fix tags then update patch.


>> Thanks，
>>
>> Shuai
>>
>

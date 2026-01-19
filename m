Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D683590A5
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820615; cv=none; b=c+h42YSF1gpslQ0ryOzNp1t4MZXi4kpEQx5VskvcI0D4qzVqhKn3D9B1q7TCwHVbR+HtE7Ef0RZoGBFgb/vjf/lZZ20FXxxX/VKF2bHWhSXClQEODVbCD8EqFpdF9gc+S7cEXkTT0TLHIUXpIr4JR59G06PDbMYeUhDOB7BFkoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820615; c=relaxed/simple;
	bh=qdZow0iIRdgkfYhOnDo9Dex4GvP/UuCwNCPNEWFUyoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGpV0hWef9cNckH35e4YpZ8pKFNQj6/u0AQE5LCAY+FfnP/jLGYe692iduQsGDky57Ry8/ppRWW/GHrTOdTlIlw063c3UU5InTD/n/SkUtH8BblgYR/4owb5vAj//D95SK53NLUtXUyB4HQkqsWPPT+B6LUoZs6UvSKRRtA2KuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3IlmLkL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i58I5lXH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q3IlmLkL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i58I5lXH"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J91EYY1150160
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 11:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c1LOQNTiDOuTEop/KvOGER6fTNN+/DBF3R/IDkhgQ6s=; b=Q3IlmLkLDuPFJOKm
	FLbMRjbOPhn9e1QoktulrDirOtvqsbdpWfNaLu+/O/69+Gk1G/RcX1bQr8hCg/zJ
	WK4yUxsr/JLv6jx6jDreP2Fzj9Dg/JEF2w78eAgMJlOZhDpZIF12oBtW9xV380PN
	ePXFr8RwaE77HuOuljKhBjVu7NGIFdXotwQI4yOtBj1r8wLgPv74tDP6cw5TJo/o
	a8xyCvoGryQsFJ+3ULphI7r0cNZRF02APM0wgxo9SU1mubP9Ld7f456nQEZ8u0Z9
	m0SASsS/SkzvzWYBrn9jkO4GmBIHriV4u/vQPQGxw4eQaq0AxJ2w73djQVWPdBBv
	ZRRPkw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br04e56nk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 11:03:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c56848e6f53so2317948a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 03:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768820611; x=1769425411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1LOQNTiDOuTEop/KvOGER6fTNN+/DBF3R/IDkhgQ6s=;
        b=i58I5lXHJExec6ggluYw8vLstUyxnxceP4GRFiANyLysKkexked4ZMwFq452mZRNG0
         g/cRW1MIv/AW2q4AG66um0jVNBGWCH0doLU9l42XmYoNSDQc+Lnt5iTP19D7YWUOwzUD
         wx3TUssdsNATjHcNRAQCgWypAlo63czrUIBmwqh5J66++ghn67Y22rMaOcJWNEGSOzn1
         Xpv5C/XBzQFdgJlzHX1At4hxh/W0XO0J9NYfJ9Zm9o7qiXQknQmxGQQZyO5U6yCwxu4i
         zLOw/gu6dUil07JXeBOAqMc8aG0BSdtuJz7wrms/I83Z66H1H99XbmE/JnvYj7FLmh5N
         /gQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768820611; x=1769425411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1LOQNTiDOuTEop/KvOGER6fTNN+/DBF3R/IDkhgQ6s=;
        b=a2CaYP5qiaEg1nZBpJcojXGThIp9cd4O7be2S6nMHus/RTCYjS76i1rLsq2MvrZnFy
         3OBNc6vODeEfyWFxXm7WcSw25pjpIfWN3a/cmojeXdygVHdk74eEYztNxwYH5bk50QGc
         /nkrOYoEv6n4yU+JmCdm53hFo4gP5Y9YV0Vs4aI49fnqScFG1vmS5YvPXVs/KY1w5bWR
         cYVR1QIJukVwd3Zgq5gYqRavZq0GCHQYoLINf64JYFGSUXlMAvSInpBTQCPIEFe0GrVS
         FbxSi4NjKzNMBfF4nNBPZ4tqJ1JUXJ4xZKSRVYypD6GQxYr6f1p5+nac5mQS+Zje2CKj
         l9CA==
X-Forwarded-Encrypted: i=1; AJvYcCU41Cgjt9CoKds0h3yXwGicN/J0hG5PBxN+AZkxgDG41Ou0RNrCE+jpuK2OVxUdixf9/BqUZFf8n5UCcSNpA5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiG2KjN3s+4y3JSVG1y+1OoaMKA6kmvLUMQ9UHRElJurlFjPGk
	/CVhmqJJBDoRbVxo6GeFeDniFKnRjozAJDKVWHGNNDVufTsqAthRmvsUr5z4sqUIa94ffDfPgeU
	ztJF8Aa7HtN4eDzZsKFTgI2+NgZ/ccJpYjPUAjwU9Drot6rtn6pE1RT2CWzSMc81nrqk//ag=
X-Gm-Gg: AY/fxX4noy9fufIWhI5PsjAtaWobQ5+4UsBzGxdKnX3EAbnujomDpMFnp33SFpdVkuU
	/z2DApm27sPahwQyj1CD1tRgIft6sR+ZSSraMyaGnmHjYTYHsxNY9yKlNX+7i9JeW235Gocb+L8
	IDFx46w+oI5zuoAmP+J+1t7eyw0u86tEHbYhfKde7KUolMlE3I586hRRpXspvUgDomxL8zPQhgm
	tow63M2vtiPgPtf0LaZXh5fp9WKFzj+ykCLVomysKij/gZfQKm+Y9pg43r2JbwDpbZXHckOsKP1
	+yoEjq+aE++5zHyqomk8X5pyFPjHRvgS8CeF8sEXdHKZEMXrOO+0lYlMNtJurLnGI0Kh4wz640i
	m2R6jYBs8tcYZPHbDnkhN2TO2hAkMQsgKBYI=
X-Received: by 2002:a05:6a00:440d:b0:81f:3f6e:166 with SMTP id d2e1a72fcca58-81fa030fcabmr8923183b3a.46.1768820611450;
        Mon, 19 Jan 2026 03:03:31 -0800 (PST)
X-Received: by 2002:a05:6a00:440d:b0:81f:3f6e:166 with SMTP id d2e1a72fcca58-81fa030fcabmr8923164b3a.46.1768820610869;
        Mon, 19 Jan 2026 03:03:30 -0800 (PST)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277a15sm8994060b3a.42.2026.01.19.03.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:03:30 -0800 (PST)
Message-ID: <148f8566-2d99-4fc4-a934-5b7d1bcd5a20@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:03:25 +0800
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
        stable@vger.kernel.org, cheng.jiang@oss.qualcomm.com
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
X-Authority-Analysis: v=2.4 cv=J5OnLQnS c=1 sm=1 tr=0 ts=696e0f84 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=oRiKqNWV6AETYgLPPlIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA5MSBTYWx0ZWRfX45wR5UJRdeb6
 YikoqeSi+ThMYw1c1j9b0X+4fiC732zSvqDtJDfb5bINzaxgULmjwkDi+ttS1JYpxr/f+4WaY5k
 S57q8pYKp5BRkVywr9P4+obv+machDyzN9MtFhD+4KDEm7JtXr476eupdvJ0fw8oxSprlmPBrqO
 /BKZ1DQrqH3PIsDJABf70N9FD4F6m8JjjrMRSoH8J3PtCUW7eVwsIRTvnkmDLcT1qQfuIvKaq3w
 gsSSONldym9OpysfXoRx6MytIwzaCLcOWdjMFrW8zcMkqZYYarztEwDlKVHJ9i0nIzu3taxS7l7
 GFMz5ZK2VZU4PBSd+ve6Ux8/fpqkDe4x/4aP/QlvtO0CNDlYR3fk45EKWQsX/yNAmrBT1i9jq76
 BQllmw23YNS40NyWzxoCV+jCYClafLQSoUJL/SM+W4cJWW81pjKbx33d0UN+wZDbxmU25eem6PH
 lVIsrfND29kDo+kstKw==
X-Proofpoint-GUID: tmr8N7x7XEeoDQ49ydQjdWoJ4S2_hl_F
X-Proofpoint-ORIG-GUID: tmr8N7x7XEeoDQ49ydQjdWoJ4S2_hl_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190091

Hi  Luiz

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

I saw that it has already been acked-by, but I don’t see this change in 
linux-next.

>> Thanks，
>>
>> Shuai
>>
>

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4839DBC5
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899782; cv=none; b=htNn34UrYi3jBFXeHsniiZPRkAtsKbNt2P5QcxWAV/slN0GwFJT4qNkxf6LXUXZuXf+HU7WD3qrxDmMKNNGvFukra4hLTSJ5TRgjrux1y56uH8qcLEcXn/8AYa29LT5fgj6RtuM6lSv19tSEHDcsLK1A6/vQsppG8ms5LvAjz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899782; c=relaxed/simple;
	bh=8ZiUi24fqFUdPu4QU34GDgepeC6HnaXmOxRZ/hB7GnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GA31XtiLZ6CCd959S8/doFbLc/8Un8dZ9qVIklBVMefrQkaXQURZ/b8lJdE/kTlv2FZmKNQtsm/JgvhZRjIVQzVlu3WXqL3mEs9aSFeudKv7OicKclKObPYAeIaLEo6pVyCCUAe2VclHEheO8qRpZdV9AQ5Z4YKyZk3Vc49jh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P2KCUt9+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Czp+MJFz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P2KCUt9+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Czp+MJFz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J5XQTk2347861
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tDkC/xeR/SGMrqyVDxbSwFz+SYbQs1f95eXg5vYl4CQ=; b=P2KCUt9+iuiCPzY0
	8GD9yGDozQOvPOZugZX0KlZQmhXzvvoP0xCp5QTSuO+PnJ8NmUTpEbYlX1iJKJJo
	/k5Ieg7ga4PayK7fHuRiaF6XR8ao5jG62z+tHSGqicntiyTAEsBovvkwVbeDX6En
	9ni2jsQa3G2PfQnjIP2chTYYmCVv42JNCXThSqBnIGHmqwSKsGv3soCLhAfEhtzx
	al2UHcJNhBWuv1Q6qruC8hN/kyjx+wHLZ3QbwL30S2MHsHsc8E6IaHHrnOlPYbhh
	kgxmM0YY+MgelIna5/t0mu2mCnn+YqC9UDs1xu2Gqh7mdc23HQG1zwpgCTrVQBXf
	qGSkDA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0957rbyt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:56:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c0d15416b3so11684841eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 22:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773899779; x=1774504579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDkC/xeR/SGMrqyVDxbSwFz+SYbQs1f95eXg5vYl4CQ=;
        b=Czp+MJFzSxFeJuwMiEV6QpHeA+d46cZXKv/aQ5U/FFls+C+EOywoU1w03Ds9LSswJO
         RUjxb+bJfBUVfFZg/GvAJwAbkTJGbEW+dhw2NrEgoHYGJ+8MGqoGn3DVDIqOynrdgrdD
         vyCOEX8UXnNNbEjaXBFfL4lLTcHI7AYy4fjtaerW1Ip+A+zXynMLiFUo2G3tqtMacyB/
         RisuwBF0tRY1/Ch5JTgPh30/sQ4g7plakjAExWKXXc3cDzRfVcDKKoZc8BABXE41jHkv
         CAEfrFDCwZz4BfcRTpBaXBvi0OXrG6B0IKAYnsW2FgfwpnV/Wfyj6ScEJ4AUwfSBmIIR
         KGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773899779; x=1774504579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDkC/xeR/SGMrqyVDxbSwFz+SYbQs1f95eXg5vYl4CQ=;
        b=ki4ncUZTT/FVFTZ3M7X09ui/WTka8hER5eTA3bDKEKuedhBkrBHswkza9irscCkTaS
         fyt1tL8me6ciszmWFqNsjcWFQkOM02svoweiWswAHwknFYgoKO2DtFFcyKBRpKRqLljt
         8vphwT3oovN9mL0fbBwA4TSLK/QlC0QX20ujrTiEpNRGywV39srRJzyFE73MSzb7ghl8
         97mx6Y4g7b9JtGB4VJBs5epd8d8P/aJbVKqP8h1H1SgNDcsoowr73pdSmHZZJKgPAPvD
         8YK5pfTnHQj5p5nKISzHxP1hJqCK7aglR/bDEnNhYDUgjEeQgXeImk+TEogF3YnsPw7w
         cJdA==
X-Forwarded-Encrypted: i=1; AJvYcCWQLvsJXwyZ5FDwxmJOdZ/1UDhRlA9PzTISk+fHSHV2vQED1aXVknKVORAqTho5eErAQjVHYef5yPWv0YUQsFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQceUKJfAb56t44A1pXRw6as2WUG89mx5PdoKJ/hWhQ8Dnpji
	ZdAjB+AEjjQC0NkuYLck2zkxhE7zBZlE7jpNU4a34ZDlzUo0PsY4ZPY5z+9944XyyNmZMy02AVE
	fvByPFM8r76LCgIuAaWYa2ngMreQLPuUfIC1tKr8ijFANHpXnyWlifm9FMAW2Uowv2m8WDt4=
X-Gm-Gg: ATEYQzx+1446kfEiOv72S85z8Wkw6E7lQOcNB0XekOU1SWZhcqLJC3e1Cac4srQfiQg
	un1iMGtk9TJBZwHsiI65q4cOEqm5NnGTTImOEctW1CmwY0MXsPmer/NoXdo7nQzl9DV5k21sBo2
	RofQ+wwuxX1G1lB6lmFhGUMBFXkpZUpgPO6sEthlUEsFuwTrtjMQY75WCt4IFpkEjwRmNGeaZxB
	dLm+L9OPfo8d+tKseY/87OzhF+Bb6bnq4fi0GrJKNTm0lqhNqVE6Kte68x0X7vWWOrVejPJX2aq
	F0hs2GDdz4wXPE2Y3SqrVuopigjetgH/PxGRJkpjXlMevKV+yqFvrxxxmLc1X4V3U4eCh5PjrvX
	umQxSsJuT0vHwU+lsoszHUsGenBxQ4C3S8IScO6xavdLf+2bGgm88h4Y2jjrJ5oB2ZHe8vINHOB
	E=
X-Received: by 2002:a05:7300:7f9f:b0:2bd:b961:7e8b with SMTP id 5a478bee46e88-2c0e50e9b2dmr2972221eec.24.1773899779382;
        Wed, 18 Mar 2026 22:56:19 -0700 (PDT)
X-Received: by 2002:a05:7300:7f9f:b0:2bd:b961:7e8b with SMTP id 5a478bee46e88-2c0e50e9b2dmr2972208eec.24.1773899778813;
        Wed, 18 Mar 2026 22:56:18 -0700 (PDT)
Received: from [10.110.94.9] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e53b5235sm6901248eec.8.2026.03.18.22.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 22:56:18 -0700 (PDT)
Message-ID: <6b5e6d2d-68cb-42da-82f3-43b2fd6fb943@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 13:56:15 +0800
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
X-Proofpoint-ORIG-GUID: Riw_32bxlHeB9lxcwPWEiIGAryfX_8Tg
X-Proofpoint-GUID: Riw_32bxlHeB9lxcwPWEiIGAryfX_8Tg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0NCBTYWx0ZWRfX/MmIIbNAKpyv
 O5EcFIMaNAb0wl+Or2/pha7sOIBh3iArvO/5aETlII061RfMf6826mN6Fb2KVY7rbTh1rjGF+OT
 usxAoxDFMgsQMN8s1PrNjvUxmJzHwwRxSfHlK1QOnl4uTim2Dm+LUqhXlfkiinBuLR6oW2yC50z
 5UYY4tcmF6lNVVwL3y3EYcpG8vX+IGyQK1gmqul5PBd9IsAgIhfeI2b7QTjtPWMn6PwA1+JnSap
 2ZbKA+CT8AnfgiGS7HZAyePQnXh9ZIniwOlzk2W6CDjbvHI60GBT5+ZUon+2jua524Xvym5pHb3
 Oj/UZI16fwlnm1XAL6Rdwwy01pBVUb4p7Y77lVPSku0prkyLhP8lTlcDsXqhROCtjLpfFNCngEr
 dcDNXnGc+1KESc6P918kS5GFjaf8fKyl9sW+BOpeJnRNlNcfVgGfx47HAmnvoJpWHJkdF26pJMh
 gfao7xgfXixzeMgyWsA==
X-Authority-Analysis: v=2.4 cv=RZedyltv c=1 sm=1 tr=0 ts=69bb9004 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=2-u-yepbH7nZdbuG-UkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190044

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


So far, I haven’t seen this change merged into linux-next or any other 
branch, although it has already been Acked-by.

I’m wondering whether I might be missing some information, or if there 
is any additional action needed from my side.

Please let me know.

[1] Patch history: 
https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc.com/


>> Thanks，
>>
>> Shuai
>>
>

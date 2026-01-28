Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84127815D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 04:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769572995; cv=none; b=E0Ly/sMcZPhiyGVNmW7WlAB+ZD55ge+wC7yph7OnHJ4iBqNMRh4TLORKxViKfA25OeY39oiPgJ1YHfqbwWBYnB4aqMiIjpGCmnQbQd2lQXb39iOOXlDLtpV1ptOKYxAf+oK0Set0ZMXer4x0OBzLpycJiTqQIBfB6txOXdK2CKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769572995; c=relaxed/simple;
	bh=kB8xsjBTb/gFKpjEArBn86GeVi12fURxDbiZebCBmFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNJCGROijF2Ycn69xNw3t184cbTbeCfYrndtfu69OOLFQZsXF7Hg65GVOZX0Mkb5HubjxoNhRmyN7s3YRb1FNASPrfvVXeLjf/CSjpU3UEmSwsLcqwUQdvJ7eGkbRefTLQv8h+7zejxMHH6qvsiL9yXQp6G28jfmzKfdU3UUS0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vdr9VO0s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AjPgLQfz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vdr9VO0s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AjPgLQfz"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S25CnF1714655
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 04:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MUoswFlJ+yiIr8sXirOxgbmRv5wfMSzY+cd2zV55w+o=; b=Vdr9VO0sywE/pNOl
	cvkUInN2H/mY+ukQm+6Te9BjAS9eIS6Clv94KXYjt80lk8CESFHoi+tAuzd44KFF
	VZyO+qJcIqwkl/Ss03/kVgfVyc8WZgOOF8KiqsDUIHA1kpgvXAcjTqKbFzdpd/XD
	ZrlM3PDxGbrmVVYZjkZtApcpO5THE/FyXZAfEwXvpF0Dv/OXxf9lsjifLue+s1kF
	s2QS78uBaSscwvHcDnbDUOYbnLrMkHP3U3S+FAnndVEeP2kO4FpqB69nFZU2MlL2
	G3d0YecyOCG7SYawKbZskcVy6VgS0dU4HYFmJTRy7Zzx8UlMJEEe97fVTg5ovmX7
	Fc2R4g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by0g0a646-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 04:03:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b71c5826fbso7016548eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 20:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769572992; x=1770177792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUoswFlJ+yiIr8sXirOxgbmRv5wfMSzY+cd2zV55w+o=;
        b=AjPgLQfzp+wg7nGNRZZVjOdc80e3+c3KjneAHSAcPhxmoXIKCYud0r8Q54N4PmeYlW
         5NifFYN/YpDNkvQas2J0cemBeu2LH4VNfcrfBEhEk6EkzNuM6FAsYlKcDXeSRDo1CZl0
         V1G1AjmzDBVkRWW/01CEtmOcPpZUhSZxppPYD0+aKOu+Afysy91ZUGB/xCBznfy5g+sv
         Yq7mFmREE68jQm6RMxKRYwhUcwZcVg4EjBTwTh7ODKlZoElVxHPdIpN7KmFa9Ivlyhbn
         wk7ZwFCvRmU6dh/UVZdp7k10HZT/hbiB1z7W3+tdDvtMrJ0+w2UzyuR+lLHfzFE4mRu/
         JKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769572992; x=1770177792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUoswFlJ+yiIr8sXirOxgbmRv5wfMSzY+cd2zV55w+o=;
        b=iAn8Rx0L3PMY9oi1z73psxqwNmYPH1uEeXpXT4w5hEOs3HIVDkKtX715zn5fOs4pT2
         NivVSzgxu1p/Uj29yXit1SE6FLtoIlhtuq7azfM1EVicOOeO9I3SIh5YIXDdhr7r2Kgd
         fyTxL1XfSPd24kX1Q4vew7iGUw+Cr3h1GUc17oIhpKI43nzLTSbKynGHcvdfZkHfsbif
         tQCj8lCDalFbCR39pF2HzjoLnzzfiAHZZfjgPy5pQF7KAywy9npNc1OkQmHQJmHHgFHO
         Hj08g5He4v8OiB1BjKUAOX7BrnucQjSgFGVWfi8bsqsMmXRg92Y/ThmVW12KELWFWZsK
         Mggw==
X-Forwarded-Encrypted: i=1; AJvYcCXExvMlqINCRy880wEcN3umIMYEB6n+kpEOoUPiM0wOf2bvp/0kgSQ9Bf92eWyiZSBkIUVooA/vZS3KDyG130o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDfPFKU4X3eztftWvOvOBjqAokAMl1sP1d2OAOHE9cCBfOp5z
	eZrkXWYp1c5RFuE4hPDZbZN45QrpTVoFnG+8ao5ThBoxrRLx8YQRTObmoQHM73YQ+QzIAB4zax9
	9AAZPL3WrK/obk6PH9+3d+ukXqjfz5SoWGMjq+b5YVsHaTFhDw9EYRXoFjtIiB4hrWBP/B38=
X-Gm-Gg: AZuq6aJBbQ8+9Dx2HnkVAInha1TWP8JbiXzjl2I5/A+fh/BILxu1rVPjYi52RaWiI+z
	HAVc1N/gV0iFlk2umBdf6ZRAW06ZSTj57lTZsDaQsyP0udRe47ixQzAozWVUSY75Nfummr9d4C7
	MVxADiLBGLUN8W5qGSiQZFPDN8JFVFWSqJKq7i0CiqDxdr85X9voPcPTB/HjK1fkwbYQ46nR/qJ
	XXXwlLtss8dcvUj/BEr/p/GHKoHX5MRtxYmOmEw1G/TQzz/Y3BFm5hOJbuZTk68zQrg0NbMt7gT
	Z2w/b+RuFoFLqINfFEoTEF9hZ/P2MKyH7ByKoW7QLqVPw/qND7Shk0kemwGZS0QZeSGipTHz/ry
	kJjEkho/qVPJQScUrE5LPjtHsziM190k2Emei574i2eaDoxVzQ0fuFNXLb50KJwy6
X-Received: by 2002:a05:7300:8c9f:b0:2ab:ca55:89c6 with SMTP id 5a478bee46e88-2b78da3eea0mr2595606eec.41.1769572991950;
        Tue, 27 Jan 2026 20:03:11 -0800 (PST)
X-Received: by 2002:a05:7300:8c9f:b0:2ab:ca55:89c6 with SMTP id 5a478bee46e88-2b78da3eea0mr2595561eec.41.1769572991167;
        Tue, 27 Jan 2026 20:03:11 -0800 (PST)
Received: from [10.110.57.207] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af88c4sm976319eec.31.2026.01.27.20.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 20:03:10 -0800 (PST)
Message-ID: <a1f8d7f5-8a32-4d27-869b-4ef2c18250c3@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 12:03:06 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_qca: Enable HFP hardware offload
 for WCN6855
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuai.zhang@oss.qualcomm.com, cheng.jiang@oss.qualcomm.com,
        chezhou@qti.qualcomm.com, wei.deng@oss.qualcomm.com,
        yiboz@qti.qualcomm.com
References: <20260126162444.4194293-1-mengshi.wu@oss.qualcomm.com>
 <20260126162444.4194293-3-mengshi.wu@oss.qualcomm.com>
 <kej5u2hjxjtfdzmgtebns3amz7gmb5d2nciy45jsyglkprgh6s@kt6fodrc3oll>
 <7b9fec28-2272-4ff7-9575-76e72cecada5@oss.qualcomm.com>
 <l2ib5kalse4nop6e6ak5xronejxusnprl4qgz2wxvdw7wpzw6e@aa6fn35id4we>
 <CABBYNZL-J3-kcrN-B_1yXci+nw8zjgiiD_YFH0i4xeRNvY_Jrw@mail.gmail.com>
Content-Language: en-US
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
In-Reply-To: <CABBYNZL-J3-kcrN-B_1yXci+nw8zjgiiD_YFH0i4xeRNvY_Jrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qk9C3Q2nYZhDlTUvthZncaWUYNNR4yhf
X-Proofpoint-GUID: qk9C3Q2nYZhDlTUvthZncaWUYNNR4yhf
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=69798a81 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=jLO2Fxiw5Y3_fRslxeUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAyOSBTYWx0ZWRfXxIGfxMHUPj3v
 //oUsYv0ODUzeT23qeJh+yHwt7ZKA5NqxoTePDxO9saXAnDP9ilqJ86T0905o9cGernZghDn1E/
 44BItp0x93B3wDnifccPEQJ1e1M6JKjKbVWlBjqMirjtlCzWjaWBblGljiTuB6ww9Tl6RuCVbqq
 VU0E+yvwT0n/+iz3ogYLGgniJq8yTJ5L6gdWlDitUwFqyQSovtbiMqbh6eIAgP5TLsDumfOMaxq
 oFxeNHU+kIUo+LGorZXrfnLYbcB8UgsgYBJFX7XHxlhXMc9T+l89u73O3a2ekr/ZeR9ONpnLJeo
 21g+r8INHM8c7hSTiVslwjgcBR9SHSAau16dOkhEl5w1FtvWFnnZmZibE7fCELwMq51TYrN77nk
 Xq9liN9TbmGri+bhwcDDYtZBzrQmXWj+ksFNTnziAPfQWJXbAK7U/WP0c+IAajRj4PedELh6USf
 mktmhrmLfvKFSgxOy+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280029

Hi,

On 1/27/2026 11:47 PM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Tue, Jan 27, 2026 at 10:06 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Tue, Jan 27, 2026 at 10:32:58AM +0800, Mengshi Wu wrote:
>>>
>>>
>>> On 1/27/2026 1:51 AM, Dmitry Baryshkov wrote:
>>>> On Tue, Jan 27, 2026 at 12:24:44AM +0800, Mengshi Wu wrote:
>>>>> Add QCA_CAP_HFP_HW_OFFLOAD capability flag to WCN6855 device
>>>>> data structures to enable Hands-Free Profile (HFP) hardware
>>>>> offload support on these Qualcomm Bluetooth chipsets.
>>>>>
>>>>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
>>>>> ---
>>>>>  drivers/bluetooth/hci_qca.c | 3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>
>>>> Any other chips which would benefit from this flag? If you are setting
>>>> it for WCN6855, I'd assume that it also applies to WCN7850. Should it be
>>>> set for WCN6750?
>>>>
>>>
>>> Thanks for the reminder. This should also apply to WCN7850. WCN6750 is not
>>> considered at this time.
>>
>> What does it mean? It either supports HFP ofload, or not. Does it?
> 
> Or does that mean offload is considered the default over HCI, and in
> that case does it actually work with the likes of Linux
> distros/Pipewire or it is Android only? The fact that it is mentioning
> HFP rather than SCO is already concerning to me, the kernel driver
> shouldn't be involved with profile layers other than core.
> 
> 

Offload over HCI is the default way in most cases, but I don't mean it
here. Offload over non-HCI ways (such as I2S, Slimbus) need other supports
from software aspect, but these supports are not ready for other chips yet.

I use HFP because I noticed that it was used before, like qca_configure_hfp_offload().
Should I change to use SCO if HFP is not proper here?

>>
>> --
>> With best wishes
>> Dmitry
> 
> 
> 


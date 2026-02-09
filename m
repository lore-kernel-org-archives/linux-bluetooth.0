Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E682E37F8A6
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651956; cv=none; b=b5G1XJv4vFfyM7HnHFAFrUezlcvvWc10BTLHJ+xU4/+10HaErYQogzV8hhM3ejHUoJnsGwEMjNAfQ+Y0KJRW2nE9/OY2MrvoGYW0UtmaT4mJSdn2XQIULBJw2ix90C640hepr02HkYJ0z8LV33YKnErp7+fwIqWgrdCZdYsSNG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651956; c=relaxed/simple;
	bh=F6ZHOYjgOqKDDSkVmJxSHzLZsU9BiRICO3QW5hQN72U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRLgz/sb9hk5NuKdr/nKuli2lWYJHJSFLWRVW3wAEM/jk1O88GjZYVaYSgCKEQiVX1U9cxkpswd7i9saMRdU9nPZ2NyXNT/XLy24qyjGwDm2Qr5VrfVj8x8IPudovTjRg0brpwwuwgDDRaaVFTFtiq7SYwuyaOYwonEa+tkJVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QzgSQqdz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iTX7rN/2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QzgSQqdz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iTX7rN/2"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6199sflu1656367
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Feb 2026 15:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BSWE5q+1oo4kM8c3X2R4tW6aG/lc41Xt8NN6Q2uo37w=; b=QzgSQqdz+yS73z0Y
	nlHBcrvBinm1MhKrDUjqaNuq/bsORhH5ZRDs/SZ2jC08bHDc4oGXCIW9dtPhApYl
	TGvuqUgxgkpGcqxi2SxwzU2aom3igIn1O4ZSVdnLe9ykLtMO7Y0bxJNaz8LrsL2S
	cwMWPnmE9ydvflDqAmCQ6FiARioLclx4RSkzaOEFqUgDgEmr70Z+I6QfkDW2Bmpb
	Sb6DFQAtEOWZPJW76IyKLN8Hr15s16Jwa53otJq3z7P6kiNLbbhdEb77QcFZQjq/
	HRQk8E6dlfnQFPfoC1b6T5CRMMcV9k3jmm9jwXjDO7nZ5ySUqg4QcugQhNfRRxHL
	0vT0hg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7862t9p7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 15:45:55 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-124627fc58dso7360039c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 07:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770651954; x=1771256754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSWE5q+1oo4kM8c3X2R4tW6aG/lc41Xt8NN6Q2uo37w=;
        b=iTX7rN/2bEjwcgd/cJ5Au9Lx/gsKjYbMGryi45Xtjsj0y05D86kj/GQlGcvNNiJwqa
         YmkOmwJRI8R4VBQsjhitrujlekpPrpDUmatznYRT9It3wfAMQbZ/ZIqQv2YDeJvuE1FH
         WRsT2ZHf7Dn5yLj+6LY6HDzHLyW/PU4vNszBieggTy84ojtXG6o25rucwK/MGT54TEe/
         GcF4nGLo1kcYsEZDFnwVdnz7Auz7W/TW0aXofPhTxXwaswKCFzFspVxNWfhznJM9Wf+8
         Ktjn1SQ21ToC5RfRi8ULO0IVrehtzFCtIT42sB0q+LCjzDv+DiGSfE0DsbZCan8Npct1
         5+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770651954; x=1771256754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSWE5q+1oo4kM8c3X2R4tW6aG/lc41Xt8NN6Q2uo37w=;
        b=Y6VmNkGJ5HgHZVGX4Yh35FSfGjmiG3gjq1FPi9WdT4pfpWON95fcd19ucXWsieutuh
         YwCivCQJgW3yS+wDK/oisvaT/Zjq0QmYeaVbcnbpb8qGBreawEMFkSGP8+lebeY2k0SC
         1FTziXpVXZ+073TLvWl51/nqXZH6yqQMo7zr9t9AWJNXPrdixM5yL4Hi6/06gyKrBvOF
         9Y5yWNr66rNKi0ogCfc+SCNNclQ0fZCpVzpB89ArE3OTVYvBRcTP4vgcSpUQ83pHxUhD
         MQjYlz+fqAP4XphU5PeG/WU2Drz8GTZdm5Y3HA4MmhXo9OnH6x7EnQQTR6CtbrLb7Tjg
         0VDw==
X-Forwarded-Encrypted: i=1; AJvYcCUytoj8aNXzgvEAvCopy1RBdKI8WJQWw4OMct9P93I1RA3jjhMilY5TzMnCgncb7qTtNL2E+r1RX3RmTF/vq/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvhbI+7DrYSh8ZGYv5N3zMYr9rMVSd3+X2JcSTGg8DV1Ui5L5x
	uOu8O5nMRZH9/5kcv4QqRkl1nzhn9Ce27Diea3XG3ADGUF+XG7HPeNqOJ/PLIiHGz9dB7S3Z6C0
	29R2Hof06Ja0odzlMx+LqyrdaLwvZIr/kuP6U9c+YXNTMs4rxCsUsyQAHyTKN+qPO9A5/OtE=
X-Gm-Gg: AZuq6aImYN2nLB1fC096acn2GedFhZ94yGhq3/7hZTipSh1Bk037sNItSkFDNj0OvO0
	wXF0UggmTQVsXuuL+BwH2KsAOhrPRUFVYmOD+Vt1YjjZJIAZTOaCa2rIJ956JPEddupXhVSQrQs
	bz/2EIF1S1UPQVlxUtRB5bc5SFUJs2OSTYLRy5cZyuGOlYycLgdssY6yeqfmlEioLK19fQT+PUs
	LDOWjBenM+GeMcm6A+HyKwo/A9U4Jsl1OMb3K0+J8luUiAqQV+jySzdZFPOZiGfeJmVUbRPLIih
	3XDxXhn11+G+fZ9AVZ1Kpd8bShjc0I7DCW7LSLB02gCnNYJ0i6pqlNtC2wqTh5oi01dJ7wpWs8h
	qE0/zfWgjlwTPbg2F5ZKG53lMm2sN9pdHfOKITgA=
X-Received: by 2002:a05:7022:4381:b0:119:e56b:98b8 with SMTP id a92af1059eb24-12704049aa5mr5324273c88.31.1770651954495;
        Mon, 09 Feb 2026 07:45:54 -0800 (PST)
X-Received: by 2002:a05:7022:4381:b0:119:e56b:98b8 with SMTP id a92af1059eb24-12704049aa5mr5324243c88.31.1770651953610;
        Mon, 09 Feb 2026 07:45:53 -0800 (PST)
Received: from [192.168.29.235] ([49.37.135.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e5e3asm10212107c88.7.2026.02.09.07.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 07:45:53 -0800 (PST)
Message-ID: <5cf30e75-40f9-43a0-848a-cca63ba8df0e@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 21:15:46 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Bluetooth: qca: add QCC2072 support
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
References: <20260209080613.217578-1-vivek.sahu@oss.qualcomm.com>
 <20260209080613.217578-3-vivek.sahu@oss.qualcomm.com>
 <CAMRc=MfT7ourMH+ShJpnBAjv_uOb_ds0rxJOYaz_HsoT45dJYA@mail.gmail.com>
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <CAMRc=MfT7ourMH+ShJpnBAjv_uOb_ds0rxJOYaz_HsoT45dJYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEzMyBTYWx0ZWRfX+Kyt35/ikRO2
 8TXqVCMECj5YNKxsEkIiIrEPAB1oDFpQPezGfBcepBBTxPZn5i2y/Br/ZWGBFhQWrE2NvfJShSf
 3mFJppGzS9FH2MaKXjdJc2cIGXxQeQ0doW5vPpa1M/GGXV4RuJbPdTCSZCiDayHoXMG+AsfMrnB
 rVjzoI0EGfsUYOwhS1Ml6EKRCoR0Xa6VrrdaNgdRU6+iWXHPbj8MLvBziQDIaBERAPR5XlOZuO1
 R9vJ0IAOCTiLlpeHnJT8apwHqaY0nSi/7cT9gl0k1Y5R1wtXFVTL1IIKQMYcW+ytUZsFUth97Sx
 oUKEVfaTbi7Btj8pUUjRI8vR5A2kfNq7KSfmQzF5elexxrpm7t2KAD9f6S3NJjjH4dkxb8BqeZg
 x5RkKp3hMEFee4R+tLootvkf/QgPBz7cdupqDJ03ABJzlarIWp1yfQtMV8qPg30a7lOChEN/Wny
 q0dwID+2nh3JV2Bjs4g==
X-Authority-Analysis: v=2.4 cv=bZhmkePB c=1 sm=1 tr=0 ts=698a0133 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=z/GpFUkVOss2g+jQkJ5YVA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=wKTrfkEMPv27Zyno9vYA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: 0xmGceO0JlEqzZlKe9lzFzm7zaWWRnzX
X-Proofpoint-GUID: 0xmGceO0JlEqzZlKe9lzFzm7zaWWRnzX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090133


On 2/9/2026 5:04 PM, Bartosz Golaszewski wrote:
> On Mon, 9 Feb 2026 09:06:13 +0100, Vivek Sahu
> <vivek.sahu@oss.qualcomm.com> said:
>> QCC2072 is a family of WiFi/BT connectivity chip.
>> It requires different firmware files and has different
>> configurations , so add it as a separate SoC type.
>>
>> Correct the sorting of other chipsets for better readability.
>>
>> The firmware for these chips has been recently added to the
>>      linux-firmware repository and will be a part of the upcoming
>>      release.
> Something is wrong with formatting here.
>
> I would personally split the sorting and support for the new model into two
> patches - without and with functional changes respectively - for easier review.
>
> Bartosz

I'll divide this patch into 2 parts, one for sorting and another one for 
adding support for

new chip-set.


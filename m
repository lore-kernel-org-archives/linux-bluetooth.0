Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA295328605
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770725482; cv=none; b=UO6390KX3YvBZLBqOshiZcjgvbqSiHub5hm7JXhTrxeG/nwsFgpWKSRoNrwzl1FVOiAy3FPLrFeo8EhoNw1i0SN30mzI7XQfbXA0C+lpCGlP5QyHguw0IFIFzc9BJ5/g7OgDoW5zV+a5KU1HddOTKN1Hnim4fmyHcRMAeNEv42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770725482; c=relaxed/simple;
	bh=142drCgTks99HM430Xd8Lb3C78zqfH13zuJmV4x4yyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQWScwMBI827GAtNq2jJ/Rqbo1scn7SVzXjJSaN8viA3zKmatW4pCOPSXBxTiBC21ksvwHBEYU7CMQVF+jm3cNAPhzNBiFKMf+HfFLinCjt9nk5RbLg1wMIouNBs/uz1Z0TfPYcI3FsK1+e8e2GuwQCSngKDW5ZD9awKVcIbw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dZ22dP46; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eL9uYyMr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dZ22dP46";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eL9uYyMr"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AAaKbI1940305
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zLIqZx4pR3vXekB7QkxU1CKhDizraSJLDhVZT3DZtRo=; b=dZ22dP46UUv2Gghl
	r1Ja7SlBT8d8kqDyQCX8tji/YlhrKjCuVJhL7GWxclGSWhXJamwBH4eWdbdevKVj
	yZ90BNb++Wecw5ZoOgzl9APp0Eq+CRmXAGiUMfvl5kdsujmNWbtHydkZAy7S78LM
	E7TDH3aOd695/se0PSM+ejkPq9x7faR5iysFon7ipoOVZ92HggS/YxCS8poDcGsR
	9KAbTEJueJkL07uPTXadH4W4ad1dxCUyU5FiYsUO3OfVuEa9Cq5ncDoJF3tVdeI0
	Wq0OFGXuBxoDTBwu3ANpBjdGA4/gYDP8CwcrmXG3A2aM9dLDdT8kJ8O/wg6bxnbf
	u1vbWg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7w1jsgd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:11:21 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-124a95b6f61so4947415c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 04:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770725480; x=1771330280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLIqZx4pR3vXekB7QkxU1CKhDizraSJLDhVZT3DZtRo=;
        b=eL9uYyMrS9N9BiQMbTxK8YMLarYOegLDCyhDALfpcWA0PDr50QQDlybMRiw98Q6CrO
         JKnBX8wUe0yuG2RA6DORIsr0gVnB1ESyaC3Dpyhv4joQ+990Ruv6g6uVkNfPY+JVwgNo
         WLggreaUEzMzavEwd8kRH0k8W8O324iqwjo0SUTKYgjl7Mn85JAcS4rStOeH8s4bdh7z
         jzg8YYWmUL8uZWRn30t6L/+DGdXeT9W8NpayUNTYRnmqPoVA1WfIMSVEHM0p+BlNoyD8
         BvkqWgCJ8ogTTlWj8P5cPzgEHgW9LcuKbqPH0P0BEdIv8WK8okdQEHYNEBOZXZFIEZvY
         lPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770725480; x=1771330280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLIqZx4pR3vXekB7QkxU1CKhDizraSJLDhVZT3DZtRo=;
        b=QjNhY5lrhBU9RlXECQQ+9oAEITH2JGJFJKzoI4KotvA6l82dh/88BNNkaw5EB48Hwg
         kq4YOXQtwX/tdD2CgnOzHXqW0ZbhGpPpalfXC4SgN4zJuU4BDLeAgQg+SdcHf/H90sXB
         lHl+ocMt19jiT3nQGDjxcffkueU9+m9k+w21wtrO95a4+RqDKnCz9Jn5NHWOqtJysAF6
         90XWjZYEGpCAsB7WBv9J8xp1tLmA/j4KDwsGXyH3IEStJUC1axzKYsAexcoRrtR7dwr2
         8TDB2bu8iHS003+QgQb0HF7IEcGc/0gkPFUI57GCjJlXjecaHKABEDogxAwJOVJ2x/bx
         wvRA==
X-Forwarded-Encrypted: i=1; AJvYcCXrgvf/M/4Lqwkh/O4BJBJ0vrqXnEWKd5uwwxmDUvbMo9MYQKBhADL7gn/yfUVGRJBMcYezFGpQwiPru5PdSA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQEhbwwbXFZ9qC5qV3qGFsynKzo1gdGHZRfqsgNNHaeOnr9Kt
	C14o3kixoafvLvk33F5kDLjU/n5mL0vcRoxuQXEk2d4+0yYeBf1r0jGOcn9EOyoeYlg57Zqr5OI
	5pJUtONOmEuPfU1XKfvZXo3+N438c8fcF6nKTNXtNDRdE4wBRsQdgjt7Mkr8uAGZpjEx3bOCKjg
	J/QHE=
X-Gm-Gg: AZuq6aJIENnkUPahdPPjWTtT1tu+rVe2+BQnMYipL2OOXipPdNO9g1mOCmOAcEAnyh1
	uHpB0g/14dyhM1YaFTuX/KjCjSrDmGxEvuRD4X6iP+Fw9gDcW8RYJekhF+Gw27wAYKEUr/hSuR1
	htEot8PUlfAzy0pBZhLRx/vrbe1ASO1Mnl835Z4AIQ9DFCRwo87sU8wihAjHRswjcMA4uGH4Inx
	VG3vtKrcH+4DByT3XmeiwG145pPkYB3+GHScZv9zLaH1Orl+zEHEhfg4IHRZKYK77HOSZpi8ygs
	7OwowpEwedOLsaUCDlrD0W/QkUTAtu/ZKyRX5m5/MxaWAuGNFr0+uMCn7nCdRi2vI7JOV9kFvoX
	fOfXcOGVGUzd6sG6rBQxznbuHcxmrG8THBXQGRAyNMW+f72Gs
X-Received: by 2002:a05:7022:910:b0:123:3461:99be with SMTP id a92af1059eb24-127040153ffmr8274115c88.21.1770725480323;
        Tue, 10 Feb 2026 04:11:20 -0800 (PST)
X-Received: by 2002:a05:7022:910:b0:123:3461:99be with SMTP id a92af1059eb24-127040153ffmr8274090c88.21.1770725479713;
        Tue, 10 Feb 2026 04:11:19 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm12883089c88.8.2026.02.10.04.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 04:11:19 -0800 (PST)
Message-ID: <cbc0b42d-fb5f-45b8-9074-d0bcc64a9de1@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 17:41:13 +0530
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
X-Proofpoint-GUID: 3btQ-SUTao3DrOCcsdIN5qE_5mNTneDb
X-Proofpoint-ORIG-GUID: 3btQ-SUTao3DrOCcsdIN5qE_5mNTneDb
X-Authority-Analysis: v=2.4 cv=YrIChoYX c=1 sm=1 tr=0 ts=698b2069 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=HN2rxSbq-rsLsfjk2icA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwMiBTYWx0ZWRfX6KezZdjeCUIG
 89uei/1+mpIEE5axepynkvtehsgThvjBBS5Og/5iI/C6WA2r8sEj0PE/TK8tEkff+LZijg4UVaZ
 T239Xd+VzfE76+BDPR9hkwEhDY5lT/0LNxU5Z/n5BcNnUZZdMYa4ATBdKn2rejR5ywzmL4djzf+
 Gsq/1tjAzDybAvUBl0rmTq0D1rzsrOBXxJCaKat7xdH6B+3Gj2u5L59gLSVz5VWR3GUEB+44pmq
 Miy/qNx8c19/xa+ukGtDaZuCEkuNFha645LC4i61IWuqYlrd1DLjbCNTGNiqDu1NTCJ8EICSp4M
 Y8Py7f1Eb0G6pS7wZPQMHWVJ1E4X7+3osfTyVu8rGvuIZiXtBDjDS5Ul6CEgp7Ok2Y9GI9HLIJe
 XFQi8gWd3/0cjDptNrl79R9NdtBWHriMgUNJfWt7M0tv/CrNRJh86KakMN9qW4laT1DnTTwwzbs
 6UvwJkByMqjw5mYlnoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100102


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

Yes, I'm now splitting this patch into 2 parts, one for sorting another 
one for new model

support. Please ignore this patch.

Sorting change has been raised with tittle "[PATCH v1] Bluetooth: qca: 
Refactor code on

the basis of chipset names". Please approve it at quickest so that we 
can raise new model

addition code changes on top of that.


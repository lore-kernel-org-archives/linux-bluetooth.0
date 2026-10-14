Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702852BE5F
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986748; cv=none; b=aI/NgRzUVDaYLOwdpb9VDqM2V0xh1SQDKU/qXgwo5sZsWon8FmQaHl1ZItd7SKjqzeDJVizO5DtlzkxFdbnorHR7Rr69CSPkOJhLna02ztGTmyAFUcmF3F+Apw8+RjGKP2uNxrCBLQasaynrcY5EH0ijfNZwiLGZfep8LoMDoD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986748; c=relaxed/simple;
	bh=ISgqwQwd1WJVQMG+3HZ82LwF02NXekQ8kwdnDHTu7qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLH4Noc7oD4RPOn7Ku1LXuaZ+x30HHJol2MknZWE848gO9jmHUpPd0sRGAZCcgccNjBHkPOaVICdEZ7i7hzjkhWFbofWeP0GT4Ib6vwoREtaQg6We2ufElGVIO/+ob/F6F911WHoqVEo/LgifmBQ42U4zzQHyDXx+yN/eodrqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nCe1EvZP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TKdMGIGq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nCe1EvZP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TKdMGIGq"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EDHxF9329092
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 14:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pVpqOXgKn0VsPxuA6dqYU8O/g3ed5Mas2OnmRjlWtHM=; b=nCe1EvZP/0aHf93I
	BdHU2vT98aD5USlH/P+wqwb22JSku1+uqNnuW6l3q9f2qtOUMjuDDyhS/AKwQ9f/
	YZsVsxjWmMn76m0UhAtPtVVw2OnpgqJrj86RhZrv3D1SsYGwuvAbIDXGTTIjU9aS
	6hIIK36//VRJj3FSeXCdrzcZgAjxwDYT4pQrKcalEL9FlbJYj3+WuAots4Hqm7PI
	m2KpLgQ81UN21xtv0MJ6aRUs4pP5ExZS5S/81C9CgovP1HKAtUzm4iqtzku+GXDc
	GyGD9QLmffNJ4wX82sO2ms12M2t34WgmqIhOLjMtPm5QGX2Rnjt3ImmytdLfFg4F
	ZV+MAw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf069j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 14:05:45 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5e97167fb2eso15709e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791986745; x=1792591545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVpqOXgKn0VsPxuA6dqYU8O/g3ed5Mas2OnmRjlWtHM=;
        b=TKdMGIGqBaUsFvOYj2Z5eagxgq/Eye+f86Qpei7NhtMBEHi5tcBvuwDRv0PTqYLmiQ
         yw2RPCNhFTUvsZkssqUG1GJBK5yxJLjbQpvd049JXpgnm751WCpmTr7ym8xvftzeOFee
         2Dn5DL7TaaYKmxLTgum6aW6SJqovRt7pNY0SNp5T99sPXKVy5Od6UddG6xJFCswfMCvZ
         Y8b6v4z5I2igzitdsSCVKKOZmJUcqpHPOsFd7TUHP1fnRitrx2MxDxE8qdTSO6uohmY/
         2xzL2vTe3hdYSxRxA8ewCl/qj9JvO8V9TgU9J279/n/Ulbx3p/ttZHAsW08z369LXZ3H
         YCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986745; x=1792591545;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVpqOXgKn0VsPxuA6dqYU8O/g3ed5Mas2OnmRjlWtHM=;
        b=a7eh8OS6bfTUFIEvcs4aniKJnlBnBOtxyTfbbqFi9hiscea7cjJnD4TwvzrsmHTSY1
         o83zU1nyFQyxrMFRNql0/OX2NWLCKOxT9kGcCCWfel7UJdlvgoZIJtLAiElbwgPm5UnG
         4EuUYM1HIh5GLevGN51kminsC13cNWAO7TbeNTgNI0FsDDH+7U8akzCV8D7Kj67eY34s
         puCYTjFRH05b63LlrfkQBuwCnTmRCCBy1jNhOzYhEndM6WZQXidBA37tz8M2h0wZaqM9
         OenGF+29lXkRDAZYm5pP8URllmoZGTea9etbA9sWYPd+k3Q/mwpZjEZsl43OTO9bBU8d
         Z7Zw==
X-Forwarded-Encrypted: i=1; AKwUvByJRzUlPeGl0ilU9KPtVhtykqtZO+Mwce7f0dQfg7d9C0ZWjvwW/3ONBjPs5+/AcyQ9hMhyBqPpDMEOMzXsQ40=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7jAfeHZ0lvSbbHPHT3fW4r2ugNPG2zzHok3K0AyqPIPzb9qqr
	UMtYNomPsSahS1VSTMZxV1bWtyWBN9KFsqY8xd6nu8s9EHmb2J1XV6Qmqs7/i2QKJBZ+RF7uDw2
	7Q8DGUQSGPEf+jt9lD7pojpDc/AaN2Yos8TfvPl2lL0L7eSMyo84ZKSjRczAP39itBvGDyl0=
X-Gm-Gg: AYBFou1F1o1wIcl47uCCuKucTbXrmwcKefswEPVAeVP3nj2yJ/MN23Yw2JsPg6qBaTA
	d1UkmvNoS1H3m+2cxEOiGrpnEAbxHwvsDypFEVQF6f9TtQ53FxBhp0cHeM6PPro2dbdTmQ8S1ER
	cGQkr4JKOKA4m7r24kgREKa8IhdpC/stzOxwZMJuvBrpaBhyl4AUkBDO4omE+nLPv6ho2xb3vab
	sk19VQVyxdPl7yhZnmf70hPatQV37Ur068NIOkupGLFvOiC6OAptpJ9mTYKRSs/0mmXclOE0r+a
	N1g4eOQ8CMiImiUT8NMGokhC/xqG+lSlK5dy6MnJsSCodjRS4zvVJispZBgoT31mnCf4maWtIDX
	9ni7t51IdYKrYLE27I/yUvg==
X-Received: by 2002:a05:6122:4659:20b0:5c9:f6b0:e5e0 with SMTP id 71dfb90a1353d-5e91f45e3edmr3449585e0c.3.1791986744630;
        Wed, 14 Oct 2026 07:05:44 -0700 (PDT)
X-Received: by 2002:a05:6122:4659:20b0:5c9:f6b0:e5e0 with SMTP id 71dfb90a1353d-5e91f45e3edmr3449553e0c.3.1791986744082;
        Wed, 14 Oct 2026 07:05:44 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203862c4esm1222206a12.16.2026.10.14.07.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 07:05:43 -0700 (PDT)
Message-ID: <d2ab26d1-2feb-4759-bdfa-7db9b923e7a6@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 16:05:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] nvmem: Add a UEFI variable backed NVMEM provider
To: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20261014-b4-nvmem-efivar-v1-0-187c85f65018@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261014-b4-nvmem-efivar-v1-0-187c85f65018@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX1DN+0DIbBeb1
 Mg5Dj1pBbgX/CNKAX7s09WUSZ+KP13mP9uHKsbhL+nAALOWPK92rnXqS7zjV0gnpiK1yf5LwBQn
 edAySpu1GI/+GrtJkmFGAIIYho93NKU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX9xHNPyG8Ut6C
 g0flojt2ZCgW4m1krRZc41GAH/9J5N8DvD8oQBOSf77Hm+2kWhl2zIx+6xiBmERiM+bVHWLyUda
 fU5QSbv7/vG+BkzfWIc2Z6Y1QdQWze3OhDmxFCowlh8vN5hUNK9wo4hNq1w9M2XWzMhFkLvVOvi
 WF5pKeDaByHJjA8Zb8D7BzHPoqZM1AzaZ/wLKka+M1IjbshFHSl5F3R6KSWdtkbE2EEtC8prfuB
 jK1XqifFfqqmqcP25D9NpXc21W8Vtxs7012EbJgxsbmEbZ7S1sXm5GUiEZqH/UQ9CjiLzHIoUBy
 IIOUgU8mEY0Cfd85bMnn0/OkkxD54Sce/7Uz1KnGf0bXLgWz7YVUFvGvs6vKNKVFo87Haeb29O0
 9A4sRi82nRMT1qO6RXuVbmqUPuDO0A==
X-Proofpoint-ORIG-GUID: c6IXtAW0oBIC8esjroWMI9JY6K-tjMRA
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acf8c39 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PngBsCrCUa3bum75zpkA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: c6IXtAW0oBIC8esjroWMI9JY6K-tjMRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140056

On 10/14/26 3:02 PM, Abel Vesa wrote:
> This is an RFC: I do not expect it to be merged as-is, it is sent to get
> feedback on the approach.
> 
> Some values a platform needs (for example the WLAN and Bluetooth MAC
> addresses on the Qualcomm laptops) are not always available to the kernel
> in a convenient form. They may live in firmware-owned SPI-NOR storage
> (e.g. a DPP partition) for which there is no straightforward, universally
> working way to read them from the non-secure world.
> 
> As an alternative, this series allows such values to be provisioned once
> into a UEFI variable and consumed in the kernel. It adds a generic NVMEM
> provider that exposes the contents of a UEFI variable as an NVMEM device,
> so the data can be consumed through the standard nvmem-cells bindings.
> MAC addresses are just the motivating use case; the provider itself is
> generic.
> 
> The first two patches are the actual proposal:
> 
>   - dt-bindings: nvmem: Add UEFI variable NVMEM provider
>   - nvmem: Add UEFI variable NVMEM provider
> 
> The remaining three patches are included only to illustrate how a
> consumer would use the provider; they are not meant for merging as part
> of this series:
> 
>   - Bluetooth: hci_qca: consume a "bd-address" nvmem cell
>   - wifi: ath12k: consume a "mac-address" cell
>   - arm64: dts: qcom: glymur-crd: wire both to a "MacAddresses" variable

I think we can take advantage of Loic's work here

https://lore.kernel.org/linux-arm-msm/20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com/

Konrad

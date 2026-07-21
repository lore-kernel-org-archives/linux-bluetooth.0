Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776D38E8AB
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662817; cv=none; b=uc28B/8tR7hlzMkcKJMLku/tiHGwG1GPZ1/HPDo8CDfwYTxPQS8YvQ/GqgPB+MTs8IvZuhRxyI3O/ZJNh3GxSMm19wwyEcW/bSdr1nosh/9xOArHpbT+ZuPcUfaZ41uSrbNQdlCTyFx6aV7vJOBH134KWh/asC1JUL45AKbdkqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662817; c=relaxed/simple;
	bh=3wxFQI8W5u5vXXArhESeY/9hpYpeEMqOBWpDmaXQPkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOKiJMF+GWbTHCFdxMoiDXJMRe4EMRx2oS1LOqMXqFnGQeoMMy5fniv1PPRskuYHWzxeq9EPjsV1lOB2IK9xmWiSwVjWwrN2OT0nOLRUvhGPSnWygwNf5WyaQTSuB5is4gBikyLn28rpukFQxw8ciCh0/JZY5yeL8f30MbCAlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cjV0iGkn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TNHuf4YX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cjV0iGkn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TNHuf4YX"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LHRAGo2376074
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 19:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3wxFQI8W5u5vXXArhESeY/9hpYpeEMqOBWpDmaXQPkA=; b=cjV0iGknfJmebu72
	HQy9VLvgb0ix1WLLgcywWCvybXdgfrod3FGMgo1Pu+GZin6grq1bnxe82Vi5Aty5
	wOuPiD4fRDAw9j8O2A+XYdXG+TbdevsRMYUPZVGWm363QfqCZvAvZIHoT9tDoz/q
	APEMoVDLpnz6Itn75R+MZPyHkyH/aZ13pE5FPrHYAfH+b0RKqcoeT21QPJcevyh3
	R+4MAfv6v1vQoNaFF45UK6St39W+N4l9ZcLAXLd/srAhEB5fS5XL2/DW7MKaId+7
	cCOSt1lgdhuBFcBA6VRLNCOsdcjD9XhADUw89ol9f/Y+UvRUuAWSPGc20OuIGkoR
	b0c4og==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6a8jw4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 19:40:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc620652bfso29427165ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784662814; x=1785267614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3wxFQI8W5u5vXXArhESeY/9hpYpeEMqOBWpDmaXQPkA=;
        b=TNHuf4YXM498BdgTj12b6VSxpfnxHXAvV5JdVowrcfmlAryQYOg1fe4C9iQiIHH9CT
         1j1ceq8h6rGljTZAF2rKI30SEW1u0AJ/SaNnRitOvylv40FIebRDsbyo1MmeiSxy6eX/
         TtJ/ZQiwboK986r8N9R9jr+X/u8lCPtq3POMJL5nKscoohq15eG60bBGy7ZPJZNty/2i
         TV6Uie8K5TefxofC+0pxN02J1hJgwiOQbtaCpDn/JiziFWKcAKfSCAJqYmG58PIr49FU
         hqCPLnUJ3ltPsSJUDsyrHQ2EYF+y2cXOzjkJCbX8TSHe9QFQ9SHdYbeVz36k9omgnX5a
         2sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662814; x=1785267614;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3wxFQI8W5u5vXXArhESeY/9hpYpeEMqOBWpDmaXQPkA=;
        b=rsS2iy5pffgvG1lK426bYcfcAqYlJ+zSc7y7xVMZZ1GGqBRBuuTotfefXd6BzFt4/J
         YcQO2dfRlY/+TxMYBCuaj5hIRgu5XPuFCzkoOWUG3O86HKr9zuzCITv4hnzA2FRzmls+
         AOdX7kgeRlo3BGu7/ykVGbdPNuh/HXFYemv2n5yWQREXWkKWlVsRXh5WVo/9OTdbH3KX
         QenSTvI3Stg+uHqe7WDWTxtATAP5d3CRvXCL7FLKGep1595MMwwXNjw01QFrds12YY27
         yhKP6iRhdRLZTkbVu1wgy1gm0RX9GRnJ2HvrSNXO/5Ut1XD9YNWiAnlB6255WE+V9o3T
         7KvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrVsXMSAboYKz5ejk63u1IbOXJm2gWLW+PBQ9vdoUnT5OF/vjuQy3E9mfdjuOw7qVUMeKGbVMtZChlyU974250=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNvKF+VVWwOet+aj2XbQjy88DoSg3KVq0Q4em9VdEilMWTQDBD
	Yx7bnYcXXtYWbq7EbkhwC61Hbi9wzqaUEGEtPgvvXD6nO3H6Xv4hAbRYFTTrDaCDW0muYSKX+uQ
	bdFBhBMPV6twIN39LywWJg0dvoCiyDHqtDoTZ8Ew43EFUiOdgXFeEF2W5tx/i4VsGOeqs454=
X-Gm-Gg: AR+sD12EO0X/yxZ7PYk6+QgC0jmfHJsv4yRm1ifWNNTbTxItrc5hc3d0+CrWBN3aHur
	KI1HpTF+VaMVCqu4EPjUqegE/4bWDS0qfq1fZLkNmY1hcjzin5O13LEEtqgNe1HicUthOsG5kyN
	98utkzCEy24zX1RXx3221KtcVXd1sq2dxxNrCuKvCg1bg/7/SUsV6LS7kOA507Uob6WOq97vT35
	mFX2o/ZRIB9iQ9tnMyXoH1AY+WkvCXIN4QaWi5Ip1uR4BoGQpcb3bF0o8aMEufQKxSaBRahemUB
	nSa+SSjBjmNqaMbQnpz3G6UhDUwKe1XpOtUV1YWM0DWYXSIxlw2ayvmxUIC993bHbUohw/O2Ef4
	Kpgi3YVTBClB/YE7zbIxEQb0Ja0LnrzWHUODr7w3zuN57M3fXpQGK/7Zjy2vqTXopQt0=
X-Received: by 2002:a05:6a20:2588:b0:3bf:b625:5bbb with SMTP id adf61e73a8af0-3c40fa49621mr3835094637.6.1784662813680;
        Tue, 21 Jul 2026 12:40:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:2588:b0:3bf:b625:5bbb with SMTP id adf61e73a8af0-3c40fa49621mr3835063637.6.1784662813120;
        Tue, 21 Jul 2026 12:40:13 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1c4c3asm53298a12.31.2026.07.21.12.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 12:40:12 -0700 (PDT)
Message-ID: <b37e1706-6a36-4e07-a4ca-8a7dc2bbebe9@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 03:40:09 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Bluetooth: Add generic support for vendor HCI frames
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com>
 <CABBYNZL_H2iRAshF-RCX41jbt0jots5i5W=aUUJC_wEN6wzp=w@mail.gmail.com>
 <0c5a924f-7382-407b-a0f4-dfd7dfe0d5e6@oss.qualcomm.com>
 <CABBYNZJbyfqLGNdXedi4+ZDNW0VNsiChaOTEb02Rz4rYd6UyNg@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZJbyfqLGNdXedi4+ZDNW0VNsiChaOTEb02Rz4rYd6UyNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNCBTYWx0ZWRfXyyeLLQst8gc5
 7bBCKa2mngPZe5fuqvC04ETLtr+MbLXJWsMkKjtQ1ISY8NE6VpSBblyAA0Nw6Tt2k3OocFMNs0J
 rvVfrSO4zNg6M/7AVjGgDt2CfOSHSrlwt+h3UfZ2dx0amZYnMip5uyyMSib3NkTUEjwOdLQJEzd
 +60USZ9TgbNNnJt6AVLBIZZG9lC8FW5DoPhcXZ1UQtuTdHDENZZwlnhVthvyVsyD0HDn0QoAOWW
 WgJYV0rhnZtXKJICOo4XOcfzdj2t8JPJAgi4+MTYW3GlrIZO5Njsc6RKU9g/uZKObMtJZogaQ3D
 IghPQe0EvSZ1l7phvM7ahwekORefFwLaG4L7YFq5UV/HHDFIrqt6WTPG6k2EdQLv5TCcIIza7pz
 OOE006u24HqdEdsWdtcYwGAEkAgeJqTzo99XSWJWUzIQpjAPN2lNpN//oG6UqRmxiaUoe6nu+pJ
 b7s4nSZW0EcIbCaf38w==
X-Proofpoint-GUID: Q9O0COIMqpoLMsW3gV6C6_OXNB_XV1nF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNCBTYWx0ZWRfX9O5LlQ6R1BzX
 TPTSBMruFJWXkv57zZ2tOKvxvXO2Hy9EC1HLpXYhRXWmlgx58+pktRLNT92AAcZA55ov3pKuuIl
 um0nwWPPrFgM5t7HOH7oTj5cXriCBQE=
X-Authority-Analysis: v=2.4 cv=HvJG3UTS c=1 sm=1 tr=0 ts=6a5fcb1e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=ZCvCaZH92ShBOWEjDq8A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Q9O0COIMqpoLMsW3gV6C6_OXNB_XV1nF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210204

On 7/21/2026 10:22 PM, Luiz Augusto von Dentz wrote:
>> Could you please give me a clear direction
>> Solution A or is_vendor()?
> There might be a simpler approach, just consider anything other then
> the known packets a vendor packet, so it is automatically stamped with
> HCI_VENDOR_PKT then push it back to driver from processing.

For this simpler approach:
in TX, userspace send data to kernel by 0x31[inidicator] ....

in RX, how does kernel send data to userspace
by 0xff, 0x34(indicator)....
OR 0x34(indicator) without 0xff ?


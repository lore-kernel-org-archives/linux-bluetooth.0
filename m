Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9151D362128
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417853; cv=none; b=RLj4XpPsVjWqSeGOcY2tNx9pyR8AfS93Pqj7hes/2U0HpB7kd3E8k2/WnfQUEe93Jcmo/RveFMqmvKPmJDL8cwNVpUB30y9mjlPNvmlU+U6G8qOE3do5Os1R6G+9NvoahUMVpcNyKx7Fhaqf76LN+2x7Nphfp6ozKe9ITrFKj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417853; c=relaxed/simple;
	bh=rK8S3XcdOkJtTPmU3AL4lHebx836znNSJPDRkIryyNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKeGLPNrqcamWgaUECldsfldh8Xf8eQcCTWeyLm0xPtO7yReUanYquTuPxdv1g8tTIzFLtftYYGxzmlj38Hu1PsQzb8oKnbcRTVuN5cVEB9R6dAJ18RGkaIGqtC7tnpvODnGj3XG+dOryz2Ox1USzmRabp1XqJ9lLrAbT/n3a/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d8Rj6Deq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h54S3c1N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d8Rj6Deq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h54S3c1N"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D9B5ZN3906306
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 16:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qoIt/c0c3o7wTtS+reA6lWhErdA4xTAVSkX0IZxKwL8=; b=d8Rj6Deqx87RQvwk
	Hb7YnElw+GX2/F6B8gyXuwmugHHhtBXDclq/DOQy2K2yllf3pybfkIV4BzWlpNum
	y8G+IxE+QG0j75U+7eUX6h8cOp1jy1f995i3W6+GBclKZ51XqGniPkmS9LFL4AFm
	Lz3aESXM7GcmeLai5LVhbdU8VcVBoRrRr4E26QadDZtZJpKVAd9wbhLHrOlUsp+E
	Hmz/9T+SxmugnXCJak0c0vDo1a+4oM1tq5fBVGc3ttiwmKgz1G/70IBqjMJNCBp/
	FpxWLmOF9AvKfLDUYGG4EmK0l1B+fTja+CE2XVR0UaC/OuiExP3oTfeenkekjsGJ
	G7QxIg==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvfqs9cf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 16:04:11 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67baf164912so21795198eaf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773417851; x=1774022651; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qoIt/c0c3o7wTtS+reA6lWhErdA4xTAVSkX0IZxKwL8=;
        b=h54S3c1NG05mLoBcf7N5P3CKbU77Gmk0tgCRyH7H+vmkjdcU+3Ue0xt3OdO7risKEL
         hHZGIC2MCyNb9OKyJZiT2oxhkN1z3PtOBS2+cWJguHbGWfTgZREKSsCUXLUZURMNem//
         /x3GDqv5TbFLsqseCT1uXP8sYcqN/VcIOPZltCLyUU6Og0L09HeRbtgssIsaRa0yTEEl
         tDaZYK9lbvZRyN393RmQ35/AdhDragkQU4SF6aDmkngIFFf5UvSO5tuMI080MUodpxD3
         3ygLM5ueWgjHtWGaPrgPlD9XnqMLnuD7Wa5vue1iMZerMiGacfW4/TRshLyek9qfPdqE
         NN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773417851; x=1774022651;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoIt/c0c3o7wTtS+reA6lWhErdA4xTAVSkX0IZxKwL8=;
        b=JLe2zl9NiAFL/beaoqRX8WYKlT9pppGTB8wEw9XfTO/QgsNK6w6A8qSrSHJFV87ko8
         kTtE/9jw33FGmOQgJmI8IJr8iu821qgVpdVy7mB7WDIRuNFBlj4TeyFbfehdG2dl1pRr
         OR42KSePbR2K8ZEnp1C/5QeOVzFed2qRgpxpTmNDFw8fdsq04x5cOX1M4R4htGUgvO+9
         5N+uFvidH9AtUXsQNV5UCjco/8vIncvl6uIMHBagUvCRay7U84pGuWxP0F5kcEeLiXqR
         JDonOeWigYDu/lb348PLbOn8r5BUa74r/u2NeceaSeu79eIBtb3LWr2X6uNX7du9ZO4L
         f1qA==
X-Forwarded-Encrypted: i=1; AJvYcCXA3U7y6b0pfNxGibcY6MW6/3BpVLr5cvo7DsKSyV0bKiOWDCzNZfF2F9L/5iniXoH8sVxEYBLxq3+6SwPkV54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkywvx4bRFzimoL3UME/kBCOCVLiSBqcth/xjP3n5d0SpNo0gu
	9Z+aT2n9iG0rfRS5CJjFSn9TFDSTEN32Q4UxTefxBd7iqBIs/czAWs4NewLZbIpapgCtP8n39UW
	AqJm0QCdWPIomRBeG9Se7ErVpHRGimiuDwP0Za+kfXdR8lNury5cf+hXcOJGOW6QRsIF3PSM=
X-Gm-Gg: ATEYQzznSOKq0niZNuZGtQUZ9DReY/zfxgRzXf61Gx0DDOCFE3OTUwfYkTQu3RFl0X0
	OsvnHuooI+4nOtcRUW005v8rIpwZUkXApnHC52DvXAGKzyoiLd3rSkEHZQwBkyk4+27QVmwmSAL
	c0wrrnPTFai7DAi2Eax1Vftj/H8M97WNlMMsa7UFL4fA19dxDepCXGnLNXIdlUAP5EZJ64Ezc3k
	6ZgxlY9EmUMBZMPuP6Sf643lPOkNUOiotERvT1XYXtlBaFVjKgOpTxjopcz6dQv6xTaqxoYKQvS
	0BGMANtk7Pd7qveDX5p59syx+DprKuWKq74QSgo9pjdEwyhE2cDTNOR8JJmL0DF9aQ0XbfQTDC+
	HoWR3BaZgMeNo5x2yqBLmz8T1mU0ACBSIMg/HMCeXhizlIxHfTlldm4XCIJO9kR7bMZCtEYmbEs
	nD0HhRer5q2T4tBOnHsAWFVXGQokUQufkrXkA=
X-Received: by 2002:a05:6820:448b:b0:67b:d301:862f with SMTP id 006d021491bc7-67bdaa5ceaemr1871688eaf.50.1773417850673;
        Fri, 13 Mar 2026 09:04:10 -0700 (PDT)
X-Received: by 2002:a05:6820:448b:b0:67b:d301:862f with SMTP id 006d021491bc7-67bdaa5ceaemr1871667eaf.50.1773417850160;
        Fri, 13 Mar 2026 09:04:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a96565ecbsm1475181fa.41.2026.03.13.09.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:04:08 -0700 (PDT)
Date: Fri, 13 Mar 2026 18:04:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v1] arm64: dts: qcom: hamoa-iot-evk: support Bluetooth
 over both USB and UART
Message-ID: <liap5tu5lpmwprmvzcjutp5kyulq7lyddrhfyorokzomdwfzdu@zscyzbg5enzj>
References: <20260311090921.1892191-1-shuai.zhang@oss.qualcomm.com>
 <cffdb8ab-a293-4535-860c-378a4b8a3d33@oss.qualcomm.com>
 <97a3f3f2-e9e2-44ac-a682-0e0f0c100a45@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97a3f3f2-e9e2-44ac-a682-0e0f0c100a45@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: KUrK79D3Uogwtk09OqUtoDS4U1yHdZsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEyOCBTYWx0ZWRfX7XymcmeBuKIx
 WvN85JPO7vadU+fULv7h1QG/HBO/JSodNQqphGqTsPI+FE1zChpSNjl9tVoLToKPfgjikcHXi1z
 EtLtcd+L90tYVg9pp93H38ZKEkpf2rWeWtMVHFPllE0VuTs+14x0/knQe5+LvtURsZq5jLnCGaU
 kaKptuicHy0Y15FgCXjskq615hkim7sWzsyCr2Bc2GJqyMSWHIhlvNtxSU0AshAczPT0Y4EBEMM
 pKWE3m43HaEsIeXKkPfmu8RaRGZNBRtwLwTQjpf20O6utJxRRjtcHtiQ9ikJsoXW28AGpskjEhF
 SYutIYPORZIFG5HG08lLeb4pIbubqLm92PTSytoyL9db6GGhXwKHlo0p6lQwQpSYug+Sh22ByOI
 txVJSG3fYfe4wfkd/i34I7EWqzC4g8rgyjhwYQpOYvHpuVLIaZXvxGjGqAaEEKVXpRQFq0Y8QdX
 BQA23Lsb4Vwt8i1H0EA==
X-Proofpoint-GUID: KUrK79D3Uogwtk09OqUtoDS4U1yHdZsK
X-Authority-Analysis: v=2.4 cv=GoNPO01C c=1 sm=1 tr=0 ts=69b4357b cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1xRLyjFezCpYc6mQBXgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130128

On Fri, Mar 13, 2026 at 02:37:39PM +0800, Shuai Zhang wrote:
> Hi Konrad
> 
> On 3/11/2026 9:07 PM, Konrad Dybcio wrote:
> > On 3/11/26 10:09 AM, Shuai Zhang wrote:
> > > When Bluetooth supports both USB and UART, the BT UART driver is
> > > always loaded, while USB is hot-pluggable. As a result, when Bluetooth
> > > is used over USB, the UART driver still be probed and drive BT_EN low,
> > > which causes the Bluetooth device on USB to be disconnected.
> > Is bluetooth connected over UART *and* USB simultaneously?
> BT uses either UART or USB, never both at the same time.
> 
> On platforms supporting both, the UART driver is always probed, while USB is
> hot‑pluggable.
> 
> As a result, when BT runs over USB, the UART driver still probes and pulls
> BT_EN low,
> 
> unintentionally powering off the USB BT device.

Could you please confirm if [1] would solve the problem?


[1] https://lore.kernel.org/r/20260224-pci-m2-e-v5-9-dd9b9501d33c@oss.qualcomm.com

> 
> > 
> > > Configure BT_EN as a GPIO hog so that it is controlled by the platform
> > What's "the platform"?
> 
> hamoa-evk
> 
> 

-- 
With best wishes
Dmitry

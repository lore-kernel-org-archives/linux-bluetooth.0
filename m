Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088D369975
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775244793; cv=none; b=GCfiEfV6sOCnPrjAfOdbVVn4O1lPOUjRX8RMZOE9h1WxN8Le/JS+Znr35Y+piIXVURRNH4yBAMFpCQwMGBdQGg/sE/l5S/qAwt5aKBkJV40Y6VMYiuFqtq8nCqVQ9JSwFJd8OUswYYqeg4pjY+aBo1XIiPBWtwyChR28dOfs5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775244793; c=relaxed/simple;
	bh=Nm8bVhXwnXi2Nj/UAQqeoQnFymro7OZDrrWhb6FQxok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPV3IuEddsxdHmF/SBrg93h/gVZcL7MAU4DyAo9bibhZSnRJZ8J0xWX798SlljZd9reRQojY4KxbfYlh3PJ7iiMQHYzUif2gDI5btymbr4JUOjsfIN7ACeTJQ0AL/4p3LrIVsdKZOzJHbWs0JrQRgHYoIAYqAzpCYsx37Xi4p8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SFXHOl18; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=is3Y8BAc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SFXHOl18";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="is3Y8BAc"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633CAcjJ823343
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Apr 2026 19:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hYnQcnhGrNgV/eoN2v/2MbLY
	nIbeQOs3Yrb0qovNiyA=; b=SFXHOl18ZrNpJYsxzN0alNvOumMDCNM30qEr/82I
	PJbpGr61yKTxM0Ht+vfdgHQSS2ODMl4CQky3KuOEgsguhcW4Km2MHi+7ZfeGHCxa
	dKpua3ge4HBlz85i+tZGv5RfTHQCsPTxgSSKm44+pn6FdFyCpQFnzY6W9Yoh09Y/
	hmTWqqhtVosQ5po5LI6q3xPp6p0KpdqSpv/yDNICpnVXYIcp06rC3wC+WWfLdJ15
	pGeyH3O6nbSRHIkySc+L6Negk+qMi3rhyOfxdHK0fuQYpOyKWnWH5X+WiI+zicaS
	JZretIRWjpOFR4hzxFjHhRC9fxX3nR5kh0M/bU5r6MpYeQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4da673ahak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 19:33:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5093b92f327so62222461cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775244791; x=1775849591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYnQcnhGrNgV/eoN2v/2MbLYnIbeQOs3Yrb0qovNiyA=;
        b=is3Y8BAcfRynBV4Nu4AKdq/aw8T1bXMd9sJ2d/7KuXUdiXhT78V+B49bw0ilH7E2fq
         3f7xmgwuYZddm36Sg7VTN7zRhz180X/N1PVpo6ahVBFrrlNn7P9pYU+laiZDJhd/0UkF
         /QhL0vL8exMrwh49aPEaxAZXybsL4Xmc4iko475AYdkJiV7GuulMNlqf3ikCRvOvosej
         lBCVSxaWCqEXgeAeOw3fyTR+lPhwNwJq24tcg40d29qN5v/du19hA/xfLCbQkQ0yu8sx
         KPQzGDtrb/z6VLn5BQGJ+rvVRyUFZHDDdjJJU/6FMBpHIQiS5w1sfifQL+dkK26OyaSd
         rY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775244791; x=1775849591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYnQcnhGrNgV/eoN2v/2MbLYnIbeQOs3Yrb0qovNiyA=;
        b=eoJ2WtfCMmuRFV1bD3uaxF+UCxbwU46nbvUfgRtw82STXFIJjvhSYAoc/HnqUAvn2Z
         2Jq6PWpT0mVeNaAvztOGxEsW95bS6baBpX39a/12yIkuvgoEBJa2GCDwkkuBwpnXEPaV
         uoYjSGBFy0d9TM+zS4PIe0PLWdKXUAyp/Ob/rphg6Iup3KgruXk9itywZJxi7575U6Au
         UEutczNn7aXK83raaNa2aV6wNuFVe5ALHcMRzwWI3f/LmMxd1AkVsHXXlVm+jiqQFFGA
         yvZZps9fsOYt1YL/p7hHl5MxVGxGy3ACzX2y88mut4Um9nFPvMJUdiKDdMmvc4x4dSwX
         7v9w==
X-Forwarded-Encrypted: i=1; AJvYcCVQMCfxR8iJYfnxUTWUGxItxT5bByDgk2qc+yHPf1pLT+SMYn0GV0lKMM/q/pCtZ9T06KtlzoU9L9pgLLbadzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSsYgBHfNMrhpoNqoGRuZzlX9OhCR//eaYOJ+Vq2QquZDJI6OG
	D9v4MSjQJ7LS1j5n0khfqRqG3AZdDTskgq7J5/ffiCA+R+Cm1j6jp+Dv2Y1J4XSFHSIsEEbj24O
	0QpGVr1sGpWeQvO1HQzfgOazKtZ8bHbvwQMo1QYpcIOJwkq6WGspyLXiWZv4R9+gMEhraGeQ=
X-Gm-Gg: ATEYQzw/dgYDUNGIrm2WrOII8OKzGyHFzcVCS3MD/XA7riXw+gNRa/LZ/qxhNCC45t3
	lh08eT1sQD0PQKhYFEc8cIILZJ6Jg+F79H3NPGOCEZnstofVmZkhwkAiXexsducvxaw+hnKcjyM
	r0fb3iGsYmQ/Olp4j+OHerPkFeoZGM79K2tsX2rsns50q8HFHuQ/1nE5LexHgXEClVoSsuUuk12
	PuqAnn7iWfppkmGEtK7joRfvOWpwsWh1MfrziSJveTFTJv0lF17Kf2797Jf9JGU/lbKqwAjTbWP
	CuQ8ODw7Gfvdehn15OL3wNy+jH1vbTaZ8vd4rq6edQztk9Byx32BBtmpu4jxkALRQo+eNT6C2UQ
	tHgfLPFiaAd2bTMWlc+gYtjDMzU76YJhM3l7eIVcC44rVFwBtPOOJVdko9tSXUeEuSCSuCuVj3k
	gxdEhvvvp+ovfHYM4JPFeqpbdBMeeuALa1iaA=
X-Received: by 2002:a05:622a:6850:10b0:509:481:5365 with SMTP id d75a77b69052e-50d62b02630mr48690911cf.50.1775244791137;
        Fri, 03 Apr 2026 12:33:11 -0700 (PDT)
X-Received: by 2002:a05:622a:6850:10b0:509:481:5365 with SMTP id d75a77b69052e-50d62b02630mr48690431cf.50.1775244790654;
        Fri, 03 Apr 2026 12:33:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6c9cbcesm1654085e87.21.2026.04.03.12.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:33:09 -0700 (PDT)
Date: Fri, 3 Apr 2026 22:33:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Koskovich <AKoskovich@pm.me>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: milos: Add WCN6755 WiFi node
Message-ID: <7edl5o4lc2jk5exozyxomxjzooqqhek5zyvmp6e3p4ndxweulg@h2dwmk2zizgj>
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
 <20260403-milos-fp6-bt-wifi-v2-5-393322b27c5f@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-5-393322b27c5f@fairphone.com>
X-Authority-Analysis: v=2.4 cv=erjSD4pX c=1 sm=1 tr=0 ts=69d015f8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=nnh3LCdgXL55amKsc48A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: 7aQhQxP84eRegykRO269wZyj0robfmxp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE3NCBTYWx0ZWRfX5vKEvlOETKR1
 D5T0D6NAo243zh4C3DU4nPxb3v/8gLjTUGdGsAxzcWuBooOEPOfHb2Qp+9Gpt0PwAgOk62dpcRm
 ih+pF23892UZCsCZGGkOAo1xdlfTmQwNPuENOjSXQRH7WUJLS8IOccI6FEsy33zdDMkNX/hgm5d
 4LCbzAty2ZkS71vFchS4SbAnBqYeN9BxNCds2Vz95909QZKalO2ySFpjtyz0cgmvuCwe0Xx2I/Y
 fZOV/cEuHJD8lUSzA/LaAOy9k4TkPZWL8sH8Xwq9J9FsgBiu1s2nISL7fdnWrDtifYly5qqKTz6
 vuzbtlO3ylJwI2SEnLtVNyVP2hcHRuugMI/Uhj6mftPwCzpKAKJeb9m0GbgpoXSHkK4HCgmy1Nw
 RscizVbz0t8nBc3VnytEjymI/ZF0KCcffYe3s91zrUrdRvgXyxFvt3BgDy8lxC+x5Y8qYwU5dpT
 V6jkBz2hzGErbN8Vh+Q==
X-Proofpoint-GUID: 7aQhQxP84eRegykRO269wZyj0robfmxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030174

On Fri, Apr 03, 2026 at 03:52:51PM +0200, Luca Weiss wrote:
> Add a node for the WCN6755 WiFi found with the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/milos.dtsi | 46 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

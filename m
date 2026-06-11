Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF0367294
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208312; cv=none; b=kvpapXP98pMM6uoELSME2cG/bZudUfS1rrmFDvNInx6aCw3RII+S16jhQBZs3y71Ahas/N6dL0Eo99IpmKAkfe8jreHbwVw0LWHWZk0JUFDa7SPNT81FjGl7QEo68/pfIxPsnp51AX3vE16aQM781uV0zoiF8JQogImvJX5JHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208312; c=relaxed/simple;
	bh=/PJ574lbgqCaoCMVo1Yw/p6bzvW2kDDxvFjQvuxEDpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/2CklxlDpd7Yg2UQoKjV7OJ4SvUMQMYg7uiQEI95SLXkT9E1ESuuWHvAvT6G1cn8eonMRWsJksZfj/yrBv8oljWGK7sAiMYU0Ca9z2w33HuilM6XkL5y0r804eFCB/9bp8RfxbugX802Smmq2J5XXhrDTCMjQpzwqgC3owi3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RAqxCevD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X2g+2WX/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RAqxCevD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X2g+2WX/"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJ3Uu81427000
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 20:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YmR4e1Tj2lOm/nlzcOpM3CCI
	VcV17DTEFBWvUeS7yO8=; b=RAqxCevDyP6U/Acy9PUbea+A/i5HTILTR2AhhSCx
	axV4TvFQkK+2y+J+3UBiXH86NO0WvhLTnxp3XcSfyOr31elHHO9BbsXERpAI/UhU
	8d0OAdRJz7pbQez+he93JLmCBmawgEYH0JsgtbOB+jjNIprXGN9Hjpp86R5PoLvM
	RVfN2lstzHtk/3Bu9V/E/dtjnRhqFjg8SJmiF3Z2MUTSTdIOemd1nWXxANZVvHow
	36X/KozWcnl5tYGNcECKkGUsL7jL92jVkFg0noGxjO6NoHbPD1SDkviSKf7VFLsr
	bQ0S8hNEiDDAYQC4PvCwCCpBRRTufHAfQTGkmVuwl4ixew==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xcggbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 20:05:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6c89de84f33so201285137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781208309; x=1781813109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmR4e1Tj2lOm/nlzcOpM3CCIVcV17DTEFBWvUeS7yO8=;
        b=X2g+2WX/l+L1CJ1IGpESXQzyMVNspKqXaY1cgTxLaXdcWoowXjyj0IGI08T8R3KUFC
         dLAnHRvP66toLRqKIHbnge5CQYs/Ahfhr0Rbo90xjksd2LT83aG7OiQLm6rfo/YpCYFe
         sxspH+WjZ2f0/B8tUMgfHFf6oVlRPi1RwkASy+OVqOyHtNTHkMF4cGYslZrQCjT8RfKG
         qOpbPe9659EyLz+YAIvmY+zVb6Y3GY4ZGG2Q4Yqye5Vo5BStZx80031jUhkSbwQkmcQI
         MdmPxgwGV+mfs2i+oxiNysoO43BwpIF9oeP6yLH7gjRKmyHPsyVzFnUx3X2If9sL+0PJ
         96Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208309; x=1781813109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmR4e1Tj2lOm/nlzcOpM3CCIVcV17DTEFBWvUeS7yO8=;
        b=IEUd1UIph9IuPyFRhG/dBvMB+H1wQbfiZCpQlQHuRlxXglOWz91Kyz6Xiaic2F1/L9
         BSjk3R25/JE9FtkzPq4DqIqM9cnkEwlVU1gXYYqIV7djQfBG1EeKnmcsJ8P7sDhOS5qS
         pDHWrbv874k1Zn0h/12QO07y9KoGYq0A612guOPjpXqNDk0akoOKrvEbuQ737wGj0yUr
         bD1TisEh9yZRtXh0l1sJTCq7EY6Vo/kXyIrcjyEaGrOFueFVdWpWkvYGRQ4OzlroNKAB
         UOOO4gogbS/jviniDIZKPDeLyTXALgOMsvWGKlbk7Rs/d5SkHw9bHmM6Nlb1BOojTMcs
         dSeA==
X-Forwarded-Encrypted: i=1; AFNElJ/i+iwI3oh/4kcM2ICE3za8IESQXJqXRL4MVeXJ0OxvecoJDPSsbPnErndATgAIdw/pG8M1mpvYkYYwpOdhpUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziSlCFbfRrgpoKbvAV3eLucUfTsML7/7NVZb+CHCM9Uyc7YoBI
	OGRlP26H5xx4cOeeikdO1aLLmO/KZLd0FZZIGNpoK5aoT7iC/MMuI5WiLlwMrnzY5lR7UO/S0Al
	5TivPXbttxsrel0fmTeJ/YxNkLDfeOLJaGRBaerB1hB57UQuSuXbgkAoCxVi96psTUVGq+MQ=
X-Gm-Gg: Acq92OF4btkwk7R/VZqi3m1g0kRuL8gSeuUzfXIAiYEjFFGnhIZEP16NeuPpzH1wNEd
	gAyKEsWb/HvXiTgnLyCRjzG34IDgpEBDlKEQC2Tf44KeHYRcWeHcz3Ujr+CZ/kFg9+R6EYVytt1
	tlESDDjn1yl7hXJ8Qr8xtYNR6PxR0lmk73yvGuz8RmOevEb+231qurwvMpbwD/riVXbI1mlR9yP
	SUWd+i1xn/TQI9J/XXlfmxz3lDr2pVxMaVIWLEMxrRb613lXPag0ajby+4IJnOmm5ICMKNrGWEA
	hjVkmPymXgTdzuyLtBrlZEmzNcJ2Hp0Qtgg4kbd9atTAt6Za/IngwdDz+IQ028ikSNxjI8dYg2f
	R+UAU5ObdiRiJed7KGni43Jmb9j1G/lITZKZ+cu+LX/mTIMj0cDL7zjBajMF94v66pbMKQ6lRYY
	MMuy+ahriU/VyNjADKJMWssPNLnVUbuIUS4zM=
X-Received: by 2002:a05:6102:5088:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-71d5c4731d1mr3076997137.17.1781208308996;
        Thu, 11 Jun 2026 13:05:08 -0700 (PDT)
X-Received: by 2002:a05:6102:5088:b0:6f0:3c5b:ce7a with SMTP id ada2fe7eead31-71d5c4731d1mr3076940137.17.1781208308534;
        Thu, 11 Jun 2026 13:05:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2cd98d97sm108447e87.80.2026.06.11.13.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:05:07 -0700 (PDT)
Date: Thu, 11 Jun 2026 23:05:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/7] wifi: ath11k: enable support for WCN6851
Message-ID: <fiuuh6rwohtlmwdiy7cwqee62e7jrtdgii7fklfy7jkgh25yul@mzlefhqgzo55>
References: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
 <20260608-sm8350-wifi-v2-2-efb68f1ff04c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-sm8350-wifi-v2-2-efb68f1ff04c@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIwMSBTYWx0ZWRfX8cA16cL5UhR7
 6gbRfQC4aMqnSoAEO0z+tj6/sYz4IEn6u72FgZj/31+yVCEjgsXzhg91UptemaGTCKOmLollCNR
 ve7d/PHzJewGVPSfbNPhWICo/I1C3NqafpViL2k/YhiuzZObOj+hRXV8ERRabY0DqiR1h549scL
 FmYFk8uTkbri7cGuQGxAyWD14VOujls0pNh05EXJPC7xNsGfB0zZf8XaKOQm/U9vAAe7AKCvdSv
 k4dnArmdYzXc8215MVdRlr8afETF1gtm9EvKFcUl1qByf+wubzFGsV275C0UZcW5FUjCr7avamk
 9lajcBw+H0N7MrchsBayRYx4mqpGy856IkbgOIa/4bYErWosxBqZckqOqvkQSRpa6md1WrPbkpz
 OXMGEUN03BNHIqIvxiQKy2bEE0vstTda2OaVh8gGhQW/3wR80Ewd2v1jbHHVvNdIhhdq2qGUKZK
 g0aCO2MMh+2xXFlwIyQ==
X-Proofpoint-GUID: XmhEOF9id3_zixlBWkiPMviLP_map34C
X-Proofpoint-ORIG-GUID: XmhEOF9id3_zixlBWkiPMviLP_map34C
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2b14f5 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=TUQ72T3Q6eNCQUusxowA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIwMSBTYWx0ZWRfX7Yad9TYHImix
 BYpwLAVWW74ommGnEUMxRPupmo3wwTIlQOdnBe/r5wA/PwIK4fSPjMm5VYQLVwzBMOcbLAtN0VJ
 013fFkBZIfeKm81rBuetvc+cTtJVuZk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110201

On Mon, Jun 08, 2026 at 09:59:20AM +0300, Dmitry Baryshkov wrote:
> The WCN6851, found e.g. on SM8350 platforms, is an earlier version of
> WCN6855 platform. It identifies itself as hw1.1. Copy WCN6855 hw 2.0
> configuration to support hw1.1 version.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 92 ++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h |  1 +
>  drivers/net/wireless/ath/ath11k/mhi.c  |  1 +
>  drivers/net/wireless/ath/ath11k/pci.c  |  9 ++++
>  drivers/net/wireless/ath/ath11k/pcic.c | 11 ++++
>  5 files changed, 114 insertions(+)

This crashes with the firmware that came with the board,
WLAN.HSP.1.1.c3-00200-QCAHSPSWPL_V1_V2_SILICONZ. I will revert to 3
vdevs for v3.


-- 
With best wishes
Dmitry

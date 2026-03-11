Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5B31AF31
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235259; cv=none; b=ZCs7CXicLSo5dPkeQk+FTk5aMZGuo2GKGibvaUKq/a7BRRcJflDCAtGh+X9+Axxec7lAoY5rzzDORRqe7cIqUKfQQ86QRnGIDuB/oB+8urmWK8wSKjndCLZJdBzWYivQ3Jibzxevqn1gcg4AgH2KzrLDuheaX/icS+qYLp0eZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235259; c=relaxed/simple;
	bh=5YugjOz+HdRUy2XsP9iwWKjQohlRwLKjRkcJ36Mijmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3snDHA5HW+mHqywZgJ8nO70tjO0Z1Q3vqhznUn1naNfMUnVurxjHMCMO8LHQSyA8+vLo6dqHXXrzAsjWFLgjJQAdYI/fml9Z+YDxk9Kw2DaaN0hBo2ch5bXUkhd4LP0eI3hMbhfw3qEfdpzT+3AlKa0hoAfVTD1jHqQFdDbL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bacGXNJW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KSQ5OkQf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bacGXNJW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KSQ5OkQf"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B8nWD21572980
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 13:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X/KpjEcjrBSw229vMgSWlfoi2t/w3dtq/Ha3mvvsA28=; b=bacGXNJW1ywveYjp
	jk1s1D5yfUr8PZI2mWitOay2EcLKM7ErGNgsZsbQl5eiUFy8AW37+eohQFBlTRn9
	6M33OQ8bATpPfBgqkTwVmfRG+qQzus7A6HYuyenk/Ro8CxfaGfLdJhqXnOaCfb6Z
	je8xLjWVtjQSdRA70WmptQzETm7WllIpXak8zxX8KfC0k6AQcGuHUOgBev8KCBRL
	71cxu9ZBxU8GAUMrr+UoZ9E6Vyf0sWpvWnGb9jjkuw0wOro+kK7HvqdMOwVBU+dJ
	GWlbKAgIWfajucoUmMk37ozWDb/FyyM0K4Og+o6Zzc8QEaUGMCI4TxHASH970QDn
	YWBrzw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqgkbqya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 13:20:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb456d53a5so118329485a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773235255; x=1773840055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/KpjEcjrBSw229vMgSWlfoi2t/w3dtq/Ha3mvvsA28=;
        b=KSQ5OkQf1+PdIUVyIAueVqzlr9qWNFvq1FNbfhicEYv7RtiZ/g0t3vuBH2wyYA+tK1
         CnIOUgcdQ20tBfKXHVo15H06zeGmNTT304fjCH4rLSAlNWfhG9X+UIN+PIr1QvoKnpwx
         P83KmeMUJdO8R9bNA8yNyhZcaRTGDhS1cQ6NzdfGe3pnhMhyC9/K9MQ8YwzR/8OjCZJa
         AELOb6qybUNPrOuZ+kUPj24LfWWCJiyFKienb8qdeBoRqCuh2IlVwFAWD7+vqTaapPaS
         CkRtfK/l+cEemehuJxaxYe4/D+cuFeElwk3NtkDStSkj3D2RdvnYCt1QOkSIlnaUmNNe
         7uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235255; x=1773840055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/KpjEcjrBSw229vMgSWlfoi2t/w3dtq/Ha3mvvsA28=;
        b=gnFVi26T6LskT0WOVn3coeKBF1wATBaPu283e4WcX2jvPisgDfdBPpIEHmioe07q19
         A2DHCeT4xmxrd6yyU8+iNxIpHfXqtTPsv/duChwQpNslew6Gkr5XcTYp+aEdsQpH0zgC
         zbJQ8+mAdb3xiLI5JUZcuvkGaaDww48gxNMLel/tURKDaY6z2FEVBnwxJGLTJzsQRaxk
         nY0hCt4HoR4wVFMaDlL/Nr7gImSOWJLsWZ/8vCNfMzHcTdHEmZyjeqOE5hZa+cwgVW+t
         /y2fo/F0qYY8vkOK3olGj4BBqjPox2Hj8lk5F/8DHbsqe6yFyiFonIT15RTFE0Hj/r/e
         tPRA==
X-Forwarded-Encrypted: i=1; AJvYcCWwxpNFZbH3sbjtIIwos+5+4Au6rKCQUKm2euhKJCoweob0dKNtpUnbXxrCmoDJHAhn2RDwltbgX0Sjv4pvAX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjpGJIG4JqujsF1dRzIbctE4HPPNxk5lhuL6+Spa6lypG3ullP
	lbjI3a0XOdU8lluGZ9yatykAFRa+vsXKt28ubm32VNt5DtVMcE9SsDYnPbyvhzCyg7KWlOfBB4U
	pguwI5Fo8b4OC4ZPws6JJ8ilKsjDBSm9t73r1s7R6/1POEnRaUzDtk3OeniVH/hcPjs3P0Vs=
X-Gm-Gg: ATEYQzz8tXCk74l2TQLxpevwh8vRa8km4p24VgBDxBKA6WXQjHUwt+efY45J6FMfDix
	OJ2k4KNFByWf++pfS6bDswGJx5A5CjO2WLUCRx9nnb0w4CiV30iL6AIRnKaUcjM798BGJitqYzt
	VCl4EcQKpafrQZua4bxisRAtZuudK9+EJlF/F+coIcMYiYVxM/bq4JK6lNCxIvLprIm0vzdpF4v
	05luMGr08TXXC1Wvy/cWM/csTiOgVdO7I50bXVDwj06FNlOsyxIAFGli8OV6ArRgYSQpr4jDR3S
	A4RTrxOtvi+tzSDJ7Ig+MptGPp8MizJsY8lRxNd1Jxkk5M69v7zQqdJDPBmZ9aXEIPD2+Kxrf5p
	74/PrfMYObo/wgxalLXsxmaXwKbf8ZzUY/9AaY0LuHRd00qvqAftym33HJEuLd33TvQNk1+VrnR
	/++mk=
X-Received: by 2002:a05:620a:45a2:b0:8cd:8d50:16a0 with SMTP id af79cd13be357-8cda194a812mr270677785a.3.1773235254957;
        Wed, 11 Mar 2026 06:20:54 -0700 (PDT)
X-Received: by 2002:a05:620a:45a2:b0:8cd:8d50:16a0 with SMTP id af79cd13be357-8cda194a812mr270672385a.3.1773235254510;
        Wed, 11 Mar 2026 06:20:54 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-663144821adsm524831a12.8.2026.03.11.06.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:20:53 -0700 (PDT)
Message-ID: <2511dcdb-12f9-4946-aff3-4dd19d8d9348@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 14:20:49 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Fix up WCN6855 RFA power supply name
To: Konrad Dybcio <konradybcio@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260225-topic-wcn6855_pmu_dtbdings-v3-0-576ec5c4e631@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260225-topic-wcn6855_pmu_dtbdings-v3-0-576ec5c4e631@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bMX-jvH_1WHxbQtKXR_FuCdPuqevkp9f
X-Proofpoint-ORIG-GUID: bMX-jvH_1WHxbQtKXR_FuCdPuqevkp9f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExMiBTYWx0ZWRfX0+RQ132N8Urf
 vQ0bOJ1ALS9r2LnfaEDs4lZgFiEMJkpLuqD7l7B+ShrjmvTrpxV5cMgFTSdV0tqwEfkI+6buVBN
 GiFuJCVGUlBxEgcUb6L0m/LTm26nrYmiW1ldNU6sSGxlzPUBDGAKUTLQKz2q8XoI07Qi38Kd4DH
 iuTBDyUN4/x8K297sse5zL51mohsahqYxslWu9xcwYUoPwLT9ORqpuddAgtD8ZShICP0ps9WVMX
 zgzJdIxER6oHAN1t9d6a1Rrt+YmJfKdumnt50UYg2hvB8DKa67xjPTnBq7SfeLtFWSVz+6WpfY+
 AQnr0hg3ip/01ljgHPfWtnJo86bHhYMTypeZRrPsIPAk1PvilquO/1R/xSYx7WYflAKcBM1JQrs
 o7NnNsno6UdvxPnQLbE1SohoorMEbRy4zXiD4VCAxBuGHyXeIdAiequAG2Io9/A+TLBdZZHrggj
 xHbc9osNm+dhyBSstbQ==
X-Authority-Analysis: v=2.4 cv=M4JA6iws c=1 sm=1 tr=0 ts=69b16c37 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=M7h3R06PahCMBt7vG34A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110112

On 2/25/26 1:23 PM, Konrad Dybcio wrote:
> Commit 5f4f954bba12 ("dt-bindings: bluetooth: bring the HW description
> closer to reality for wcn6855") renamed the supply representing the
> VDD17_PMU_RFA leg to mention "1p8" instead.
> 
> While the supply's voltage is normally 1.8 V, the bindings should
> reflect the actual naming of the pin. Moreover, almost all DTs define
> the output as 1p7, so that ends up looking a little odd..
> 
> Ultimately, this is a "fake" regulator that is consumed for the sake
> of DT sanity and this series is meant to bring uniformity and squash
> checker errors.
> 
> The last patch fixes up a less-trivial warning.
> sc8280xp-microsoft-arcata is left out because I don't know whether the
> mounting of the chip is on-board or as an M.2-y card (although I would
> guesstimate the prior).
> 
> Depends on the long-ready-for-the-merge series by Krzysztof (per-chip
> bindings split of qualcomm-bluetooth.yaml), mentioned below
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Changes in v3:
> - Rebase once more, pick up more tags, it's more than ready to pick up

This series has not really changed since its original posting in
December, could we please get it merged?

Konrad

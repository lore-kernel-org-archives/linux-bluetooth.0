Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6F30CD89
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778355; cv=none; b=VY+289NeNtw5W8JTFArTvZYWxkbICR3jkby7a2KzulElYZaqiLt3/lKW20qPOCkf0Jp4pCqqcXpPWlOO7BVMe3JSanFxLvUYkQmVtSiQGU2qj2dOTbwvAx5w4gdH4I3VICRit/Pe6aRPWhWabpys5iiiMmpZBapaZuFqSdbmcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778355; c=relaxed/simple;
	bh=gFT+3Amm33MdGkcRdM74CB/X6g8NjdXUxYSkJHwrXKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYVbkVueBQPFDTbwrZnYBRQmSHb4VWwDMK0H2bvGIXl7quxLBXul5n8LfBWpGjvkEcJ5viRr5j4Y0mh/4tPX9c2etA9zHmXBLlLbeaw9q6V+et+hyZwxf25HuFw4PGp9Pd7LLgO29wFXiuX33uiYJUgQt+r+e1kld996tmY8GRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QxerOKUe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gVnX/ANM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QxerOKUe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gVnX/ANM"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACMvok3306813
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 12:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mu3glRqdWt9AjEDpzM9mxwbY
	vCJas7wdjM+G13lxLSI=; b=QxerOKUeZjj15a4crxY+DH4S8zzP3rWz/sO8sLwf
	sOCc0DMNDrPBJjio7zt0ZHZf0R15FgV3XeQanp+u8q6+vGmG53vze3ihn6PUiRmf
	s+pw6NrPstpg1NofLK/d18PaehVchBr3NaD3GJRQk68MOU/bobVe93QEWhzJKuej
	8UzyYtMBa3CbBczNocVTSi7OAaInx5B9wy/lsXdCI6/wVApM8oVkbQ4WukHGS1Dt
	jfarP1Ya8E6//EULG0O6O2p24ycwNdGg1vMSEfKW9x67ojiYCSHxUGdPwklM72Xu
	sgTUwKJdZ2GPBYH4ox/pCAnp5tDNpDOuy6909Qw8zdrxMw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abg0q81eb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 12:39:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e88947a773so70420101cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 04:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762778352; x=1763383152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mu3glRqdWt9AjEDpzM9mxwbYvCJas7wdjM+G13lxLSI=;
        b=gVnX/ANMniM9mqxpJ72ah+wuJEZGOLCMJSFnkIGI5bC6eC1i2PYzPipJEq21OwoxhE
         UgBHFU8ZEDj/5lehZytkE87VroxMWNMEX+R8fm07Lg4PMn3vnyIGbuyXc/pGlAuK+B6G
         YrQ5ltWOAL2h/NeT2UdqA/eF2Tc3IzsM5Xfn6YbTj0zbfdhBzo6R2CJpV/XDYmj3kT90
         xA+o4fdM/GWbriy+eSDxecFp94cgo06Qf3eMsdrpD+yL22G54JGFEd11jFGYyl4unkfK
         FEpBHH7VvJnY1+eKVLntCz9HBxT4p9JBblP8W6yCsWGy2aT3dbn8OlPgXUbe7xvGmi1w
         z53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778352; x=1763383152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu3glRqdWt9AjEDpzM9mxwbYvCJas7wdjM+G13lxLSI=;
        b=DXPgq5jVsh1k1gbS4WCz9itny9zPzV8tgzDWf6oD6CfBDF7onKviX6VhEbYFLz9T9g
         hpoCgY16LL47ovYnI9evldvRwoBCnfcDUw0nua6mquspWdsiSR/+2N7GyuYSJTcNxtcB
         ycua//4Co8jxyr+TOF0sHronOcwZ8JjOYXqIuvrV2cvm+EsMjtVkzlSLFGe8AiqJ4Q4I
         m75vPu0VIaFhiTzR5YIY+2jIl7tdiw6MwQfTizrodY2O1dBLmZQ2mWNecuTb+9oD1Nkh
         iLiN9pn05f+81Wj+RiWfc+4jEFx5mR7FADaktNPY0C+zdmCy2+GbM/QmBPT3QlcSCQFE
         lIMA==
X-Forwarded-Encrypted: i=1; AJvYcCXROHyTJiwyIfM18jXQu1u8AhnAO2YjvweuzQpWZ/lhGs4GmHaImnZrAS5stQr69v8nMQQaABe7A89uWEBTOJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzooqZuMHiR03vRisqdNjhKE47XDiyf29+XhdZ2qLPrKpJBFcOJ
	Wj6ANGaQwObA6rqaDCg+W04a3L0GBSPncgV1pBomUfaeJ6hMkuv2+VF7q1sJ2HdZFqRvZFt9yA7
	Mq2ojz6QNxIg7CWOdq3vBRB8Q2t0IwqKe/lTWcykJ7d3GNQQv1cvHXiVDtlq/LC95Iwd2B3Y=
X-Gm-Gg: ASbGnctOFVGNpxxN6mZC0ufQydQuP3b9zpxpLXHCiaU2XqzQgDMBYYvQytqjSNafvZo
	QlEPO8X6fpwdk2CeZTtHzEmEvJtvAE14fRtFgHIzyJRZWZCAgp2eg2Spxm8AZCpPDGUrpFqN97o
	xh81uEBsqPsqz353U1b7DupTyYcYMKBZNnsyNt9wO/5l2JzxGh2DnQ/t+X0pNofs4zECuWkieyg
	QvnnAMgiiyzr1kRfmlSamfCGuOMEGaW42jJzLOM+6eYdeZOOJE092EBs4X71jyWSxnREs1QWUGj
	0pem3CUgEdu/G8NI1a4SV8Y01ISYa1cbxtwmzCVXxQmax+LT663zqkRzg5rf7Zvol9yns4cVwky
	o2ZCRG4OoQVS1lRkiUL0qnR9D5pi6jmeSy8kCjiLE68rRQc/3DepvbrZMmsmflG5weN7/7wJhk5
	6d2tAgD05qBuIv
X-Received: by 2002:ac8:5a49:0:b0:4ec:90fc:59f4 with SMTP id d75a77b69052e-4eda4ecf7a1mr91893581cf.29.1762778352458;
        Mon, 10 Nov 2025 04:39:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc7FjOtBgPgHxkl2t4dPvZb4lKQroBgN5ujgHUpHoA0lYUguSSs9vhkQDvjQQA7BW9uWg36g==
X-Received: by 2002:ac8:5a49:0:b0:4ec:90fc:59f4 with SMTP id d75a77b69052e-4eda4ecf7a1mr91893141cf.29.1762778351861;
        Mon, 10 Nov 2025 04:39:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a019f21sm3973713e87.37.2025.11.10.04.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:39:11 -0800 (PST)
Date: Mon, 10 Nov 2025 14:39:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
Message-ID: <lr6umprjjsognsrrwaqoberofivx6redodnqwnuqtpp47axhiv@nho74vyw2p4e>
References: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=D6JK6/Rj c=1 sm=1 tr=0 ts=6911dcf1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=vuKYHiuAbYjNwaP7v-kA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExMCBTYWx0ZWRfX3vmIGs6CHfU7
 X23bSppLNb8dDyRX/XCJn4ErWpctdB/5O3IVqrT//1ktrDWNyKav4fOpsXfsts44hj3OBQSoypM
 Kc8hL9Kp+MYbVN+bswhnwDePw1x4uRbNP28MRATIC2vbdQ+9TulCJGOM1itm8aZfvRs6RZhzdcQ
 j9DQbMBmzdK1MUCmXJx1bWaUdmbY+wioFdId9fUwmszxtcXpvoi5tyN8xGkJ+Kuo7FW5vOfIqSd
 awPk0UqwSHaRtAkluDcCU5IWk/l4wXkPTNFCGhb7AXwkMsQgUe269pBFtNtrcn+XFesWT2qoud0
 lPJcBx+PHc0yU2x+uDIfoXIdMOkoY4tJTjcZ1DabWSII5Gr0XWYGe4vHBGvHR5PVCOIx0E506xa
 Ao84sg8S/Qe+ZKnQgJS1OHBEarbnIw==
X-Proofpoint-GUID: cPM0R1XaDq4hwF0KwFP1erOg5uYx7KVh
X-Proofpoint-ORIG-GUID: cPM0R1XaDq4hwF0KwFP1erOg5uYx7KVh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100110

On Mon, Nov 10, 2025 at 11:27:09AM +0530, Wei Deng wrote:
> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
> Bluetooth work, we need to define the necessary device tree nodes,
> including UART configuration and power supplies.
> 
> Since there is no standard M.2 binding in the device tree at present,
> the PMU is described using dedicated PMU nodes to represent the
> internal regulators required by the module.
> 
> The 3.3V supply for the module is assumed to come directly from the

Why do you need to assume anything?

> main board supply, which is 12V. To model this in the device tree, we
> add a fixed 12V regulator node as the DC-IN source and connect it to
> the 3.3V regulator node.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)

Why do you cc stable for this patch?

-- 
With best wishes
Dmitry

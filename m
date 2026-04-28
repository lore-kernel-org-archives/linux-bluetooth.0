Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BBE3F65FB
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375616; cv=none; b=QnPq42xeXJecl9o4wYcbRJCW1SSz7a9QuwADwogNEdieXGYHKEng3vTkBI4VgX9eIM17BBNKRu0sKYNW5tHlpQqcMjm7NLldCDu/7k4kioGTsVHEXYsi2TMYFA5L/Vdz4kcB58jnXPKvgHFLUUU/UIJoCorBahrFy3EWrIaq9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375616; c=relaxed/simple;
	bh=3Rn+857zkrDFLYBUrf5Cyzg71vtUa3pKPZfiKCJ66mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0vl8exodUKIvb1NDx5Eqsj+GMJL9aajwGQ/nmxNpRckMNbujgBhmadLcI3Q1VWFb+d7EucNzSaXgQ6IOaFZLTGU8l/1FnpNBJRPet7lt3Nm65r+bsVIpKhFiLllLCwnX+eFhKM2U1pWI3i+mLQ8IaQPt8cD9Pe/nikvKXmXRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C3xrjr7k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=apvDNU6H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C3xrjr7k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="apvDNU6H"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S9GI4E662986
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 11:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=03ou02At5F0k5bHCtPQ6XIG8
	n23e29Vm74dcPRA80+0=; b=C3xrjr7kklHd3+PzukV1xhRynVZHADOT5ayH+GAi
	0P7QzGCYFBC3S4LWZ2MMuPW2GYyxJ9GG8DG3mWV2U+gCn+7DhJDdPvTOMQaXuMFS
	GP1L5qs7091NAPSnqDLCNahCAN2kkaaPcFvrguzkdHXvplCwma54ZbJ8dS1ikwd7
	/PdyeHRqdklazf2e71sKULD5zwZob8NJ8QYCzoDwl2rXT+nFw4MCDz6K/a4CdKnE
	iHKN6EvK1l390wzCgcK4zbXloO65pcZcsmkUiSgiqyfhrzPhrFQ+2hafYRdtxRkG
	eBOBilAO+WAsld64foNrFF+pst8pdT3/MpVJPXDSx2FDug==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n3p1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 11:26:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51009190feeso29959771cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777375613; x=1777980413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03ou02At5F0k5bHCtPQ6XIG8n23e29Vm74dcPRA80+0=;
        b=apvDNU6HbB3Ag8vUtl7MbtoOJzyfCz9pzzzZgntKK6YIrcoHQHwZak50HIb/pFfwJw
         gyTjCGe4Rl/FghMs1ZkoGkgKqCxMhUk9viieJpBhD50affwWiUILDF2ajbdaYTFaOGQ8
         yk6ShVWCT2mVS8tfibYyRuFJl9NRgtbaru8LIQbTyo1z1IYoaxjUkr/W+/bd/9smOd26
         j4ISgOaNe4w5WmodRMn2GDEQhcoRO802Lr10lYl+ejosh+gNNxvJH+HX34yNkVf0yvE3
         jLzCS7oHulPm5sFRUci11vOAYzn1rC9ERYg1O4akUjrkAy/lhaRU9XqPad3mpbSPckln
         p1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777375613; x=1777980413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03ou02At5F0k5bHCtPQ6XIG8n23e29Vm74dcPRA80+0=;
        b=EY+8sCKusdECOeMBAZHH4J85zpnrlEgwddPpgR1A+gO0jJpIgDt0ZvGt7cNkr0E3NQ
         XHwiYxstaYr78A3essWbkbwv1mCd+Aj2Ul0KfwEgkZNMxmRSR17l7VtXCgwsuBRfwik7
         X0qJxR5rUG8NL+mmg/mimUjEvGoNcpjDA1nodt1Ho/guRBIISW72pmpMywD56cEScfY0
         nUZmEVQiQXqreIJbdE+0lfGn+HgFxPIbol60IhW4li4oIXpE4IwKEAKW5uPZuP2j0ZgY
         r21zrtcUAejEyveMFNgQukJAOAJcragRxbpqOfDFHdHwwGsip0RuAyGyQvf1Wduay3V3
         gkdw==
X-Forwarded-Encrypted: i=1; AFNElJ9sUyYwC5iYblYqFTQpgvHUM+/nviqryX7oUZFKP4AgHHhH9d7Vq9FZWQrLVc5dOnpkyjIqFwx8Jy8zNgzyBr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw82DR6hShpMnqo5a05iEGNufDo+f5O0TNK93JXjUJKJrF6B1Xc
	AkJ8vW4YEB2Oa81oGDaPIYWuG3DXxPUo8Rrf71MPskV8nCBwbT+wfW1uBbr1V8ldd0tbBjFHHeo
	qaaVXtLQCl0VyBEfD+1rZ5r9Sbwu7EZ8AWwhEh8Z4EIraYbemlwdf4RQCYk1MWz26DKVdLO8=
X-Gm-Gg: AeBDiesjeKQJJWNhJ2waAXJEwKS7Kkh+0nMtSc8XQ/MMPsdnQlRtAkA0vkChSTgk5XE
	rOzIh+IRvxzwEYfwaOFFKTkHxfh6scFwf41Yfnmb0RoFcQqxLVMmidp30hlRWPs+V694dlqv4i0
	Rle6p2OYIxkPKkJ0mr+eZZy0EoKvwu4XOpbBDPMeSbqlteVNiUx6yovooK3kwmRcr8HvOw2zlpL
	SyEN9ql6di3IVJrRjNj/8QSeBDQmzmTgbqgGMPfKAG1e5i+DuPSGUJQb1UEP/HL2Wy5UEn4hQfT
	RiQcpkQmLJt9rV5itBMaYsepg9pv9kXUtjHxpSHZgDhDrbSoC3lZiSiU0gFXicX3liyRWEEzVK0
	eSWTR28IybtEIlxJP0C8hfmt0IHSzHscg8QvmO2AQSUo2fYn7rYPsmpbg8EmTGA0dqZUZI3CMYM
	SHzRiZJC7ps1wQkcqzitifQxLA7Q8JaUOyUNa3oGOZ8HOCJw==
X-Received: by 2002:a05:622a:653:b0:50b:38c1:c6a with SMTP id d75a77b69052e-5100e1256cbmr34995241cf.19.1777375613180;
        Tue, 28 Apr 2026 04:26:53 -0700 (PDT)
X-Received: by 2002:a05:622a:653:b0:50b:38c1:c6a with SMTP id d75a77b69052e-5100e1256cbmr34994721cf.19.1777375612542;
        Tue, 28 Apr 2026 04:26:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a7462cfef5sm550447e87.19.2026.04.28.04.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:26:51 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:26:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH v1] arm64: dts: monac-arduino-monza: Add Bluetooth UART
 node
Message-ID: <ejjbhgo7xtkyggd3vobthtvep24p55bzqzfyogg6iemon6onjp@wch5b5jsz2u5>
References: <20260428025652.662502-1-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428025652.662502-1-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwMyBTYWx0ZWRfXzMe/3QriOw6Y
 f4R7VPaOBYv+hnW8x4peXwYjC1JfV1h0+OtqWa9+zcSAIVpm7MM+p/Zdg3HeyNEyDPoACL7WqvC
 6rR5csRZIKeCA7ZE83xkat3mlZN3wdm9CM0/7k+gXAz5lJJ2IyT0vZocl00iDy1Z+aWJpJQW8Om
 vwEnf/fVUJixG0kYOFYQYD4t8QZq19OtBHCJ44+/xpgotLITD/rVV8Qg0GRRyNPE4u8oTXg37Mu
 lo+2DSh6yVm5yn+Rmfo+0iAi+mFa8t4EK6UmVcDgIPBL2uUjTj6E/VuixcEDbcGWuxKPS6qcIbI
 i85IWTeKTtnAy8yEJZtWv1o72GBVfqlBMSwBZ6iARgI5JUHjN/Epn/g5s4ovWmJjQd5z8Uuf5zV
 UytDJUwmBLOrBYPRQpUF1NawobrEVm+50oQ/pcaljVHjy+n4mwC9VdRv2AM9kV1QrjpIoqZlDIb
 P5yep1eyqccp8OXQO/Q==
X-Proofpoint-GUID: YD_h1VJ-4loNZ1YSe-hLPvpGfcULuW3I
X-Proofpoint-ORIG-GUID: YD_h1VJ-4loNZ1YSe-hLPvpGfcULuW3I
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69f0997d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=KMwB8ELdjFECEPWHL98A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280103

On Tue, Apr 28, 2026 at 10:56:52AM +0800, Shuai Zhang wrote:
> enable bt on monac-arduino-monza
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> index ca14f0ea4..092ca0b59 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> @@ -21,6 +21,7 @@ aliases {
>  		ethernet0 = &ethernet0;
>  		i2c1 = &i2c1;
>  		serial0 = &uart7;
> +		serial1 = &uart10;
>  	};
>  
>  	chosen {
> @@ -454,6 +455,16 @@ &uart7 {
>  	status = "okay";
>  };
>  
> +&uart10 {
> +	status = "okay";
> +	bluetooth: bluetooth {
> +		compatible = "qcom,qca2066-bt";

What powers on this BT device?

> +		max-speed = <3200000>;
> +		enable-gpios = <&tlmm 55 GPIO_ACTIVE_HIGH>;
> +		status = "okay";
> +	};
> +};
> +
>  &usb_1 {
>  	status = "okay";
>  };
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1527B4F5
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768532278; cv=none; b=hV9r1vCSrrRN9m/iqa9v8GlIqjn3wgMRHEbXK8LKVd6Y5CkP/qkHX38Tid9O9k9Oa1EF1O/IvMk4TNB75yigVj7YwtBajr1S2QNAGf0Lg5ISbIfORtPgX4QwJyV2cNxTPCbPt6tXWkMHAajlCf/OD0WbmIBdyHRwvbN9ZtGNLEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768532278; c=relaxed/simple;
	bh=mHFtDo1b6G4mIW5vvb4D8Xxgfyc5Fbt63oVVDEDFJcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmGSm1zidayuuSeagqS8rOEpfvniZpVB/zUjawyDCb0HgjE1oemJR++Abza4WQDo60B/vQT7BbCSVJke9lQDgIrM2Mggfdybg0d53+M6Vy0N5dqdzejWUgcT02rulr77tcZQuQl8GPKiJX5NfHqHTi+xYPm5NZnvMYLNySvlxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hvtn6roK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=idKNgPg6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hvtn6roK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idKNgPg6"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMhlZi2819530
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 02:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EA0PgA0/LPBITWEYyXie9wh+
	KymQ/5ynEDnlQXiuIHg=; b=hvtn6roKLvsf+MkLAkKGRtN7OwhnbvBf0c+RrLBA
	Y+GIhhSS7dxlconWeSpzFS96+pdf7bqyPS4FyCVZVee5A4fAuhntpHPQCYyomOF+
	l1WhTobjarfja+wJWC+9saFbB7a4GupYMIcqbOrSug8ztV0KWa+3X0Dnl0JbZrA3
	1kYdnGcr2bVnNkjkuheJEPG+qsh+4iXlElaD+4Sp5kjDqlBIBkq7JtMs9TBNqvpG
	jUd/+Kwd98BlGcV8+CI7oGvrVZl3tbGOcpqbxCa0rV2RASQT0r1s0PA42F3M3l32
	DUvlVsp/FEXdYT83Gg9b23XMv7V5fXSAtLxQgYnSpNiAXA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq99aghr4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 02:57:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a5bc8c43so198925685a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 18:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768532274; x=1769137074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EA0PgA0/LPBITWEYyXie9wh+KymQ/5ynEDnlQXiuIHg=;
        b=idKNgPg6HUfeAX3VOfyPWs83CfVdJnvXqWcgz/i88t7ZBSn2o7u7Y85iOYILsNN/mk
         08d9zPKGIEadLKuGIlOsP6PrmuF1ltcoVPlqTnlthrv/BeQu3Chm40HgSvPTVUUYFr41
         eZWlrvg9jZ0n5VLYv6nqEnIqnI+y/BP6OAAaxEfbh5pxNH9ZE9Ypo5h21rF2YjCwxb2u
         Sz1joaqBCl3B62iCDIspaygH+BkKkp1nupNuV2QVL0DcpZJV5dzogqpelDH/Ede3rwZy
         CHUtvaBcQ8iAQ9b348Nu+uGrKa093RIgKnMSEG9UpQY60Eb5bE8PyXfA1cGkcmWUfVBS
         So8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768532274; x=1769137074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EA0PgA0/LPBITWEYyXie9wh+KymQ/5ynEDnlQXiuIHg=;
        b=AQo/Lq4JnQ5JfpMuU394zHBhrGzhdDbpg6pfwTrGzwYxhySuouMCjCfcjOf9k4LAyc
         dIaaTAh1SneuO0TyV6Jk1AwNrZbuDXuHgn9nU6ALujuwLb0NAevLKoxloFE2Bp2k0YSF
         CFX9WmbBeOClCiP2wCvAlwhnsI6mrKD6DldX3aMQTHSs90818eD+EQ8SKDyIuJx1n3zY
         qdLil6GIq+bdJ1Zf1hRg/przF0npdHHUPja7OzNhtWgDnTzkDFB+4MSt6ps57w4Fb1sz
         Dyu/j+QnF9XtfdpMJowJ0VYDhHQuXO6FUS+qQ8gmRPFr7egiXYovZn4UbbzpEo2xrapO
         mVWA==
X-Forwarded-Encrypted: i=1; AJvYcCXSTGT3CKHkoW1gUCM0jInySTlZI1M6cDA08AiK1p1sWfevr0ogTcNW7GqFxu03LyslqITw/q5AvUqR9znbLdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQE0ERJvBsWsVxYxNiixdqzyKWeAXh5yqx5F6aIPcyKaOJrmn
	5edP99FW9IL6M/rzuSn8bdCEkrjxSAzOnoSGRrb7gFKuU3LVltMPGLXu310+VgFiipuB7iSqZsm
	Vh4zcWtXK0K5iUtjHcp0cZDRQxHC+RCkCHz02xAhVE1R1PPDt/MJw7tXu2H1AcchxygBkAgE=
X-Gm-Gg: AY/fxX4uenXxYDXQtkLJ2FOIoeKgwzeqBA0fCHOWeK/bkcbXDsKqvglx5YV/xOtYAiK
	/GZucXUDYJZt11yDrn6XgbfuuMPR/AEhb54phAl9UhtEs2ho4Pe4ykSD/T92HNs0sMgBkvTD5m3
	ORkXgPnUC5c6PSzTgS6JP+PgHMBawNsE2ExzFhVNlEYjkZJAScpDVUADUP6L9BJCWak3+2RJ4hP
	V2rPet8gz8/kSILOOrHkigHMQRQ08nfXFigrX0LYubc9THJI88HYb7wtWC0o7bOxDzzuM7uFX8E
	vS8lo4eGyDOuuT10QLdYZHK7oxWlhNH2YTLFVX3aj78TWplSQasFpft4dES23u1YKiEbv/HK/Lr
	t8UCDbuOSub8STxzNdZwBQ/dePjktUGaD6/3erfrymbN4A/D8MwidI8ZrhCnP1VOqJsVXnfloil
	YbuGpcx1r3pq2NPOfgtNggh5c=
X-Received: by 2002:a05:620a:4544:b0:8c5:2b63:2d21 with SMTP id af79cd13be357-8c6a67bf47bmr235713585a.88.1768532273843;
        Thu, 15 Jan 2026 18:57:53 -0800 (PST)
X-Received: by 2002:a05:620a:4544:b0:8c5:2b63:2d21 with SMTP id af79cd13be357-8c6a67bf47bmr235709585a.88.1768532273306;
        Thu, 15 Jan 2026 18:57:53 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384f85b8csm3334171fa.37.2026.01.15.18.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 18:57:51 -0800 (PST)
Date: Fri, 16 Jan 2026 04:57:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 04/14] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Message-ID: <jxnfzb442ii2ucbttlcu47emycxeqn2bvu5vi6xjdis77hkes7@tshuuiwv6fte>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
 <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
 <6db7a42e-7f12-499b-b36e-687ec93b2e62@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db7a42e-7f12-499b-b36e-687ec93b2e62@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: CqopEB_f6kWSrpfbYdQnVW3lRR_JBT-j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAyMyBTYWx0ZWRfXygzEKW06s9M9
 cRHt4JSFUM2RZFJrTWNwfZynnpNW3077A79tUVf+8TKnLvDmtaNYcZP1+J0tdKfpOV6ojBW3G9L
 UtqUwI5TznHHK5YYM94Bp51CnxdjdnyB8JWr6w7Nep2JOZU5gCmJIGhkRJNx5D6Kl5byVMB71TU
 kfo5vFwlUxXHpvHzEtuUmeSc4ZbAd9GgTOICh52ZM3eKVwgTFVzMsA31Hnjk37PMg1kMrKkgW2K
 p+S8VS58GNwBp/2Zdf/j3DPErHEHQoTIyHFD7YScpTRFnqi5X4exGI/R8XpD89aUBQ5Pp2e6jkr
 hJTQdZox8rsKqmp0CL77W6RurJsTGpIJyBlokLCvXoPTT4q4dba/PooXvzwoQHfUK48T5PnzOF2
 1guToMkCsJgSCcCnhSF26gHvaHkYswJMkgo8f/a+YeV5bEmjhV3WHMUhj3mVng8/dWatxxxlkZM
 k+3Gc4JIL8lh7k0nPCw==
X-Proofpoint-GUID: CqopEB_f6kWSrpfbYdQnVW3lRR_JBT-j
X-Authority-Analysis: v=2.4 cv=f5ZFxeyM c=1 sm=1 tr=0 ts=6969a932 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mLrUVEitaDHWRjaOxVAA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160023

On Thu, Jan 15, 2026 at 03:12:19PM -0800, Jeff Johnson wrote:
> On 1/5/2026 5:01 PM, Dmitry Baryshkov wrote:
> > @@ -1023,9 +1024,15 @@ static int ath10k_hw_power_on(struct ath10k *ar)
> >  
> >  	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
> >  
> > +	if (ar_snoc->pwrseq) {
> > +		ret = pwrseq_power_on(ar_snoc->pwrseq);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
> >  	if (ret)
> > -		return ret;
> > +		goto pwrseq_off;
> >  
> >  	ret = clk_bulk_prepare_enable(ar_snoc->num_clks, ar_snoc->clks);
> >  	if (ret)
> > @@ -1035,18 +1042,28 @@ static int ath10k_hw_power_on(struct ath10k *ar)
> >  
> >  vreg_off:
> >  	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
> > +pwrseq_off:
> > +	pwrseq_power_off(ar_snoc->pwrseq);
> 
> in this function you conditionally call pwrseq_power_on()
> but on error you unconditionally call pwrseq_power_off()
> 
> in the below function you conditionally call pwrseq_power_off()
> 
> so there is inconsistency.
> 
> note that both pwrseq_power_on() and pwrseq_power_off() handle a NULL
> pwrseq_desc so is there any reason to not just call both both functions
> unconditionally everywhere?

Indeed, it should not be necessary. I'll send a new iteration (and also
update the copyright).

> 
> > +
> >  	return ret;
> >  }
> >  
> >  static int ath10k_hw_power_off(struct ath10k *ar)
> >  {
> >  	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
> > +	int ret_seq = 0;
> > +	int ret_vreg;
> >  
> >  	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power off\n");
> >  
> >  	clk_bulk_disable_unprepare(ar_snoc->num_clks, ar_snoc->clks);
> >  
> > -	return regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
> > +	ret_vreg = regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
> > +
> > +	if (ar_snoc->pwrseq)
> > +		ret_seq = pwrseq_power_off(ar_snoc->pwrseq);
> > +
> > +	return ret_vreg ? : ret_seq;
> >  }
> >  
> >  static void ath10k_snoc_wlan_disable(struct ath10k *ar)

-- 
With best wishes
Dmitry

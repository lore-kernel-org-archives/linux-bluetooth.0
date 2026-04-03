Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46E9363C58
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775244758; cv=none; b=bujFBD1E+MZB2WFt5a4kRGr71G67iIESnkCTlMxXjGfc8WBKmTzy1vEVkwFJ8stidVqwjrFP/wOvS2YDSJaOJr9clmwiDmKSBw2h4/TjlC6/xDReqrm0P85HjZ7eAAipoUnjceBpAAWpeYaZ+2sjXzAIjG9LOl4ZTN7pEbbi1tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775244758; c=relaxed/simple;
	bh=rLBiThT6tmdqB3wRgoadCQfsJcjxkTpktBDsZA0y4hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxFhtISjkK7kPiQcFs9hBUa+H6sp+DQKzPbMJQvVk3yhmiprnBtYyqIi8PImg3rZgEaUj9aNqSShfpg1I54fhg7r88xA89NqNGI63Z41OSo2c3tBKzelIg2qgFMq30+myH4NMCcnS8i6xBK7cL4JMZo7qkjD94Ttw3TwKCmOJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OA9PLhXO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DPadb/yA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OA9PLhXO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DPadb/yA"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633B1dV21453232
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Apr 2026 19:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=miF4cwndo+UagGtGzMGwU83n
	O7jsT3rW3iUuyZWlKVU=; b=OA9PLhXO3sLjtUco54mVLdVYVzlsxNPFOMTCF0EO
	LJRNW37pUdeK16IzY+5UB9lxjbNEiKMZ255B9KWDEK9upEArlemlVA0pa66B+XC8
	AGZcVKTfoADssrX6+HIPdCfFPyK/RNSUPN2imTcGA79tcOEnMMd1eU8I7f9E5Ar4
	NUiaYfdQztTQvj4YOoVI1UCrfEowqctWrX1N3NOEa1e+5NqHf0usFgfwvSX+A/hN
	eWkYdlNx0HS+OxGZwwFa4wJ/xAutWhMcsrLTfVdxHoAlIvRItm8jFxYJ4KvQkAsS
	vTGVwQ092tJGGTF2D72fv9VKh3SuK6h53aMmNILvWsTpSA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dacam9ctm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 19:32:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b4076dc16so98084831cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775244755; x=1775849555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=miF4cwndo+UagGtGzMGwU83nO7jsT3rW3iUuyZWlKVU=;
        b=DPadb/yA9Yc/hOg4b3kXCZMsEqmkG95hur1+rLSvDHQ0SHaG2L5vPmfJd5NOMPTf26
         f57ILZQmRASMplepikC71Xfhf8MDssY5IvYqfG/INzVD3C/CJjRlsovydJsPggbS6l97
         GmgcV5jWSk5ToFW0OCo8be4pJcScamdOVVunIWEXSVDo0taBCVqfaxE+u9+0Fntw/y5y
         OJnr4F9/LKs5n+wwbCvXPlWfxJDWU9vSkDf3dUKNJgfuYSIzViyicBqqFL3uYLJ0us/m
         b+To1uqYDnd2xL4DfX6XW27D8a6FZd3HuaKnvOORlX9BSvbKsA3noDA1IW7uqhKZ+hAf
         3j4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775244755; x=1775849555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miF4cwndo+UagGtGzMGwU83nO7jsT3rW3iUuyZWlKVU=;
        b=EvOaI4/8mQcPHGcncqOF9qjAycKsUGHqV3Wb5iRLvCYw9y4w8ClaUhcO3N6yLkEGg+
         Nwms7fKFemQb3HXtFPRzR6id1tJPeQl9zNVqugHfvZTHJxNsbvoGFq62F9WLUbPl4zfb
         Nm9lQQtGrXGaG3oBBjXt1CvGbtvZH1MbSm2yvl4113jcBiMup7/x0Q2K4tSnuaQfZmrt
         4JD9B2RMKfHhZHln6fSUhtjptOfRJSVJ0GGaCoPGUJnv/0aWnFUVY0cn5tmVYMeKz3cw
         WUZ00Is2s166d2HoF3XtDzLahuvtwvMaNL+3dAD0A16lIq1hQF0GZ3KsOTzQLC1UYFVG
         iIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkaqcyEEhSMFV0Gs7cfStwPbCFr1GXECA3ZWpdkkqF4lXcq8COl8EAjBCsJCyBtueAejTMRfUsVYJ6Wd6n+jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4B1NjuHgLReaT6YpLX2+O4xhQPRJGftHMwmv3aVjibuP3sEb
	GMvt4GlwqmaGZuDA+tsBlh8Dnix6A1uc/gv28XhWPHIQNLByxAsqNB30ln3IZ6ZDTIpsvoWODZa
	ZJE6Q/kJI6+Wd/kbomP1UT9UZub10YyzqZN5QOBXsg8DEBoa1daSbQ0ow7qUooazpmjpDUik=
X-Gm-Gg: ATEYQzw0oymJcksVWPz6OiaoO7z6jQMwPKoyyqOu4hA+jj21y+gcUfORvr2hN0JnFn/
	cjtWM9v5GSLNKfVaAzqxu3uLjVf1dZiCC6KEogqEaXCJtUVbcVcYrFAKJWeSK8W0GT/q5M6hBa1
	ygtaXITphvQTi8HgAH520zxuAo7HdlVFS2AdqRETXTL08wI6X3S7PxqhRAa83Bzrs2zqDgnBXc9
	LamkDn8mfJ050bXTPVFGlZHzjsOEYwB95RUnWlJT2WOJMQ1Lp6kf4hotRxsaFPHuu5zozy203Kx
	aNnoYxj8keKzZWpeLI7k3q63ZgopsO3mHi8lT3sm97CnPgDqrzlYZzI5QV0/w5dEJT4S3Z3E6L/
	zfGLKatVwj1zi3GlL4jQMj5fkW4umyaqlolhnvQ+KbPehfPwqQZKD5SPPSdowNYtkMAV2Nx1Dz3
	2ZBaJh08SVsILP072I2IMLmqlTcEJJpNDnDp0=
X-Received: by 2002:a05:622a:4112:b0:50d:6e4b:d8f4 with SMTP id d75a77b69052e-50d6e4be7edmr33157591cf.21.1775244755205;
        Fri, 03 Apr 2026 12:32:35 -0700 (PDT)
X-Received: by 2002:a05:622a:4112:b0:50d:6e4b:d8f4 with SMTP id d75a77b69052e-50d6e4be7edmr33157031cf.21.1775244754737;
        Fri, 03 Apr 2026 12:32:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38cd1fa8a79sm14362611fa.1.2026.04.03.12.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:32:33 -0700 (PDT)
Date: Fri, 3 Apr 2026 22:32:31 +0300
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
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: milos: Split up uart11 pinctrl
Message-ID: <ep7xrcp5pvtcepq4wmiy7p2qal2qaupz3pae2cxopfnqwxqtij@ftzlldtpowdg>
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
 <20260403-milos-fp6-bt-wifi-v2-4-393322b27c5f@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-4-393322b27c5f@fairphone.com>
X-Proofpoint-GUID: 1wunSWrmErXaft40EgC8slGbbwivUJWK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE3NCBTYWx0ZWRfX0RNFQQ9aqE0Y
 xcbmH+ggq/j1UOWxVzC4PN9y8RtGSkShj0+YsFrMI9+uLd4yMEUoO05CZXr33pbM/smlCcOJCtl
 Q3xkQvMSeantwstAUMOFVWUkWfT4eWvImmfD3iO9845CejcZRLfx+PyvYrUXY0hqHQKR8EOLaj+
 SeKtnHyusixbkgWjN92DBHQ2E5ahdiXL7gsQYEcYdYM7nm81uQxzgk/aPn181L8QhGikwduDDad
 OtrMimcnMZzFUg4hoQmGDSvKSh/xWGwjJRTC696DlTlnk9ERhqJ3YWDW8LAhJaGBLjmdHPzkn1z
 2O5XDR4CpppQZvHdduDZHNWTfrALGdRZwjXLQvjyoAo3/38kdofbzuHN0GKgKAWyEQZS50CE0p0
 vKBltRt9ht3sf5nLFzDu0Yi5ph0uGRSD9FWwWYf4c91sKMDbYCfTQAbF6vHm1wnD5JEVnlEXn6y
 sN16wKgN4f0k4gzVWHg==
X-Proofpoint-ORIG-GUID: 1wunSWrmErXaft40EgC8slGbbwivUJWK
X-Authority-Analysis: v=2.4 cv=ULXQ3Sfy c=1 sm=1 tr=0 ts=69d015d3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=WCMWw2a6SM-JmIkApqcA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030174

On Fri, Apr 03, 2026 at 03:52:50PM +0200, Luca Weiss wrote:
> In order to set the pinctrl for the individual CTS, RTS, TX and RX pins,
> split up the pinctrl configuration into 4 nodes so that boards can set
> some properties separately.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/milos.dtsi | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEDF84A35
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771310096; cv=none; b=il2KF/9i9RtRtGy9ebCffEL7u47H8APR/alo51j/brvPcJST3mpgcC+xAQs/tc80C7Gj80Tfw70no3xXkh2LoV7qbrLGTrjsA9yRiP8hpkB50utObfgOTUx820Xem6V+Gl3IJRLqjzmTbRTuAqJZZQ//N/Xuk9MYuNECOL2fQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771310096; c=relaxed/simple;
	bh=JhPv1xXhO2rKgUpDxUD04mkBJ5HizP0NjDWHT9ofgRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXBJRg/VypNEmjOur6LKg/9yI/GzIT96oRZyE5V6S7u+V/L2lKydwgAf3U9LkD7/KZq2Yh14renlcEkxleEap2xFQ9pWORIPxITAfuH1HFiMP84Oy0P1CqOYDbnOijNsmo+rnl4+MiJ2/PW5Mpcx5WrIyCl8CN2hrmkrJGqkLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c7tzI6Zs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I2KvgxRA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c7tzI6Zs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I2KvgxRA"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GNvE9Y241227
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 06:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2XhnYVSOv0Bi71r+ikrHXy3C
	HaRUjxy1U7/+XGjaO6A=; b=c7tzI6Zsy21+B8kxhz5BjnfNufjBPo1oWJP0XwGi
	RN1bBbpC5Vnwdk0KpIMeV9uTGnxaVfXcbOWuiZ/BAhGlf8shSpqT5pNdI3DKW9xW
	hIeK/nqXSTYE0jl6+q3IGDAMhSODrPVJid00JImyHKjU0j5FNRJxo2lQDD6J1jbC
	/3HGNeUJwxBZ2HRfKd29Uu6LltSSwZmCoYVWaU62UHJ3QpqFAFaKrEq2UmLV3LU0
	cJdYwePKisNDHkKuphTmDjCiqkAEymNoV+Fr+WJaSBx1C2KHus+su7TCNfCrLoTm
	hjLM792JufYPMyZp9WgrhBF1rbLeTJMYw3qWBwfy8I1Hxw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc5kh9knf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 06:34:55 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-896f50f008eso122576686d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 22:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771310094; x=1771914894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XhnYVSOv0Bi71r+ikrHXy3CHaRUjxy1U7/+XGjaO6A=;
        b=I2KvgxRAt4eQ2xbN8vt0Dra6QobQ8i6E1C6SgMRmFtJFOBURZk3aSMkYu5V1kyOztH
         l9HcNStx6/bChMHGcNPwBNReL1RCihxiLalX5fzEFr1fvR+8XLeZBalBDmf8HPg3Hl7v
         e+oqRf+QhiKQfyg0x0JVNQeqkDQNft62zW8mJUm5trm33XV99gqsL0AllnGc3pUEz+K5
         4Ht7yYqEzDzMdmJtrZNOw81CUBqFuHRQKiNc4MY2dgvCiky/pN2iD6QX7p5I+D4+KRyv
         CQzQHUc1YUnHZlSmBd+qr6H9z3mh6bozDSWZXvibZbUmNQLRuMX0b1Ie+pUKYSUWpLd1
         iLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771310094; x=1771914894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XhnYVSOv0Bi71r+ikrHXy3CHaRUjxy1U7/+XGjaO6A=;
        b=eTn/MBJXtMHBHTnCus+h8Q8EnYtvP6gco1WAl0W8Yd8gf8L+yNBJawwiiNvFbVwFGW
         LLnHmOTtl2cNwmkJ0PabN1/pO3dxq4seySZOCvCFh2WWMABmKG1ydMvcUZRw/tdkHclc
         BJYvCBrpKb1SH0omgK4yFJ4P1t8KzMxULYGLGq2P4Uc1+pItaKfXN89oU+uwEOl1dUW0
         qda3KfH3qkgsxXExO2QE/ysZt9cdzvd9j4yJN+vCNGSwVo+f6I+5TJuiiteRSba83BWv
         K6JHxWpUGCwwU/lGhkO6M1ta/Il4ojhUt/lsVbXxUPOSER4VVKAwjgpYvTxEiHXtkmZf
         gYMw==
X-Forwarded-Encrypted: i=1; AJvYcCVonV0q1PkqAkMvHkmfcouP6EnVZsPss4dMoFtE0GDxY4KeSq9Fxy31L+jLhS42GWvSRV1k4sUmFttYjo/GxhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV501gsY4WMiu/L1BHk5MfhdWQsSI44FnqDhzZ6tkvYls0HJjB
	5dvgMQJh/tF6MRiLGjStWl/6sG/kL0Fe/ClmrQo55oHUIomxFZMqnTnHwT4ujsHwcL8s5oeTple
	6bOLBgllMDetuVEtWkZQhcu7eAorw5mKMDyuNTUek29iQ+XOZqsNTjlhH4vvEFt6HygBbB6E=
X-Gm-Gg: AZuq6aIbVbL/pmEwkCsZkTaVXXhiQuzAgQXQ5dDTJVxdEyCvQV+mzqzdiuwpRlmJbPv
	Bf3y3d2O4jIrhwmS74eLXGuUjLGKANPw++xBqxUNWZ+9A50VWWHsIWDdJEcPf7EG9MRDg7gSoGB
	yC0jZKl/o4Mn06z3SELiX0snXqnIrNp96Qn96LiIm0KNDwC7doJPv4tcRtUKkHki5NdThew9liX
	ZLs5PLVsWvsJM9EUCuPk2g9P6x2W56n3kBwnrUImT0fv2R4cQMZtVPP8Zuvq7HS26DP2L1YiV8C
	O2Rw+C6RpY10qgEC0OiJz1ONYWTmeyNbsTEC5CjYuRdHOaefWzLw0Y8zDhpNuXbZe3rMCaex42W
	m91CkEkqFfJxdOWS58qremPfb6FYUwy5KTMfCmYj9mxSrDNr+mGSQl3aWrW+3L5/Birv8DNkzcD
	L7yXXa4vB6wy1v3b0jK7hMuYZ7bvTgXHnQee0=
X-Received: by 2002:a05:620a:46a1:b0:8c6:a034:9225 with SMTP id af79cd13be357-8cb422bfef5mr1496098885a.35.1771310094127;
        Mon, 16 Feb 2026 22:34:54 -0800 (PST)
X-Received: by 2002:a05:620a:46a1:b0:8c6:a034:9225 with SMTP id af79cd13be357-8cb422bfef5mr1496097785a.35.1771310093687;
        Mon, 16 Feb 2026 22:34:53 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f56312csm3792271e87.6.2026.02.16.22.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 22:34:53 -0800 (PST)
Date: Tue, 17 Feb 2026 08:34:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, janaki.thota@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: bluetooth: qcom,qcc2072-bt: Split to
 separate schema
Message-ID: <xai73ei5ixb3qpp53cjvk2h4adlfo2zl7qglshup4pbeyh4fpi@ihdos4z6vsoo>
References: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
 <20260217054731.3058567-2-vivek.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217054731.3058567-2-vivek.sahu@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Coyys34D c=1 sm=1 tr=0 ts=69940c0f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=uJRx3kuxFX2Ebkl9aE8A:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: c5dvVKnZkubpoU7_3zTCt7fvdsoYPkx6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA1MiBTYWx0ZWRfX6RuUVSo0UUvs
 VQHMWv3aWIqRb3kLig5sJ1NLNQ9+6Cj1/N6+HZ04U98CV1hY6LWIfu0WOmFuuDF5T+0KKwtVqST
 QQmei5zV4HR9cKIPi8cbecZkMa5KCdp0FgxElDEu9gwfLGVDSeu1eG8I63BbJYUUGqvP61Tsme/
 H1G2iz+anfkZH/5VJwVVJOl4W+wZZOnAS3LyXRFSkxxqBDSAJ4mddKmla0pZAdVUF6O/g3Ogr/+
 N6Wp4gpw2yDY5FKBzvwd4YkyKXmxEl6Qh1w/gK7n2dDhKs5L1CU+UWWPF5gWRXVptf/jZ1jOTv2
 rRv3InrOHLZhDEY7ycFKvU+rbVAT2PG1OHOi9KRroS0jl87cHBchawbLBG0qc+b2bz/y5ATrfzV
 Sldpelq0qRWDbcmOuiChdTim/xunmbFs63RnMhS2V85YNYqveb/AcfkW0SGMGaApuaUrzb2n967
 mmbFqcpGrNRhmXLQwSw==
X-Proofpoint-ORIG-GUID: c5dvVKnZkubpoU7_3zTCt7fvdsoYPkx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170052

On Tue, Feb 17, 2026 at 11:17:30AM +0530, Vivek Sahu wrote:
> One big Qualcomm Bluetooth schema is hardly manageable: it lists all
> possible properties (19 supplies).  Split qcom,qcc2072-bt to separate
> bindings, so device schema will be easier to read/maintain and list only
> relevant properties.

How is it relevant to the commit? You are not splitting anything. You
are adding bindings for the new hardware.

> 
> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
> ---
>  .../net/bluetooth/qcom,qcc2072-bt.yaml        | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
> 

-- 
With best wishes
Dmitry

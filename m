Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ADE18859B
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 03:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773892307; cv=none; b=bNL2PF6SbJMFjIrzfq1pK0Y38Nv8piwwzV8v8yw1NPPTRq431C5whsM4a9VRknrx06eEkLBLs3w5WYLOb3t5amypS1mvrbLe2zvM6+nTAdVE+bm4gWcgCXXHXNBaJ7yBLmdXpFOIy1n5J/0do8zoohbyqY4w3LAzOaiq/0T2Sk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773892307; c=relaxed/simple;
	bh=+Aqfr2g3kKk+EnLVyITE8EbVgWCth8DpoXrPuCPoS6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm9ceTBlH/6bm9j0/mgMB2SSvEZcuf08qyBiN+irWy+XzLY0WKg0qTTNuY6sdpEK6P0uEbEg51Hqjos4WdHC/PpUm+sjFwNnZl5mT3O8405VOehYA563WTnsuufIpOWj256xYJ9KVeC2igRgIUDtpd81U5UmcFTImzm1tlW+kQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OSToykMk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jARyPCdH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OSToykMk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jARyPCdH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J103xB913711
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 03:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3W/YkzyHPozK/274pAC+gmeA
	pA7r7BpU9l9L27ky92w=; b=OSToykMkuC+7d2raqw3FkQ1pyF/0XqVRBavO7tMP
	X/jiwtfeYcw7rg8JHZddSPv8jDAqr8Gtuft/hnk3eV+o2rShaUApxF74ELE9TEFv
	mO6G65hSSIZ6/3awFoUgngBrRCnXzeCehbl63qk6fXct0363fYzKqjKX6JpGIUO6
	Ap57gnSNPHHwpUzYd1fz5HPlVpktjd0cCehlTxF+C4tgIxmrbhO+s8iqGtFBeWLM
	kem49VXFxz+B+zFwzjbPBCnM6hUeF03UitAxhtF7g4vgRjMWR7QqmFozVbocKCqJ
	D/f0LQaCZLzR3KMyH4AQn30GoqVBclHDakaKILEuJOnt+w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cytxytypv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 03:51:46 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5091327215dso26396221cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 20:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773892305; x=1774497105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3W/YkzyHPozK/274pAC+gmeApA7r7BpU9l9L27ky92w=;
        b=jARyPCdHOx+o4jwh3aB7X4a/J8xjLSPufWXhfaFMmluGMj1N/SbaK1CMwKKYWKpo7l
         hCuc9aYopotcvBf+HJguon+/9KoB6kVLXG2Pl4I1SOheNBGL6VDzD9QAjAKBCL688j9C
         PZWyBKRomIYxkCEixYT9YCMfgIUpGir6cohESQmpQCJNtfjN7cpY1MrPy8KAMbApTJng
         NdZaoQgejN9Cno1Ift/vP0EmD4VZRhufTuznmgH5nVBgw4sCY/3jCDWQwhvCUTkuNhKJ
         3Dbme1HdFSBPLlam5IOK8Hx85IEV64HnVGJGsfzx56WonjXSSNFJCYVf3CYQwjh+hxE5
         LHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773892305; x=1774497105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3W/YkzyHPozK/274pAC+gmeApA7r7BpU9l9L27ky92w=;
        b=MxMiKeW7IvCbYweZO85ppaou61bIxbO7FFnja2ja2IRm2V0hQeG3DWepIkfGFX4YIf
         ATZbrmLpO31rX2kiBXR0+2XoLMzJTdXkvDzlL/xvwofWfDiJw2dYRcZHCniY8a6qrDJY
         UlV14GxvnPZGmHJDpXTJf3jduMP/MpcbZwq6XsZJnGdqfZnMW3OM+Q0JiIK7KnDMNpgJ
         yys7Du9CTv73X7T5NgEQ8d77S92GbWK6OgzDRqi18r+cUvJc3XZufQMZQOaOYOfMw7bQ
         ivylDb2hAmh0BgkBnHfYN4AlyRcwMWTb95VWE1ZGTA/08RP5gdGemY8YGmBHNfIPgJLY
         Tixg==
X-Forwarded-Encrypted: i=1; AJvYcCV8OLTX2/KwZT0u/AABfUaCYFVFwIDRcc2uyNBdatzRD3EHaxj7SJUZ3n7X4E3T3ZtOqc1nW6TgvMAMjT1+fYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKsupYNOpUylTboYObgCFqWHuUeRtv8c2UBFVl+ZfA1iwxrobd
	M2eHptbwbwfK28ogz/FZ2OxjNAREJAFdzSyTzwMwwRhL3gvpUKxtT16sSBK5sRfOpYzqsdArIhh
	kyMIJoL0cWD7d7HTLU2YuWxhFJ4GlD+fFOOzhksRkQjaDYkfgH9L0fDdX01//NMRqej2u7UQ=
X-Gm-Gg: ATEYQzzY5cZFQ4SQipfCBVF5RG4s39R1hWquLqvEy/yC5jM3IIe77vRLT2jiYvR2NN/
	utnsIQFeNBVTyC/hjNzAnOW1QGY14WY68mhHBCOgCmZCa4uTggl0xBRdsltYtS94Uzd5o6uYYM2
	9mHgNVTwfkErdE9vUbaQjA8+Vn9JtwRK8CA3E9xqGXqQg0s+ZApoUhXvS45gHayxdj5O0BKdNt7
	1oXhyDeyIlz8qf6rmR2W7OR527msBBzcme0MO02JUNT9lX2nwUpiTGw5OHJNQLf4Zyyp6bc612P
	8PEWiR7sOvfQZuA47funROxkhGkCxNul4CtdNMx3b5vCwd4yoxX3JG9n7ObeQ36+93BHnbeeSG8
	G9Yu+IczY80k+yZsMUZM73n8IVqnyH6m5a8RmBljEGlfdBPvn/qAYPZdWvk9YeID4al4+Snuijm
	eVP9blILwuNz8nhaijeWcJdBSRgUMj4rjihMg=
X-Received: by 2002:a05:622a:1448:b0:509:1d55:6367 with SMTP id d75a77b69052e-50b1485e83amr74788621cf.36.1773892304794;
        Wed, 18 Mar 2026 20:51:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1448:b0:509:1d55:6367 with SMTP id d75a77b69052e-50b1485e83amr74788451cf.36.1773892304269;
        Wed, 18 Mar 2026 20:51:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a279c6e471sm948514e87.40.2026.03.18.20.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 20:51:41 -0700 (PDT)
Date: Thu, 19 Mar 2026 05:51:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v1] Bluetooth: hci_qca: disable power control for WCN7850
 when bt_en is not defined
Message-ID: <mcjloavd6jhinb2wgfwihsdtbay5n7zv52tn63kzrabcqwyp26@mh5aet76kl7t>
References: <20260319031040.4096297-1-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319031040.4096297-1-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-GUID: bg5OD7n0pqs5XfaXoaxDMYYK4Xu-8R5N
X-Authority-Analysis: v=2.4 cv=FKAWBuos c=1 sm=1 tr=0 ts=69bb72d2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=GxE_oxOnowU2S2JLwIsA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDAyNyBTYWx0ZWRfX2TDfaazAjY0Q
 Z7G6Au/LhOiGkAZh9XZzLUpnbq9HSLhsZ/dwu98buYqTgSxkXhkM/fDg6lTBffISGZVW8nVNTyC
 /lpW74z/txLj5UO6NDIJGsNcae5Gismq5N95zUZEkoeUib+kDoUn4gMDGApnzfB1uJHHbYBVNK/
 vctX6HS9FSLtZVfbXdzqHBeEPwn0PMxsMHfxGtB6O91p1ynE87T2DXbimUZMn32iXib8UQ3TuBK
 5qguHW4hJD+IWukzzJD/kmocols7PXi+pqnFbKurphgQnSEv2lHvQQQxGm13tXzWI6vSUOrt1Tw
 Kg5TfGjT61Uw4QOgFOnE9/wiaCkEy72KJJdmogfbK4Xt5Sbmannc5oVkuBFNxRtrcYJxaKgURLp
 YLEQuXuE4AUvzRWoKBgM3GAellbksaPCMVICe8HRSq05tuo1JjUnle28/t7FkmUbir4oowoHXNw
 SfOp2mvQTFITyCUcQVA==
X-Proofpoint-ORIG-GUID: bg5OD7n0pqs5XfaXoaxDMYYK4Xu-8R5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190027

On Thu, Mar 19, 2026 at 11:10:40AM +0800, Shuai Zhang wrote:
> For platforms where the bt_en GPIO is not defined, software-based power
> control should be disabled when power is managed by hardware.

What does it mean for this chip, managing the power in hardware?

> 
> Add QCA_WCN7850 to the existing condition so that power_ctrl_enabled is
> cleared when bt_en is absent, aligning its behavior with WCN6750 and
> WCN6855.
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index c17a462aef55..4512ff7cd0c0 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2484,7 +2484,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  
>  		if (!qcadev->bt_en &&
>  		    (data->soc_type == QCA_WCN6750 ||
> -		     data->soc_type == QCA_WCN6855))
> +		     data->soc_type == QCA_WCN6855 ||
> +		     data->soc_type == QCA_WCN7850))
>  			power_ctrl_enabled = false;
>  
>  		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB6217659
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668436; cv=none; b=jgRjdYVhxnG6cIrl3hvjuEAxSO3aWkeT8x/CJFfsNTURV3d5GA9bk9fk3FYj5jFU9g4M1sZ3VqZ1xm91nHp8mmHZkAC+p5H4x4LgZndSa6ZO+tWBLC1D9BiM1Dt+9OOkPR/jqQPudtw4T2O8SlHdrLP6Qc2uGhauBcrUgEZ+c2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668436; c=relaxed/simple;
	bh=AkyqsFj/353f8qUOmwkcq+4p7inrBYw+YVzicCTKBEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLsl1xyVBasAlQhXyfz2srI+/GerOiO+/QBXzjBPh+NmbYC6x76POb2SayP1Q6PpsJymBo6xDn0x7L43A/vbnJEFFanGmDqTXi2VT0nAJVIyUNVaObyGv5PrfkBd8xUXbNekAkR0pt4Gdqp9omwsOEAqYciFpZdN/xtjiCXW7qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PaiI0g5G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GWZU7Jja; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PaiI0g5G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GWZU7Jja"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nKVS3114925
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 03:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bPmu3vaz2euSVBGyYM6eqiMo
	5+5JlaIKTYry6nDmmyU=; b=PaiI0g5GdHLJkivSCEa7VsGmrudx1HJRBYgShFao
	ZBqS+RcF+9VBx7cy0jIUyXMuGgOJitI8igIDXbWPgdZgefjfUnw39iK8xQ7CGas2
	j+AA36qYuNkoILubUHjCyRaWps09iSqmOiNqsOcPiNsBK5itjyNbLZJnp5iC7feD
	ipOQSfjSarmD+zKguO0sZZUzRwjiR9+iUMr+LLhJLJluf5c/3sBnkSStpUvNXI6o
	v++nsM/HxbezDXHsmvazzK9Q815xWj3/ratbn4LVOE+urpW/uOgwaClcKfwhiwSJ
	fh0cYT3P1OA8pp46yvWrO2CwUNf+7aWH0cOX6+mMkd4C5w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgmnh8t62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 03:00:33 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a360b8086so14415436d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 19:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767668433; x=1768273233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPmu3vaz2euSVBGyYM6eqiMo5+5JlaIKTYry6nDmmyU=;
        b=GWZU7JjaiXXBc5pMZ7snpHSa3WxeSn/iasHxk1GvCimapgWbN/dxH3oKPr8oCVbins
         8YrkSI5+ZnG1iMp6JdL5clQOOlINUpCsbwGu2gn9VQWlHJlLBYpiqpp2RunhhVOsk1UC
         ggYqVZxH8bIDRZgy2xJPss+tQZM9ASl393kpTjOi5pQgz2r3fBjRu9960HGeekWJgVTo
         zbOYfwZsiTYEFoJwa0SUc7BrE/Iv2HuaRufYaT951f8BDDJYrFRLJkuI1ULvphsK4mdD
         VhLmbt2TBr99YLdK1ulfxx/v1CzjaV6RyeNhiaeqtnFI9BrIPkOpwFJ1BAipY79UmgSc
         hAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767668433; x=1768273233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPmu3vaz2euSVBGyYM6eqiMo5+5JlaIKTYry6nDmmyU=;
        b=otaTjynxivSfywfZNGj8STScyppGZnEHFWVAaRIlRLW+ycu3x40fqggQ/X6qxJhKbu
         7xnNLISmcJ2jTQpQiVCoGdntscBB4rxFL8ceiAEGZMywQ8zmFSMOSv+M4Vf1dKJI5yhX
         Yh8bzAPlo7zKAlW68wPP40/KqX5MDaigkVo6Q3ObeF0sp6nRBupWwnlYt5MdmiQQ5XuY
         aIpIlhc7/VPp1sY8+ZGGAF+Acuc7YopMSfve9Etvy17jxe2b3/oWyMHsUzLi1kR9ZtD8
         WOAujO1oOtls1gDFhrr6X7/OMyjmgJs1hH+4SYMGA6n/2ekPqPk7Y1nt6iVAlf2OYJQn
         l6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXguoUdxtbb88Q3Oxok7me9+mk2+ltaeLdld+y8tAmXu9ZJPNHMjkbaCjsG6MeNLyEAupoOuEKLToVhhgFMg2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/REtWExti2M99EgeuARkIDp102lfYIh4UlxPI7ClCWH88sj4I
	4mE4mnwjMuyVbUy/qvvsPJ9R5TlxedQYLl+BAYG4Mh027BPRS34Ax9/8Da9kxTnaM3t2vsyW/Xf
	0tVfih052fPD72KWwzh9SpTntHB8PG5TOg2AShCBux+wLiEjmqWjcWvL/2sHXR/i2Wayy7Zw=
X-Gm-Gg: AY/fxX6qqnySgCzIF0kSDOMAyaSYzyTFCgaANskfl4vTVCFJE7K0CV3yQr8jyLsuc7F
	s48pKNFs8cNm/ToG5baEb0ALn6A35+KufH0zCnoqLhbgziisD6D4kH8QdFxB/T1Al7oLJpl8Z8j
	8XGlL6VIur0Qcqh4/Nq3p10BEO/2LAnvEBjEbctalqya+W2DRHgMlVSZEmB7yD9F03eXCX7Q4HG
	Jn2enOFBeek4RJvIGE+0fc99ZUDmlNoHCxXUvY/RlmTXI15ne6PPFQfILB7582Yhs79YjrVF3wM
	zeEAtqGKZFSzSlcPeP7g0WYkqQuO79yj425Jvh1wvktPve56ivmOZetE6JbHmManK4PeaT2vUTv
	ctEX6cj3Ds6QW4nxwMdzkF4ceTcDc4T0zgE2vGhZE3FmrtLsBdmKL6IyLC3OgRnQNgtQ9E0da6R
	DXuv5bgIoaDx73sUp9GkEe69g=
X-Received: by 2002:a05:6214:2c02:b0:890:228a:9c00 with SMTP id 6a1803df08f44-89075d1746amr28050176d6.14.1767668432882;
        Mon, 05 Jan 2026 19:00:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWhbvoCGLB4gxx6npGV06Tvbj0CX2RWVt28+84RwZorO4AFluqfa1ljVdjge+giEjxY7RQ1g==
X-Received: by 2002:a05:6214:2c02:b0:890:228a:9c00 with SMTP id 6a1803df08f44-89075d1746amr28049646d6.14.1767668432258;
        Mon, 05 Jan 2026 19:00:32 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65b89842sm236043e87.0.2026.01.05.19.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 19:00:30 -0800 (PST)
Date: Tue, 6 Jan 2026 05:00:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v8 2/2] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
Message-ID: <k4xtx2yd2pzimnoi5tmkqv6dcrz7qikgv7dwa3ptp3owgc4qxe@5n2t4xbdqyie>
References: <20260106024806.480779-1-shuai.zhang@oss.qualcomm.com>
 <20260106024806.480779-3-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106024806.480779-3-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-GUID: JZWD_ErpIP2Vw5FVtaoJ1AFDXOszoLqJ
X-Proofpoint-ORIG-GUID: JZWD_ErpIP2Vw5FVtaoJ1AFDXOszoLqJ
X-Authority-Analysis: v=2.4 cv=Vscuwu2n c=1 sm=1 tr=0 ts=695c7ad1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=nHHXIsCO6AQyv1VF1mQA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAyNSBTYWx0ZWRfX+SPJlFsX6aRV
 oBZS++7YwUOhknNjLdhDzGKAZSWvEjfhsft5lvx1Cu0VtmbIbkq3qHi8VdNhYDzNjsCf4z3EHAy
 aNr+Akl5jM+fwu8XPhI2dNdeDYZEfxeSU9kSXynWsEwayvHTshXAb3R1qBAfaAIPRKvFagpQUUT
 X29s4AKbngfmE0TgOkbcxEprOIxk3hznoXMP3reBZM0OCNFhfvHfo1rL3QySSJaI6WlirO8E3CE
 DWO6T7EGr4bXWl4KQhNxao9uJaPPiYA6Fv7wd+7G0Ox7VcefvmFQFX42qvVXfrPfAb1gsSCgECr
 OGqAtySSnwHCEoFCpyX10Qshq7+/U6UOsLX7gzc08NJS2Jwyy2g6mKZ3HqOUIkmkQcJD94K6JEk
 X7h/Rc4BIGT6ExPMbOv+cr/QrvU2Y6IS3bZ23iWFZWac4zMJgX3kRen9TlM1nD7glOwzz5KLmsO
 RRwBdt+RpE/iov07Reg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060025

On Tue, Jan 06, 2026 at 10:48:06AM +0800, Shuai Zhang wrote:
> Historically, WCN685x and QCA2066 shared the same firmware files.
> Now, changes are planned for the firmware that will make it incompatible
> with QCA2066, so a new firmware name is required for WCN685x.
> 
> Test Steps:
>  - Boot device
>  - Check the BTFW loading status via dmesg
> 
> Sanity pass and Test Log:
> QCA Downloading qca/wcnhpbftfw21.tlv
> Direct firmware load for qca/wcnhpbftfw21.tlv failed with error -2
> QCA Downloading qca/hpbftfw21.tlv
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

You've lost my tag, but no, I won't review the patch again.

-- 
With best wishes
Dmitry

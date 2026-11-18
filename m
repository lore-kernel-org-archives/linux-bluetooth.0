Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795010166;
	b=bHM5qsJ9KAzr0Q4rbten8K7TgJfy0+rz8/V2BRZ+lodvTEjreqcqE/mDg6n7pYf6NJLV
	 HW6v+oXVcihvNcObx25K8jM6V0fLfCaTJviJLemY4dtvZqXriuk7FQ2G/Qg02TY43bIGT
	 tA4bMZaFlqP0d5f9rlNcGATviJwNSPq3LG6UcPs3p7GUcDyu9tl7HsyAtXIyQWuIGRpTu
	 6NiIVV3kSItOcffArNzU6FcvfjQxomvZzJ/71I2JDNGcciEWnF/GpZCd+q6ATcLAZBMyd
	 reZM8C9/TbVPafIwZR3JQXFysxdlkqa4Tp4dyK7qzB0DZES6EoCEEhg/6RB34tsXWhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010166;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+M/mVoNgd24/u3erUknt3BRBqjOOmARFcn4tY8lzAAk=;
	b=lVtpeEN7HhJwWz0+JqqBCgJgStKGq1Gl2spMrG9EO82drcGKhaxxu6cP4KuL78Of75lQ
	 2oKUJnOlX0n5RsqEhEowYDXIH1Ny8RPeRqwd7R4u9s8SJplpM111e7tEl+saBTE+fLqCv
	 tqbj214sbRuMz6ocpU5WtMHubaRqH3J/zexYfT+upVj262jfC+JEG6GbtcU/ay+UciCYh
	 CoDx5+tvT0X65fkaeTBB7QEyavaFa2wAVvg8sE71eP7bupcAQU/c9qcLDQKRU8XlNJO56
	 we9ZwQTiH7Tjm0mWBxW/FZyx2EAvOuG3UKlBNfKYeWZawX2LWMieHJA9vBmNIqsEu2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nliv5tDJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MWTSqLy0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5126606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 13:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5126606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nliv5tDJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MWTSqLy0
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQ9WT2225983
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 13:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+M/mVoNgd24/u3erUknt3BRB
	qjOOmARFcn4tY8lzAAk=; b=Nliv5tDJG5sJhnO9K/ccvpMiq8JenueCiqB9EUPI
	Tr2JefRt57dpEYMA5qlDgakkG+enis9tiS1IFWeF1g7un+7AQCxtpCJwYS59z8Lw
	Y3WC/lEGYOL9X/YjJUE6u6ULQV4+AZ+qwQK7l/PwJgxIwgaEBNrfZtNxFM+Ae0RD
	vykbzcM+R9p9iUvdOCRneU2NMO3sRVt47+LstAQ7cZh6FphFV4yd/QAdhtLjHTe6
	bWIvwToV26yQJKKYd6uvYQAYOvLsZ3KvgUnJH/wF/ZefHBTsv+Dj9kSYW3QDKcSC
	Qq2Mnfp69+WYHzghoTpm1IjbL9y4QcZwuEJXrGDNR7WTYA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvbb8mv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 13:56:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b08aee6b3eso935743a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 05:56:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795010164; cv=none;
        d=google.com; s=arc-20260327;
        b=JDpKgA35CiP+8HMyY/n2DguXlKAm/XTz4iSI9VFpAu9wJZAHdO+V3rSt5l28DjKjUA
         egVDbm07ZwEiggyXnMRgslGf6wyv21a85h+NtjLiFegj49TLkL9GX6JbwE3652EsxrOD
         yH/8vc13LIdpuSaYFqEJKwjL2VR1RNL4lb20SWVQt7GOZ/4CQIGQh9zO53N+qoL6FINy
         hHIBYcT73Po5Qf4YThta9i0RAgP9m7hqdbVO2CMcOIoXMsduEg36kuM8qX+V8gsH9emJ
         zTlKGJXKbtqQwj/RvlqMymym5e4UdfP94sFJmWnCrxQ9myX7mq3zI+nD/zhb6aqDNmjV
         aIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+M/mVoNgd24/u3erUknt3BRBqjOOmARFcn4tY8lzAAk=;
        fh=Z4V6s8WYzGaBBiSYdfL74x55wecY7z8o3HQs+cjFwzY=;
        b=TLbuo1CVy/HVjzkPOzzsF/Z2nwEgAcYtfeOkm0xVTL1CQ1VGg17djYhol52cPFm4wG
         akuJMpxl68nduCsg8yWxS4ym8FPr+40r35Is/h1N6xn7iLkTcA6ceFoyriZ37l8vAhb1
         zUXa9y57tIybePU+74H7U/8UA1tToNfmuxirqKrEDk9xPc+tBrr5ABNmMuJlWvxlWBSe
         +TS5OO8kYojIh58tP5cWwyt0L4RxfyG8PNFdOqGeC6LL3iBFX/wGAUMPrYl722nLaWP1
         WioSlTHuu2E3n1AHh9jrEAZyFe30u6mtbgqb7IBeO63lGxWI4GjlwCBJSejlSuFnp4Ax
         zdFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795010164; x=1795614964; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+M/mVoNgd24/u3erUknt3BRBqjOOmARFcn4tY8lzAAk=;
        b=MWTSqLy0lCB24cr/Qb5S9xSmhJBb9bU/3/L2UwYv0u5qs7Jo6TLO5C4w37monj0XKD
         PBj88emEc9xRAmDkhtZLWLz3vNI/lTzseHyRK3ELTUIq05F8tEEhL45WLON2X7ebeE+s
         uJ79rBj87dlFb9eRqMZQ1mVueqHvEJ12+n4Z4KjEdvZ8dnnQKkpMWerrC5Ad8MIyYNN4
         nCrAUgtOjW8DW3tST7xVzZ6+2ewkW6YGZx1l/nT9mjO1O2C/hIpJ5x308p4Yk8sugvAa
         b8JaIL0VdT6x7d6a9N+cJnsVDbIo+zAaoIxGqtQXmbktDZOLW6IAOJaIhZNCyhAOnUsz
         jjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010164; x=1795614964;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+M/mVoNgd24/u3erUknt3BRBqjOOmARFcn4tY8lzAAk=;
        b=gIBc53k57g025dfhKFfzOoqnIiOOfwgzVyxR1zSNtvtRqmi6sNsnSc6jMhm7dHcP6a
         pV+XFRg5ov/oPGyalC3nPRQTo6WFBEithLPwOPrqUDbR5WcxbImW9ZHB+w1uezSxk55+
         XOqbcjefVzraYhftjQrCjSYuIopg37Lp8CoPkLg0PqPpZ/KF6exOgqJwuXRO+544PRuF
         JxWe58VuOQFoq/33jH+jV6RPS6meCD6CJQq6gLAzBgPtpFsdxNr+MzwnRxbAxmFa0Cjr
         7uPJrh0gD6GhOFXB3JzSlhODMRcd79y6nLFJhFpi3Equ1hbdMHsX3oU2H5yk4CCClvGO
         rMLA==
X-Forwarded-Encrypted: i=1; AL+hErHeQdsESaAmxVECdBqn/MdG/fal1GsH1i8DagVR/Wu6m7tfr2XYO2szAdp5PrkVKX6oLcEg5m8fHlns7jWg7ew=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pEVRj6ytRUjPcBqcg6BLWZ2VFVKZFSmTnI4HjmFs0tZT+DmaW
	KgRD4N8+kLHsX4ioevt6tefZtRpNAFecPH4YsyzREA8J1DyWZZDe7pnYDl4JAiYC9H+cm3UpCFV
	QizdWctaqG6jnv+0HZ/ICwSK4NIQExYWVTexv90rH8DpPc6HUpGBPsmGWlwb+D3x9fwgw/JrfQK
	U+/jEyYFVP76fp3qGAjkGq8+Egcmz3H2tvhT7uOBswLvHNVle8bcGvNp6X
X-Gm-Gg: AZFdTZdSyB64M0L115xsXcqK47o631kX4cB5k2cDrK5iEGAd6mq6VJZqq+QO+nHzO9B
	AvaCTIy4FTrFoWWG4qVOVwsbV9UlLJ4FVNZEVQx97BI0jaHCAOwAKzL3A7R1BH2OE7Y1gWfBhe3
	xUIX8bvrDFBLPw3B0zQVYHXgTc84wPazwfZWrGO9QWpCmESTaYBmMLhw==
X-Received: by 2002:a17:90b:17ca:b0:3ac:9772:8da3 with SMTP id 98e67ed59e1d1-3b3d0765d40mr2571667a91.31.1795010164071;
        Wed, 18 Nov 2026 05:56:04 -0800 (PST)
X-Received: by 2002:a17:90b:17ca:b0:3ac:9772:8da3 with SMTP id
 98e67ed59e1d1-3b3d0765d40mr2571643a91.31.1795010163479; Wed, 18 Nov 2026
 05:56:03 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <680aeb35-74d2-478a-a1da-4d70983b7431@oss.qualcomm.com>
In-Reply-To: <680aeb35-74d2-478a-a1da-4d70983b7431@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 14:55:52 +0100
X-Gm-Features: AclHuK-lW07UCrKTUn_Yy3xa8rksP2okQnUgkwD1J2iUMd5qOmHH7e4tjD-y5Us
Message-ID: <CAO9ioeVJcPKjpq1rtVTS5JwCGi0aSZd+srPFNSbdrUzyBO1Gng@mail.gmail.com>
Subject: Re: [GIT PULL v2] Bluetooth: btusb: Update Qualcomm QCC2072 and
 WCN685x 2.0 firmware
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: linux-firmware@kernel.org, Josh Boyer <jwboyer@kernel.org>,
        Zijun Hu <zijun_hu@icloud.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: JzpsC1g1ReE2P-kMPn39lXn9saiSoWsc
X-Proofpoint-ORIG-GUID: JzpsC1g1ReE2P-kMPn39lXn9saiSoWsc
X-Authority-Analysis: v=2.4 cv=YfgodARf c=1 sm=1 tr=0 ts=6afdae74 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8
 a=wjw7POpTTtnhsxlADrUA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NSBTYWx0ZWRfX8T5pYrWfRJQw
 17cHBYG90dLJ+ygKmmPxeofLCUtevijgBydgOLZLqZkbJMLR4GiVBDLfhmsV4/YaHbXDvKgSbbG
 TyjEBnHJURkEQUMtZDRQlgS7kDo6exs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NSBTYWx0ZWRfX3NTvnfheD/nP
 gjSl+qpIsmQ7W1ligwUsiVEeO9oLNCZq3RzGMY2hcrXJZlSlchddJstsh1RY0VFbR4Gw7+SxOtC
 q0Y4YK+mZHgMPKAhds4aVVkuZqZvIny8+JzvumPyYC+PBI9f7BUvy5w2YqP58IZgsoqZgZfWOY1
 xfkZKw5ISLNLw7/kF8rPbM6s3Gc39X8nYkThEvH8ffOUPdb1u5rcpp3PMHHl1MPjpoLr+YMiE6A
 OfySkX2JRtRGwbfOdMyF82ufaXdg/SOz8CQ5WkbUhdkR7mXXxp5ZcIwmeRyJ8qfuMsEqiexiEAQ
 Kde++sO2b6g5wmQrYOdnm3dTFnnF6pIb7JmtqP+SoDMYf/2YSpdAbocCB++vG5CN78jUlLoZwW5
 BGTIZ9oEmOotaELfLMXsaVoMvi977f9i3o2uPq1/tRI4y1S8XXE20eALozCXTxy4CtryNABpS6a
 nzsLUwST/rr0cEzlNEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180055

On Tue, 17 Nov 2026 at 12:53, Zijun Hu <zijun.hu@oss.qualcomm.com> wrote:
>
> Hi linux-firmware maintainers,
>
> This is v2 of the pull request for Qualcomm USB Bluetooth firmware
> updates for QCC2072 and WCN685x 2.0.
>
> Changes since v1:
>   - QCC2072 BT: keep the ORNE.1.1.0.c1 line and update to
>     ORNE.1.1.0.c1-00038, instead of switching to ORNE.1.1.0-00391.
>   - Pull from the new repository https://github.com/zijuhu/qcom_btfw.
>     Please ignore v1.

Merged and pushed out:
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/1386



-- 
With best wishes
Dmitry

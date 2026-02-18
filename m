Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA042329E69
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771423033; cv=none; b=AXoQkSTpmZN3YPd488kGBcSlT33Du1CtGk+Zvnyr2CGR6zJuGYBzdwobI7TCqVnLSo93HckUU7QO2ZHQK8rDkPYFPdmxtWTvX4kiUReGLa2rcmK7BrmeGEZFVj28tUHbrShx1r4NF3cg5SWvC/Cr/CMfJwDVIv7IWl8KSWTSD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771423033; c=relaxed/simple;
	bh=MSzPACKbUGQEvNgIeWCQPkVoVNEssZNKauJSrQVB8gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5hWrnVPItV5ctxDANeJr04iE1cSfl0ycr/djjuWGeqticasPKl01eWKoNaSMgqQdHWVviaERpilfCNpANXd+jbD31UsrteTX+uIyuaLlMoPrsALzRwidCGzB24WS6n/qOIIVA9wQhxT6Mr3VaiMaOQWl9VvHOGlavtOGM6KNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GtviEALU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cb119fED; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GtviEALU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cb119fED"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I8XAAg3379848
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 13:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BmSkQ1H6aF1fRqkgmk8wrB44
	msStnb43Uv/ZPNl/kHk=; b=GtviEALU5hVWxDOMLiNJEAjteqENi7x/viXkyZsm
	vRg/1TiD+X24stBEochHNKmLOyh+EArMjD7f0ybujDFHzIs9AnE1gErPIZrrNWIg
	kaTP/E/JMGRbJH99Nk8F9/9QfQDhvxwfHNV/guNDqW9tSKEesvf3IzbD2ZYVeIhg
	zmvbOJ7P1HPTBcXApAKB6SZAECKXoDLFu91oj4GL+tdCT5o2so84zOWoIPtVi2hk
	sKsHQaU4AeSIzDj7uefjAtzCyqYif3gq3hzibjrRAgReDLQNS0zrN4snhJKK47sE
	3oyths0mabHbFCttcS3N65p8yuJVGmg79K+4zRIOQTRl6w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccxnyjhxt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 13:57:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70b6a5821so3026907885a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 05:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771423030; x=1772027830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmSkQ1H6aF1fRqkgmk8wrB44msStnb43Uv/ZPNl/kHk=;
        b=Cb119fEDeQFoXUnCGg/ZalZKHGQLibk7UEw8DxgtS7bJ4KIWNtwdPMcEYeXP2uNeo9
         ggnIqHIeEpdkD95ENKyGNk/aZpA7UOdrFoGDx7b2HcXbjR2HidVcO5myf4+ehZ2pPQMb
         oy9ks+a1v30M+JszUZZYw80dS5tW08xujISE6sEUuWYMnzbyn0MGhHz1Ezxm9e+VdXnk
         Nw3m8VXGWeWaI/7LiiIEyso3w/6zpWxt7sDQ7w4t7ImJEEjD+Wc09/MKzKQBFkTg/02j
         QXKHOmcIjVdKFmd8PPRjrqmmC1GKR6jADL/D9P0JXrbcDHv3/ygFf9MmOEoyYHYK/Gju
         cjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771423030; x=1772027830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmSkQ1H6aF1fRqkgmk8wrB44msStnb43Uv/ZPNl/kHk=;
        b=GzkD/nHHOHMIVdu3iBOmQPZGfpwlFZ9jpcPoBvV8LXwl1PZH0uq2JmqNxeJEH4RvtC
         cQ41LnMqdoNeGDDLA7fsI8A6EnxOtqiOop7IQMP9BjNnBm/IctWs59tX4weyYKZX4Rh9
         FYKSjhw4QukjFUu21/N8lAhg5fVQ3li/UNS4kQJHa/cZiOr45EWEOPJTjFp+ebubNhVN
         KNqiO6Kmsq22AikJc2+sPevPu7P9Jeqx8/tfeWzE77MPUYyAOd1P3EzPpHY8eJG/ECH8
         RnVvgWMJqFzB0LiMUHI1TCviUEPjt8+Ae6Rs8IG+d3u33j0iAIC+DdTq42jU/peCmSmY
         8CYg==
X-Forwarded-Encrypted: i=1; AJvYcCWuWfgVrgizfGwF2AiNMeIQwtWNAemr7DZREUhUWJzaLYNxtIjPB6ROhoyFrINn25ElNTDcVdKvYN974Fv+r3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTKfjlJ5tyaCaINJOlvCnpFJE011hYUMXvTmE+pWWE6noqZwk
	D+hRxBTtW304p1Qu1rZpVg/JhSUEZtwfW/6SrNFHzcKtnzForoVtylHW3J1I8o9VjDzCfc8DprY
	qPWMch9khkeFJ4QBcDrzcf83DsmFgdFdeTWMZdkD/vXiSNDcxY3YLZqBcXCAvf/+IjkhnIhg=
X-Gm-Gg: AZuq6aJ0OxaD0Q6XFh7+xwrRpGVvjtSBGyzelbLjkIIaG/RRHF9iqSOvJJLS3Ms1V+Y
	dlWwv2AVbtmKcf8bPVHC2pM7y8oicVWr751o3iyPsYvVJT2dwWVRwZrJutBFrurwQ8mcbKv45xz
	EP2BCvcXQFnnjagYm/Hc29tYyG4bQyu/GL4t5yJk0/ez+iUthpKIqHC3a5Y8gFuXyxlE+V6GNHa
	+4aaL6DmMKTveOZ3HMm8ey1F72TYewCFT5FcEqr6HcfjPBLkkbOEnu8yF/p89RSB8OBHbwzIksU
	7yxyh9PDrbafteUb4hpJ7WbFst3benPl63zkCBOqG5cG8k8N05viCUGAZ6WOWj4V0lt5E8hzm0/
	TYvv6fpoQjLwikem8SAvRgniMv3d3dw5iSzDvw1k9uDe0qYzL8Qb3eZslXAbWdPuk+gkAs25Gd/
	9E/UvrTccxI036fuVbuwFrmzTHI8EzuisFN5s=
X-Received: by 2002:a05:620a:1908:b0:8ca:2cf9:819a with SMTP id af79cd13be357-8cb7406d603mr203931285a.40.1771423030056;
        Wed, 18 Feb 2026 05:57:10 -0800 (PST)
X-Received: by 2002:a05:620a:1908:b0:8ca:2cf9:819a with SMTP id af79cd13be357-8cb7406d603mr203927785a.40.1771423029534;
        Wed, 18 Feb 2026 05:57:09 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5a50cdsm4587769e87.58.2026.02.18.05.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 05:57:08 -0800 (PST)
Date: Wed, 18 Feb 2026 15:57:07 +0200
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
Subject: Re: [PATCH v5 2/2] Bluetooth: qca: add QCC2072 support
Message-ID: <ekjymc3he772uxqcwailweeso56uoz754o2kmf2vgtfjmvyy3l@dw3kqu7hnda5>
References: <20260218114955.3970974-1-vivek.sahu@oss.qualcomm.com>
 <20260218114955.3970974-3-vivek.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218114955.3970974-3-vivek.sahu@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: bSqXZ4llBfZyQX1PNpiNSIupzXeUF7OJ
X-Authority-Analysis: v=2.4 cv=Do5bOW/+ c=1 sm=1 tr=0 ts=6995c537 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=EK0TE1-zV21SCmVBFFsA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: bSqXZ4llBfZyQX1PNpiNSIupzXeUF7OJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDExOCBTYWx0ZWRfX9Kj64ZEAZz9V
 LdzbV1KVXfvllF0b4VWcHR9kjn9hD5AhG+kR07M/E7PTKs3r5jPQ/E4j78IJlYoQm2npPgzLthP
 YMrboSenYC2LyeQtBZDMl6xRI2/3KECMcJkusegXptCKgmqHCvxgo8h1/3JXWlRW1p8e+pd5ULx
 45F2P2JHCtGfeaD3i7GmuT8UbE7vBvJSJ8ZRupzBzH5qpQ16IrUJZLuOaRK4mXqDM9tyBRbYFK3
 bcurMEcc9PO24zATSXCnZ9ziVkDx7Ur4GVgnL+sSCy8+nocQYLnhARKWSbaJt83RSOstt8PzfPA
 ss9wV8OonYcPgPS2f9d0MxV8u1gbH46cOLDZSgKZuSV+Mr7Iptqmhh8bDBghMgkit0C5L+CjJxF
 H5h5w+f/0ARY5bMRPWvsa8oAa7n57ae/RKrZ+5gWerp0RZB5ZvZ7en9FwtuVCIO4dB3K/ecDQA6
 GgNblhQ5XgJv8p0zQGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180118

On Wed, Feb 18, 2026 at 05:19:55PM +0530, Vivek Sahu wrote:
> QCC2072 is a family of WiFi/BT connectivity chip.
> It requires different firmware files and has different
> configurations , so add it as a separate SoC type.
> 
> The firmware for these chips has been recently added to the
> linux-firmware repository and will be a part of the upcoming
> release.
> 
> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c   |  8 ++++++++
>  drivers/bluetooth/btqca.h   |  1 +
>  drivers/bluetooth/hci_qca.c | 18 ++++++++++++++++++
>  3 files changed, 27 insertions(+)
> 

Provided that supplies for the device are going to be handled by the
power sequencer.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE23911B5
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142231; cv=none; b=j+WHqezEyCc3Rn1n81ZFCaZWe3A7HdtOa1QT5Z/nzfe0qPCqe89AmxljtuWP9JLgfK0SHoYM/jNnrZp1BD57HZxJDuFzJSEcgKGPBVcJsdzweUBv66KJPz7lyD8wOzNyqJO1dMtC2uBSpDSZcLrh8QfhbeDs3MClfkmENWBbgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142231; c=relaxed/simple;
	bh=08X7YJvg9i/BpzdLdTFU7Kq7fC0sAhUviX9de8/X4xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMygflxjKrynBMkEMrEkO82aLg9bN8zTJiF5mGE4wmOH2cMhEsbsSBT0rW+IJSqUUQUAS1L3JDYCT7w7bDJMp4G5kXc39fsv69TvsBA08mzuAZTMfipHKN67wrkYuiypjffmfKioUCr6orCTo2kssQlhmV/s4gjs1ytlbUf9oEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nq5BQIe5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UzbXWT+8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nq5BQIe5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UzbXWT+8"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDFxZs3535705
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 15:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eRDXGhrS4KlOfatb4u0Gk4jO
	jeixzy2pPP9MyC3S/2o=; b=Nq5BQIe5Pw4du82ugRlqLzSFJKJLSnBDk0hsySsU
	NLBYHxUDii894Z3awYb4QOwKOmFZhEy1qBhcxsxc66EdT7bApIncZf6GJk91Asxr
	OGcc2SMqEj0RloxOReaBRWkJLGYVV2W1LkTBNZUvhye8sFMQrTMRFTqYv2c0T3X5
	CYMdM+d/TDewsDM0As0usxTibO8TH4VJkIsLOFW3H+ZD0pieBW540DB+m78lhrgp
	vC11n0Zj5vtnduw2mUrR+uS3YcY0ZObmDYs5T/wh4V+jbwwmGhMqMhobhuwukmir
	12tuc7f8Khb7zB4sGcHnSXfO9NDkCyNf2ZMivop50IKplQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yhs4vr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 15:30:29 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-48656ba24fdso8094230b6e.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782142229; x=1782747029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRDXGhrS4KlOfatb4u0Gk4jOjeixzy2pPP9MyC3S/2o=;
        b=UzbXWT+85q1NVC+cVhvf//tc7ulNwK59cTXoNoodxJ76ngAz/QFesQxB5jEzeDoxaL
         F73WxNhkXv2EfmoR4HwHOdK9dHgRAUTgiNnmWQidxnOBWBPF64Z4ISaEArP+2usOgG+T
         pT4tb3WvWFIDrbOMQMsPfTwaaqWJJB6Cf+suADS/68aRrmV4TGfebqgiiUSyLGJ1ThP3
         XPWKzrg8wklLlZD8LcMVikLt4px2VTzOpOEQmdAN6LBx4pG6N1s4UkW01tVdLID68WjN
         cZnp8+F602QD0xlOFm5+KGFb95plXd0HrczPvs1xSwH6M4dp8YglfzeKalKfahRMTXPa
         XLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142229; x=1782747029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRDXGhrS4KlOfatb4u0Gk4jOjeixzy2pPP9MyC3S/2o=;
        b=iTcN5g6aSEcW5cB/gyBEUeOiy1zLT3Lr4lrOef6hjfXEMTB3JoiYXZRankDGtvTDVF
         kr2nkUgCHqyV9+uGoeAgO2r7CFl9+uASecNiartpgH6ra+leGid+rA/arCA6aOLwKKo6
         qFVeiEjcSLjR02rGDy7dlYtVgHgQF24AVVILdIgDILB1ofYC6Ry2GCCXnCQa439Okiyv
         ehZVJqF5t1tPPCvXuaO5QMSffsboGratkN+xD8Yr0QdDcWM6HaYyR4E25BqTVI01vkGz
         KyWdtxXbcWEu4QDZV1lpo1gg9P7Cwrjnwf+I0VeVHNmelXMYVqsNp5ptSPO32dl+lM4D
         WNmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1HXJBlFjoAzkJV/eHpPbfr5EyP0AjTVJAeeuKAWsOKf90Rb+rk8k9t7qOhBvRCbN3VyzRpbB1eTp21eHIMGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+CS2hIKhYEOOc2/906LP2v2GtoGYyV64Wt5sX1RRpUXfKysO1
	6HnDurtbZJHEQ+GzWxngy/+AfqukBcZt1isV76MKBX24KrhPxBhtEOziAW0rqlfDAGxJbARdLqD
	RtQdvCsGY761oab+4rMBpuczeEDFQJAngOe5lnslMLGUxa5Gi1X7JfxPGLOFeWcP0pwey32Y=
X-Gm-Gg: AfdE7ck49ugVJUsaBkBgerIqf0FSx04J1XbPbU1XCpiXP+YwMuvoJLqKxqSu4Xt3HDN
	JOLtiQ4YIUUj4IuM+J2FdCyFEhngI5zuvwKn+Xo23lGCH2++aUSgpv4oXrVhEQ19n3ByAj48hv1
	g8sdMDzUSzDr/+O/JiJ9EQDfwX9c/IzuFMm9zrUFMw8onm1OzxasLovwnbzGIdjb36LwbCXFs2I
	s3cKWIQju/Sz8vvl3krx6EjpACcXR8Dkwa9jVnhFXFAR6aEFP/bVjeH9rW79l1/1+t8YJYULKky
	diYkoK7QvDHxoS+45or1EClSg5WpFn8jqpaeRq4k5bcxVWm5E6OgFtIQN/K4UzL5faA+l/6COZ+
	PSyNb00iXxeR6jAZhn1bmHwRzGUPBcM3x5pG9iZYD6YyJG2nVeyHbzmGi1tW9ZB1bxYGN5S22BC
	277MKLV6R8U62N401zLihmd5dW
X-Received: by 2002:a05:6808:c1f7:b0:489:443d:a8ed with SMTP id 5614622812f47-4896ac4a91amr13345148b6e.32.1782142229149;
        Mon, 22 Jun 2026 08:30:29 -0700 (PDT)
X-Received: by 2002:a05:6808:c1f7:b0:489:443d:a8ed with SMTP id 5614622812f47-4896ac4a91amr13345129b6e.32.1782142228684;
        Mon, 22 Jun 2026 08:30:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69555981sm3020e87.34.2026.06.22.08.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:30:27 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:30:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 01/13] Bluetooth: btusb: Initialize @priv_size at
 declaration in btusb_probe()
Message-ID: <xzps6lqo2k2w2onzleg4baycsnzsejiwhhefilk5rt5e547u6y@orl7l3yklhuh>
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
 <20260622-bt_bugfix-v1-1-11f936d84e72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-bt_bugfix-v1-1-11f936d84e72@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1MyBTYWx0ZWRfX9r/yJH+486M4
 dYqZQ+GK+0QwqLZLQS+nw0RpBzz8STZQs79h5FiQ7KsY6FBl1ad4yCtzr7IChw8gYF6Rl1Fkiot
 8Iqfj7cqLDjVIuyKZV/pmjhBsFQ4aSo=
X-Proofpoint-ORIG-GUID: JlcZ-Cof1UjCuIjvhPU6MzORTNP8iGTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1MyBTYWx0ZWRfXxRdzVQYYcyaW
 YNMBRZDjs/tPKmdIZbu5gPA2SQZTZLyeV56exoDWgjZ0Tn7P8x9bwGNELjpJVdOhBOv2O74TZEA
 7FAkhq+uu2kv/10a7+SUQZ3V6kHOUA3yE5UggBa065rEAwaxRKqva0Dt1DkGmgIRgon0OS3Xisi
 JDSDJGaYHE10ch5wZ13czvm/Qf23aelV9s94VgkbIlQXlMy/zJQQWo77RwXJgxK9FJciDi3AayV
 A87AfAD2cKiOOv7/Cp7/plO0gTbs91MYGbcanRduoFD8odC19vt8IuojBV8X6anfLt6fTf6P2vo
 zx8BopF+JW9TOlM9ZnbwCZMHxhwVgPFArpnetI/80hQxKFFK+63NwH5rbmerRlBi3jViZdxYn0p
 iOhs7qTTsB4X9QFCuHLFQt1s8nLT9LOlFKfczY4WfJ79sdXpIZlCI+Q9OZPf2Fm4X9bOJCJaIqV
 +V8Xuo12kc4amqEg2Yg==
X-Proofpoint-GUID: JlcZ-Cof1UjCuIjvhPU6MzORTNP8iGTR
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a395515 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=31voSE5pb1OKvNjBS4kA:9 a=CjuIK1q_8ugA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220153

On Mon, Jun 22, 2026 at 07:52:14AM -0700, Zijun Hu wrote:
> Initialize @priv_size at declaration to reduce a redundant assignment.

This is obvious from the commit. Please tell us, why?

> 
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 7f14ce96319b..5209e2418493 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4082,7 +4082,7 @@ static int btusb_probe(struct usb_interface *intf,
>  	struct btusb_data *data;
>  	struct hci_dev *hdev;
>  	unsigned ifnum_base;
> -	int err, priv_size;
> +	int err, priv_size = 0;
>  
>  	BT_DBG("intf %p id %p", intf, id);
>  
> @@ -4152,8 +4152,6 @@ static int btusb_probe(struct usb_interface *intf,
>  	init_usb_anchor(&data->ctrl_anchor);
>  	spin_lock_init(&data->rxlock);
>  
> -	priv_size = 0;
> -
>  	data->recv_event = hci_recv_frame;
>  	data->recv_bulk = btusb_recv_bulk;
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8592236FD
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665882; cv=none; b=Tq0zoIAqSv7j41eoxTgMMjO6B4tbos4dFN3qosGGP2qxn5qm25ONNQztdhOex24cG4h4ih+kiQts4Q5cKl9ap4aKGxg2rQv9JiBHhbjoOI4JAl35hwTx0R7FFRw+JhcshprwdUWqoLb/J5UsEOEpf79ad1p891fWsvNYxn3A1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665882; c=relaxed/simple;
	bh=n2fg2/Af5GpewttNT49HB3aoRxw1yXTxo9EYF+Jtyq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTLPOlNhkcVHcq2VL84mGYcQPXS+eOeyBziJul38zFhmhmM/fdtxtiRkMKez3R4lZMp8cAczQWpWCmBAldmBwPh1bNoq72pxl0KvyVwYDqy4yz1nHd3TF2msv5C3n/W0FF5BAg/Tm6baMwuOLnkQGaCpL7OlShdwPL1a1bYpanc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=APOXoJRr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TXPES1KZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="APOXoJRr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TXPES1KZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060oFrx2530740
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 02:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V/hqyfw1+JhGgX5FOIOJy9NP
	Z6e81TYUvrn6tJG4ijU=; b=APOXoJRrm/kcx6e3vqTpwbrtznqZyWHCijksdVau
	YMaAeloxbg5HsUUjrcu9GCX3/kOlvrFbwkwTEjT/WRKFiRSadodBw6kc7uIU8BI5
	h4CQJ5WchtKVRZzTeWffVGga+EHO2F2304LX/9+d1Uvx4yukgoyzQ1lonZLZWEju
	y9QNYQV+w+YHFQCDL0NCOPwO4mfWI4lWkjgIZ99WkeNu2pKRLtGZmKGFowLJXAYS
	p8WCbv3SGs9Y5mZi2CX+OAY0qpmNfLQ1jR0ot69sqiZAdc7p+mL3rnIzO+OWE2io
	Lky5K0YtVl5uTqnjkKR+yoUwvTiMIpVxt567RETvsrpvXg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgaus2gx3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 02:18:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88a360b8096so13374086d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 18:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767665879; x=1768270679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V/hqyfw1+JhGgX5FOIOJy9NPZ6e81TYUvrn6tJG4ijU=;
        b=TXPES1KZTLkmebROpNjlC9w2MbMt3B5HhJiDsZOuOpYF7741YgNfiite0lVT1Sqi25
         KKJ0DDxW0BQRS20Kaf/YubEJHRRAdU/FWT6SJYnjqQMlceC/UHMzbsyEd4yepNi6vg1g
         Zt7CXrU1gQ12yYrVykTjtIRfF50/5zU13BOpsqbN29Qee6wBTdYe3dzEmTqliLmr1I3n
         +vMltYQHHfBrTh4qJ0Z6+MJD6X8jXmrUNrlCwCOl/oJRxQ+at0RDcDN118y0Cebm3yqo
         af/psRZY70ofuiZs7P4kmkKuQH257gLmMcv0uTA3GLknBu/BgReomxQDWCuTyy6qHXup
         OjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767665879; x=1768270679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/hqyfw1+JhGgX5FOIOJy9NPZ6e81TYUvrn6tJG4ijU=;
        b=WoX1xkZJX34Q/RUjxevno/iA3MH6n7K259WoMnU3KVxC3jmCEHDoOSfsKnhQIUM/38
         ouGnm3U1De9mfzGQcz/RO4BiApaCx3gislEppXF1dF7NDhclEK2n4xwMF09M03lZosVB
         nbMC5V3YS4k4joqGTnh6kT9TkXazkNUcii4hjm0eUsm1kSWsBUkxG6yKdMkg+SutmdJW
         5HQZkeYmKcUtLDEmJJQQwqTPuh3diAyxoezk9IuwOMt66yRBze4csyvut+S06A3yGWzd
         o3fUiD7aDMdxEOVeISInLajnHAols8/Cj8/hzkir7Fbi3iTu7nz/aySPAmxsumSy2dUy
         MqiA==
X-Forwarded-Encrypted: i=1; AJvYcCXcpkrDX/ppI4X07BBFNTKVkiOPy+6ewmU1w1R6G6A4ShvAb+NLAqYYRsZCTL77a8l/Tld+y9I0A7rZ+cc/ERg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7oiVsQG6jN+9ocfGK4oK0xvBFHYwfyvNaFmMjdLphV3Rke2p5
	Wy18MA+gvGzpVwP9i4LmTN4zHx0GkemoZEzySi4CW1SPvLxlOY1BVPiH2C0Hox1VbizqNjLHBYX
	+AUjupbLQ6A0LrsVoU2WLHVj+oQbyQWK/mc7R8RCLp3xjSe5VfBBtgZIO8KhxXzYoX/K3qhIKmS
	JfFnA=
X-Gm-Gg: AY/fxX6SJTNHBkOM3TdfgXuMvIaE/bYV7jG02R8JUB6GITOVeCcG0pIEyY6xa4TrPRc
	5hUVIoN3NQA0r6vgQObHWNz17pwWrIIX4XLiAjjb69qTVEc1FeufB2/BM5IQwCSy1uA+yX+DsQm
	Xn/YIXfIhpsm3Io/pc6Iy/SGRFKecpZ0RRetmLGEPKzVcX0wrA2oX+stbmxzmBBuP6WmJxxyodf
	cBVXelyx2+FA6elv+xoym1MJ4Nea08HUpeLwXGd2ZZx5C3+RLRMBazRdjVNkf4mR+Uizl16g46g
	T3SLEdqy3HhggTRFmhbn5zwB9snn66CM6pcHm/1YsgmqQsEo9HNsdlfT9O+b/BTiCRHMe39FtqZ
	YQzyAHzEoO5TEmfIwXOD64inXMha8XeVnfasAiqjYj3bZ3YmMz6YRItP/QNIi1Bv67nd1ruiRRS
	Qb9ZVz0kRGrg+M5RjwN74+tzM=
X-Received: by 2002:ad4:4ea1:0:b0:880:6647:1031 with SMTP id 6a1803df08f44-89075e19183mr24409336d6.1.1767665878825;
        Mon, 05 Jan 2026 18:17:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXJQ29cnUdZqNNihnuRfmFbbTDe57nwdLlHFaOCjefwB0lyfwIqKCf3VB6Z4++v2nlPJUrZQ==
X-Received: by 2002:ad4:4ea1:0:b0:880:6647:1031 with SMTP id 6a1803df08f44-89075e19183mr24409056d6.1.1767665878380;
        Mon, 05 Jan 2026 18:17:58 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d6973asm208846e87.74.2026.01.05.18.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 18:17:56 -0800 (PST)
Date: Tue, 6 Jan 2026 04:17:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v7 1/1] Bluetooth: btqca: move WCN7850 workaround to the
 caller
Message-ID: <gmmij4bch672mxj4uhws4oeeb5r24p3gciwykrtmhgrq3o4soe@wg776m6ixy54>
References: <20260106020738.466321-1-shuai.zhang@oss.qualcomm.com>
 <20260106020738.466321-2-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106020738.466321-2-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 1EvI_3ayp95JQL-_dOrnEJMgt4s6zUzU
X-Authority-Analysis: v=2.4 cv=DP6CIiNb c=1 sm=1 tr=0 ts=695c70d8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YWdG3P-n8oS0mWOsiswA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 1EvI_3ayp95JQL-_dOrnEJMgt4s6zUzU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAxOCBTYWx0ZWRfX+LGljDohyAEB
 ff8XUxskxI4IyyeFv3i4q/c0Fcc9OkuRK2UQnvbovwzbiXFHHEhCRzTxvRqTeZ088kwtjh85Xx5
 FJFHxuD1tTyTTNANZ+WOJ+3JOilJX+Zvi/HLe+VzXel2MZp6uekR5HAut9uTkTQf/dYcdQ4B+DO
 ABDyoFJdtKzpIxLjgx+7RYP4QhaqPRu1HEG7+01vq+UwVDOcyORyduAYNtrLS6KCnevUV6fNxoK
 qo1xAipdn7K1W6sMoQVnm6ZwUtylrM/e4liHud8vei3mUHY3gEAgfaKZhaWXo/3Ek6UoVu+LOoA
 xfMYeoSgAiH+5vYw4MHn6OvyOWcy+3hu7Z8aFNqlIo8hzRwSa5JQJe7i9aZdmoGD9EO9jrE68Do
 iIvApLZwh/ZjXmQkOOvHwgQ/hsAqI5Y4PUfFKMnfZTON7bZbLkXNOykmHDBBmb3/LYB8fEzTDKT
 QX5c7ss7HBY1HP0Jl+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060018

On Tue, Jan 06, 2026 at 10:07:38AM +0800, Shuai Zhang wrote:
> WCN7850 will first attempt to use ELF_TYPE_PATCH,
> and if that fails, it will fall back to TLV_TYPE_PATCH.
> 
> To code uniformity, move WCN7850 workaround to the caller.
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

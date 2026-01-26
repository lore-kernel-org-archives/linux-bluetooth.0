Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBAE34A790
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449889; cv=none; b=s1CbzSCB0x8I7uLKZrVJY6Z0O5S5hJpJ7vz0r+It2rs8wy0kewdD7LIE2K8QjBz8Bsm6Gn/RpCEKCG4TQZ0wMPyLL6kb5ZJkV3zoRZIiSCCkN5Lpr0ugKxguKEoFRRvBT7oFIq3bMJLqHnRzaJ1T5rXMnPzjcK0y+WHqJ/Jsj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449889; c=relaxed/simple;
	bh=sfqtl8D5xrQwgPJwYKBJ/0KVH5pLAReiRdToQe8LN9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWhY1BjQb5V/9RMJVfHEEZKtq4YuGaSx0h/Hy6aYpfIP6sy26wVAncEbRYYvIJLQ0UginiJcdJ6NUyAireV+XQBYxgih5wq1vUom8z5KOBlEf27XAHaiJqpeA4gdJZKvIhsGevuM4uCRg6N+b21FGhC6z/H9vEwLTXwndTqppBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gEtuQKM5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YidvFfRQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gEtuQKM5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YidvFfRQ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q8HtUj631548
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 17:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rLTjF8XCejQy6c+mku4HCCaH
	acMMJvRoqeKvF7cseFs=; b=gEtuQKM5EjTN8RtRN7CohRurRdeETLCERWUreVYr
	QPLwx4+8bOsDVYMjSnwl8jpZUO3G5x/J0UforIRcupQTRzJrTAtqOUsoH9nGspx6
	Hj7t/se0B/rVEsYDd4hhxazhUx8jSVv4HuE+ry0pTa5WnHdzvcgR9MdkS9OVP6q2
	92z9BRVRIrLm5+4FL/C82FKzmJFUKyHFwZglnuw1RvOugvWfYIGavcoVsTKYIdqU
	AX9H/3j8+dS1wU7UkpAXcQcoEXE+xW2qTlUSvpd4vpxZLoIB6SmYYi1pbGZaxYr+
	KiyLFtmyBbzj/X2mAIf7UGboA1KJlJ60zyGlVUOxqrMHQQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvwtycudt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 17:51:27 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-93f65d0a94eso6677029241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769449887; x=1770054687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLTjF8XCejQy6c+mku4HCCaHacMMJvRoqeKvF7cseFs=;
        b=YidvFfRQwTHS1g/BKpIsrM71KEIV7O9Xn6ORJ74EzQFbOZwk+ZT5XzILflv4AHRByI
         nFpLis7dlh/73+MS1iKOt+QuRjpfd6QHdGgZx+Kxj18ZFJ+7+3bqSqq2WV6dkTxQTN5p
         TghjrIjpwi/fKn9SRM9m0spXXW1DfqSI7yoSF2xxbceMQJBgh/FQTdiqgVy8e//lXj4e
         CYG8ngS2EVrH7/6p6rSlFoBAdIQsPySApTNQy8276frifBOGhWCW+i4P9tK/Rk+IXUti
         uAc24fwBh6sZDssw37PGBcxwU57qSIpD3wT44ByPJuMqH1JQGUBFKdSZPi7eqelMGuTg
         esew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769449887; x=1770054687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLTjF8XCejQy6c+mku4HCCaHacMMJvRoqeKvF7cseFs=;
        b=gmpCffTC7DxMYCTy6YIohxRim0MlphEyK3HUsVLu1Qc6Ri/vMFHCJRsFsS/WArncVZ
         FI4uZam2eOm0v0SfoyitNjg498Xs8dDcHM97ygxuhXNC4peZah8Szm6SRrqPr4A74dGS
         jXPevH/GeFiHH+TzQRrkzb11KUPrNnB5xRKCrU58KpsP1zKTrVt93b6PXwCoZDWkBcXh
         BmqCwGUh+vdH2qX21Hup0zHKhzs7FvjTtop/m6YDkaS2iclBHPzFC1yXJssbUr14CXcM
         eam2d0x9ITC3+JkTBYAF9K7puIhTHMCmompNGzic/HHQSlRHTGf/rdVow8WyzcatnbxR
         tLvA==
X-Forwarded-Encrypted: i=1; AJvYcCU8eBe0AKvEM0Sp8VRdjeBR0QACQuFDrJa7BIZlBtOgaUckvO/03hUgoefG/v+Ay1C/P+weCmPF+jSFVdiIAXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKT8iBkBz+kh1G7ZeQzP9B27cSuFkmMDhQ8yxe+JNIFZO7ddKr
	y/j/7vHhg3/nT8fMcLD5Na+CESbdrsKcji0mfqHwLOI8T6fHRhmlSEpoPicG253Tc/ZYOhWVwWw
	8SVIN0+wUz8DFW7Y57yhUwxM1uIz5QB4zE5SNjpN/bfLRjB1DyhFdJOMcyY44hMOUkLDrAKo=
X-Gm-Gg: AZuq6aI23mZzkHJQNPXlUkgrOrEly+FsmzuUAHw8YPpwPVLz+qWxs3ANlHKfR5+blsn
	HhiVja5/lZqk2OodhgYFavxREmZO6rZP0xaXWA8jC4rfNnBz3SAp7nztrk5FN69mfl80O9h0QKt
	7JXDujh4kpy+AUh9alNVitTHmDlrUdFun6lHzysdohauhFSSXMoSPsiLs+nkhOQMpNjUFNQ4tPO
	RJB+EE7h3bMzOehGyz0kynFJPyJ7ki+4GUWyECrzL3z6dILh0vSJhSKQGm7E7jiw2EQJ8WYvJ7D
	mkmVJX8V/hgBmUUlmBdhxCsfltE9Gso7I9eDoK7Tbj5byiaAmCbBA2BNvJtnl6Nz+02lCCh9exR
	ne2UF2IRGiYbOQ1rbyD2UV/5XNrY+WF/vFMDdGpmPvDBBir5J5ajFUX4w1bq1tO0EJ4YeAMMEVV
	FVD/mJ/a6VfLu+YIHKs5T8BOc=
X-Received: by 2002:a05:6102:511e:b0:5f5:4d65:9b05 with SMTP id ada2fe7eead31-5f5762cbf44mr1305308137.4.1769449886505;
        Mon, 26 Jan 2026 09:51:26 -0800 (PST)
X-Received: by 2002:a05:6102:511e:b0:5f5:4d65:9b05 with SMTP id ada2fe7eead31-5f5762cbf44mr1305296137.4.1769449885947;
        Mon, 26 Jan 2026 09:51:25 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48df61asm2844187e87.12.2026.01.26.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:51:25 -0800 (PST)
Date: Mon, 26 Jan 2026 19:51:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_qca: Enable HFP hardware offload
 for WCN6855
Message-ID: <kej5u2hjxjtfdzmgtebns3amz7gmb5d2nciy45jsyglkprgh6s@kt6fodrc3oll>
References: <20260126162444.4194293-1-mengshi.wu@oss.qualcomm.com>
 <20260126162444.4194293-3-mengshi.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126162444.4194293-3-mengshi.wu@oss.qualcomm.com>
X-Proofpoint-GUID: 11nhMk5noXAs3ax9HoaN99hezpXr6x3E
X-Authority-Analysis: v=2.4 cv=BteQAIX5 c=1 sm=1 tr=0 ts=6977a99f cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KNAojhBsoh0SNi9vREEA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: 11nhMk5noXAs3ax9HoaN99hezpXr6x3E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE1MiBTYWx0ZWRfX2UVBy3AlXW2R
 VxOPvNu7ZYk8WcNZTnwDQj8C4CGvGgcSXIcvgJRxXJg1kJ0esoIu+adiLjSQnokVL0QAxJOo7bM
 FZAzj90i+xspB65ODZCqlLsygOfDauQZc4+FTteBl24Few3dKgCJuvLnbBtZ87sJtovLbmdmFFb
 2YoGNokeYAHBffwWo/HY3IQkOAjWGhLJUNlD5dEJusZuzm9dR3PLa+HwzOQuUGckRNTwluKpzAr
 HpysyHa/UILW9ariQUI4Cd7Lu36YIo+fw6rsmzluXb/flsnmpkfnxT1xV9YSe0aC9JkLqzrePWx
 qe+7hj1aAiDpb9UXPfunAZYPjFfdj95bL2FJg+IxRl8MwhLR2oMICpR3UsfY0Kh3EEdosYPwMdH
 IKpWJOIkjj43C7+YRj2s5P/KOtq7exiTVLQqogNMts+GDQwBBj5RpXccV74CuqPdEGyefsZBnvo
 /MQoWOtTGxyTh1cCFLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260152

On Tue, Jan 27, 2026 at 12:24:44AM +0800, Mengshi Wu wrote:
> Add QCA_CAP_HFP_HW_OFFLOAD capability flag to WCN6855 device
> data structures to enable Hands-Free Profile (HFP) hardware
> offload support on these Qualcomm Bluetooth chipsets.
> 
> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Any other chips which would benefit from this flag? If you are setting
it for WCN6855, I'd assume that it also applies to WCN7850. Should it be
set for WCN6750?

-- 
With best wishes
Dmitry

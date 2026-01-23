Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034719C553
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196394; cv=none; b=BYjCEP+X7XDZTNWwo0GiEVE2TrkApS25MYzAnubldZ9DPB3/ela8uLgNsvRViDfzN1qIbXEGImkqgLRMa3rOgEfO4ZcqLmdupmalr9J63+d13yFXHddh+zW4i1E+T5k+UUsNrfatS7Kx1QQcPyPIMxHC1n4Kk0324BqLViA78nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196394; c=relaxed/simple;
	bh=wXE7Z9OCOw7weTySTvgeTgXcpN/s9+IKG4Ms2kxtKgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NST0s1Q5q1dJnDi4Dk8G4eHUapb0zm4dT1x+Roxob92EGyZMh3dLCPnOuJZRHpMio2IkMsJTgsgGmmpmNiBooqrKR63jqDtlab3ggmWpR81MdU8CiFn6Pahwfkq1yHGM/I6OcSQThzZKqAo+xJ5uX/wymExNI6372QbwfW2ZNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DTAtQ9Qh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K1p4nl82; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DTAtQ9Qh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K1p4nl82"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NFUqPb1848614
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 19:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=e8hAKZySqTcQnkl20vjocL4c
	PvHjCgdXva8j6wqimVs=; b=DTAtQ9Qh3K3QMM2wjQuH63PLe83q+2UMFztd8i48
	qDT0On5W9qYeQAigOs5Jo3kAwXCWZwLQ1fZSRcwdCJZam5OhvunXEiPpH323gZzp
	SfqkYvTiYU+ezt72vmKoffEjEEz9yq9KUcQ24FHI1T7CdRNvuzz7T9WGQ94XiVPB
	jRcT+0j+WWSCC6Ld/q4OypCteux/ELBB5O9GLxFMvPAbIxWN63wTHIEa97A/uib0
	dGFpSX7i6YoYUcWIF7CLQUMR2kKh4YvtN1Fa2jXxBiX9UQPFGzHabM+DCX12MQHi
	mcbS07lqni+rw8bsTFziU5n093tVZcfwp7Q2/3pHqTdV4g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvbpn0q3c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 19:26:32 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94804733b9aso5885065241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769196392; x=1769801192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8hAKZySqTcQnkl20vjocL4cPvHjCgdXva8j6wqimVs=;
        b=K1p4nl826Esa3TUIGkdnO8E3qclCniCdQXdQVZi6NzeGJ5o44MwsN5fs1R3gSpe1yd
         OSK4f+Xggbw94I3UOvb37I1UEaZ/Wby/jyp2GOiK2o/jU2wiLxcb+rkqz0JZpAetrL89
         NTUxTv8C6cxtLLJnGsG+fVDnfIqoFp4/feV6shcesr4en41AakOUYR9cIo6o4rokZ47a
         gv1umZcK5AC47AL3iXpx6TmuJgDTmDvVMLePLwbbS8F9toMje8bApOSjE4E1TyqjJB4r
         Pg1E99OSEqfGO2faw+PSnp4jFxKrmKFtdQLGp8ZVYW6UjFKwykvsRq/4OYJ8cCMrHVln
         WY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769196392; x=1769801192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8hAKZySqTcQnkl20vjocL4cPvHjCgdXva8j6wqimVs=;
        b=fpU5L04YQxPQS8YVyrXuvsJi6Q7UussXv9tI7qUwgIgvKDO0f1h6U8VtclhukUej2t
         ObQWFZ0UEL0f5DVmLt3NYVEqAJEWBMIdWBtyDUjhofUu+AHC6y4IgeQ469PQl/jFCuTW
         zaX+3psLgi092BIQHSliF4jK/nrX3lMSycyFxs4Yf/wnUWQg/+GL1zlLByc4oNq19iq8
         5JkbgqN6gvHMEx1OJinfP8MZqI2gMeFqH96bMYOXPri3QjjDGOgwdYRaPYZdQFapibLQ
         0atHPDOSpCES/F2v+FmiBo6j+ZNxx5TP2SYEQHui1ZFsrPNY3neISP4OQzcXPHBqVk+g
         zG5A==
X-Forwarded-Encrypted: i=1; AJvYcCWHKt3/IhuknxrprqSkcn4F5cDkJhwirKF/5NG7IojteC0fw6bj8LjHsZHxQwrHoKX1vkqoVh/9S1PN23wrMxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmuzSfLdWb0HS/ypyr6TscFFJ8DgunQsslls/8cXV0/korTn3
	VGBQaWBxijG5fwhtDBcbnVCavnTLSd+79sua7xRgGhLg9pEFf5+Yps9cQkl/PqXAMTd6ND2TH2u
	/o5OPeyn8XXmLLKPoAZlEW8CseudD6w1BX5QoMgTJraXrZcJKyMA4Kl+CRCSO+Ik+NPVRhCE=
X-Gm-Gg: AZuq6aLuAqXVLwXObFdq/pBYeBcpTHdK7aroUzGsXbiSMmEqqxncbStV78569/8Mtuf
	M5GlvN3Sr8kTE3aNGPxRtmTNXCyMArLoZ8iBs0xYkzHuFgG45w6T8yV+3PtiS4jdZuI4NckSGte
	nTA4bnJMVPDCXmR09Mlrur8Mlcpn8wX1Wd9ixA32U+sX4e9vGMD5Q2aSLxWa6sM5WNabcVMEnjD
	o6Dz7/ky7ymQ1NKO0/sH45VZCYkqSA/rNq3zXOt3RCOLkxo2ARIn3c1iOjcnW2DTJkZSyIf9Xmh
	bEBR9oCxsfV3bFmBDoOtJvSPTEpyURJ2QNq75448FMbSYO3CQim2I18eOAxpcJfEu2Ywt1QE9DW
	xMJjdOoPLFJ32duSSPikvNIUxpn3+wOU9jJk7swnVf2rtVGW8VaZijL9fuRTBvu5n/3fPve3WWk
	oid9mrZFp9bcP4XZQSyfcQGb8=
X-Received: by 2002:a05:6102:3046:b0:5ef:a3b1:3012 with SMTP id ada2fe7eead31-5f54bc6454cmr1355862137.24.1769196391845;
        Fri, 23 Jan 2026 11:26:31 -0800 (PST)
X-Received: by 2002:a05:6102:3046:b0:5ef:a3b1:3012 with SMTP id ada2fe7eead31-5f54bc6454cmr1355835137.24.1769196391265;
        Fri, 23 Jan 2026 11:26:31 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de492782asm848942e87.88.2026.01.23.11.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:26:29 -0800 (PST)
Date: Fri, 23 Jan 2026 21:26:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_qca: Refactor HFP hardware offload
 capability handling
Message-ID: <mt4j2cxliqkwbeprt7ye2kt2cgi2bjfnz2knfgxvy7fy6wda3p@jadb7x7ocagi>
References: <20260123055243.2634107-1-mengshi.wu@oss.qualcomm.com>
 <20260123055243.2634107-2-mengshi.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123055243.2634107-2-mengshi.wu@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Ku-T5234XEojMfI7Dh3w--QrLsJoksog
X-Proofpoint-GUID: Ku-T5234XEojMfI7Dh3w--QrLsJoksog
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE0OSBTYWx0ZWRfX6x7gZWlXeIvd
 MQcRJX1oU0nR6BY/KRTFjyovzuLEqlzZtWILWCChHO04c4XzHtBh8tmJD4juQHCkQyjZlX/705R
 4pNfQJefPqhQHOI4MlTBooisZCWClkbQiBwjov+G3hilCnLouAVs8qv86k3YQOqEIu0+Yb6pr5q
 zeEjb+hyhVqRfzd3S8uPVgTeL0nE/j/trLUjzKwvFeuOPxMIsgKLE+qIWE2VRjqJWgYgDrH+OiT
 xX8ZWxua7+Jm4D+OPGygV8JUN1v7Aqb1gN2b4V0oeZSeUy6iLZn8HZyuxVSLPOuYRYKRiVVPjYp
 CGJf0Qr9z9ajU0kiL2UIQI2XSpWiMN/dSLmooxg9P2Mn5tVEASXFCaSSNEldr3DtKg9dLFWEoXd
 A+81idQTk9LLrTwX/4NEEZ1NuaEeI31WtGrpCs7J+up0kdpTtPaZauC3OxFWD3FZAG051BmE9R8
 p11YgTXXqfDkAhFuOQQ==
X-Authority-Analysis: v=2.4 cv=P9M3RyAu c=1 sm=1 tr=0 ts=6973cb68 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VGE6h4fSrwVDp8RXrTgA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230149

On Fri, Jan 23, 2026 at 01:52:42PM +0800, Mengshi Wu wrote:
> Replace SoC-specific check with capability-based approach for HFP
> hardware offload configuration. Add QCA_CAP_HFP_HW_OFFLOAD capability
> flag and support_hfp_hw_offload field to qca_serdev structure.
> 
> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> @@ -2033,7 +2034,7 @@ static int qca_setup(struct hci_uart *hu)
>  	else
>  		hu->hdev->set_bdaddr = qca_set_bdaddr;
>  
> -	if (soc_type == QCA_QCA2066)
> +	if (qcadev->support_hfp_hw_offload)

At this point QCA2066 becomes broken until the next commit. This is not
a proper way to do things. At the very least, squash the first chunk of
your next commit into this patch.

>  		qca_configure_hfp_offload(hdev);
>  
>  	qca->fw_version = le16_to_cpu(ver.patch_ver);
> @@ -2502,6 +2503,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  
>  		if (!(data->capabilities & QCA_CAP_VALID_LE_STATES))
>  			hci_set_quirk(hdev, HCI_QUIRK_BROKEN_LE_STATES);
> +
> +		if (data->capabilities & QCA_CAP_HFP_HW_OFFLOAD)
> +			qcadev->support_hfp_hw_offload = true;
>  	}
>  
>  	return 0;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

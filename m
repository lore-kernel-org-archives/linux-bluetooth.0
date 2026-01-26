Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3BD330669
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449787; cv=none; b=MQxkud7hjCd5Mzb6g3n3AhwDR1XrFmfSms5Xd7Z/LkteQVMpQ/d/FOF1fJFlNYY24Koh2m1s3THAk7KeUEqSmxTReC2XTmJpMgFmd7zEmKaFwEa/BIQoMP7BaLJasEoQUoU3U64zj0nC09IRKdsZVzvY6oF8UtPNPnbdJqDIYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449787; c=relaxed/simple;
	bh=qvYeO5CCgip+OgI8p8rVg7oXqN7yNa3ohCROTYQh2BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me1tuKffxk3VklRj17dUxTpSSHVUdmzNK4MH+0BhoN7+ls83dtzB+Qittt6KmxVjamUcBsLwIDezsAHWFoToZkhjZ9PqjyXP16fOUNmwa8mQxZPFz86n9USaDLhNtQ4ow9J+1M3VKw9FbdQBepV8jM3ldxR/CDJu5iRLcj0pyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mpnf+/yL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HOQb//iJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mpnf+/yL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HOQb//iJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q9bqEx1776918
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 17:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ySodch6v1QRZGOCXacTCdsPe
	ALMgFzrSdAkV6wT6V60=; b=mpnf+/yLJBV5QY4hrKaX75dKM7RTNNe1PabE67RX
	+fi+cMYrYFs0GNfIxkNlUP8Zf5pKjA5Xz2y1HupcUBdZX3J5/NsdyhsNQMnwkA/7
	XQ2/p7i6QFXYJ4kqWmfOgXl0tr6fYPW+KeWrmWmKRCEwb1PhejM3KGg7Vi+fczB7
	u84xeToKijFFcYouMl3dW5V5fHXH/0dRcPJZeFco4Uk62Ge3LB+d562MKcHfJLEj
	11m1Q82j8HmXG3UzDqVWY998fOu3/rDtzf0YfZeR2Qspvu6NMGW4N3TBhCGuW8At
	768c58YSXVJb8/Tsckh/jKiUWQRGxRSNEXQ75dCdwIG2dA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq2q5a2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 17:49:43 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5ec9a4e6cb0so5569154137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 09:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769449783; x=1770054583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySodch6v1QRZGOCXacTCdsPeALMgFzrSdAkV6wT6V60=;
        b=HOQb//iJ7aW1UnTpdkh2cAPq+8tBAPqHBt2mBtGXwgk6pcQZHREg2keXLcMc3XgS47
         vQPnevEn7ELt6jn5mF1xkPRYHS/Qzb64rjSUfmmOUBNpGR706CrfOlcq5cW9aRQ/j0PE
         MOvUqkbMa0A7EemXUc9NBY5hUWfHs9dAEQWTKFxMQ0KiwCw1DDkFFETn1rcU8pNY9Pzc
         UrgsT3EPgm/Bp9wrqMFVX8S3lmUEdT2U3ySxqcrg7/lqhxERKtyyX3vmKZWh3qHxpR1U
         K4L9PA9a01n2Cc6znd41+1vRbgP1NNq9n3mElvlTrCcqZmE62fqOchycF7uB5tu2cT4H
         Cqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769449783; x=1770054583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySodch6v1QRZGOCXacTCdsPeALMgFzrSdAkV6wT6V60=;
        b=rmt9beFPENG4y+itvwkWHUtw9oh7/Ss5S6b/o1Kn96KfsDeg6EHExkNCkkB3D/cN9X
         sIBrZKBHYL8iDw53a/i8oajCpHyDBcJl8h7PP6yfVIq+fDvqM/NaPOtqHlax6v6aQH36
         L4Jm/g8cnGZQzadfUUO7bGuLxa8W0dinzGO/trGXTo+FMLQzHo/AAe5W33tqXU7qQPoC
         +KucScJpX7q+GXbK2ZgGs8nvOierLVy0iskibgVFyhag3j5yuB3ap0pRZqob/fUutG5/
         yZamV1jsfRsg+4WejkxwpK2KqneF4iVg/0oE8Gvln69yH4vbsEb9R9LB1H2n/TvE1gGF
         cO6A==
X-Forwarded-Encrypted: i=1; AJvYcCXaMbUDY1nPLrILE9EiCF0wGD0YaE/Tr7vyoaw2RMCYF+xy9wBw468Ha8TE5IT3iopwZEs6XUSLj7sweuT7pPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvKLLlz/rKe6KXukRYJ9A1btc3vPez47MYwjE0otVC1QficUto
	JLW/wM3qPto+40UfReo0kcNr4rJBrFdbrYa6IcV3JceE7fN+iNF+l5YHSmU7wQWP/SEF7ldVWLG
	9rFmJdcOlRU5TTNhmP7pdBRvocJNCS1w6t4lRA2htKZOGyxlxfIvxNbYBoCW/cf4oKnAmHWo=
X-Gm-Gg: AZuq6aIgCwSyZuCbdtXejY/o3qGUrxJ8TgCmnwQyQTZH1JAAuonWassDsZM2+gFCOLt
	sZ0t6/bM80WxUiiaTRkQ9zqsixZI5Lt0wWeSUw6F7AzR4w/L2ylk0e2SulVk8T8dKCX6axyUtWz
	7hlJmlUveLSwQOAQzbieP+BQylB3AhU6pHq1VJAT2AVCeKW97WAQIv+cYwc7BlPxnpJbp2Sd2GF
	05vuZxD+tUroZ6Vz+BLdT1hPMzay+sCMbhkI1L+FXY3akBH/nZ+sgI1NzJYZjbhFR7aIpkdwdU2
	9SCo0YGF0hs7NEq/vHqiBapRLYthTVsS6EHSPsudJKVBtkKY4CTIWZz9ph5C4WaZsaoUWAPiEBW
	pakKLVV+yLK2MGWWQm/xXfSuLbynlnNOTMJi79YQfTwFbXhAj7BfHoL2YbPavVtTBJT9qHuuPgS
	GxrPOepcZpwFjOnDiHE2ohUlA=
X-Received: by 2002:a05:6102:c05:b0:5ef:b5fc:dd4c with SMTP id ada2fe7eead31-5f5762c5007mr1243500137.7.1769449783158;
        Mon, 26 Jan 2026 09:49:43 -0800 (PST)
X-Received: by 2002:a05:6102:c05:b0:5ef:b5fc:dd4c with SMTP id ada2fe7eead31-5f5762c5007mr1243487137.7.1769449782690;
        Mon, 26 Jan 2026 09:49:42 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de4927b19sm2857055e87.91.2026.01.26.09.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 09:49:41 -0800 (PST)
Date: Mon, 26 Jan 2026 19:49:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_qca: Refactor HFP hardware offload
 capability handling
Message-ID: <4qib2j5dpleedths6z2dhdf7lbjinxesqetab6q6f3j2cdgpua@wz5vfomy26y7>
References: <20260126162444.4194293-1-mengshi.wu@oss.qualcomm.com>
 <20260126162444.4194293-2-mengshi.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126162444.4194293-2-mengshi.wu@oss.qualcomm.com>
X-Proofpoint-GUID: 6daQ_1nl9bUDMvf9MnBecymizpXZyXWW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE1MiBTYWx0ZWRfX0IWMxOfP2GhG
 6JGzevRKStcMm70KBYrluACBnL+rQMDYYe+T3qXjr4Uu7RZfkUZXsjkYwnAgZM3XAPrRnDE7YeF
 4Ay1BCVH3h5qupXg9op+EoZ7AJxGsIEYDxe/CZOMPmebGLREzSUuK558q1Hqo/lLva7NTRVuGlL
 FR/SbcK4qpEkmZFuKW+ybO3xxEsZsaUzIMoOHp2DJ7fS9VFtYwLjdBZtrP4NQsn+oRv55Bja+aP
 ZUDvv83sTi6VV8hKFyHPevFzR6LVgT/ouZ52quZ2fsy1wN8pRGDDTE0o3WcA/eyOiEJspKpLm/0
 2Acz4LhatLC2vFx3pvwsK+xv7ZnwuKhd917NJZAGuUWZ/7yROkU0uUXrB4X4p2VptJ41X4WvV/h
 KZq5x7Y0YLS/z0zp+tAQl4m4oXZfZPKh8U3BH5CgH2CDl9tKUlXb2iA2nq31lSDwxHwg0x/RGv9
 6dj79oRJKalbCSCcfpQ==
X-Proofpoint-ORIG-GUID: 6daQ_1nl9bUDMvf9MnBecymizpXZyXWW
X-Authority-Analysis: v=2.4 cv=POECOPqC c=1 sm=1 tr=0 ts=6977a937 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=isNLRfMVHu74YVDN5kMA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260152

On Tue, Jan 27, 2026 at 12:24:43AM +0800, Mengshi Wu wrote:
> Replace SoC-specific check with capability-based approach for HFP
> hardware offload configuration. Add QCA_CAP_HFP_HW_OFFLOAD capability
> flag and support_hfp_hw_offload field to qca_serdev structure. Add
> QCA_CAP_HFP_HW_OFFLOAD capability flag to QCA2066 device data
> structures.
> 
> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

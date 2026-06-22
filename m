Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE95326D4A
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142253; cv=none; b=J0BzSJSAadDQlwq/o6i8L1eHlsZw56K4BXrKmY75Qpd9mTtM4TxVh5IL75E6hMo9oHQFy8GUoV0Wh9JAksMr82Db2/LWfgPftuo3AuLlA/p0L+0E8bj+6siVgccw8CuytxtofEM4TMOfccA+OpBHKhYqeFW4Xu+3i7Wi1IUun70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142253; c=relaxed/simple;
	bh=8S0kA32J1+lPVud5gltXSiMqVNaA+7pFkfB/HTQjusQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSdl1Od+RFisfZCd3PQcLMmdYELfDIUUIv7MAeSsyOkzXj+BeaTMJZgY5gCo+bJDMfCAQDEMEB2DRm5CYUutkqGKyNUvUgb4ZtsRn0nppunIs12Sct/xrVtoK3e3XvR4NVynAe6ULxHGpD/5ax994VqqyqtKfm2LLqTp/gxTgGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aMuS2FYc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JWZEVv3a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aMuS2FYc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JWZEVv3a"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDG7bp1338388
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 15:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oTLskQpAxIafqBM4bwRBYXlg
	B6bC1qqplPkstd54/z4=; b=aMuS2FYcM5dYhv0oRu6mAMjsSwUIfx47YeL3SKQI
	EW1ki6we8JTxMHc9rcImEr0pc05d/He5pr29eXBvx+iiwhfVduI1zudwJkWefNmM
	UCshMWgcXCJB+HXSfxJaAnQK3/fyebh7OCaNCGtkgVvyNsvW4wQGWVndzuymlijH
	2XfAFyzZOFVuzTThj51+V/8yIe+J5SuMxm8Zsperhy6fu00QO36oJwmG0FURpSOR
	G61l6hxG9FqDE65AE4K6xyyRZvhTPrYPn3278rVPgJ/s/R7BL/SWeov33bomxy9V
	1n6b/GTupYcEbYj+Pb5WtjY5lZDuoltukBGMtoEYqqns3A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37h938s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 15:30:50 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c47a07f324so2610122137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782142250; x=1782747050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oTLskQpAxIafqBM4bwRBYXlgB6bC1qqplPkstd54/z4=;
        b=JWZEVv3aM8slYpBhxZap+aEDjX8AYTt6CKYYVsrtwIsTC8midQ8ExyXMWpCl3nV1Iv
         qBP5zAHZdxa9ICJz13aKQ0P+K7JHDUduitSg1QU1b939j/hRfwaPtdDipcMYPRDH285k
         rG9Z2ZBYZbO2txNj2vgQtl3DIMkFvIhQuIaox0oOgVZbPmI4orxx/ySn9xMvDpCmEB8K
         8DN/VPUJ6fLfPGy2EwJN+yWvu6j/Zu0xlIS3GOHn7cPRFQ4SDvbGnV1Y8jS3iR08PAQA
         x18F8hPMM/5a/r2WsJRZ0+h3tcIMGWnKlQW/1JghuFXzf+Q2u2PedXLVNtCOPyrmqNrD
         BTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142250; x=1782747050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTLskQpAxIafqBM4bwRBYXlgB6bC1qqplPkstd54/z4=;
        b=NI9UQ45DE+DFQnNv36KvD+8BDVYWVjEh8DhvjXfWDCrD5mtBx2pXWlaNu4Vibh7b+B
         wz/MPcBSsnRHrW920UZIxshyorVxxgttcaytY3huUrZhZtbZdAtPwhDXQ/wDzYnWuBlF
         oE1vcX+kv4qBaCsR2cAqRzxpOIG3T3dTnv1GTH/w0SIOtXNRoqWBe3lS1iVxn0qJKp9W
         wEYrrARAQvZQVFJGWtQDKl6Fq0Z5THZKXVJL/vDQlmF8eqYXTCmBLFUICKfGrS4fLGH8
         FE3XIyBkrwiOArfEv864ryMUvtPK94JXjzIiFKPnLpL5oRdK/klLOFgQT4p35bHnFMEC
         qpoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/w28quyw1r07Pe1nqS1knyNW0c0z37j55hl5D7Rmw2ScVZAcki+/WfbE71a8E/jyC38nEBFePSIze+ghSPmgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysg2FPLa1ZBkOkyzDzjB6AZOdMvriWG3sie/56WMh5wE4U970p
	b7o6ZIkmN8HNPgBp4EDyvRMj4v3NVP4GEKCk826KZ1H5/JZIuOBPOsETjLlQ8rYdiDRAWuFZx0B
	hjLUuzquZaQ3EPbVlEQ4Dl8xulciOgMMb9/xvDfrsEIjrq4TroM1HJQvENguB9bZD/QfgjWE=
X-Gm-Gg: AfdE7cnAcqCM4VgH0eEF3hIDWKQyZNm8jMVYbudVAfi2dk7eB1lAnwkSuzMPVtxFSQP
	sqrXmI0gd/bogtApbjO1VbjLV/0SjBYCRYSFsQJlfzLSyHuGCo9NfoDXQldL88BmVET10++hiCA
	H1n+UXd8wdBpnRVVvnEpaeJOOlLKZfUYSUw6N+1PF8xGlX93j80n2wLR00s1zXOVjK3goFk1vnp
	2lrayiZhkq3teRhDk+O6uKKtSFgvQVPfN7VzT7uL1IELCrhPNzz0twrg8kXalDemIs5gR+BGqI/
	3AOe8wnNby8Xa0szbc1bFcbIeI2RvMUdXz6AqKQLyDakotEDoKAE4eENMzx+H7qUyslMLlh4zIM
	dbBxKAGfNl94zGdqWdaxg2INmNI96b8kmALrZttO7jUTBKiWVvCRQ/uja3I0/kUU/UZE6ZqVn8b
	wlJVlmjaOXRJw5ZenRzy1Zo9jk
X-Received: by 2002:a05:6102:5e8c:b0:634:420a:ab1b with SMTP id ada2fe7eead31-72a1f0aa661mr8171079137.18.1782142250073;
        Mon, 22 Jun 2026 08:30:50 -0700 (PDT)
X-Received: by 2002:a05:6102:5e8c:b0:634:420a:ab1b with SMTP id ada2fe7eead31-72a1f0aa661mr8170944137.18.1782142249322;
        Mon, 22 Jun 2026 08:30:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad5c3c1ff5sm1783461e87.79.2026.06.22.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:30:46 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:30:44 +0300
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
Subject: Re: [PATCH 02/13] Bluetooth: btusb: Use & instead of == to test
 bitflag BTUSB_IGNORE
Message-ID: <hstcsmjqhjt5pypnwc2hlht3jckoallc2x7bs6f733ltp6latr@onl5topdfa5y>
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
 <20260622-bt_bugfix-v1-2-11f936d84e72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-bt_bugfix-v1-2-11f936d84e72@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: eILDT4ptN8aI8OrIGoI7M4pBeRmONHO6
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a39552a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=B5acAE-UCJMUPL_hvxsA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1MyBTYWx0ZWRfX2QoHpgrTOX8I
 N4TJMg04K1nMZQaNvMd/6+GSB/r64CKmnzguv6AgywbNG6Tn6F1lg7DbFkVeBgjw5yXZz6d14Nu
 iWOjtA06stO1n+LoGb9zfI+b77cuGyI=
X-Proofpoint-GUID: eILDT4ptN8aI8OrIGoI7M4pBeRmONHO6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1MyBTYWx0ZWRfXygEv15fKXA++
 sQ4bOBTJ1ngjy9HdzgeQBhqCH2od4h1AiZyqZqmFJtuevvPEtvLzJ4Msb83U7bbe/1YhhNFaWRu
 HdIai+oNzh4kksuFhhoWs/yl7ME2b6h44HPgwsnnxQ6f82GKE7fHJ/EQSq2ychP7v2MSFX6xkRr
 fwg5gP0lOii9zydDZrL26Wnv0kYP7l59WumcUgAVunvzBE2Ft1sJuyOl3uF07rKLo4MvFyfteHW
 cAQ3TGwEH1YrzZb0PN+AQnQOM6O0JmsVIP6PWwwpg8v9pkmya6ohteO48r2P2pC2mDuQ1nrxhOz
 JtsguYh6LAI3ig2fWvrB+uT3bVlumf9s3W2aodjIJ4r0iilKC99AWtY+Day6e8ByQE/QDLKOGti
 ei2vJfD+Fh6W5DXTb+z0F7CF2kxEOZvMHpoqqWvY+gSSCn8mOj97Fx1UElCp/09fuvv6mnHiHU7
 4f4xAN8DAVOkId9DocA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220153

On Mon, Jun 22, 2026 at 07:52:15AM -0700, Zijun Hu wrote:
> The driver_info field is a bitmask, so use & instead of == to test the
> BTUSB_IGNORE bitflag against it, which is consistent with how the other
> flags are tested.
> 
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687D3AE70A
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698114; cv=none; b=BRlaLZA75YYkd2xUwC5PA5ROf0fwmW8dePBoy0fMhpptxceCXmR8TJfHWVZAQkO0EavbCQY1ViUmQytrTvTwaujZeB3vyP8atIkiRoVSxrljpaa+cJO3s65vmhhRYqL5Pby2ijfSRV5QPTdmVzNcMOxVIwwVJ9gFcEDW51tufm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698114; c=relaxed/simple;
	bh=Y+3n8jIuDzVA+Lypx5YfLppuC/Bti6Rgo6cllyQC3LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDW+Ryg83ix4uJD0mIMQPyBvMBu6a6Vx3RdG/CF0/RJvSDjXM5y5EoFICBQH8WmgZ60JrlK9qRlXALhVHBn6RQlW5DwXOf2F0ebpxIcHXrDOL0DZZnW7uSFCQleyPimYe5Ukg99Q68vf62LshR3t0n2A+3AUDaIxQ63fdVHQBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J+vCMvkX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=brx304EY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+vCMvkX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="brx304EY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P76Qs51392536
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 08:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iJzfxaDzkqM6VgHRcfCAXDJC
	gw+Fp/v1dA7ABLX8i0M=; b=J+vCMvkXZ8RlIuuDHkUkVN83mBOcQk/negMfehdE
	4peBdKYMSH9q2I/Ru3Kw1rrRY5coXglEa+GZrP0A8Se+V9WfU7cooT8RdqqZwPo1
	OvKHFQ0+NTx2EeC/hM+mo4XWVvYcgtMYFPAy6MFZ093agRnWkwAO5rmqUAtSNwDQ
	P9oMhMyQ3EqjvD6IfxiSywXoHHLcLttvbV9MSNr2qxSkSYayFO7bJ/jgeZEVZsMU
	HngZP7OsvFO4y2yqCBc+24fdwQV6Ci1BHoLOtkbUjfJeNOpEPognU3U7taEv/NIz
	BBRL/oU7qyJb2MqRiHL2mcdDKziOgVENp1zDENbPKc/Bhw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3txntf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 08:35:11 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-95ccfd9b58dso13439378241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779698111; x=1780302911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJzfxaDzkqM6VgHRcfCAXDJCgw+Fp/v1dA7ABLX8i0M=;
        b=brx304EYZxxc4vvKsnnO8j2hZ3snxWQAxFvbr+a6HLmB3FmNwvf1gDeMTAgyAC/6fK
         vMDctTRXcZYQnfXQ004Vy3VPbTUOHx6Uq8yXruPn65IA1uJi7Veg6LLrSzVZXKADT4yt
         K4MRiVTnwaf8iSTTaUOD4IXOS7iQzg5z56ukllNVkWtwLgICFeRFrBQr8NzJSHKvYqFw
         q1uLueUUNjCKWpmtoFKvwP/ESmOuWNEVheiWH0EmA4X0lD/xO5LIas8wbnbglzHSyZD5
         aRjaiUgh9yoqv1QL4E4B5/u6ZvYgPbxy7Rvrcroa1HJs2W4+Y8MzFCk/+IS1GpOTjFI3
         ioZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698111; x=1780302911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJzfxaDzkqM6VgHRcfCAXDJCgw+Fp/v1dA7ABLX8i0M=;
        b=mO8SVsHR+l5U5J40tZVqTz4R0vFDSIzrOxuL8kRM3Jn0gSs6GvwKWMTJlmse1KV6no
         BUOM9TdPhf0CegQMCn5UBIk826bIeveF4oaSzB/q6OfpjLQ2F0UECYKPdyz7yyXRkc6a
         Z31DLQGWeloM/Z0GOCkObf7F6GE3qxAse6RN+Ra2WHAaiv+8LKBwsrG9a64W+BwQC72S
         sQv71EQJWN+pWGhvRo1cAEKhXWL+f67F6WJyuHRbnzhq3vl+mxWfu6TjqRQnj0oHrOKV
         DV6/RQozk65iUhIN5TvBiqraTUt4OL/1Ojjam6oNZPaCp/YrV66+xTBvUUXkEOT/0JK6
         Tw4g==
X-Forwarded-Encrypted: i=1; AFNElJ+d7NXiyWQntCB9G7TQHSMWCKNdm7ADV641bINg1IIuTLhtp2qerIxq2zGm/jKLf1spYeA3aOxkdu5Fgj+whMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7D7wlAx1dSC25DUgTLLfjrrwP2Nsm0uRDj7XdT0ym1g3lKK+
	0qTZasT30saDOLV+rOX46zq2cNUfcY3hWeLMP1EZrIK7u6r4uZxDgivRwZdIsjeGfDvrb55gRIc
	r6sFrDS6ERZHnhRDZuQ15VffwVJIinzZR27hyChVh4WzNIvemn3m2IIaMvUI72r8L9Tuula4=
X-Gm-Gg: Acq92OH9t3b3BBTjRCCxBvik6IsgvsL2J+QBgCyIRvL2k37rdd3OHpMx4ASwFPxJWrj
	p54Rg1ZCH4HhOQKSskqiESFjx1q7K+eaMi762/bCHtI07knuV2kk04fcL6rgzy4GY4EP3Vj1y/F
	E83IolxKftwaPzwREpOZmidjDQo7FYuQyzv/Wo9X0mByIzzz+Rzge1l0c3kKdIEZC2zj47RhwzP
	vc19Axqz1oWWn1qZATyzUD97dbcSTBVrEd5eKyaUE+TyF4NV7MCGRfG026zrOBrIa9288OX2L9V
	fH2MvP4kdNn/2GFrA3weN+Oq1YZJZTCWKdXNhg51dBNA3gsy6/6LqvldTA2ee/eChiC43WNaVFV
	39bvTegE8Psse6WMjImkp7fH5NsOl4TQaSF0bhkfZb9zll1KgAyZhpmjJjHBOwwpP2K90eOjqHV
	cDQ2TyzyFs4YuioXIUd7dZqHEvKFV2AfUFulQ=
X-Received: by 2002:a05:6102:8651:20b0:697:8b50:5949 with SMTP id ada2fe7eead31-6978b506c71mr626173137.19.1779698111248;
        Mon, 25 May 2026 01:35:11 -0700 (PDT)
X-Received: by 2002:a05:6102:8651:20b0:697:8b50:5949 with SMTP id ada2fe7eead31-6978b506c71mr626166137.19.1779698110912;
        Mon, 25 May 2026 01:35:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cbabd1sm2466936e87.34.2026.05.25.01.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 01:35:09 -0700 (PDT)
Date: Mon, 25 May 2026 11:35:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Use 100 ms SSR delay for rampatch
 and NVM loading
Message-ID: <foqjrfyu7ahktzhpnzv5wgxti6bob5d6rza4tv4mhwdvdokqxa@twdr7hts35b2>
References: <20260525065156.2213123-1-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525065156.2213123-1-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4NiBTYWx0ZWRfX9EHv9PPWtLBS
 287iXIwiybau+SjLrzpyTdV8Qn808LDxGJHFDN6Au2c/TprkkyjhTDC9T7MbE5mgpkRgSMoBXL5
 Sh6eSP3a6ntA2FUF8bAalZpGP30ivJh0dQfDNCeqhpzuOny3FIxtKFgBey5W1nPQztHdcD3Wm+T
 WPnVxHCm8Ns+ehLOZ4wuPdTYQW8L3dlB3lIm79ZQI8XkSLzabwuT1u1v0FdYnKaO231gHnPvD50
 yPeMqCHwSXgy4ZkvyNxWDm5tJhUm0RtuzStiZiZ2d5VbAvajlgajFnAnp8mwkQOEf+oJD92S9Pl
 U9M+ux6zpnMHiuneZXeBajgP7M4yuUtmI8Yt3TbMNFSvRBMskdb0WtUsNr4IUcgElpOUczcpYZT
 tmd/smHKpRcZtyycL/Lzj4BbYJYprRNF1EAxRyyxtOzJsO24hxrTwPWLMgRdHcPtNd9dz4crgD5
 MeEmjPvIPGM9VhuUqog==
X-Proofpoint-GUID: pGW0j62R13yfKvovfSBzcCK8Z_BpI-p7
X-Proofpoint-ORIG-GUID: pGW0j62R13yfKvovfSBzcCK8Z_BpI-p7
X-Authority-Analysis: v=2.4 cv=MetcfZ/f c=1 sm=1 tr=0 ts=6a1409bf cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lKc13Z-neGfXDhYO5DoA:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250086

On Mon, May 25, 2026 at 02:51:56PM +0800, Shuai Zhang wrote:
> When bt_en is pulled high by hardware, the host does not re-download
> the firmware after SSR. The controller loads the rampatch and NVM
> internally.
> 
> On HMT chip, the rampatch is ~264 KB and the NVM is ~9.4 KB. The

What is HMT? Don't use abbreviations which are not known outside of your
company.

> loading process takes approximately 70 ms. The previous 50 ms delay is
> too short, causing the controller to not respond to the reset command
> sent by the host, which leads to BT initialization failure:
> 
>  Bluetooth: hci0: QCA memdump Done, received 458752, total 458752
>  Bluetooth: hci0: mem_dump_status: 2
>  Bluetooth: hci0: Opcode 0x0c03 failed: -110
> 
> Increase the delay to 100 ms, which was confirmed as a safe value by
> the controller, to ensure the controller has finished loading the
> firmware before the host sends commands.
> 
> Steps to reproduce:
> 1. Trigger SSR and wait for SSR to complete:
>    hcitool cmd 0x3f 0c 26
> 2. Run "bluetoothctl power on" and observe that BT fails to start.
> 
> Fixes: fce1a9244a0f ("Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw")
> Cc: stable@vger.kernel.org
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>

-- 
With best wishes
Dmitry

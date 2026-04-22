Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242E3C9EFE
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881830; cv=none; b=lHt+U7hx7WGOxdeNcKuqiG+tDAccSVTsCddMtzw5XMHErmUf3m8n/G4VofyS0L2f1ImiLuVNBAS8+3YryIPQg8v5JxghL6ydHfuw3pdtfKw2u1dKtcTjgcnybsU+7w6ItTv2FuWcwVq78nN8FaOpbwUtPm3d0XUrsrfyhw3gsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881830; c=relaxed/simple;
	bh=QyxMpCXkdpo86Mw+3CM5Tn7kWJdhDyrON+s2e71h77s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5qsk5lSF4lrrYy/9rX0mtd3/MUIEgbXQoOMUChV8Z3jgjcqU8jeR2S5NVVmVeFsNjRsAuIaiNiH9epfC5HuN/qSYxNP4exadXve9WthaIMyXVa+ItY0k7YwRhVnRW751NNcbNAOKJzS5r2Eyhdi0dUB775N/Ivg4lNFW+T4JrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VRPn90qy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ms//ljRj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VRPn90qy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ms//ljRj"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MHtpxO2630173
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 18:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3YNyozOmqbEWs49NxHPxfWO/
	ujoEQ7C37uXS00Jnihw=; b=VRPn90qytWGlVt/ltNShAODhvWuMMc6rebbTc+/T
	213b1Jj66nBkjNuGs1RRre26wsGSO5BKyTjoGKv0+SHJlR+ZEl971rD35F8xl5j6
	ppbg7QFNWmmEPLY8KQHRqzfIpMSmwXDnRSl2yslXlks4sOSaStpRSTKMW94htIDT
	W96igmX3GHpKRYxpnyiPy46dnJ6hWXJVPSnPRo9Y/NT3RjNv7yv/aFB3Ytm+r0od
	MLNJH/Q/wjdHLx2aOjqRJolgsin34NDFCXVAXg8vl5pOvt26nUcREux2bKJKBY2i
	nfl28ABWPjVnLdzsj5hprWg0BVmmo0mmrJRGYfuJu2J7fw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq35r8292-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 18:17:07 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9568c49aa10so3128299241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776881827; x=1777486627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YNyozOmqbEWs49NxHPxfWO/ujoEQ7C37uXS00Jnihw=;
        b=Ms//ljRj0x2kWiqNFWeZfJMRuHokAizED/0QQUs/jUFfdALossGjMBpTdRXyhEc1ur
         BuqV4jsETs2ibie2KOUNE5NHlAZT5p45m6YMb+4dHHsAR0Rcbbcl8RF7zlMxKTl/87II
         OmWV34iS89+1S23cXKiQ65y0q5ZNJ3Wl6uA7RSu4qGshp4Fi9VxwTi/srRSz5woF8fyp
         IBa2iPkeauaRYNivtHJwcFuuyieUA38BMruHrhGUAg2zE09Y3pjkFLWEA7JPo8zJiv16
         KSzX0poCRteAEs/9Vgpm+3G7aodgRLl/A5O+ZaB3G5PI4XTOZOTBdABQmGMbG9j6iaUO
         QDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881827; x=1777486627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YNyozOmqbEWs49NxHPxfWO/ujoEQ7C37uXS00Jnihw=;
        b=Kc8Ow3Ppk6jVj7hmGSgEJU7yEYO0DpEUiOQ0RKZSuDXKWNyYeyVZqzk3uKLXTtT/Nb
         TFfilwpOHCRLYhx6GfuvabBqOeJHRfPdfwgSUtUF5aSu+H9zjeakMiRtCMiBW7VTMw6c
         GEw1QOBYdzRObD/EaqvRVBAmEZ44LxBj7WElg8DT87eg0toYd1nFcKQqhy+JhMBWZvDt
         ZB7ELNx8rFKw+TDIoaiIiFweo1Y75gqicZzEFw4qrMhgqf+Z/MCMrQyv3ZuW/R9bfTyo
         RO95Smd1U0wz/4c0bS1lTz43Csaf7CjJy5MnSm92KON+xRscIVexvrvucUbKXUr5wYhi
         Bw1A==
X-Forwarded-Encrypted: i=1; AFNElJ/v+Dk+5yf6uYXDjg1mUioM/9quRqwbLA5+Z6hsbbdu3MNUDqYsxnFJgIRM+dSImesA9JPuRyQhQAi/nx6+g3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjysAi/lyz4lfHwHjdAnsLoN2qh9srwWkiNhBdWtyfcD4oRRk
	1eFHvEHHZfxcCrBWanDkPw1Gk3qonxLzFR+ntFjTUoEzneZ55wu0DcV/SZjAGVGFQUjUtp1I2/n
	zt9sHO5lHp/eVl2KIvPDrBzo5yXxxqIPnSYr5EAJuf/WF6h/W3t5AfXHpmYS0Ft78dO2gk10=
X-Gm-Gg: AeBDievY6fbwUcilkRPLmEn2BiufAPOYaTEV/V9eNTk2YkZwbdb/qsxYWoVjI6DOKo1
	CwIYVBbH2JFeTXAQ+48+hso+4Q57zOoS8eBJ7ukZx4Q3Crr3KeahZDX9KB3K9NPclt07n/eX6il
	vvUd6I98u08ZeiQJffLdXAQ4nm2wOr/t0Kmxr2lBo+/YSxAwzRcMjSnxFHXsAgTgKEAdW34N7SX
	IdOUJP5NprOFXkl+fB6mLEU/8bJCH2FOZqzv6ooxBLKVDVxZsCDait09xeqcA+NGviIQguzvs5K
	hp2N7co9sInMJAQi/VO6SOQinPjzOJu3UWjyPQf8EwFXMVTkurTxKGoJ+GBO/5s6O+/GjCynww4
	X6Y//IyctyTIm0IDXMNpi0UUr7TIpxHI5yyfXyBWhtNCZ/qZ/eQlr776lNdibPj/FjUc31PrKAX
	CikT1dDAmJqoX8Xu/f7NukxpSfTLGuxkRZO/3qcm5pZNf+IQ==
X-Received: by 2002:a05:6102:3a11:b0:608:94e3:bd89 with SMTP id ada2fe7eead31-616f5eb9cd4mr10922053137.1.1776881826216;
        Wed, 22 Apr 2026 11:17:06 -0700 (PDT)
X-Received: by 2002:a05:6102:3a11:b0:608:94e3:bd89 with SMTP id ada2fe7eead31-616f5eb9cd4mr10921842137.1.1776881824146;
        Wed, 22 Apr 2026 11:17:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f51a7sm37631051fa.7.2026.04.22.11.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:17:03 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:17:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 11/12] Bluetooth: hci_qca: Check whether the M.2 UART
 interface is fixed or not
Message-ID: <e4h36co4ein4mqvqempmrvjhfbgx6cxwjvdcsfhkz73qnkw75j@dceeamd65gl5>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
 <20260422-pwrseq-m2-bt-v1-11-720d02545a64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-pwrseq-m2-bt-v1-11-720d02545a64@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3NyBTYWx0ZWRfX3Aa1dZdOZdVX
 S875C4+ExOn41GfLi/6++gSPfvP9oqda8BPsmbT8E2swHHdpwrN/3kJiMr/6hooKtY2p5zFs5+/
 j/9WYSqQ0PnMwHMpmyV18FqO9cf1Ro+tfxWO54cjpkXmae/+fe8fr1TE3sxtyn4cQpDSDLo/e2w
 SQHw3Wtc9cnoxpHlug+eau/PJExm0Iplp7ICAdNtgnG/BX8A15psZ9rOks7D6q9Q6jhmGeRgxls
 9Ju0KH/UnVunG8pp8S55Lf8bQSJ3lE/5udvkX9dOkmRMxlzbTQRpMMTRDp570txgDcLFMvWCl/I
 WdevVaQLlEE57+am81JOT76KprTDzfZ6qNzJiQFKWGOnYguRgGJ2kE9HYQ3u+IXG5hrD/DaMoWt
 H0A+n2+IqSMOXEeOZ4iwddoaMbjh/7KPHfTkHjlVmUnjnEnNJ+3sl/kCLZndghK03Mie1wJlui7
 9wslwVcTbAmUeUs+YsA==
X-Proofpoint-ORIG-GUID: ud_QAKdJsLFuSqvMTbGs12BexkXcvlIz
X-Proofpoint-GUID: ud_QAKdJsLFuSqvMTbGs12BexkXcvlIz
X-Authority-Analysis: v=2.4 cv=f5J4wuyM c=1 sm=1 tr=0 ts=69e910a3 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=rMrwSXHligAysd2ZAJkA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220177

On Wed, Apr 22, 2026 at 04:54:52PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> In the M.2 connector, the UART interface is controlled through the
> W_DISABLE2# signal. But the BT driver cannot know directly whether this
> signal is available or not.
> 
> Hence, use the new pwrseq API 'pwrseq_is_fixed()' to check whether the UART
> interface on the M.2 connector is fixed or controllable and set the
> 'bt_en_available' flag accordingly.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

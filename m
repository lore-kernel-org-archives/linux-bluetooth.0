Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF734040A
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726290; cv=none; b=gc94HUnat7CYpIlBaZFTiUKAwdj0/FNasDG0SfV9N+r9JfpilZ6GmwUbVRYjwUg8AnosIlJmzI8GD61mLBS2Sm+GdqZD5m/yVOJ8sxzmD90CLng6jo7vrrWbKMv4E8DEHQspqDvQOhuj4IAqA8FJXNRPmcXYOPMLURxHyrxI+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726290; c=relaxed/simple;
	bh=sDAtRHZn4DyZHI7y1G+7cSpzGNLxkLvIzW3IVoSRaNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxDtg2dMzXyNZjGsbMojd+F8yAjc7mwew6M2G3rBCXyH0nctaOfx44UcgwE11zpHQRhudDanxJOZ7S0ug2iqacXOnecm7njLXEHRZEG3prvF9iBgdJdwiBrvPzNMkhT7VOWuLfXwLs5P9OP1FNFyycL/tumDKPpRKMpaFVRwtGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GmAo3kcS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eeKrX+Rc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GmAo3kcS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eeKrX+Rc"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MD1keR1959309
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 13:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=f+AbOBrck2WkE1P7RDZcLaW4
	KIvRnF2j05kguajpEXA=; b=GmAo3kcSV3VHLKr+hwsi1ku6PZer/VjXNZe63Ev/
	NCuoqVtaOKnP5/aliEqwOkAqFusXL9iNVz0Q/XWZvZkE8+8YNGkN3MxRWFqTfp/J
	PEGuXdkHFbtkUe6oIQviZAYSjYzH7hL67s4mLA6V8mwP6AELcLlyeSrRaPEskQm0
	TaPG62mg0tkBRVQ8+fRLbUl5TVzxe0YNyqyeFpwulu0hgsqEcs6d13ZzxA8mUdMo
	4scEtt4Z6MUPM2wmDQz5pLZDT0JFO1FxSevqdOJL3VOpp4SetAhRij4vRsNGBLNF
	XFFQsZ40lcGoOqyDZVcdKYwCjnW0XBhNHT7snfyivL90aQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjr839r2w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 13:18:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52769fc3f2eso33193641cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784726285; x=1785331085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f+AbOBrck2WkE1P7RDZcLaW4KIvRnF2j05kguajpEXA=;
        b=eeKrX+RcIY8F/7qVecH5Jv1K/uzG4XKGa3qX1TAf3vHHeXDMXGniPNe5DnRlhqJ21W
         MRZWYdksghOyeAy+mR7t/S/OgB+JxY3mayN6sy3v9FwhBhiVn625IyK2xHO+QDDpn+SJ
         kN4iGY0kM3P1Z68waN2f8VgU41/TXGbNZ4egNJ/wghUkZwN5JeHspUreEhVodjsCh7WK
         li5q9wDd0J2Re4sEGAVtdLBVljdYwvg/OBNtdiRJ62sY6QnlWD0E0fGgCC4JIroZMS7o
         UnFHwjdgc8Am0IGrb6dMGAxOkhNbluNTqYlZ6MZfnNuaNJpmAuxGNvQx2OJVyrobiR85
         xkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726285; x=1785331085;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+AbOBrck2WkE1P7RDZcLaW4KIvRnF2j05kguajpEXA=;
        b=lMq1bRc2vqo1/OH/zuOl0cEBBzu9YsjGn4sl+DhPSq06kYT4g6TxPsP75/7px0POzB
         wxrbAqn48ekRX7X6tv3A0kRtsC0rnGWNtKJnQlQNKS6ldEn7gR6EWwHJe82Tk1A4i47m
         qZz8bwo5o6F1FTJyBbzGXWLdzIJrYGzjywWZCQYV1gzdoB3bu8TUsOkO3SwlpdhIrQJs
         rpANUKHFxNkH+j+O8cMjy48OtgqjCG+xqf3rBclLWpkUPzAAkVFqYIHOloabTUWtn7eg
         GQlqUWwDNjePFThj815Q75jJys6NJIMYK3kNoVpdGBu2YAFq4D9Ip8DS7ZwN+00NOfJu
         bBTw==
X-Forwarded-Encrypted: i=1; AHgh+Rphyb/JBkhmdqdn0reliE4rR5X4Ssis11bse7vCxVK4pEnegWxStNVBFjEFOjBKp5Q5ykaLzvqAxcYUeenY6T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZM2yc9rgPogvXA5wPgNYRG7UOUlEx1fr6vQ5obQTMxtCHRQQ
	dKVuY8q4hREH3cdlhFLfFjrxBUR8tMxXU3EieaqtLBS7ZiC6Aq6kmnR3ABsVuB9ofIIRfgKXQhr
	78Go1GsnhfxZY63kwRdeaNZaCc8sXe6GNWZc4GQ0YlPNDrwtzTwtXxi/0mEfXobKke5ZyWzY=
X-Gm-Gg: AR+sD11DuGGDdTn5Cz7+3e4/Xz09wOruBuBVR9pxc0H9FU1v7SrLeE7oiLfQFNybaGF
	tnsgKzFC/dPqTRXHRpuBrXt+ZMGKoWcEHKzrkIcIhUzoIw3UxjGrigEYeStOaET+AdmLCcFsCoD
	zTg/GEiN0NmI8eUriAXC7C4duMaluzFV97es+zfkKsf23zQSFrce74EFowMq5EnAMWc1LQucqel
	/Z4HQgxUnMBIco4x1a9W7O0v3aCYgTF9r9MODHtXlLFiv4HAUy9xpv/PpNduBqvu3qSteY1J+Lh
	mpf/c9B9YV6EarwDW2L5AeoPWet0ebpX5WQmXVeI5kEWc3OfvqmfmuPiq+fwgYYnG2E13FyPIdi
	aehGhHA2xC4aBZy1iZ8XEll1NSIgGfGL+M5l4ZsDu+jbEK58vWkXaI6b/PoTSpA0MmeOTtd/8qp
	mWMiOKlRUybQLbCg==
X-Received: by 2002:a05:622a:418c:b0:51c:83ee:e42e with SMTP id d75a77b69052e-5213f07a168mr218040111cf.77.1784726285228;
        Wed, 22 Jul 2026 06:18:05 -0700 (PDT)
X-Received: by 2002:a05:622a:418c:b0:51c:83ee:e42e with SMTP id d75a77b69052e-5213f07a168mr218037971cf.77.1784726283055;
        Wed, 22 Jul 2026 06:18:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9b8bfa3sm463297e87.12.2026.07.22.06.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:18:01 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:17:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 04/11] power: sequencing: pcie-m2: Report power
 controllability
Message-ID: <74x3c6zri7j2nlnhry54ytvckozlimsr6p3cp7eqfuywq3rtyw@bdbei5ophevq>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-4-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-monza-wireless-v5-4-69ec6743543c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: LJLvzXMFr59fjQhTVlI8LLBO5a3wXFfA
X-Authority-Analysis: v=2.4 cv=VfrH+lp9 c=1 sm=1 tr=0 ts=6a60c30e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=kWrQ3qjY-mGDYE7M3pEA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: LJLvzXMFr59fjQhTVlI8LLBO5a3wXFfA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfXwZZNuxoKSNYB
 fE/nZ+qDEpJMOpJsX/dIAszBUGOrX73Z/Eai7QVlh2Zl1Hr0CaVev4P/2bCfjJA1jslNs2pkqm0
 NGhlZAi/Ajp54DCbUD/jHlS8oeUPjjqaTEUSGdFyo3j8u6LYu83TreX8ggGyDSHTcZ02J5VO3n/
 i7m4Y/znDzsq2KWn7mItcT7wcD+txZFKWBzqHaRHCNKKI/BXiCLDuRfEMLYY/vJqhCWZVLs7kZu
 2V0slXMS+ql9qmIWzz2LWpB6+DE0NinMYplPRi7S4I5bn/Gdi48WDGelJ5r1KyCGUrlvU58xkv8
 ebVHeO0xmK2QjrzFeh/L/jDdPDxTr7urvJaRBWIF72r5ph19ek2m9oBWTl9p28T9Z6Wy4eb8Gpa
 UUCLOa7PBYGvtbPWRH+OTqYHOjsPIzrdBM77AGqg/X0CuUNbWkRMmPXIjmF8YTVcSpR2SlQoKvF
 SQ2iGLHWzTTCDb/Bs2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfX6e6TtUcxQmJd
 wbv6Vo4CKwQiZI8/DIrIYQx/ASuUzCOkvINdbr99CMoMkmuIjJD0zI681WxWDwC0/AZwXUD2nhj
 HPtPfvHq/N2rkKsxlrcAVYDmeIwfUhY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220130

On Mon, Jul 20, 2026 at 10:04:06AM +0200, Loic Poulain wrote:
> The M.2 Key E connector gates/resets its functions through the
> W_DISABLE1# (PCIe/WiFi) and W_DISABLE2# (Bluetooth) signals.
> When a signal is not routed to a host GPIO, the corresponding
> enable/disable callbacks are no-ops, so the consumer cannot gate
> or reset that function on its own.
> 
> Implement the .is_controllable() callback on the "uart" and "pcie"
> targets so that consumers can query this per instance (based on the
> runtime presence of the W_DISABLE2#/W_DISABLE1# GPIOs) via
> pwrseq_is_controllable().
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

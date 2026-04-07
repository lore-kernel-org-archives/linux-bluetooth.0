Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D233B636E
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567238; cv=none; b=YqW3BIae6uRlwDMYxUPRgGthhiEVK75bteIIr+WeIcj5cFLracA8yuhSId/cQYN42S1bmwfEPz8g4XITKwaAY+3N3aR+N6wEgchMlrkClF3qEt1YpS7hm5/24t3pQDINqJeML7sh1eDxbLDGHWCTves/QqMuh7pK+/WT2ytPrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567238; c=relaxed/simple;
	bh=if4a0dZt5o+Js5rWKrjRO6Yoegf2GTe8BpeTLvHP3ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIhcQ5aPhFpgsJaNOKq1buvUZjsUB9D15+iWmwDWNTM+7DqomnfpSztHg+JDQ42VuwUq/D94zuwdBtDxEMroQtFI0FHp3p5NGTzOuEvH8SsFQ9cQilc/J6mu4db+jN2CXCKvE9zmpk4zCNRLPiwgG6VsaXwukiEmHY0r1TH9CoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L6vtKFvi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JUsrmYsv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L6vtKFvi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JUsrmYsv"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Con8T3402629
	for <linux-bluetooth@vger.kernel.org>; Tue, 7 Apr 2026 13:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3+FbRRZF91Di0ErlZa0qnpdWS8M+hjG9ECkw3xgzzD8=; b=L6vtKFvi0BKAvIus
	Ovaz0JofGQwzOahDSHZaFeXnoe7KLPDcOZHeeVMXh/IuqUpK0UNgoTd+4plPVRva
	9VxnD/YorZDO9lvibGjmJk1nzQPeKBTxF9pmUSbCEiX6btGi1hjyhLI+SRv3gbZr
	pd6BIHnZtvpRY2ihYSQoyrAdt6PKgpkW7Ton7PiDPO+noY8cK4nyjawuyNArovr3
	WoL1qnK0WapjQ4l+JS32hJ5bAcpxb6cwvVB25Wsorp4Lm5HXYV+CS4sPPqqhrPo4
	9m4TXpTFLtCDcI3vR9Ngw5WdjqNOHpTLbgrm+qx/UBtTk8J/N23D2GX4UCguZcZA
	gwawjg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhtsxc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 13:07:15 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-604dcdfb3baso234941137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 06:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775567235; x=1776172035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+FbRRZF91Di0ErlZa0qnpdWS8M+hjG9ECkw3xgzzD8=;
        b=JUsrmYsvO4O4LzxCze3uePWl7Zo7EROwHNr/3NM2Q6ndFBdZpN3NHSwI7+ZxcDjeeH
         iUYRGk/kRh5mSDZtYEMn9UGBpjT5bszZ9wWQ0MU5qgMOXRSh2Ig94bTVY124qsFb9fSe
         xsUf32ZdGeSE3oKiS1Jo3Y+eHMVkoGSIjZ6zhxPLvv4YfnISQ6aSO/OvzpJRREaH2o06
         F5x1dO/Ga8pth4iu2yP6kJTdmHBijZTUHBmrOb40Z376FO7xd0GwiMld22wX5WUAYMVJ
         DcTXJyQqViLDbbvT8+9HhAXShZZ/9l1RD/yOzQzC9Neo7neydh3U6rhKmeD7G2wcPshx
         iNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775567235; x=1776172035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+FbRRZF91Di0ErlZa0qnpdWS8M+hjG9ECkw3xgzzD8=;
        b=QACHlvt2fG4+lNvsgbmVFFOCcFNL0/jLe/dJEopTdNQ1x3tQEfJqhn8i53kkgtKtVt
         o0tkEIkHDl5f6TtOp+pXcxzYc6mbnMHshkuqweiqfJXP/eCvakAVh6fmt3CEnV11UF1m
         U0N4mSUrYXwAWAVOT50N+54czbZqItJHPbBFvgC/LEVexIo8zZ0k6bcM9MfTZozpJx6U
         RRLuq7gfB/UiszOQ5RJzv112EXDQl2RyCPQCCsolSMu39H/MxXIhY2XWXOgFDh82ZI2y
         i5UczG5VhQ/Kdhjb7qzKzp+Ym5zipc7SacXxvrBsD91YcBndL8JkmZcy1ml+cjzv5ATj
         Pa+A==
X-Forwarded-Encrypted: i=1; AJvYcCWg90YJR0bmlwYhwKtlcXZlw02jd6W3O2/03XKYHaJbolEIPnDK68IcafvRbeKIGOJpkqfUMymeCHBazGXvPoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzmm7IfqcOXsw+TfZuHSDkPphtTjWt410SUt04TD8eRaVUkTJ
	83R9p8sf+vIoKklKOxPcdFM6G3nJxabMod8kUdJCB3Mbn+EvIpGe93GXmpQzuHEs3UhYp8IOUiH
	h2XN2whWWF1QyM7mQ7Kz8tRqixH1K3FnvkDt+c1USnG2LgSJBUjqOYlZHxsbFRgdqgaMfYVU=
X-Gm-Gg: AeBDiesdk6E9rTvwCkNpbgQZRfAQuOusulHrlCN9gv8J+AMrnhBzJWgaoWFqOOQPICA
	uuzw2FCs3Ridpojaest5A03nNeFVrb8HwufEOZgloHH77UPTmT99VEsoKfSKvzLq7MTOTtA7ACe
	Y4mC6PopSMMslnSuU58T2HFApHDBUEQccSd9wbbuLR1C7rE94Zv7KJ4aIdmEVuqU539uvkdCCsI
	A8dzDprqwdmOJo/UFVkFmLIjPxYzGESr/4ZS77n+JW2CqnvnqSLd5/vlaDh7oR+oalqlbghfNlC
	XOu2UH7x208JhwYQctu9bSF66MDEjuVcLX+yhbZ3tfrOTlVIzyxqsfegHxxjdwageddbuL2f6r0
	NycCdZr4+QaVL+L+mDTBaKMWF8LFHUzk6bw2NbJV00pXQZeG3mDehtMMpJkVzVAhCN/aeex5qOx
	4J6DI=
X-Received: by 2002:a05:6102:225a:b0:5f8:d54c:18c9 with SMTP id ada2fe7eead31-605a50da5ebmr1992216137.3.1775567235214;
        Tue, 07 Apr 2026 06:07:15 -0700 (PDT)
X-Received: by 2002:a05:6102:225a:b0:5f8:d54c:18c9 with SMTP id ada2fe7eead31-605a50da5ebmr1992173137.3.1775567234769;
        Tue, 07 Apr 2026 06:07:14 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c99ec7csm550660466b.14.2026.04.07.06.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 06:07:13 -0700 (PDT)
Message-ID: <fd0919f7-e510-4560-b355-15b86ee9e5a3@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 15:07:10 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: milos: Split up uart11 pinctrl
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Alexander Koskovich <AKoskovich@pm.me>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
 <20260403-milos-fp6-bt-wifi-v2-4-393322b27c5f@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-4-393322b27c5f@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyMyBTYWx0ZWRfX5GxjARMwGB1P
 VrIVZhuyulz/UG45B0RIFpWBtsXa+idRy/DNVqWWDOMz6POgDcuwBK3wx8oz2NizKLpKRye9Vax
 VHMXgJ+5aKwD6z12xiuLdmLuC97s0r6oRn74x7fayjIbYvJfDMWBrt2nMgrUFdLIFAOX0ZrrbAf
 66ev3kFsHuUXJvAv9iEZCGT/rTYLcaQxeK+MklReK0YXrYoq4Wj0CEulqZtmd66ph3zsBCzY5M7
 P37BWfl7ogscGFb8zOLGyAN3KqgxvOfTz8uVMRHizqiboqF1ZtwzfZiL9ldftHNYWU5G1VFwYvn
 q6Rq4z3wMeHoA9PXyDxbJOtHwahsNEl3KLhPAGjCUWYQ8LHYgWeX4wXnAW1EwaTudokRs0EyiDd
 qpWBDeKvzqRKkSau5rgJ4Lgls9IEj2SHpOsscDRg1N3qfQ2MyF+eMoY/zRU66RIWAkFfH5+xk1w
 3oSboAlpaL0nLzKtBww==
X-Proofpoint-GUID: UybssltJh3OhlUU5DDh8LurWGSpfjRbs
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d50183 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=WCMWw2a6SM-JmIkApqcA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: UybssltJh3OhlUU5DDh8LurWGSpfjRbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070123

On 4/3/26 3:52 PM, Luca Weiss wrote:
> In order to set the pinctrl for the individual CTS, RTS, TX and RX pins,
> split up the pinctrl configuration into 4 nodes so that boards can set
> some properties separately.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---


Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

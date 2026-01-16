Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485233ADA4
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581713; cv=none; b=pZ/0BkETi9j3KOvzZTf/QFJdJ/lGbAp6Io0RSG+VubUMQ9oREWjnMjuzmSMO+XANkiLgPUbcUC8FmHUgB64Hc1rzXuSIzR5Xrd8up7sKh3yRcpdp0ojMVuIitBOE8ykydnYym7fDg34O+jGC97WhsKnpp0jQQ7iiNgLUR7kl5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581713; c=relaxed/simple;
	bh=0H54WM5icrDDsHWx0slJii+LQKMQlvrQdSIj++zZk/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5y3Jg9BqY9wlRZf6BcsxktvjgO/TAVzRyWGnkjkmxxgALmh56KAho54VB8G3llFzoTPzvihvTiz5SRbbp73vV1cJetK1OUTKpeGkNvq2jCedtjcgXVOdotWfWiHEwWCOqL658F+NKkOvgkPrii3JJynQjeGMgjaUIiJQr6UNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i42Www/N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dyG33r87; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i42Www/N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dyG33r87"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GDZxgf1196568
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 16:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iAhjhpP5g5sO71epspZ2mzNR
	fO/LIFwmhQneKuVWClY=; b=i42Www/NdZN6LzItRHhs1lGNrTjUffsxmgdOuTcw
	SwXr0VTXaQvPOZiHg58VQdO49hyLYsnLXM7E+rCHPl4SrIn8z6NQKLMcuOhXkes3
	TSfQqynYD0YJHu+72n2CBiBFnTOsOusQI0IyRrjXjefyGsjDZ1Gi0i9ANX70CBi4
	4JXhaElFc8ikkOrLQUHj6AsmlP6g+5Y76wPEPtc8mDp4Hf2VQHkZWqsjR916DC2d
	D0X8EI+oE4s5NRc9NJ8DORM+sb9ob059Q7n7gdhoL1ohDTQmGuEd4ey0Wyk+HcPb
	mF6dj2VDj1QTQRqU5iEilTmhMRYZyZkxgtbmtrdmpEpoVw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bqpbr0hmh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 16:41:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6a341ac9fso329544685a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 08:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768581710; x=1769186510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAhjhpP5g5sO71epspZ2mzNRfO/LIFwmhQneKuVWClY=;
        b=dyG33r87HzufcVzQTFL2nksJ+R3K8xgaVzgt4aziY2WI5sHRVpXFKqexwAYtk126cm
         R78vw/HAXFjMxR1ggRJYEljcDPbuuzwz8bwgwBB2D3yL8envCgWktuq+2t8Jr3ziPIPQ
         MrwkO3FKuYRwerisXPYpCzVIJQ4Uvu1Zngb0ZE0GlPnVLpo7yHQSR/R8iiE1m4ai6Y4Q
         Abb6iZuFmSFloRLw2PA7X1IN94yAqakWt6C3pCrr676BbH15l4FTNWbDhQbR/eF73dGY
         +nGObPE9eVEHqdhIGg4rzjEKIgb4fd/KIqnK01DIIYb/ek8W+9AmxObbCySPAMvl4TQ8
         Rqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768581710; x=1769186510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAhjhpP5g5sO71epspZ2mzNRfO/LIFwmhQneKuVWClY=;
        b=MWwsrbbGGvuSejhZNQuXcP1V2eUjXrcLhk3IRMYaz6Wv5XKtezyq/clMcTn6W9K+KD
         h9p+SqI+JmU5kI72fiRiTA9vEVmIuARH0crqRjrLTr8D9Z+qUoOu6n/KM+zDLDI5s7FW
         HRAHYX7Y95Ojp7Inu2yVXjlf38EWIDOdH1pgP6hz+njTjtRa07ef8URAbH+eEAN5BY8+
         6ybkthWrKoMaXucd8NXcZqyCv2kolO58Nie6POoozIKq2Kk6Ap3fIo4H7Gc1sUJIfZYn
         T3tbeVj5t9OkRqG1UhFnCKa8vLCcY6fFzZsBJecO8Sk9+Trzlm97V0a3zM3wJi7B5CxX
         XzRw==
X-Forwarded-Encrypted: i=1; AJvYcCUUTqqBuVBywdAXZBpyNWRAAOtQGadEmmJAsGTzQOvuGeja/5AmS9J/1s/IKyRtrU/SpVk5BsYFke2bknaFNKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTmXxGKFeoKSkTnfAIjL+P16528Q1fXzdJODB4UDsHUACJ9N+9
	SDiySSFIg58REXEhHqf3doupzmppI5bEaQFPsG5keBg7P7HlDKUNLGRABi39IfJZk5Lmj7N1k1O
	B20BLMz2XqOo3gxn/nkmPpsdG7S5xOMbUMzzr+eO7EK5xFvTPFu1w0SCsUG27U0e5AfzOLHk=
X-Gm-Gg: AY/fxX7P85AYRX3uAyXLmX0D16ztxnRY2AlqwllLmUIVinXrZ295v+jALofccipP4/Q
	PTrisbYdAlu9txhNhefLm9f89PG//dyoM6p3o6dCWfrp0s7bFaR9rjEfh9I8n6NhguGVcOsEhSQ
	XLL4XG1XyGwGj8PDNVisDnisdgh5in7KG0lr9W7jPrAMFy7uk1+De3phpYfMkz+3Ckbc4IRZr7m
	EW5kku5RAqgAXTeMWlgfsDkc2FrRH7VOqh8SzW7RAX7FSv1L9VTF1hA8Ro+Kr7ZQLbux+k9S1Yo
	2wp7IegZlXNkerII1yWR/U6EkBgpjki9d3BmLv286FF6Kpm9xRHCTySIbThTEcSU1TMparbCwg2
	foex6fpf4ZbSMuo7o0gvzL6Y67i1t8wvcgMg18jioK+qdQdHZP9TZF7eUNSrQJiOgOAE6B3LLCX
	DneOB61BD1LmLnjku4ZF46zCY=
X-Received: by 2002:a05:620a:f03:b0:8c5:e166:fa14 with SMTP id af79cd13be357-8c6a67a12c4mr475981185a.73.1768581710550;
        Fri, 16 Jan 2026 08:41:50 -0800 (PST)
X-Received: by 2002:a05:620a:f03:b0:8c5:e166:fa14 with SMTP id af79cd13be357-8c6a67a12c4mr475977585a.73.1768581710052;
        Fri, 16 Jan 2026 08:41:50 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf3a4ccfsm899874e87.99.2026.01.16.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:41:49 -0800 (PST)
Date: Fri, 16 Jan 2026 18:41:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 04/14] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Message-ID: <d4ttsbhlw4c2fvgpfwgnc5mdh2egc6nwluj5pmkst2sunpn6m7@7b6by2eboob4>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
 <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
 <52b2b799-09e6-40a4-bea8-c7e8bf21cf51@oss.qualcomm.com>
 <15470b51-d398-449d-9017-304df5ad7cef@kernel.org>
 <132c34db-07c6-491b-bfda-f3c51462a184@oss.qualcomm.com>
 <f35b1380-b7d4-45e7-94ad-9f76973d3289@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f35b1380-b7d4-45e7-94ad-9f76973d3289@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEyMSBTYWx0ZWRfX3PdXA0um4FZm
 mM6z7brFsDku6i/hbz4uhzgGU/d3ZMpLQ/eGlpqzr6ZXssKJTRLAc0c8o1nnAVhCNfGgPD2Nhtb
 6E/f0fZ3ghuj/YWWBt1aVdZktdG7R1KD8XzOCKn7LiWixiAmF4fRqu+nlQnRboJ6tShy2842Z5D
 8GUTWbf0s/8bMSunM9scLrQCGr3eQThZitqNqSa23sEI21Cf/vbexY3FMoqW+9kiqBwHsnVj1x3
 7yqcoWyMfFDHU+uNRczDV/6i7DJZyNrXUaW4BRT9QPxVd7Ua3cw3FS4oST82ZIrjIP1vyh9wo+J
 JggoKek1EivE7yjqViJrT2H3p8xSASdLGF236+0Jh9l7dvaJaYJNyAGDeqeoJIW3u/cMdC1kO7x
 AZOx3InK7RISm9Ymxja9FUtYSZ96hN7zErM2mQu0yXw+xYDyfWBkuZPSQHlorbng5vWbSQ2Xjf6
 kep6sv0X7iZbOFJbLWQ==
X-Authority-Analysis: v=2.4 cv=dL6rWeZb c=1 sm=1 tr=0 ts=696a6a4f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=d62U7F-bSLN4PTEm1scA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: SOqEAvC3EVTFPNDkI8nqQKl-gKztuUC6
X-Proofpoint-ORIG-GUID: SOqEAvC3EVTFPNDkI8nqQKl-gKztuUC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601160121

On Fri, Jan 16, 2026 at 05:08:58PM +0100, Krzysztof Kozlowski wrote:
> On 16/01/2026 16:18, Jeff Johnson wrote:
> > On 1/15/2026 11:48 PM, Krzysztof Kozlowski wrote:
> >> On 15/01/2026 23:30, Jeff Johnson wrote:
> >>> On 1/5/2026 5:01 PM, Dmitry Baryshkov wrote:
> >>>> The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> >>>> voltages over internal rails. Implement support for using powersequencer
> >>>> for this family of ATH10k devices in addition to using regulators.
> >>>>
> >>>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> >>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >>>> ---
> >>>>  drivers/net/wireless/ath/ath10k/snoc.c | 54 ++++++++++++++++++++++++++++++++--
> >>>>  drivers/net/wireless/ath/ath10k/snoc.h |  2 ++
> >>>
> >>> My automation flagged:
> >>> * drivers/net/wireless/ath/ath10k/snoc.c has no QTI copyright
> >>> * drivers/net/wireless/ath/ath10k/snoc.h has no QTI copyright
> >>> * 2 copyright issues
> >>>
> >>> I'll add these manually in my 'pending' branch
> >>>
> >>
> >> And why is this a problem? You are not here to impose Qualcomm rules, bu
> >> care about Linux kernel. You cannot add copyrights based on what exactly?
> > 
> > I am a maintainer that is paid by Qualcomm to perform that role, and hence I
> > have a duty to enforce the legal guidance from Qualcomm when it comes to
> > contributions from other Qualcomm employees.
> 
> No, it's not your duty to enforce rules from some other departments or
> business units. Especially not without agreement of that person. You
> cannot just add copyrights to other people's commits just because you
> think that such copyrights should be there. Only the copyright owner -
> which you did not identify here and email address of contributor does
> not imply that (you don't even know what work contract a person has) -
> can add such copyrights.

In this particular usecase Jeff has enough knowledge about me and my
working place. I will have to resend the series anyway, but otherwise it
was perfectly fine for him to correct the copyright.

-- 
With best wishes
Dmitry

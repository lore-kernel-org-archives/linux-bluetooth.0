Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F32226165
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715803; cv=none; b=uVESMveMp5AlwF+AT7mxIQMRHjhh/pa/TAkTrrFzzpy5AonemMopwWxiKQUH6AKf42dsiXDXrZiZymzKAUsjcHjPPiPL+QnLRo9+B+Nl5ZuJPPr2ZAkVjCnvmSC/UTRYTCgvkz7WoA+B3V7rWXUVmxIxW1278K4/VrQ0QN0BkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715803; c=relaxed/simple;
	bh=GKJahy9bevsbHRGE/eglT/m8qX8vTJghuh2mr9yMkm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB+2By8hu9lCpSLigTMgfnIiIM6pYbsooGd0txVQBtKWIHytnx4cqxGzKJmbBrSAmy/VL4O5TOp92jLxqgFoNFt0yA/zLhhfCfttXnRyMDXMP/RFR6TP1YabgVuJpWZfp7aeUcRKEPMTR6x0nC3VGp+wtP2Y/asENMnRJaKM4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MPY1q7sv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a477iujk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MPY1q7sv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a477iujk"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606Ar89a2255371
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 16:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fWqs1Qn3NpZHXjse/DaLUi1M
	PNuZ1A1rxoloy7v1ngQ=; b=MPY1q7sv8B8ld5H75IelkQUs3MhNTGABvOSI/mw0
	K2CPWMWJQ52AtxSetkXMkuXT8P44h33dNLll7mQ7XTVPt3rfKK08ZjevlDQ9trBc
	urvk+uAWTyaSF3iyi7sip26Gvs0mAoG8hfvW7LlKId19t6jyl0Pad8KK0mkGOc6G
	nUYQMYmYW75yXGfaW4MDLp01NPwc5b/jCi6IUrRLNEy1Y2cy9ZeDIsgHHvjmc6fP
	MDzXg6QqLE7ZZWDIVSQks+/5RioDzFZEfkjAzcjy4+GF29kCowTCH7TPITwd09rD
	Mkzi5Y5BuoIDv+IC8HCeYJ1NfqVddEu2xHbPMoPnyRHiMA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgu42210f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 16:10:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee16731ceaso23920621cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 08:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767715799; x=1768320599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWqs1Qn3NpZHXjse/DaLUi1MPNuZ1A1rxoloy7v1ngQ=;
        b=a477iujkA6Uua3ukNHFC1+kB63PgdgaR+VJlvKLEC7qm437q1jz5XRGmXP3ht0dYm6
         EeDtIjyeFsd/C9xMemwKm/eWz8QVe5ehK+5QGT5jZuQjuegC5ci9JJd2C/MfHD9XV9W+
         wv2BQMk4thnGctJ6glLYWi8inX8Ow4M/g+nX9mEobRui99MZpF/Q/UYb/xLmjh08fj1g
         LoYN3aEAwkl7YwYOV5v75JPKCTgKYx3bMZd6p/v91fCZgv5ZQzThgtuejCBfUGhcTGIl
         sBosQjnv9hDB85+aRKxmA3/RO7V6g8pROPa69pb46NjAbdwiLTPHQnceNE+DeBumKr3Z
         85CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767715799; x=1768320599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWqs1Qn3NpZHXjse/DaLUi1MPNuZ1A1rxoloy7v1ngQ=;
        b=JHBFGSfnC42Z3HdAwfzSxob8TRqKNC3pkGgo/3Yby9znQzQaTiN4xdhYeHLtDAb3D7
         w8EaUxvOiyIfR88I5m5dI7tbKE/FHH59TlJlYvvjkPExkgziLi8JTgFbYsLt+pZDmXax
         3to5w4m197LWi14ZJMOL4C0G1diHKtH+Nncx9Kup/KEL4wGLhOyWX3EA47q9mIFEW6HM
         ZyO419tk4M24NCeQtvKNDAFiev6XBCCRs4Z6UolvqoYbV3Y9uIPWSk1XvCC+LXRw5xDP
         Am2juXjqvyQJFh7OdR7QWoT12asoriysk26l0RdWlMiHAgsW4ddp0RWTsA29i2wN34jG
         /DVA==
X-Forwarded-Encrypted: i=1; AJvYcCVfQoWuP6FDMoEhaE0dzonGj9E6eFiI2/H/pKRbctXqa2W2UCWthynkf6YSY6bOmsa+I3AshJTKfqTCxf+CUt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUZuC/LmEdEKxEgDQWryFvpp8W011g5CWvM/L8Thqr1cNH767
	7z1QsyNnh+YVVhTi2TATvjrRZM6TeHn5GAowmTdN0RwNsHOZygq2ewTzF1MerPmsaJV5JMTol3W
	GtTDZZGUEGv24+WRIOswvJCrbeH77YCvT6i24UbdsXVUSyo9p2gDi67m5t+4t3po7D2G4YyY=
X-Gm-Gg: AY/fxX70vAzKj2C/jxx1pEncEiCqmo0ue/HkRMe/Tf2jGBLp4zqb4GzxrD3uVADnbjB
	nXxIvHRkSjh3G2UMQW31tRy8ZYa/wj9hwko/MYlUSROtIa4fUp/ZGpZC6Dm2fMuQ65N7DsQKlpt
	7ehmU4dy2BAKZr6zm9l7h8sMPlH8JnWS+7X+FB7nOblSLIt1473qOZtnMnDowt+GYnPDHPLPyfh
	LphOFtW9u7FaJIsFZC1VE+O+BRi1aikMI84l+HMH9rFUdI211IcmfS+3g8GToVsgaw4itb76+Mn
	2RfjE6RlsO2kw1nmXcI8m17Q3O/u5x9ZGgpOBW173zYu7qQ8cME1AwufdxnccQUkRc+9sizBrVZ
	A0czt3brZ5Cj+AQjjY2QLCdY2eW6cqboP825V4cSsdeTu2WDfGcVevrmHxxC/LgBQEKjXvbdusA
	OQivja55nt++2l0g6ZTyX8dKY=
X-Received: by 2002:a05:622a:5c91:b0:4f1:b712:364a with SMTP id d75a77b69052e-4ffa77f4f64mr43937381cf.56.1767715799506;
        Tue, 06 Jan 2026 08:09:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN301CIMXpTn3Ofe7I2pGsbC+Tm+6+kz6hSrM4FOS9auE9S6OSXxipOg5vf+IT3IQJdRX6Vw==
X-Received: by 2002:a05:622a:5c91:b0:4f1:b712:364a with SMTP id d75a77b69052e-4ffa77f4f64mr43936431cf.56.1767715798766;
        Tue, 06 Jan 2026 08:09:58 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d67883sm669963e87.67.2026.01.06.08.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:09:58 -0800 (PST)
Date: Tue, 6 Jan 2026 18:09:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
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
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 00/14] power: sequencing: extend WCN driver to support
 WCN399x device
Message-ID: <hnuhw23po45mpla76b7z3ppflrrh6ksgcpay42lh6dcuou5usq@e45oapvn37n6>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=dYuNHHXe c=1 sm=1 tr=0 ts=695d33d8 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XeftDj3-BFt3Fdqp7McA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: oJwY07DOe1Vw_55JGyOkdhhmRXxTDAq4
X-Proofpoint-ORIG-GUID: oJwY07DOe1Vw_55JGyOkdhhmRXxTDAq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE0MCBTYWx0ZWRfXznnfoJ1wRoZ5
 /VEKuzSKpEVd6gRnuJ3MzFMoGTybLkRT0fRc+kNtHBja5yvaLxDO6Kh4roHvMJ7uj/xHSU2+B0r
 ur9XS36/YnH6M9yQalLBEtxg7Oc/0vIkt7IC6KfaFunCvvT9XkfVFcl3KKi3lcSaOSv+KpnsLn1
 xA156KoRepvP41vt4DnNhBsbeHSvFrL4SOtiemxyAKnS7Z1RstHegXzAh0x44jhHdnFcwWPTybg
 8kjgdLtwr74hn6yl4ucsFSdBx5tCrX3ED7eoChxyfywVx7d+OWhTyvxae1Q3MF/Vo+v4OCB5Ngl
 LN4LTOZhPfVrCt3y9CMjRvu3SY5X+odcADN8cxS00kGsz13qPW86CbBHMULtNdDX+9Ichde/Ee5
 8JzONgVUXsouWfg/CnVlYuq5X+4uM5j747yr4/TZsmVDM/t2E1bh8mGO7h9+rBkq6P50YfkiurY
 79fn/boCY33cqwOHKQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060140

On Tue, Jan 06, 2026 at 03:01:10AM +0200, Dmitry Baryshkov wrote:
> Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
> the later WCN / QCA devices, but they still incorporate a very simple
> PMU on die. It controls internal on-chip power networks, but, most
> importantly, it also requires a certain start-up procedure (first bring
> up VDD_IO, then bring up other voltages). In order to further unify code
> supporting different families of QCA / WCN chips and in order to
> maintain the required power up sequence, properly represent these chips
> in DTs and modify drivers to use power sequencing for these chips.
> 
> Backwards compatibility with the existing DTs is retained by keeping the
> regulator&clock code in the drivers as a fallback.
> 
> As a part of the series I've converted only several boards, verifying
> that all known instances of WCN39xx family works (fixing the issues
> meanwhile). The rest of devices might follow the pattern later.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Changes in v2:
> - Split the WCN39xx PMU schema from the qcom,qca6390-pmu.yaml
>   (Krzysztof)
> - Expanded the comment in the WiFi driver (Bartosz)
> - Changed vddrfa1p3-supply to vddrf-supply.
> - Link to v1: https://lore.kernel.org/r/20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com
> 
> ---
> Dmitry Baryshkov (14):
>       regulator: dt-bindings: qcom,wcn3990-pmu: describe PMUs on WCN39xx
>       Bluetooth: qca: enable pwrseq support for WCN39xx devices
>       Bluetooth: qca: fix ROM version reading on WCN3998 chips
>       wifi: ath10k: snoc: support powering on the device via pwrseq
>       power: sequencing: qcom-wcn: add support for WCN39xx

>       arm64: dts: qcom: qrb4210-rb2: Fix UART3 wakeup IRQ storm
>       arm64: dts: qcom: sdm845-db845c: drop CS from SPIO0
>       arm64: dts: qcom: sdm845-db845c: specify power for WiFi CH1
>       arm64: dts: qcom: sm8150: add uart13

Note for the Bjorn: I'd ask to merge these DT patches in this cycle,
while merging the rest of the patches only in the next cycle after
landing all PMU-related driver changes. If it helps, I can submit the
patches above separately.

>       arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT properly
>       arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT properly
>       arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT properly
>       arm64: dts: qcom: sdm845-db845c: describe WiFi/BT properly
>       arm64: dts: qcom: sm8150-hdk: describe WiFi/BT properly

-- 
With best wishes
Dmitry

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FBB285CB9
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774487; cv=none; b=qsZWjWXAcd7McTb36QyVd8ad/PSOPwOJKSTk/rbl4RGwZtYxtJFVQ2gn/QpLfqv33JEeDgIM9juc1bATDRKE/QAMZnvAWCw+jrwct6Q6cb4bBryduGb2ovJEQESgXhO/aScTpQwT/JTeiMECwyuNWOOZNJwz9MXWixH30H76YK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774487; c=relaxed/simple;
	bh=YuO01J5cCWly3QRXJK2VwnsCcUL+EAOlhGOT+tPLkLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNkp+0aCZrWxMloyyDSt1Ph6Ku5Tpy3Uxa7FptUOGZ4wkBV5ToLAZEPqHiKqBHxVObq/ReFYXWVgqWd/hckXTEGdz59P6wjcqNatVai5yszepgWNVzq1UVu8mOwBtpd9OmPdRwvWUc1gZbEdMScHIO1DKiT/fVh268WLJ1t20AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IjIzlr1R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hqdFp7ny; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IjIzlr1R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hqdFp7ny"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6070qS0j1979494
	for <linux-bluetooth@vger.kernel.org>; Wed, 7 Jan 2026 08:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k43xa4VOrmCN2BiW8MUJUfR8Y0vRZWMZ5hz8NjvOgRc=; b=IjIzlr1R3KKnDL48
	B4snHTjz6SONqjd29mx4uQZ3AvJlUhmn02XRlKxkp+RwDNmsJVBv9/es/IYnZcl0
	B94OoR6+JlMDnB3ABDSZCR4N4Sah3Eb0y5lyz0D04hjVx6VmV/XEubFket4cuE17
	CY46JeOZ1m5HwWTsCfA8dirRd5Xxf7Gq/kNq1YJU+8fVNDW+B4+K4iY/QryDH6/P
	edEe7CYGA4XR0peZ2whHfhBmUklhHzZK21BqVg4DccdxFDHnuMtjTwSbi1Fx2pnw
	hsUUL06lkeVTpphXAMXEio6Mhc54SPQhWZYGUGA17WP+P3TY/lSYNDCgRWQM40Gy
	VNqjKQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhdavh8hk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 08:28:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1b39d7ed2so37915611cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 00:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767774484; x=1768379284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k43xa4VOrmCN2BiW8MUJUfR8Y0vRZWMZ5hz8NjvOgRc=;
        b=hqdFp7nyW05SypdofsnhU2PsD7DYelj7kJ96jlfB/Cw8GxNgRi0qtaky+Gfq8/8H6g
         Wk3dp+QuOU3qwbY4WDn8IzAIkUL7ex+vBNd+8dBcUS04hJYH1DaoY2nqx3wIb/XtF4oG
         sns64KwVwwqdlKNOBuP1BNGrKlzvM+cWIwJVabExT4QlpttjXDGcq2EtKRe39iM66awy
         VbCPrdgwuT+2qXulzXRsIJ8hukXnMb3iWEfr3V9q9Kj7gRnDoIStuUT7nOsB9KM9tYOB
         iF9IkmGySxdMeGIhFwA3yK5V4yqNINTP/xyz8O5V+KXydOd7WIdTX50bUXFVlsR3Dacb
         Mrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767774484; x=1768379284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k43xa4VOrmCN2BiW8MUJUfR8Y0vRZWMZ5hz8NjvOgRc=;
        b=xSjRul3uQV+P/LyAyFCvAFyj1Bz2iTYhRE7vwvn8ez8nLWDB7y3BizwAzz/RaEWEwU
         1qUYUXajHbfkeocEwEOuBGBUJ0jqCGaflKoLTYVUw+tSor4gu7YPI3HwCtmaVBWQxJ+5
         PhGKKgsWqrwLzvoXlasOSi5aLUlIm+VcU6q+AtXSygWbq2+AWTJMTXaNJecTpPNG4ETk
         eDokIYKAg/NXc1G8ppEsGIR5fmbQYQGHRyQqyixRP7pqDKkOIpXoF2Ucvbnxyq/QHtws
         rsl/tv9lJLsGo8VCir78Bb3lI2Qz0nDZUZ6VqvnACvEMIIjc+oSd/K42F9p/k8yLzL+t
         Nd+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuAXdD33JZjdMY6bdhYUiOfipHNdWtva3DJZLGi5ZGo/8cbe51x9KSvtqnjH31Wftpcj2fwDmMlTwROThgboE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/t9w/UlEhf2g44Wo6FlNsffEjJQzc+cBz+jFV8y6kEaFeeeC
	ph6QaztxUFlyJ9/5rXsnCirtWJJOGTawMD/asd30yRArsmPNksvhI9oZvPE6fLMErcTi+lvd/Yo
	mv0dRVA1cnc74cBGJfJDLoq0IsemM6aHXb78JEmEq63XRbWetKUGvefQ8wE1e+dljfd2Z1zw=
X-Gm-Gg: AY/fxX7Dx1QQa/APxQ4FsxcznXYZlvIkrKOZeDlc7kKxBFTv24ezPRHcTU5d+jV51Dy
	hx1S28AWg4jf5eUx9lgLnZDMPPdcnwOXGBbzNjZxnvVsSVdUmDTqH6lfF44R0LaBQwfG8W0yEKa
	dBRrWze6WHa47mogi9zh3JcSZ1T5/zIZrF6Dq9sv57AjnWpzW0zPLfBTk8TSTQFYNqBinbxzh2/
	RG7B24Se+iNg/H2eRzyZI2Fx/22EQAX0UiBQgLGFHCdOmIP94iBeHzevHidcu336yaInTouQo7V
	bQgActMtJFw5wd+YeAOOIRzMYQM/JVGESjlxqy5IjtUe0RGuN92j3lT3wlzuGGoUI55zn/wTyML
	DnmUa3Xevk38Ol2W8FU/oNsLxc4Jr+0MtHMeX
X-Received: by 2002:a05:622a:1b9f:b0:4ff:a40d:d2b2 with SMTP id d75a77b69052e-4ffb48636f5mr24099321cf.16.1767774484649;
        Wed, 07 Jan 2026 00:28:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1MiIvYcTnGKSlwitEUnDPbVgoa6OjhOX+6gyCQTwvT+xhiYWDPGcJ1+Nnrt4tdoBe4eljtA==
X-Received: by 2002:a05:622a:1b9f:b0:4ff:a40d:d2b2 with SMTP id d75a77b69052e-4ffb48636f5mr24099151cf.16.1767774484256;
        Wed, 07 Jan 2026 00:28:04 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:b90b:ec1:e402:4249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865f84besm8276575e9.1.2026.01.07.00.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:28:03 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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
        Matthias Kaehlcke <mka@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 00/14] power: sequencing: extend WCN driver to support WCN399x device
Date: Wed,  7 Jan 2026 09:28:00 +0100
Message-ID: <176777447710.14370.7888531422852179019.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA2NyBTYWx0ZWRfX6A06Iw998jX5
 Xzaz+nYfcoeLzZCWv/Yi2k84B5yXDSBdZGJj5Pvoui1o982xVL8kFAjWwn94pbTC6CVuR/3/oWP
 8X3ON7R/N7U8dfoc/MXFFQQs/RUqXlkC/hWOoWgivSWml6A+KC4m2CQff+znM+Nova2+w/VHyzn
 M0XbQGsEpPpFxTBLgcz2HHX2KoIlTG/H0VTpGOGNvn/vYuM8U4dxvibLMJ1Y0cG0W1G/bqP15Yj
 GA8yzQVH7rytn+CHzY2ocqqYMc6kqxOFJ9o6IeV9aZ1+5ydA9ERYvMe8aCTN3yWrYv4ZUIKLKYO
 nBdqUo84gLDgcRgZV6IykpnNpc7vaDjE7RqRracrGLFBhQGpG8mANK+zfjSRaEpJnoePTviYeyp
 NhMjbdm6/gCUYEi02Q/2Jd9afPWKH4DCqZi0S2DcXEmnWdUS8dp4u8uRx3LRBbSXpq4G52VIpbt
 MYp48Zej7MkOtawD9Lw==
X-Proofpoint-ORIG-GUID: ObqFvvZ_A4LculMYJpM6tHoxyxE1qI2c
X-Authority-Analysis: v=2.4 cv=comWUl4i c=1 sm=1 tr=0 ts=695e1915 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=f4exIScRoNMJIANslhQA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: ObqFvvZ_A4LculMYJpM6tHoxyxE1qI2c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070067


On Tue, 06 Jan 2026 03:01:10 +0200, Dmitry Baryshkov wrote:
> Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
> the later WCN / QCA devices, but they still incorporate a very simple
> PMU on die. It controls internal on-chip power networks, but, most
> importantly, it also requires a certain start-up procedure (first bring
> up VDD_IO, then bring up other voltages). In order to further unify code
> supporting different families of QCA / WCN chips and in order to
> maintain the required power up sequence, properly represent these chips
> in DTs and modify drivers to use power sequencing for these chips.
> 
> [...]

Applied, thanks!

[01/14] regulator: dt-bindings: qcom,wcn3990-pmu: describe PMUs on WCN39xx
        commit: a5fae429ec2ac72372bc874a0334a7fb9eadee83
[05/14] power: sequencing: qcom-wcn: add support for WCN39xx
        commit: 0eb85f468ef515fbd2538375ef3884f6dd376382

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

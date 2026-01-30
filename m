Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB4221F20
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786140; cv=none; b=rKN8AsOe1NAhbvLrhbRwPoU7GiyUCO6wIcyhn7qdDtIIV1HvklVteUPc/MVH/mIb1qbDA6FOpGVKVnwyZctM9i+w9GDPHWx+ftUH7uUlbPfER+ugqaf/VQFXoLUCmUz4IbrZ1EokNF49aax8Xb9w/OXdI6ebWCNfJQnEJ/ub69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786140; c=relaxed/simple;
	bh=QMaFrcjLt4waT97iMzumzlM+XY3F1p9RNuu8D7U/QZo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jDSzj7WzThQmGhKS6J/gBvpTh0+H9w4/1Bndrvfj13nXrPg27YR3JN5PEhHIFRozd4eUNAcAgSL+emV8ZsrsqZfBPmI8cMQNxY8pSE8svf4M40ZDetPjLr4ZHXDrTQwSqH8oG1uM7h0SSX8KIDBwC1Jd1fN+iDM3mFU5pI9+6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gmy6svRU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gDCeJ8X+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gmy6svRU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gDCeJ8X+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAoXWa995907
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 15:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mIZREWITnjl1/FIFaSe23yCY0lDik0S4hWoOA7m7i1A=; b=gmy6svRUWsYWQg1H
	gWSRgxZf0Y0BcJ+NOrGdoSUG5V7/ls2X5r52gEI9QycnVMPVifK48Mrt5GBRwtLs
	KZ3AGcmmf7/Xqp/htdSQJ/cD3kp+iTy2l3RzxfQdC/TOFRcZsgFQoO/taFNk57Ke
	tDWiLOow69qFqk1Drw1xWQtl/UibG1/NncZpP/UJOIGGfOQtt5f3wKcXO+eIrhlA
	DBpvKLoM+dSTgfW7Z3KbAtoZSTG8XrBEvVlUf55jeccCvNcXGen46bcVNUjj+NoM
	Gaez8yIhsu4pQ4PIRdbeMF6L0GPKcP8pNWJvmI3YbhesqEqYOCjZISXxuWc8/qbm
	OQjBKg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bvvkkdn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 15:15:37 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-11b94abc09dso3308075c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769786136; x=1770390936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIZREWITnjl1/FIFaSe23yCY0lDik0S4hWoOA7m7i1A=;
        b=gDCeJ8X+QDm8FMscUWiCbTh5m6rXlpxg8rz1LlHncSpIs9ivh6/5XdGPCdWun8LJit
         2Q9S2s5QQ92FoxEDmkiaLFsu9lpQx+y6kLmxmvO5Hx4nI2guKNT/EqB3wAYYpEqES1V4
         QSYG/LP2Y7Gg1JW6V1gtkDnGxbIuVRv+u58tF5+bcGnd3d1RuDIKnHylX1dgBbSYJhju
         3VWLiT1yZY2h9pjerBaY0qd2sYpknBO57pWg24ZZYTZX02rZpDOOWi3hhKhIz4KAOb4X
         lCuJxLzQ3WgsE00cUxDuqykf7HgT3CDRWAw+DK7VNPzglggZ2dk5SyAK8pjPwo5uRV0n
         oUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786136; x=1770390936;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIZREWITnjl1/FIFaSe23yCY0lDik0S4hWoOA7m7i1A=;
        b=QZQzk+egmCY39UiY82W8SA0xX2avT6UJqC6WhubAzKkFj9Q0T8pSO7m/WEMHn9DLe8
         TYh1zF3AkRwJof2FsV8Si0mCyVBRjnYZyAJVUXdZ5nyLvPRcKEMgC/SiuLnYJkC9iQf7
         stW02xRA2451yWwO9RtvTx8NLYMumvcBDyZEiIQOB1Ro7pOUiNoGcuY3mZubXlGhLPb2
         0aGNklVUfuVEwbgGFCfruwiE/ueW5I5/3FZLd4g1PhSVjZHzSCdmlH0rQ7hrn9e/rWYs
         erSzfwxEGQiY4fMT3V+1VHoFumEdU/yvylh2gqG9seQ2Ng/CxLYufe/8tTK38ypeK7+q
         U7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUwePrH8Y8sgykIlNGGKnEPKgGaDCknY2jkNDHueUHdn4/4N5lE2ar38qan8hV9iNJVKn2O1ENWZZMIof0OGi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGme99SDsFZ0cT7tPR2T2rbJTBwCalKc70vnImhnS/Irm0GUIb
	Rlb/exsNkvIBtPstjF2B+hy6NglPGMIXYZ8q8tJdv+6L4ySUsthcMbAJ5v//dEArrjhpV4NE+zY
	Dq3aDe49qKBhMdI1B4lRmWRMoG0ZIXH8/CCKmiSukIihMF/VlQKBLU5Bzs2IQXRJwIFXHtVA=
X-Gm-Gg: AZuq6aKZOyG1ULaYo6EQBZnbMg3VCO5IE0+JDRKJAN/isVseAhdi6Gu1z8/X1uiDkqw
	74GaQGH2G1Vpx0JUlCZLv6AmlJ0BS/D5sHFIm2+E/4I2jw05BYWgunDgkqG3xxNJBsiGepbcTV2
	xc/pncCRNPCdDeNnrMXUJT6OhkszzqUpcRYK1LLQz5goTPGvCsvmcDrjAUm6AUPOtuQw09XmfIr
	Zs+nZSOooOOt6GsqzVf9oOdco0oGz694rv9aZNdBLZ7z3XI/TKUnH+tE9g2b/en+90Bh7E5Sosc
	SFjIHKFKFIbSXofFhvQpm34S6SfCU8STZ+ql8bXY42qoE1TNxSWjkjk6oEeBHFinR9vFK+AKzik
	/kK+qS/PdrsMSvE/KpmdWXUsoFbMjB2co8l50BN3CdepIzssAWNUvxGRr+v0DoE3x
X-Received: by 2002:a05:7022:396:b0:11b:d211:3a64 with SMTP id a92af1059eb24-125c0f1e671mr1354684c88.0.1769786136379;
        Fri, 30 Jan 2026 07:15:36 -0800 (PST)
X-Received: by 2002:a05:7022:396:b0:11b:d211:3a64 with SMTP id a92af1059eb24-125c0f1e671mr1354659c88.0.1769786135739;
        Fri, 30 Jan 2026 07:15:35 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f95asm10252849c88.7.2026.01.30.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:15:35 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
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
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/8] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Message-Id: <176978613488.3951544.16310124318895182345.b4-ty@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 07:15:34 -0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=ZdEQ98VA c=1 sm=1 tr=0 ts=697ccb19 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=9BDlGpjYJg453-lo7M4A:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: wJqBoMwcYZJcSHiK6lSKO0ThwKcqW8lA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNSBTYWx0ZWRfXwQ/dkd23Blch
 C82SD/a8v/yTDsbBxWjdoKUjSTslHLhxAoC+07qtggfA5+brL4zyAgrw8wVPWsMMU+M0hw3N5gT
 INKUVAkeupD+izdCnJHIyh67lGJUFr8nLC/8QebzcI/urVM4BY/lTKACB5Y77mtb6hY/6r7jqq6
 1pf2iVXhBR70m14T5dMGUmavmprFO057/oMCpxlfUF4Sgkil/BfQWGZ1oScXvUtIpP/oPP6OOb9
 DNy8kH1dYaelwjYBUgcxi+s8ECdaEkklNwJ5kBNImrvWBNnZyZ5V9pFq49AeQPhmH/sTZAqTNBd
 o2R10iyuDm9kmUDrjzvJ9aMpLm1MfHBXzxf8LIYPV/D5RCsKteKH6IU41Sqhm1GUz6mJxps45cf
 uPq4g7XWwovHArp4Cm3b6uMyLKDVqy4wa0qJ7uttnZaxkG946nbLnmSPsadHmVMcvSkyjnBlJxv
 2NO/IyfoOBSifdijK/A==
X-Proofpoint-ORIG-GUID: wJqBoMwcYZJcSHiK6lSKO0ThwKcqW8lA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300125


On Mon, 19 Jan 2026 19:07:57 +0200, Dmitry Baryshkov wrote:
> The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> voltages over internal rails. Implement support for using powersequencer
> for this family of ATH10k devices in addition to using regulators.
> 
> 

Applied, thanks!

[3/8] wifi: ath10k: snoc: support powering on the device via pwrseq
      commit: afcf3ec615c918dd71139e7ca2f4812ceea48cd7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


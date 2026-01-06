Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75CB29C351
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661289; cv=none; b=VY5s28pFfuUjHHIb8aQLb9EqnXNpV95G8JSJ0S1ggf9h+msCWpYcGOdz/XQ7pKCManU8neSDDWx/I6pZapjApNtJ9i9xRYYyj6phT3xr2RjhB+Pu/rImS+V5puHfcwhK02/TnYwDs8C47rFzKmAxIty8b6x+LeakE+MkhmjyqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661289; c=relaxed/simple;
	bh=dsdXZ95EeYH9C3J7omxSTW2//MbnLXvg26+sdstW5a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSfDdqhgMMHDBc6Is6ohXyXEP1u7RxEv8to6Av5wpFEjRz+hi03VQyr6U6KEG9IVSfk+xjW+jCzAN34krbD+ZxCX7rhtwy98Qv001mxJwKo7jwRxqUMo5tatasc+F8QiPEki5JhgBabtR1YKVyy4Q4MdoUUIyOuSnoaCimduW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FNtmA+uq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kgf4kCnm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FNtmA+uq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kgf4kCnm"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nLCq2969888
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 01:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GaHFmXFU2LgOEbPPkpReuSY4xCJ4+sCSY2NisbXzuSg=; b=FNtmA+uqDXK2qSBS
	BUWgcuR3OppC1hKq3nWeBpTUXK2T71UtYJ153i/xIEdbjpOBSlBElqSkfok6IUUk
	KoVA0XQ9sC3PUqboONYiMsz3575kuXR9XQ+G42Jmn0vzcEy6JL1pzQHC10Pcwjbm
	3lm84sMxioth8bpYw0BwhsxrWKSIZWYmmmF1xlKUoPyxwB4LuAdZ6TBZxMrtt2qW
	Cpcn4fG20r8MMhitTzewqb9YWMYMga/g4vGl23tYeR2ZBYMC7O6AaX9LfaPR0I86
	ps+zRRoeK4C76VlnfjnrTj7SDESx7BT99udzguI4W4jp7S+fzHWmn5Kuxyn2N0MF
	DwzfGw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bggsvs7pt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 01:01:26 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a2e9e09e6so15095806d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 17:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661286; x=1768266086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaHFmXFU2LgOEbPPkpReuSY4xCJ4+sCSY2NisbXzuSg=;
        b=kgf4kCnmDKT+i0KmPOr7ZGIWFoiEtbxsOUhaOZk+gImN4PjWbSngKj6lzh7rPXz14T
         fkv2jMOQcykVR1nTDW+8vhmHM05omT2PhVgHQm/8swMgTaz6zSGXD0qWgIDw+g7dabgb
         QZhhtsklJYHe9L5sO/0yJDnVivHOv58JasGGS4XgKTmfUhRn+1qv0ekBytck8vJ6cxAo
         CD3nCy8XTTkjcdH4hT59V8rWNxxk9ty6ozWcjYfmi2lnY7kwct0gEAIl6FpGk8uhKquW
         dCx2MkZ5KwB6hLwmpixllbDBq89jCaSyea9hKksDlMdVjVe3jzXrl41hfp5p+hlZ7uLB
         OQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661286; x=1768266086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GaHFmXFU2LgOEbPPkpReuSY4xCJ4+sCSY2NisbXzuSg=;
        b=K2g1/U3iYqre/IZOlCaZOwH7+OXXykWTYuZm08ly8q8kBCQN4JF1CtkfN4de9JvkzM
         LNJPWcfPkNwEvYuH0ReOKSXaszbZB0MCfkvOWWRkXdcMyEsMzUaBtV8BbyPlJwD4x3N5
         b6xsu5Qm1a6QtHOLwV0zV/Caiq9FNozboEcXQXrEn6Ohst/NQ76FHPnUcTGHBXHGzD9k
         /j7mAscbcStzcGmxSY4PARE3RjoI/iud/Q7hvj28fNKkIS443ZfN0VnO+RG9TvfwHayF
         yMEnHSNNazUAbAgOTELrX90ctnkx7J+bEun6u81AXF9VBYe86kKfK85KnxVRYpT9wqoc
         A5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXFmer77KWCn5RZWc/uyIGUL0cYnbGw1CCAMRvLKvDKx/um5mVUxt+jTOAk0vbgmKF+uvzkyGfowfwFqFQVG1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdb4cfpIFoh2kIo9F3p74jQkhXZyVB3v+9mNAOVFUXMQYizOjU
	BD6Z9JiuRmGo6pAd9OxIkCOT8TVCj+ERpkzAixLR88P1HzonR6g6GXX+g9S9l7RDDVJGLbmkHKS
	KlFRQJg7hF+nORlCLMHtFc12jnPIIpiIcRk3cGkElLFjPApUw3qBTozwJqx0KVX3oI74MzU0=
X-Gm-Gg: AY/fxX4CdIo4JoOJNyx0UT/6wADDNsB8OzzFM2z0joqGlkvRxJerdA9REkrvihMVWKi
	yD9JlyhAuOZobojZgevvAkoUK5J+Urb4FlkQMge1R+3StwEGWPo/oVtXAjZ43pXQIWPibw+TO4T
	XACbXiTZeNgooV7im6vd3JskFDnVnLfDC09sm3yBCPyVXelh67EKUpbaj5YkdnPPYjzzjGm+H5Y
	WuNFrXgn/l8faU1wSLxcgibX79aBE3p0kJxfP1cTNyAoJ0y3d3TAWEcC7FkD7gQdWsELe7kWFa3
	a5sXwM1WLZ5q11tisN7fhwutdMrz3sAkK47tVOwNzJE5ZWuwVxSXF+6pEfZS0Et8VKzWxhwkp+6
	i/ztGYSjsKbYbTLOdQ8xhrI14MnGsVpRlhCB777AJWKSI6lc4+q0+JZM+Heowf2BsPZU/HuxeOq
	sUzBBxAdQ5d3D5WNyr2evXs2E=
X-Received: by 2002:ac8:5d08:0:b0:4f0:22df:9afe with SMTP id d75a77b69052e-4ffa77afd7amr21505851cf.51.1767661285919;
        Mon, 05 Jan 2026 17:01:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHs53x/m4TYSBTf7oNnfpXpWQiTG4FUqY7QH3p2oA8FkA/fqepE9/ee56v4AUWgte/Y03Kz2A==
X-Received: by 2002:ac8:5d08:0:b0:4f0:22df:9afe with SMTP id d75a77b69052e-4ffa77afd7amr21505131cf.51.1767661285458;
        Mon, 05 Jan 2026 17:01:25 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:23 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:13 +0200
Subject: [PATCH v2 03/14] Bluetooth: qca: fix ROM version reading on
 WCN3998 chips
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-3-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
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
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=dsdXZ95EeYH9C3J7omxSTW2//MbnLXvg26+sdstW5a8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7YJdQaWvZTNPcWs2gdp9XunrWj6EarCWIme
 3YqpUhN4W6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2AAKCRCLPIo+Aiko
 1cTICACDFkWrMGC3XZY++CL+qe3yvTY8ryAmNeucwr0WK34X9AKvFdmwRsb6nQ3xCCyBuf/Zxrn
 LrU5qZ7i8x6M3QXeiHcWuEJ55n2SVVjslkCCSKRHJNSUtXZl5SzJ95eOwU4EHRRjzTiY2XpHv94
 fdzBvHkP9YoJlKY/OJFfDFHt4gCOnVZYqNMnMd6/BP+l52Jwst0YJVYLBZHubi1eb+GZ24dOHh9
 yJ0XVU0rS2ENYJj4BE9SpRR/HKSI574v7NDOmJEhtdWhrajQKiEv/iutve/w5HbftIFoRipT6nc
 owAWMs+FBiKwb+rGVEMGBWHljRYcQSGLPf4wK2jfRlAJzbcO
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: qKHVlfUjt2c6ZSHhWY7-XTd5RYzKdDLs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX1P1myqO3uOOM
 2kVwjkX8Jbo2aoeQSYP6eJu1rg5P5JUR68KvUstgn3+BArUMjqIxpdx9Ksgr+VzUA+CGvpkswAS
 MFAYq55s6FBw9nqRJvlP5Woo0I1I6nGiW2HEwcO7huUVi42aClsDYiJaUmeXbplwc9Wf1SaZC5T
 9lf4BLO8/Wpd+UgNINmxmjuMQwDRvBMRyB/Pd90iWr2DxKWaHvP5nsWa+AMjviqyEHnE0RO1ICu
 MuCd5No8FT1ZNLc8kdqaUKInq6T9d366jAINYu2iRDLmGCf8LuFj6YJDpp0wMbiPyS+AD10Mfr0
 B+0n4UCmCtI/iSVZz0B1WuaNWVq7a99sDlbs5QU7SQMWtouExg1OdvHpiK9yguekxaGDHiJ2Fy/
 8TSQu9kzTuG+d3ePvSsQ7Yl3BuI1mqu3ibzzGYSNnV0WdDDfzClkPcRZKwwHhmg0mntV+7rgBjl
 Eu0a8KuznDF5ETiOqlw==
X-Proofpoint-ORIG-GUID: qKHVlfUjt2c6ZSHhWY7-XTd5RYzKdDLs
X-Authority-Analysis: v=2.4 cv=Yv4ChoYX c=1 sm=1 tr=0 ts=695c5ee6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=TaVSYX7Pq2PjI-6xwy8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

WCN3998 uses a bit different format for rom version:

[    5.479978] Bluetooth: hci0: setting up wcn399x
[    5.633763] Bluetooth: hci0: QCA Product ID   :0x0000000a
[    5.645350] Bluetooth: hci0: QCA SOC Version  :0x40010224
[    5.650906] Bluetooth: hci0: QCA ROM Version  :0x00001001
[    5.665173] Bluetooth: hci0: QCA Patch Version:0x00006699
[    5.679356] Bluetooth: hci0: QCA controller version 0x02241001
[    5.691109] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[    6.680102] Bluetooth: hci0: QCA Downloading qca/crnv21.bin
[    6.842948] Bluetooth: hci0: QCA setup on UART is completed

Fixes: 523760b7ff88 ("Bluetooth: hci_qca: Added support for WCN3998")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 7c958d6065be..86a48d009d1b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -804,6 +804,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	 */
 	if (soc_type == QCA_WCN3988)
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x05) | (soc_ver & 0x0000000f);
+	else if (soc_type == QCA_WCN3998)
+		rom_ver = ((soc_ver & 0x0000f000) >> 0x07) | (soc_ver & 0x0000000f);
 	else
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
 

-- 
2.47.3


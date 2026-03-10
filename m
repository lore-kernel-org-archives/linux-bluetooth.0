Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5436C0DD
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183788; cv=none; b=U4kUGqUUBKio8+pX2EfqfJyqCQ4vU+LMGIfc1Gg5VEafruR1DBw196Ix5NMgRlTWr+pbAkLiIL7y+OgIDHwTaCU/MrEgeA9OscQ7xAMGNJ4B0XJyrCRdk0Rtq32FuCZypduIUXqrhvaqJk3JXRUOa5vl62x9CVcOw4vAhqTtUWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183788; c=relaxed/simple;
	bh=pu7bkfU0sTJw0PsVFgK898M90i1JnWUjS/nDJwQDnEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CL3MqB2/cgToAbBynLfOQZuRYGsBjVNotmk5h65qQ6Y/GHGCt387x4nvaXpFJTubrhdgXzAvgms2bR/TsF/tMXuLrU/0ETZzujNTopdasDUdQtAcKqowB38J10gZWnxuyNxZyk+R+EU+5XKff+Zm1WI0hRA+/XJTgfoY7Y31CAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BINbA6O2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EtGm4vyC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BINbA6O2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EtGm4vyC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AGH4fk508501
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 23:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wTtVziy0BmhY8iETUxB30NLkUuDxGGFEQ8sdwaw/rtk=; b=BINbA6O2RKFVHWfJ
	+RA7eFapoXl03B2dwzpKVNARmWkMj/fHX90r/qGlSuYGKVlMFo/46RAgfTXggfUv
	ubtJFK9LWqu4Fh4SmjQecEU6WKkNO5+ZHPXNPUERUYJyQ4RvzV+PpEvhrpEFm4UW
	ntMOY31yR4vAsLFuNZggipdfCuEAWmJ8OlQ+NfvzJPBtx7zp0Gsuob3xHWmXPNH3
	fhwj+jg4jqRWQoHkI7GS3C214kO9jksZTb4peVSZ90KZIarP24PC98zY8ZDEkwPM
	3P3VmvJsx2pYdJKTO0iEmisyR50B0nLRNz+vuEV1nxLTSgKuvZoIjreHzVmVsM1S
	34dzDA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctppahck7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 23:03:05 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9484dbd65a7so22018360241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773183785; x=1773788585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTtVziy0BmhY8iETUxB30NLkUuDxGGFEQ8sdwaw/rtk=;
        b=EtGm4vyC4TlcnKyivZNC3i8s3rXCXEVmG9nxWe03j0tlzjZigE8zLzyMkqiIQRsXdY
         f7CjermUN8uCWG+TqtZJOoC1WTPLwxLRq5szhM75GHIMUPatarvzPd/Gygwfwl/PCHe/
         NBndiSdgCobOzu0JT9YQQ96O3WiV1XJwO8ob+zvJvDyJBIxGeiFnMm5i0jXia9dAorQ8
         t8bemjyoegRxIdRaexjtGZ53dDog5XdqklvRuAUpopYXvS72VGLSYWL0yAYiTGSLelxA
         JctQAGGvfKZrnwjpQnILNlTvO7AKlibr7DkO1YuuJDnHiRTeXCpbUx8wkdzwfnDuuH6g
         85Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773183785; x=1773788585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wTtVziy0BmhY8iETUxB30NLkUuDxGGFEQ8sdwaw/rtk=;
        b=JS3YF0iQP8SrjoY4VcwrF91lQwa3qNYELuAMJTMOBToWZb5dPCJx1LhsKm3K6vgEnu
         /GQ9MB+hPsrH1pi9WTkq5KmUh5s/kFNDLK+62lyMeKsniE2mX9t5hb2rITWKdidBFc8N
         I1RMRlk+axSbSCw+SAk85xJ4DPy8F/qkHyV6wp/C7fK/L6vdcWlkAxCSQcYrNV0z6psW
         2dCanOigAh2LbYUaGU/8+GufiP+IAj1wz3CjqaoAjWlogLZwzsmlI1/AvRcdYvRAHaT8
         aFtrntorUTXhQZlHp9Qa4eehUfu6oZhVsOVmYYmu4QAYUehD7NWnpbrX+tx2TpNr+UAv
         vo1w==
X-Forwarded-Encrypted: i=1; AJvYcCUE/Z4LE6Tp7F8cLW36+xqgOip5BmSpKmRTA+3u4ra7x7zGRPy4xVaENOQGQZt9JsmCsG50de8F7AMtjb0FOhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hLnXROU02iWEA0O2/V1xoZzW6OoJLAsCFB4yRtWSAAGbQKQf
	qIHTAx85rG/wR7lOdodNZC1LluyhTiCC84uuTsCtTsPyLo6rxJOHujniUFq5O4S0wR2oKMOv6Qg
	WircEXjsKPXpPztdGvLRz5kRKnC7qT67svvQILLX1hB7wjhz/8kZVvN8fdHX349XoTq+agtw=
X-Gm-Gg: ATEYQzxitaErH/S0LAdkRRbsqRBmU3dbSJ63tlNfQ4zocQCRXPPrFr0zDE+SXIEASlL
	txOGLHlYmyRjuwvkvD4KlUkCODTJ2kIRsrZ0v5ExAFp7dD+KEJ/Tb3kC5XVjFjkxdlIauI4G8iW
	pRbSajyOwvgHYWlQfObJAHJmUAXy3+TGkiuXmD0DBm5YziEK8Gde5Z7d7usWbiPTSXxV8HPTzZl
	thEQ742OFWFSwwEySaLkQEtueIC2Pt5+KsiksIQizD1ZIRuWMOyU+AX+A8ttPK75GOjc7rP9Qzq
	2VuhX5RkQZaxmYQSGoMGxujO8ByvuZ799u2jiZ6r3nfnXGZmc18b1eGZgmBUBlIW3pIMEwm0T/+
	suv56McExdGHE5lg55vQagLaS4cuO6wHZoazBockmJvj/LTqu9N8gpeAZmmrN3Yi4+t+3Uw7pNn
	Wl/U6gH7K7HaSTdFFrjNjzcAI/M5sb2eMaetQ=
X-Received: by 2002:a05:6102:c0d:b0:5ff:f84d:eedd with SMTP id ada2fe7eead31-601def892d2mr184601137.32.1773183785199;
        Tue, 10 Mar 2026 16:03:05 -0700 (PDT)
X-Received: by 2002:a05:6102:c0d:b0:5ff:f84d:eedd with SMTP id ada2fe7eead31-601def892d2mr184592137.32.1773183784724;
        Tue, 10 Mar 2026 16:03:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156366a74sm80743e87.75.2026.03.10.16.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:03:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:02:57 +0200
Subject: [PATCH v4 1/2] Bluetooth: qca: fix ROM version reading on WCN3998
 chips
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-wcn3990-pwrctl-v4-1-70e571a18e40@oss.qualcomm.com>
References: <20260311-wcn3990-pwrctl-v4-0-70e571a18e40@oss.qualcomm.com>
In-Reply-To: <20260311-wcn3990-pwrctl-v4-0-70e571a18e40@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Harish Bandi <c-hbandi@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pu7bkfU0sTJw0PsVFgK898M90i1JnWUjS/nDJwQDnEQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpsKMjkalcIOg8DTrI+DqMKYEzOUUE1rjn2vhYg
 A64j7wts7SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabCjIwAKCRCLPIo+Aiko
 1W+CB/4zY+8UcBQpLwaFzqkP46mU2l1Pbpd2+NId95nedB1Sf0k+iuUty4txEaWnI5czWIfCX3V
 4yRT3/1IC4cJuaSvCbJt4ZjTZVf95IFu/y7m5vWJQPnHS74xzAJO5tDiYUV7GvULkHzduqKan9Y
 riaYYV2bmCnKP1SkbX+1D9i1MtEWeEYAWQ/admntR6ctNd2Ley1fSsSVTmu01NXeUEWfTSPSohT
 lBvVeUwdttK1C2ta4a0OhipfVxra+cCCS9ffMhIKYn23DN85nRoKgxrRtinVFMbbCatfpQIuI4o
 vVYyaMywUOk6X2SxlCA+IJP61QpSew3OfyANwvSBJ/A7MTHX
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: hXeXwJrx-BzzQK8pxopI351vpa6FbCnQ
X-Authority-Analysis: v=2.4 cv=D7BK6/Rj c=1 sm=1 tr=0 ts=69b0a329 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=TaVSYX7Pq2PjI-6xwy8A:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE5NyBTYWx0ZWRfX6nIvIs5N2/ht
 jB/FV5LxdioRbTqJf8PfxsYS2GKPXZ+xtS9WSXlCfNvhg9F8i00FX0VsLYOjDaMrWl5jUa9kLJo
 lZwe2Raltbqov1RLNT/FAU+05a2CHyU3NZ1imlY9AFaEdH2elFRwxrHawjlsRhFnvQF7I4yHsMD
 4sTXfYsy13U1/kjOWN6YVQ4iOaYGyl3BKcstHRwWvznSTLssbp7NCuI84id0aLH8ym65Ox2Or5H
 ODHXLKAprusz89xNDKxXiTnTceEJnqOkpFniylvHiDuzVqQH6pu0y63C1MnklUw+D0KIO2Wtedc
 hKdL7JayPZaGrveFtTd76ZVGFTg+z9IenSi/zxiTK5nAPkBS69hyJx1btGnhaTpId6zNN4uyYWd
 VTLX5TyikXliab2owSw2kJRswc6/CP1P9Es3I+lVgiZsrgVY4EWpUxyN/7Mfbpv8LoU47sgPKPF
 IkW2Pf3O4OIj3+KkeXA==
X-Proofpoint-ORIG-GUID: hXeXwJrx-BzzQK8pxopI351vpa6FbCnQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100197

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
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 9f7e13fcb20e..dda76365726f 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -787,6 +787,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	 */
 	if (soc_type == QCA_WCN3988)
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x05) | (soc_ver & 0x0000000f);
+	else if (soc_type == QCA_WCN3998)
+		rom_ver = ((soc_ver & 0x0000f000) >> 0x07) | (soc_ver & 0x0000000f);
 	else
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
 

-- 
2.47.3


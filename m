Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144263B27D5
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577714; cv=none; b=NA3+5oToZvucTCREeel94xAdVoPL0x4pwGcWH0wj/YSrNzwoCHMxWSg3eaCzJZeiX2C7I2TNklenKJkHnX4JOgvUXrm7WkLA35Oh0HtkBzPfsh/yqCRwlljsTFPEDriFycpvopkeuWLEjBKmRv425RfaZT2edbABmJDsBGyVDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577714; c=relaxed/simple;
	bh=LLSJwaCL4iFzi8AbdcqG/VTGhFy0sQ4cS+urTqFihy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzGuDZJx0xViOQATmZ6OyhrAd/O6TBLB7GEHZ7R1TCDTCr2iPmTjAYmkxPQRA+JqAOI1w0ZY0eh4gECJqz1cB6Pg/xyfb5J/TPOhk+5i0tpGErSAk2obJafvbCFilFyUe61U62mxLOE5HdXkOh5vfkyHzfiiiR0Q0ObzL7zlD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GNRzMktH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bHdFCp0C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GNRzMktH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bHdFCp0C"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960QOp784666
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 06:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f+CjvNKuUBC9o6FjJ1ARDnLxJ8xHL+5lu01kXdj2uYA=; b=GNRzMktHfgKKyyQo
	v/VwwXRoz53eJzGpt9lXZ1yk2Srf8WZRFsgUD66LTjP/LteKHNdw79u8RIq1XlGz
	+plCvhShTi7RYN74akBo0I/3UW1+Ch5gVAw0bCpNgQ0NWJUx1Nt3i1UInSElAyhF
	o/S9kSuXF3M7vB9jg5CLxgPTG2SyoVstQ5SnSQpnk+KnBaDfboiy7QZsL9QIEiG9
	yOCOS731K/7irwmXZro4XSmHATvaoL5gwEUwqyWoM3fRNajnw7rVoHy5YAbIpQRc
	LVFwzoJw9LbSLtK7S1N1LDmnvFxh2xYrrm/xUnuKPXmoL0F6rlptWsMrh/nrcr/B
	9cBdnw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u24w2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 06:15:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-847c049cdecso407233b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 23:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783577711; x=1784182511; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+CjvNKuUBC9o6FjJ1ARDnLxJ8xHL+5lu01kXdj2uYA=;
        b=bHdFCp0CRJZfwPsnNVqBeZrMkqXE9EAr9uytTjtuarAm8Z57akbT2d52fwlxVLt3cx
         woUINbKpCK5Lr5/oefWNGexwsrCH6aKlAHGYey4W6ffPZxNUE93XTCKq3C4n5UCEodvr
         I3sGTaE0p8/13JUzm2p/1fYxshqjotPyeENuYj/RtZKoS6TBM4607Yi0dgShVYjlm46/
         c4Mzmc0jxZzKpWd9wvW/XoNb6BMx32/Di1kZEo6jEGrLlucx4jpeL8mWAjysEmFjOrkF
         dIy+f3m4SBEqW3/x3LhS+eeiVN7CqPc29E/cjNM3AMm1IwgYqEV+99yD6IJ9Zlabm/aH
         DMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577711; x=1784182511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+CjvNKuUBC9o6FjJ1ARDnLxJ8xHL+5lu01kXdj2uYA=;
        b=MpZRZHZ6iEHJ2xXKz5luxza3nPEaQpCv7bep5oB7re/N4S7ivYh66G9ANgon6xU5n2
         4nXk/H3r0r5qD2HRKtDdT3BhNYrN3vsqyfnVTp2uYXC5pF+OqQdQARLgCw2k+5QV2F+y
         x1woRp0rKjg5qftl7bdqv/9jqjN/M681PL0bt7+h9BQGCqVpOBKvBx4JK+CCapUP649E
         FgjL4yhlz2WZaJcAOVseE2+yPvzubU2bRWCsyO/VTd8WqJoAbn4TXe1Chd0UhRpgo1nI
         pbhNYkqVxKF7T9aF/Ib8WqUNsw/tAiHLoTkm2B418aVic7R1vDyCAebLUhBMyc7vaywE
         sc3A==
X-Forwarded-Encrypted: i=1; AHgh+RoVqCGMg42nG/6Ss3HcCnkG20qL7nbDedaQOR3OgAaLlrANFhIHjseIjGv4ISzNfAcQFKMHHXYXo+1O8BedOtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNYx4g/nW+jrKLQlNhuGMAdBzK5JL2Wb5A8L2JDCKVsuYNdaPF
	uKpPT+8w+SRitEWsASEj0MzTHdvtsI46F5cU1Yb2mhL7/PRboyWU2ohx5vFrvLjrWj/OZqSkUt8
	mMVFnlYfX31IdYtWbIjDdpsrx1/tFBMCVsiq1tTWePJ6J2sQbAmqsU3Dsszgk7lOLzSWwqaI=
X-Gm-Gg: AfdE7cnGdoxCzXp2H7/RLHsn6Akw6yd+4AvN1RQUZbu4KRy3zwYLVmagsOaTZmQ4zdM
	JEcVTJbLUzVLeWYMtF9rY3CQ9Wwf/ltC8kyrW1IQaOQpAOSRZbCgmN0Sy21Ybd2/OlhArGReXQX
	PwrVNlk2IE1m2aX19fPWFGnGOi2aiX/hDENA/pfWekaUjm/7JobvI3Q+7zt/8Qk61MRS1CQ3cDH
	Pe3G1p0ARo+5CW5F+9hAhxIFSG7IyvPCNrFfRbtOn8WrqbFZTdXQk4tLSelIrFO6ROcUOdNCwh9
	B8YSNFxv4b0X1tvXGeXtC5KCCsbzPVt5WhE3XH6j/5VJDiSPmZDf2fcL24BZmreWk46M+cTMqPz
	8EIU7d4vEJRKQM6F2Q3KkfcZqaxVVCzzn+l16MnFcX+8vE0YbrEGd6UP4LA==
X-Received: by 2002:aa7:88d4:0:b0:848:4d4f:d481 with SMTP id d2e1a72fcca58-84855c3ef44mr1580236b3a.2.1783577710710;
        Wed, 08 Jul 2026 23:15:10 -0700 (PDT)
X-Received: by 2002:aa7:88d4:0:b0:848:4d4f:d481 with SMTP id d2e1a72fcca58-84855c3ef44mr1580203b3a.2.1783577710290;
        Wed, 08 Jul 2026 23:15:10 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm8146032b3a.57.2026.07.08.23.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:15:09 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 23:15:03 -0700
Subject: [PATCH 6/6] Bluetooth: btusb: Build the driver from multiple
 source files
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-btusb_prep_qcc2072-v1-6-d835b187fd01@oss.qualcomm.com>
References: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
In-Reply-To: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfX0UooEVebGI1N
 YFkEhe3W++chGj1IT6H+qAaMLuCefEIUntRYJ7aNCvVEXTjb2rE0z3GuMJAjAVAdQ2XAbomjORG
 sK0bW3+WpasrU8oscqYtpEgmOmDH75M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NSBTYWx0ZWRfX5Z4MnMhWvWZ4
 cU6xD3UN3MdVuR5uUdq/H8j0FNbpe7IZnBFs7vvJTQJYCtANoe9b5AGjULjg/ldRtGwEO9lfYN8
 NXPgBFPQPshbgMykXAIbOWMRzSUlamj0s+FSKHz4fZB3lyl0fUbL6bCEkBL5mLVKvFGNET4O7iR
 fkcOoKbAccc/c92xvvOMvb0Pg9E/xkPzl9ebP53iBquSwYBpnTKsQL/BphPr8revtNITsRBtXJ0
 J3q3OL+AN2OGCDnZh98ifs2Mt7pv/8xUXpGVIP+h5Dd+V/pHnxyGsUXMda573JCLtbAKsxDael/
 vhJBbvkCZjB8PwgzGWi81jYya1XLrgqEe2R70MofdGbtGXQ0V+ybCpCxwD39mp1L/2trAGpGI0d
 EHZTFRg6wP45xEYXc+fsZeajfsEZW+25YviKJD4nbSASNNvEpCS5fDt0s9xZoY5j/wTRM4TCnWY
 kxatphVgjQfW13SeYbg==
X-Proofpoint-GUID: TXv2bDRQwwgngI_55qcXQujX1oyDGD6J
X-Proofpoint-ORIG-GUID: TXv2bDRQwwgngI_55qcXQujX1oyDGD6J
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4f3c6f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ZxGmwJ2Zl1M0vQTzgjAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090055

Allow the driver to include vendor-specific source files by:
- renaming btusb.c to btusb_main.c
- making btusb.o a composite object

No functional change.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/Makefile                  | 2 ++
 drivers/bluetooth/{btusb.c => btusb_main.c} | 0
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index e6b1c1180d1d..8b436c6de8b7 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -51,4 +51,6 @@ hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
 hci_uart-$(CONFIG_BT_HCIUART_AML)	+= hci_aml.o
 hci_uart-objs				:= $(hci_uart-y)
 
+btusb-y				:= btusb_main.o
+
 CONTEXT_ANALYSIS := y
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb_main.c
similarity index 100%
rename from drivers/bluetooth/btusb.c
rename to drivers/bluetooth/btusb_main.c

-- 
2.34.1


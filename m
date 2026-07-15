Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD14370D57
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784090200; cv=none; b=l6Ius0iBDUV9r1u2FTnVyRWaCg3R6RSVcOD6M+l9rd0/xZfAEWHphPIr0O9OaCs01/I8M0RCkfS554DfpPy/IHTopmY+uiX+5Gglt51gwBoAw8u8F0PHXAWBQIx6xmAn6kW0gUtgqHFIEWS5vS29oLBZ2qwyiVbeFuMIy7A2kOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784090200; c=relaxed/simple;
	bh=dMGiayFrlHtnYSAxYSmn5U5CiGheBJfGZctupm7K9Ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l6YK+QcmAjfQcjx8ttvZAsrA1XPuqgVlcRHkzRME190xxWAdFtp5HpG7LOgXDRsP02IU3iOSExvqliEGBtevO/eWTGdSZa45o84GEehb9drHel7IHDWqgvauhViTVXUw0oQM52PLT2DjrqiqUVpWv8vSpv4tz1TH+EVo3BuArDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bJJ4POV8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZoOU1wy6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bJJ4POV8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZoOU1wy6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3l6DS2596256
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 04:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8keQuzcmW4Vy90dUuT5H+q
	EJnQ5Nni8hGBR61ivqhEs=; b=bJJ4POV8+OMOwTx+0VDDqUedKsZ2mXi3rNkl/K
	5HYXL2sb/wAyLLU6xbJuo+Q/c9gLMfbz7nRtNvvT/E1fXfTok3N/CHExZY2atJfg
	fFKBjVCCSuvY4G+9Xv+mK4elX2poZ3lr9kA99cgxTID1TVpA4r3rUOQLG1H64deh
	4sH+uqwy4y0GclDKvMjXG38C/+pvbuZ+IXNM+OQv9HiX6C1r33tQVPFFQO7ozDt9
	YD10F2FXT93H03PJqF5BSozW0QwaJr3ZNQ3ndO14gRb0cCkQCLZgZUk/mCe2dSTc
	o6ZPSptjKbBjHGdoTQsi7JO74safR1IBEusO1cTy/02KrL4w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmjq388s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 04:36:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-384cb1637c2so1319740a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 21:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784090197; x=1784694997; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8keQuzcmW4Vy90dUuT5H+qEJnQ5Nni8hGBR61ivqhEs=;
        b=ZoOU1wy6Ri+Ur0g+mzVcVFxHw0/J4YtPSaLdoZcq0Dg6yaV+dk+yFQtr8SekeKGNW6
         DO4aMEQKq5xVbYLnDhYWPKkHP2sAxBvh8f7ufI6GmPXx1uih9NfI+5kMBVsp09ogl3dk
         IG1gVLJQ9dK9P8dg08aHVyMaU04asi93nMd7K5oN6U+8SM1LGBhmR/gdHFu4elr55vFm
         TzCuqJbKQLHsDWtm+I7Vnn5gYVrDO7ANbZ9rcqLMbMsm3LKeBJtni3qv0YrlOwczlwpq
         dm1YL315KQuYmHLhmTjNFRhMrqWWjMaHy1jIdI2hunFfPB3pvtd67GdB2UuppB44Pk5/
         naYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784090197; x=1784694997;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8keQuzcmW4Vy90dUuT5H+qEJnQ5Nni8hGBR61ivqhEs=;
        b=Mgl4mZQD2hdcwVmWRYJ0AsElp74H9JIV46118NGPUTW5mDz+dX0hsOOSc3LldgSsdH
         39hlP6gfgQRJkQoyJzVtgj94Se9vJuUbZ0/BPS3Bi3+nJFFUmSD7ugG5VL4o9j7ajC6D
         wTKFu17CMDxWgXvYxZVYS3h70DNkFSVi6p6FYIpHy4Gu9pKO7SMSf6GwZjnJbTXEj6Qx
         aWUHIN/CrZF4CuVPQAoXJGT5SItm2Gez6SGwC2GhNZM/hEuSC25BD/gHnPTVxdTcYYhJ
         sWD1Ch7dSe9Kt1CJkFxHxW/oloOxZMN1Ud6XRpysAJXTplXDi7oOw+oSTopuY6aDcRMW
         /kPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvfwgN5iPKgZf8ovvpM/CgCqefyyvQB8iddRuJera3A99Az/9kRI7y9n4ob4lZkABytcBo7d9XpnczDzySH94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgzhwU+YXOAX5cNJb/cy0dmU6b74trWyw3QNUclaZxEfgSGwok
	YUu4uMZP+K/MFD0/K/mRV89VKndLdN/z5f5nfZ5NoRQm30PmKqzX5HQE3lOq/GbzWkY8QDvOqwP
	1y49qtBsjS3Mh7g9f5tH7bhLl8yccV1yeW6AEe+g/Ihg2FZ181tf+iDgCDuZCMG9slbw3ERc=
X-Gm-Gg: AfdE7cn5AmNdcBOTv0D4u9ORyN+hbAD5b/nes6UOQqOLiph4Y7kzGj/V78SkFskZo1Z
	Qu7ka1x1rpDiVKnVmYskwJ8ZZpxyalp+UakPPhOBzgtHneHvFJ880QrsGLeDsS9VIr163pTkEy1
	94OE9SrzxHI+Yvsw/YWeCScOxHcK2GrURBqI5Os1ExLmxR2JPbuPDkC3XqwkFsHmHXoawwaCN6C
	9W0H0TTBjFapiHabtrS61e11rWuiFTjLdsfD0PC5xsGyO+kgeQL2gOMfkHOrBRJkPG7QmLlG2Gn
	9jDvwmdUxypiQYMLPlPW2EAv3ucfnGJx8KP98B/17PMhHh9zlJBqfa8u1KDzqzlupHZtQsI1lBP
	7X86Pet/dlROa74D0yuNH9rO/uW6pEbTiPLEzwtr2kFAsXFIN50OkPiW/TA==
X-Received: by 2002:a17:90b:4984:b0:380:9cd1:d985 with SMTP id 98e67ed59e1d1-38dc7c111a8mr10612938a91.6.1784090197248;
        Tue, 14 Jul 2026 21:36:37 -0700 (PDT)
X-Received: by 2002:a17:90b:4984:b0:380:9cd1:d985 with SMTP id 98e67ed59e1d1-38dc7c111a8mr10612927a91.6.1784090196724;
        Tue, 14 Jul 2026 21:36:36 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f031ae9esm14294635eec.21.2026.07.14.21.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 21:36:36 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 21:36:36 -0700
Subject: [PATCH v2] Bluetooth: btusb: Build the driver from multiple source
 files
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-btusb_main-v2-1-fd32cf15c26e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFMOV2oC/0WPS0/DMBCE/0rlM0a24zxPkJITVRFwaAFVkR+b1
 ECS1k6ioir/HTdF4rLSrGa/nTkjB9aAQ9nijCyMxpmu9YLdLJDai7YGbLTXiBEWkZhyLPvBybI
 RpsWBJFwIHXAlJPIHBwuVOc2wj91VWzgOntlfl/9I/2EGkuQP6L2H8qgUIzHDLIg8mUNCNc1Gd
 mFL4QCrrmlMny1ASJoqGUc0gVCFpNK0ShSFSisOUQQ0CuMwjUN0SbE3ru/sz9xwpHOM5X2ev63
 fH09Fw+wLb3NMiyLelq9MB3mzatcbG2z6h89V/UXS5RMfts93vvH3bT1PHwPtpmn6BeFgZqg9A
 QAA
X-Change-ID: 20260714-btusb_main-3b04aad34cab
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=LqmiDHdc c=1 sm=1 tr=0 ts=6a570e56 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4J4qWk0Wo-fRNhQ-KTgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: TOyuDlm8uZGUa8oKm3Rhv0mQR1JMCa2y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAzOSBTYWx0ZWRfX22wOFpn4CbU2
 H7RoTQDKBsOCfb+6+mgmY6hACpv6lRiRDyZzBu0OXpFNMEdUxHQHO+THnumcgORenUUbRPNN/xh
 bi4FPFAZvmLqL//tIBebk8XtHKIGgjNxjoBnC61+xwp40Ayt3hJ+iT34oOojhgbNRw6XLM7Xh+3
 fSYHcaVgwdYqotvmswHnqwe+muXvwAhM4ijELvx5ko67vUYIVndK8xYjmaqYf1vU5oZPGNDRaGD
 ww8iUo1C7pyH6NF5EJx5uJudGqoGs9H/pkqoTKrSQlE/T2mNM01o4RKqWqgbrrp6U3Na0YyZ28y
 JpkamUvQxJp4AAmawU2GIyN1SYRYfGadXcu3sqXWfWmJCsSDeVxVOE7udjUuFhWfjXxhnWCcPyI
 YnZooaNyLnpvs+QG5TybzWGfchqFvrIj69tJIQ/DXi4xCG11gOqIBhCsi9JuF8nH35q4e5NlNHT
 pAqHc0h/R6r3hrMKSgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAzOSBTYWx0ZWRfX4eokG1P+Pf3H
 Y6xkSuagX12FTrZ7Sq2IG5wwFHkH9foyhq9b+Va738jILW9OvgebwUjTEt39HZlKFpZp8+7B3ga
 dTSRqTC1jap3yjdsZmJYavqL/nvjL8Q=
X-Proofpoint-ORIG-GUID: TOyuDlm8uZGUa8oKm3Rhv0mQR1JMCa2y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150039

Allow the driver to include vendor USB-transport-specific source files by:
- renaming btusb.c to btusb_main.c
- making btusb.o a composite object

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Changes in v2:
- Correct commit message
Link to v1:
https://lore.kernel.org/all/20260708-btusb_prep_qcc2072-v1-6-d835b187fd01@oss.qualcomm.com
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

---
base-commit: eab19cb7618e5c50fd1f8c1efdc4e66e16575975
change-id: 20260714-btusb_main-3b04aad34cab
prerequisite-change-id: 20260708-btusb_prep_qcc2072-23604a4e81d1:v2
prerequisite-patch-id: 7f4ab6cfb6c064baaf08ec011468a81bf0f815f0
prerequisite-patch-id: 720e02fa1f62f6742d370179e23464a273663a9d
prerequisite-patch-id: 22999f84adb2fa448bf8babfe1842ab89ba4c869
prerequisite-patch-id: 64f5751b262c4592e1193fb53b827639377dbda8
prerequisite-patch-id: 40aad889451114ddb9683fa1ae158b2ab90c1d30

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>


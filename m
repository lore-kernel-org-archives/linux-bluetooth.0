Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E746AF11
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628895; cv=none; b=pDe5DNbJOu2dYT/h7vBjgTYz/RRjys4/rVNB+WSlJ1L1IZb43Kg+aEIMXKEn8YiU4bamwbO2gX9vAM4UV4/+aS8vbVWLR475QHDtF2jhc0o4zGJIO5TCtW4VADUrJipoCOqeLEPhfSHJkCXcafqcSjBut/79tiHw+BPqY510APE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628895; c=relaxed/simple;
	bh=cNYnvAx94Lia5gk+slyqR5M+GJxGru37HUBkyjd7bvw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rul2+cKek3cqbgv9qTnYq3M+34k05UPdLQZGnaUOrGj89wGvyTsMOqmlEi9Zf50ouNOnxYhj4vY6aqFc9gCzKvv6J04qRi4W36EZFZ05+sfaX5qrPyuucxBkKkT3lBNkpUEKSx2Bg4WHPwc6/jUZRBOcAZEBvwi/KcPu1UK871Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GudcbdlO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=acyKiL2C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GudcbdlO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="acyKiL2C"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L8dpTV534581
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 10:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sR3EptUrrlf0fNVPKbiBFz
	dko3Is6AFddjZ1rB0K/VA=; b=GudcbdlOu8oDObEBAnkP6pJA0SZqDxbF6h5h2B
	sz9+lnDjrvugL2yYnTALSpSAJiL/rhpesD0ZrTBha3cdnn3iHH35slgOfLMDN8mQ
	UdMkcDKuuP/ujAdnTMd2USa8VYr1AKLzGYmXcbylGVBWh5wvuL+lIJtv/DA5c5iP
	ThBGMHcmfUMyvBCi137o55L4LYyUyZQhDZ/ahO2Eu4WPLlrHnTR5jpJ1lkCVl3gN
	WfVUJ3u87VM53wqaPGEKdOQENsHawlwXrg+MafWTN8uRFrZF+7J5GNRIqDIC/OAW
	vwuwczLTxFeQhHDye2O3LJfnBQisfxhCWpKUO/BmwidX0+ww==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1duhp24-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 10:14:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccbdbeffb9so39440565ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784628890; x=1785233690; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sR3EptUrrlf0fNVPKbiBFzdko3Is6AFddjZ1rB0K/VA=;
        b=acyKiL2CCTfUUdOkFKRAzCXpszbgD62L6ntvSgB2Td7ERbxlFab75DcVgxor3bip4a
         enPwtQubBoOZLb40t0VZSlLgj8uqZQE+uy2M7XcWGSkUjoJb/qtTV09BK6U2mPWjo6jP
         stsL1sSx5vvThJFJ002We8dYX7Z8+f//6KkfPHs1nSVHxEUI8Tyf0ZPAWcLviWWFh7VV
         5runmdo7agamDjcz+A9SslRBBWNdOrtnLL9Ys2YXC51dyPz4kdy6LCsvyXNkpKjphIkj
         ZjaL0cGRnM17CuMNMD1+dVOOmxprJMdXX656jQ0qmpPfgl5k5/5j+2zT2Gpis00CLuOU
         qrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784628890; x=1785233690;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sR3EptUrrlf0fNVPKbiBFzdko3Is6AFddjZ1rB0K/VA=;
        b=YO8eKGhECNTY3Qj0UUSTi+2/Uj0YsKXphJhmj82P4sWX9WBhC0jHKT6qE6Ic8z2a0o
         xy3/UtR8Z9SH6ODjw/NGQBDHaSiKo94FR/dJUin/U3jNb0mEsLVL4RZqzLlwz4gMLYjN
         1GbcW+gTMZsVoivnHqAZBV/mCMkI6D1ykSeCrZ6eB1FQ/kdMdV5o4/UQS93Klv2u6Gyj
         NcxfWGR9mK1ikbwFEfGUCKQfbB111z83Z/f/J5rgP8PDaSkCqig/HRKYCK5ZDry2h3nx
         0vmmwo1JtEaGS9MnrZiiGCL0zfXY/luZwhKGjb7bKn149aug71iYvI5CcxPOPloo//dG
         HFTw==
X-Forwarded-Encrypted: i=1; AHgh+RqRqhVCTAfh89DZ+enhM9A+7fCMSpugcbGg0/1UuDi4McxQm4B51Daqx6bfIoRh7BNxNhwVadqqVS8YdppJsZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7QtDLmPF37JjCR5pz9PKadSyPhzzX2N0ZLvUjx/eQAipaxkvx
	vc0jqX8b8jwlVNmRuo39LasElk/nFRgChzrp0o+Nn8ZA1iUsB+/4NAr29Lt9Dp63lqfIqOd2jrX
	0R2z0EG7vxR2IBKmtNHufsN8dWeYvDH3VlkG29yORZELRqdp1bgzUNng+pAunQpXtS9fARo9o3W
	mjHDTdcA==
X-Gm-Gg: AR+sD13GkEjchYtCs3PbLf7lsdZUk8AhyGdLp2UP1Of6FJCuiIc+Z10b293ahaWjWjS
	j3Uz9NEaZBdkDQ87dsnyGRUv9sivrx119S+2u55k7ScuH4ofq5QxTK94pA1XHB7HvXHOpstPYaO
	Pwxf5ITT6ZjNXJHVeUGHQ8Ju4niGKhT8R3EwXo1lMBL1oeNZkj8r6X055iGkCpXkQ4pb+lKb0z+
	H2vM0JhNDGrzw47p20ymq1zJjwT4jjkyIeS3fzVg2+zX0plXUNINkyaNpeZjmNH2B/bZepbzS7D
	toesn7mhyweDr9Ln9TRLyXEUjmzZuzxoU6Aye+AT+BNCFR7ifeI+K2Tu3f8YmEz6BGgJ1u+ssfY
	rRht8upWaDeQEwXmcLG/025RVULiHF1p6jW7kS4HPj07KNnk=
X-Received: by 2002:a17:902:ce11:b0:2c9:99be:f011 with SMTP id d9443c01a7336-2cf804364c4mr20572715ad.6.1784628889825;
        Tue, 21 Jul 2026 03:14:49 -0700 (PDT)
X-Received: by 2002:a17:902:ce11:b0:2c9:99be:f011 with SMTP id d9443c01a7336-2cf804364c4mr20572495ad.6.1784628889411;
        Tue, 21 Jul 2026 03:14:49 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf342e3a8esm73812555ad.0.2026.07.21.03.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:14:48 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Bluetooth: Replace HCI_VENDOR_PKT usages with
 HCI_EV_VENDOR
Date: Tue, 21 Jul 2026 03:14:39 -0700
Message-Id: <20260721-fix_vendor-v2-0-1977a8c39708@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI9GX2oC/22MQQ7CIBREr9L8tTR8rBBdeQ/TGErBkliofCWah
 ruLXbuZ5M1k3gpkk7cEp2aFZLMnH0MFsWvATDrcLPNjZRBcSK5QMeff12zDGBOTruPadQOaI0I
 9LMnWdZNd+sqTp2dMn82d8df+1WRknDkhhNwbRHUYzpGofbz03cR5bmtAX0r5Al/P3lerAAAA
X-Change-ID: 20260717-fix_vendor-6f40af4b1c91
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: F5vZpUs7hgWP7cy0EBnr9qJhowEb56MK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfXyFws26gorwUj
 rKGjViPILHQc02DxmOsDr9IGPRkQMTeKLA5MbkZ4goS/F/4QRJuCSoIyt7LgxyyCWfDdM39HxRs
 fX5A2F5LVYfOc3LKmngqWeCRdd1eW74tEia/dGj/JycA4Qmx2yYo88AugCVrTQnXcjIQfZc5D4e
 tXIjXg7ZbyAtw+X4mEtT0avDg6PhcSW9K8sMJx6G87jEDjzhJrKTqr7ynb9xBoWC+AdY37yBlPa
 xSZ/1lBbuyzkIOxa7cttR6UZSqQg1fpDS04IEDKK2ZRv4TJI8Ox9qOdF/o/eUfE4nQA+NCl8zRu
 Cx8OMhBFgj9Mj8Y6Esl9lPHtOCnJLE95c9d+7+kXVEfZo3z6ezWm2ewAz0HO+1JVLPKHOLHh0G/
 OBeMHNpjrXPNgbscNMbyCVfwtEwDIt2KdlO0vAeV1WjpuDrDoPhdL16R5I5hw2bUC8YZJIXFa3i
 LFReNbhI9SLcxtKDU5A==
X-Authority-Analysis: v=2.4 cv=I9JVgtgg c=1 sm=1 tr=0 ts=6a5f469a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Dei6p5SHAAAA:8 a=pGLkceISAAAA:8
 a=v3ZZPjhaAAAA:8 a=KFUITBosX_vVOeKc6roA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=M-Yerj1wOn-OpK7r_3ei:22
X-Proofpoint-GUID: F5vZpUs7hgWP7cy0EBnr9qJhowEb56MK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwOCBTYWx0ZWRfX1x33uEZoJLGs
 YzM38FOnyptTQXUfbIkHmdViz52YjzcSt2k5nnJ4KM77ANkr9HJIsL32JMM7JuxscvNQyKEpoIZ
 Zk470ROWtlFfz7ByAC3sfvgeeGA8Hok=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210108

The macros below have different meanings even though they share the
same value 0xff:

 HCI_VENDOR_PKT: HCI packet indicator or type
 HCI_EV_VENDOR:  event code of a VSE

several usage of HCI_VENDOR_PKT is wrongly checking an event code.

Fix by using HCI_EV_VENDOR for event code.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Changes in v2:
- Rebase and fix conflict for the last commit
- Link to v1: https://lore.kernel.org/r/20260717-fix_vendor-v1-0-f22263c1175b@oss.qualcomm.com

To: Bartosz Golaszewski <brgl@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Zijun Hu (3):
      Bluetooth: hci_qca: Replace HCI_VENDOR_PKT usage with HCI_EV_VENDOR
      Bluetooth: btusb: QCA: Replace HCI_VENDOR_PKT usages with HCI_EV_VENDOR
      Bluetooth: btusb: Realtek: Replace HCI_VENDOR_PKT usage with HCI_EV_VENDOR

 drivers/bluetooth/btusb.c   | 6 +++---
 drivers/bluetooth/hci_qca.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 891916abe16fc409d6e600ddd41b86ecd8f5a9df
change-id: 20260717-fix_vendor-6f40af4b1c91

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>


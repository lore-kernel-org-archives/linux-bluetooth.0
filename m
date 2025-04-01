Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44301157493
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519854; cv=none; b=iVS22EFcgKkCF+fbAxkNUxlTKeD5sTqTqQ3BooRee300ckPAbQs4WxHMHfcB/Jxpnilxxa6OEWE8w6fFio5it98fHmX/PDHV1cUGLS0/N0OXxIMoifvx9zD/f1Orwo2lIzbo8PYe2Q89Zc7VR78v+gFI851MusKqwO0Gk5hNuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519854; c=relaxed/simple;
	bh=PpmBSqs2YXoDzf7TlSO4wuYlkNmDn671JlCJG43EwJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ViHYhU3rdMJwzFWHvBsNTmC04oSwlqChixuS/oaOyT9BD1Y5eAVLv+CaBvFmACyNqIkToVZw1r7AgBoNPG1fz6InA6QSrJsDXCEWq1aXE8PnOY5cZnZPXV9M+OgpIf/av0OOYOmfH2GGmttTIzLw6vvhakk1/ENHGMWMNfW1YFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o2Ogtw5i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o2Ogtw5i"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531BQdJh002553
	for <linux-bluetooth@vger.kernel.org>; Tue, 1 Apr 2025 15:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pd0hCXt9UHoQu+5ORuaVFS
	87IvHZf0vjOGFwjSmYS/A=; b=o2Ogtw5ioaNHf//pqq7yHR2SZ2kpkXBYQv/obN
	bYfeQu4ie5VamADu4pa5ka5VeGRObbdMarDcCuR+IfwpdBapG5DMJ9eZL/MreHkc
	/p6UHKNrrYBD3AlJslmWdhLxE+tveVwJJLZ4MNh808Bx9KrUCKAiipXgUt1VMp9e
	BFbQUHX4/x2oI5MCZoWp3WU8GKo8v4kmDOg3LlrcxR7dAvAdlhP1joSuXkhmwxL1
	0rCTxZo7OoqT+AxD9whDUio5Vu7Hm7K7OmFN5maSY0NEpAKuwrfjqKBf2ky2ubR+
	fdqbWSGeWVre/vj8V6Cul62E04+0FIY07Aahe7Gp9GOZGiww==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45pa5bra4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 15:04:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c57f80d258so692645685a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 08:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743519849; x=1744124649;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pd0hCXt9UHoQu+5ORuaVFS87IvHZf0vjOGFwjSmYS/A=;
        b=OYa2iaJmnnEFLgGOoUNrdfXetRScI6kaTwrixK96UnCoTztjCHfL/2Teo0dO01CueM
         6S7nmqYGz5705uWPM9Hx8bGRx4TE0F/OZmKc5dUzxEVrUL2c8m/bQrCLYigffoE5gQBZ
         lpxd3ikHoW3nUJnfQ4RRneUQtF/GTz4in+yTEUzylGxtGd9lhjOWv2P07s6HwgKhsydN
         j5Hn8Dar8FJcJvcefwO+SW6eV4qog2hhtl1R4QRCFuftFI4etF+cQzkCnv9DDtH5uKp2
         FNLebtXWb9iZlnorKoBtnaSBPUOWghwNDS7iZnTv9gKy0UCkavz36zVhJJqpLR86LtpL
         3EuA==
X-Forwarded-Encrypted: i=1; AJvYcCU/32LnLIB8zr8GdMTQrR90eu7Zl02R2CPnpmanZWfhQZYPVv43m3B4fOhwOikWCmJ3vCSTAP/n7vZO0y1R3N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQaK3M72Vpjb9+xWil17fU8BGbmzFzRfb49vUhKYsbFM817Q1U
	+iWhWMmQR3+cDTzuSIHGcJpctIL2TWKkkWzAMTLcsbZfdOeuacVErhQ6sM+BcpECPCGI89m3nwt
	SI9TXk2ZEGKCxunzRRGyHEN081FZg+6VxNnJXf7C9vHHjBHWmfObSIh/ZxYjXLFuF6rk9hTQX35
	yk1P2C
X-Gm-Gg: ASbGnct2tUxJvrZYivGAFSFdvXyOSwx7lEC4XrMUcn4T5x5kIPcoJBcw3YqJ7Xgkuwv
	zIou8TGwpOGtakLBxLdLe6F+5e5gh9xFyeWqAeOl97Exwesv6yQ8HnfxcC+SDfqFu9X3AL0RmcV
	zgAeDw8palby/WuNk9uobMDCAcCUxVNp/HKjl35OmAbQv+O/jJTsUXPR0e7SISTyDhvSG2euZD/
	lDuJ8LmQSQPSfX4+9b9GpVHKM5B0LMDDJC89BT1M/iZNEOSagen7S5VKOd9iW7CDyl/PDzcT9Tw
	JYKAPuJMYr9myAXT5HT1Kudgbv7jFM0cUNMgqs7wFsXLArFkcbcqHGxmfkZwVh71OMmJ56NeC1c
	ndbjEvvhpzvQwiKJR2uXYtI8vN1GL
X-Received: by 2002:a05:620a:3192:b0:7c5:562d:ccf4 with SMTP id af79cd13be357-7c6862ebf96mr1638748885a.4.1743519849523;
        Tue, 01 Apr 2025 08:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqPojuWGziwvouxIKltW39fmyd+Pf1GhjseY09Vi4Jd5C46MgFgZcl9p6mTyFwdlVkrcMswQ==
X-Received: by 2002:a05:620a:3192:b0:7c5:562d:ccf4 with SMTP id af79cd13be357-7c6862ebf96mr1638745185a.4.1743519849157;
        Tue, 01 Apr 2025 08:04:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b09580035sm1391228e87.121.2025.04.01.08.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 08:04:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 01 Apr 2025 18:04:03 +0300
Subject: [PATCH] Bluetooth: qca: fix NV variant for one of WCN3950 SoCs
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-fix-rb1-bt-v1-1-0d140c583a06@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGIA7GcC/x2MQQqAIBAAvyJ7bsEVw+gr0SFzrb1YaEQQ/j3pO
 AwzLxTOwgVG9ULmW4ocqQF1CtZ9SRujhMZgtOm11YRRHsye0F84eBNtCM47ImjBmbnZfzbNtX7
 8LPibXAAAAA==
X-Change-ID: 20250401-fix-rb1-bt-8b2f4dd7b711
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wojciech Slenska <wsl@trackunit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PpmBSqs2YXoDzf7TlSO4wuYlkNmDn671JlCJG43EwJg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn7ABlqbCgQvhEX+BhUkAzMtbzmyCAGlnJ0tNtt
 Idq1AL5HUmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ+wAZQAKCRCLPIo+Aiko
 1bv/CACV2lQ6yu5av3Bgo8HAMaeDm4gkCXuaCCNyc+j/UM2HMhXt/j4RTecsdATllIrwis2q5mc
 WJQYF2ZfoHCMNaOV4Lj3QLl6T+amqQ5QwXhp50Ai8B0iyZiKKZLE84bs/WWFO89uiixO9FQ/59O
 QZ7apXw2vgnkoTgp3a64JhnwQYdrM2Sptg7jSIJjFk1ON/S0kO4GQr8a9ADnPuISj7sBJROIJad
 FvJ+JVeDcFyugsf6Dh9+k9jjwlrS2LyRUcfqQhQdRkDTOD1u5MrAQSLwYE8a9zSmwQRMDdC/uZM
 66SaubRPlF7fZ/rohtRfsHJKlcZdFcE1cD6vKJyytL/TvK/o
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 46JXlDq86y5-SzMNDc2-B9rLOaBaX1qf
X-Authority-Analysis: v=2.4 cv=YqcPR5YX c=1 sm=1 tr=0 ts=67ec006c cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=9FvU3PIiAAAA:8 a=EUspDBNiAAAA:8 a=DcZuiDOs_TEgLcimDdwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=upxJETeFKQfi_Qju5aYB:22
X-Proofpoint-ORIG-GUID: 46JXlDq86y5-SzMNDc2-B9rLOaBaX1qf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_06,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010093

The QCA_WCN3950_SOC_ID_S should be using qca/cmnv13s.bin, rather than
qca/cmnv13u.bin file. Correct the variant suffix to be used for this SoC
ID.

Fixes: 3b0e0839d9f2 ("Bluetooth: qca: add WCN3950 support")
Reported-by: Wojciech Slenska <wsl@trackunit.com>
Closes: https://github.com/qualcomm-linux/meta-qcom/pull/817#discussion_r2022866431
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 3d6778b95e0058beda3f0500b21caaef8e797d32..edefb9dc76aa1a019dc1e0ae06f4545b4ad3f96a 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -889,7 +889,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			if (le32_to_cpu(ver.soc_id) == QCA_WCN3950_SOC_ID_T)
 				variant = "t";
 			else if (le32_to_cpu(ver.soc_id) == QCA_WCN3950_SOC_ID_S)
-				variant = "u";
+				variant = "s";
 
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/cmnv%02x%s.bin", rom_ver, variant);

---
base-commit: eb4bc4b07f66f01618d9cb1aa4eaef59b1188415
change-id: 20250401-fix-rb1-bt-8b2f4dd7b711

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


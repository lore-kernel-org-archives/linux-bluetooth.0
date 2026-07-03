Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931CC3E5A32
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086345; cv=none; b=cQTLwn3oveHQF+pQ7xCeBtefpzX0Rf74LbEeI8p/ImG9fKWGf5KW08Npje6kyGerDg/M8CKzLTtD//EIz6mwDqAtqwm3HuJCm3rHnCGUwz+B6aqgQE7pbxRGWTqrdee/ACwwzXDs64C7cu4VjTQtJJCEAZHWlCZfBk6MrUCTiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086345; c=relaxed/simple;
	bh=U/Z+wdbfmdI0FkKVeS+XsAUoGZeWkpBSbkb3VilFKm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GMdzY5YMLiWtpOJiOGy5hUZbpLBqMBEoDVzAPQNhwX2YZ0CUoLHsp2Ilm2wBM5P30utd2Uo4QAQcYxmYGOhGRp7htPtsu1L45jsUCPEDGT0jqgyXKEJpAn5GpGr6zgNeylqn0xUFIZr+2fbk6lWnKsyxWXCHeaU7eWfMIaZiH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SRcHTfPK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OjlckQxb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SRcHTfPK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OjlckQxb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663D17u8053907
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Jul 2026 13:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ymluYMdTXrBgRp9HUa28auzpvVc2fSgjsJq4S7Nyu7s=; b=SRcHTfPKElZH7zR5
	N6x+mjOo4lfkFtVGi8gtj5mc8cpAnKNjUlj5WEbvsYAjET476Wivw5BFYgWov6/g
	C4T1ow2dY8Ar7eHAKGP5glgAU/9fwADqrA6ZGf7ujm5y0tKidxdl5eftbtZGQnAU
	uOXKnwufHmthmj4tntMfgvDVtSPg+7y5pkxHKiM+7pooMz6tRqWhacQZy81kVdDJ
	OatAi2KdZxut9XIFAFo4IcdwSuC2P8Q9HPLlVgeiYo8ZE0lylKX/P1d4mgVEIOxA
	2Y0KqX6PB6ExMOmRAj7MfpBRJLRec0Q1zu5ap2R2vbwi7ISn13veBJwpLnTkchYc
	sI9pog==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkg4rn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 13:45:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e62e3459fso52375485a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 06:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086340; x=1783691140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymluYMdTXrBgRp9HUa28auzpvVc2fSgjsJq4S7Nyu7s=;
        b=OjlckQxbfKbVru574NY478Gu/0iXijg5RhvWrjy393EDLPcUGmxtFvtrnWo0E8Db5X
         Hd1fYsbQ216eOsx8o/f7DC3HQGnMy4ogHXd5ai4enEL8rQKquuNbDP8+QGlvWHTi7iYz
         9SiQIwjBvbjKgfdGA87BxuFgfzgnqb7LTFVIU7ReksluhTw+fgjzkDFgb6/Br6tD8jFJ
         i2PK/m2OGTKYQsLveJgrf7VCozrF19qL+l6qIMBDv9QAB0jzsfLzt6HV5rtfwzPP/uTq
         dkTN46Oo6zQ6JgSIM+mBZtr9pL7khizlPy3e8A2eLgEAdKiXlT21+qKFYn0TWJ0G5HuR
         LfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086340; x=1783691140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ymluYMdTXrBgRp9HUa28auzpvVc2fSgjsJq4S7Nyu7s=;
        b=NHed4TlwO0Ov8Ti2PnQGiE+XYgK0xi40pc3/LDD7CXtRKvhQf4Po2MxcrGxB9gxVo3
         NeZLk5H3s0jO++JWdNZjwCrRE7c0HvlL+9uLg6pI7WCSrKBkUvWLZOOeQ4Pg9OLlnBUa
         a0Upf/OjTwlxi1O4z1hnACU2VRmxHPHb5lgfY1r4ncd7mzMLza3DyLSpYoiOIbsaUvq4
         7MiqhdgRf19WzSU0MrZa6hdEo05jEiXJ6DuZ0ihO4wxVPU2WNj0vzAp6Rf0KUON2+pNy
         xvFCW+8suJ5Ud82F8JwdYBhPvYbMACpALxuoO8YizXQ/JKnQ70d7lMG9+3o3cLr5EXz4
         c6dQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0yv1168Bzbt0WVn4BUOp3cUN4G+YMyrzizOm1fu8fuL1DNvDh084u4BFXc1MlTpgYEcIJyiTM4Iz+odgV/2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/BqpY29bUZGr8MYM3pIavRCQ1hK+zFOflBv/J/2zZRoIqjii
	dp2hSa1AFR0B41Cd7v032ZHSrTl4N/3jnoK10Q8Tgv2xYdrB4n7Wf/FfkYa1ohu2gf1ocsujiUg
	M4gu6bWqH1U00UwpKqy0QCpfOR+SaGFN81rC6/smTssD5lHqCWkjmv3as7Vp2awj7uiCML1M=
X-Gm-Gg: AfdE7ck1SxZljT1lGwPeTpUwOSBIjuH08lYRKj+gt3MRp20GUQAEGexpiZdbumX0UEO
	Alruq4Sf5qvoRrXq+7C2CCJPNuH6y2RBUtfpnz/aHsJ0q7sMhELZngjrvOVKEIggkoMFbSc+m+1
	LXd99rXmg1zGlnsD1dgMtlHfwuSN+YR27hBV46aeEBev/PHBWsWRjDe2/rLCznIicgyIYfvhBMA
	/GUO5BqOYir6SxyK8Evgcv4kXUUydY20chApq//6mDajhh6wwYx2CQigJIIzRJCD2IxuuH1Yvfa
	wHZ1Pg4KyP1k2jM8LTXzpooWjK9lQ41MfPcp+VmKL1GG1ULMVqrv6wRm7kmhSToQlGx5at+m9rv
	B44iJ1vFqKHdNP5Q4YZSYxkoRnB4MRWn7Rhx5AA4+GAJM0YpgQ4b6wv+m5fIYjncxO7sbshHkXr
	91haCi3nCFc4svKWe6ghwe/aCtdFhLF4dUnORddAzvANaDJUlMnheINcoILa+PR2g=
X-Received: by 2002:a05:620a:6846:b0:915:efa6:d70a with SMTP id af79cd13be357-92e784d06e2mr1356649885a.49.1783086340354;
        Fri, 03 Jul 2026 06:45:40 -0700 (PDT)
X-Received: by 2002:a05:620a:6846:b0:915:efa6:d70a with SMTP id af79cd13be357-92e784d06e2mr1356641385a.49.1783086339645;
        Fri, 03 Jul 2026 06:45:39 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:38 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:20 +0200
Subject: [PATCH v8 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-7-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfXyN3M8nLoXpzV
 pU3rflJFAYfxb+vqT+7yYFdIdkcNJ1Lunx9NRQYeXxVadXSg7DkhaHUgF7rw6NLVPqkiixnQVxw
 L4fN5T9TaMI5LFsMxTB4HYkaTm32URcKpEA5Ih7wMOHt+QjrPQrph9V1oFhUhxVDJyN8AnTWQkv
 75+EIC5M3829YDUYXo6tuqmaG0R6lSP3q8w0xwBTsJ3qvOOeK38pNfpHhlAiPnd0N5YDb++xzi6
 aml+9/eY2lNDEIDhLhlNWzbCpm6KBzU1WCOScke2GrEosr3UT+oxYrjDal1E0Ci1Yru54iRWumX
 pl1FiTl7j3Cvc/o/frB0gn3bq3Mac6+O3RL9b5B0xfrh0AbajAENriBaRlSlVGRHQZuBIWb4VvI
 sjZSQBg2xPeXWzY34nxSp7rhJWuP98208150j38LTfjTUgJL8YfIhT7JUmLm8+UE7wyETD0SHlU
 rKizavCxVa+INg5GV6A==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a47bd05 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=QyXUC8HyAAAA:8 a=WlRemHVO3nz1l1IDBnUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: r2-e7uXo3ErWnkz-ywt9s50SEGHAt6Lh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfXxe/s3Tu341JM
 MT0KnSJvfGMZ79iv7sN+NDw8ZU8tA4nPdSKpe1JUpgATXlMenEqkOhzijJBdic6gtABigzQNk+j
 TcUyrsOEAcTy4tAIjBD/bo+7N1B2/h0=
X-Proofpoint-GUID: r2-e7uXo3ErWnkz-ywt9s50SEGHAt6Lh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

Some devices store the Bluetooth BD address in non-volatile
memory, which can be accessed through the NVMEM framework.
Similar to Ethernet or WiFi MAC addresses, add support for
reading the BD address from a 'local-bd-address' NVMEM cell.

As with the device-tree provided BD address, add a quirk to
indicate whether a device or platform should attempt to read
the address from NVMEM when no valid in-chip address is present.
Also add a quirk to indicate if the address is stored in
big-endian byte order.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h | 18 ++++++++++++++++++
 net/bluetooth/hci_sync.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c        |  6 ++++--
 3 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75edeb5f6a99fb98ce4cc6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -164,6 +164,24 @@ enum {
 	 */
 	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
 
+	/* When this quirk is set, the public Bluetooth address
+	 * initially reported by HCI Read BD Address command
+	 * is considered invalid. The public BD Address can be
+	 * retrieved via a 'local-bd-address' NVMEM cell.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_USE_BDADDR_NVMEM,
+
+	/* When this quirk is set, the Bluetooth Device Address provided by
+	 * the 'local-bd-address' NVMEM is stored in big-endian order.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BDADDR_NVMEM_BE,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512a37c22b9a2be90c89ddca4b4d99f..56248d4abcb5b1d9993962a9f6bf60bf865b8d7b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/property.h>
+#include <linux/of_net.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3588,6 +3589,39 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_nvmem - Get the Bluetooth Device Address
+ *				    (BD_ADDR) for a HCI device from
+ *				    an NVMEM cell.
+ * @hdev:	The HCI device
+ *
+ * Search for 'local-bd-address' NVMEM cell in the device firmware node.
+ *
+ * All-zero BD addresses are rejected (unprovisioned).
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int hci_dev_get_bd_addr_from_nvmem(struct hci_dev *hdev)
+{
+	struct device_node *np = dev_of_node(hdev->dev.parent);
+	u8 ba[sizeof(bdaddr_t)];
+	int err;
+
+	if (!np)
+		return -ENODEV;
+
+	err = of_get_nvmem_eui48(np, "local-bd-address", ba);
+	if (err)
+		return err;
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE))
+		baswap(&hdev->public_addr, (bdaddr_t *)ba);
+	else
+		bacpy(&hdev->public_addr, (bdaddr_t *)ba);
+
+	return 0;
+}
+
 /**
  * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
  *				       (BD_ADDR) for a HCI device from
@@ -5042,12 +5076,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
 	 * its setup callback.
 	 */
 	invalid_bdaddr = hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
 	if (!ret) {
 		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) &&
 		    !bacmp(&hdev->public_addr, BDADDR_ANY))
 			hci_dev_get_bd_addr_from_property(hdev);
 
+		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM) &&
+		    !bacmp(&hdev->public_addr, BDADDR_ANY))
+			hci_dev_get_bd_addr_from_nvmem(hdev);
+
 		if (invalid_bdaddr && bacmp(&hdev->public_addr, BDADDR_ANY) &&
 		    hdev->set_bdaddr) {
 			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b05bb380e5f87715e2a4ac38aa7e7eb77c48549f..8f2a2d0f76adc3dd9cbe235d5ad0ed5e1667fcb6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -617,7 +617,8 @@ static bool is_configured(struct hci_dev *hdev)
 		return false;
 
 	if ((hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY)) &&
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM)) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		return false;
 
@@ -633,7 +634,8 @@ static __le32 get_missing_options(struct hci_dev *hdev)
 		options |= MGMT_OPTION_EXTERNAL_CONFIG;
 
 	if ((hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY)) &&
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+	     hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM)) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		options |= MGMT_OPTION_PUBLIC_ADDRESS;
 

-- 
2.34.1


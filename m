Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EC6466B47
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386219; cv=none; b=ZLXkxXeQFB60SmQ3ZXuXysaQl2OEXoKcFB+imqyOGy1MvFOKvLSf/KFRw7bosB6l4iRqPpQPeSG/vy2lT/qwLzLQ6ezY3CkqNUAPQHS/5Y8Va0yG4Q1jJTff30I5m4+ex5V1YfaVLCL/+w5pQAWJtoQ1kmx2Ws0wdkj5jtZeVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386219; c=relaxed/simple;
	bh=JHOUVT0V1f6mw0N8o8TQITsurij+VJ8yGqDAQM2x4i0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QzVD4wKX0Wcf0A+B0QoWDaL5tHVFzLqX5SeserBtp8Sl65nhihBBTp+POajxvHybxDB5EHJd01P0LTht9Nmo8/GeG+XINN1qLTTMuhet3dqW+Wjm0Sz2QEa40pbktzAqnSEnYo4cnEnw2KLTsL3AdzC5sTUPIO9L9ou5wbev8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EcpAQh6T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JGCxDVa7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EcpAQh6T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JGCxDVa7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S9GIVU662986
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Q1pBVZE4xUj8/QalPHOJhwaMsZksGiJpCvGtPNlm6s=; b=EcpAQh6T9qPyWr8l
	yo7/iDh2mvD2DmoZ3LQIwNGfL8V4wJTtdC2zRUwwoXlwlRKw7tuOUg6KOifU/4CP
	UrnUdvNmG+IvkyXs+9OstpsQK6fmAMM9MszTdh+SBWw4GJhbcoH2O2H0sCXclvQ7
	zoQQHAxmYz57Lr4TzeDb6+Jr7aXyC6L2tYn3tLfT/nfiK/O4c/WIlXw5WlgrjQBl
	/Hew6k6EWh6JBV4EyzP1TFMWHhfVzoCxdksYi8IHo4xF23hRwQ2L8nqYY0/RS+8H
	ksRpS6lFHVd3bJAYFxshm0dDtohw4J3Yyx1GzURiV5VtZ3cRULJSRIAlJ418s5Qh
	CVh6MA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n4bqd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:30 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56f66493ef1so5789010e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386210; x=1777991010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Q1pBVZE4xUj8/QalPHOJhwaMsZksGiJpCvGtPNlm6s=;
        b=JGCxDVa7xDL3CmLidLCAsUs+l7bdiNDKSJ8Uch2sM7jiSyOzwEZTiqCws9hMyw0s2Z
         kZfe4Uo4vx06KZpEwvjUqSTCwy+DP7N2moOCB4WoMiVCUuIEZ0X/tCF97PCB45D2PN+h
         UbhI/eyeXoUd+i7og0r/++0EUyL9F9kErQFVPFjF0WgdQ7JGbFtf+GAwB7c7JhqlCTRN
         utUyfXcUvMDVjhKX7dEXoj0RdroXsf7H9jKlM36ekx25clmvdggnXLDGGMxPHJ2PuqyR
         xpjfSzw4WNX8WyPODAth4jESX/0G2TCCwhhEZtywoCnI9wBXsArqYeb+b64Qd2G5iTDH
         xIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386210; x=1777991010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Q1pBVZE4xUj8/QalPHOJhwaMsZksGiJpCvGtPNlm6s=;
        b=NMx9UcooLRrBQgVeJ/nOt0Kv2+ubKcJ6L4R8u8yX29bSR79R+1Xs/QK9Ds+i9WHETr
         O+KqsPUgqC1Bnrtj5Xmp60o5WRrjZVKxGAYydOZ1tbor55pZ/hdrZHc55mJzHBnG4iWa
         +yYc9ybyMkAnu011ilG5QL69Oi3J+q2RU5paDjnJGQMFxRtySn7hr5LEMwrJnH/JEQ6k
         GfaO9HSzmGyDrsiwD73+Tz08Ho6DrQZO0vd6ywEcMWRlLOId7WiLS8uAo7dtnXnanPtS
         Vs0JAbbOnqol63iv3Guzs9PkJl7C3FOQqCBAs8MmO6OaSF4lf/VW/+PazZCRxahrITiK
         eLqA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ad3oV76SAULNBNARn0V4EOCnulRQ6oCBDCen/lSRYPVZ3m/HfU0GQ1s0zudINu0dFILrt5W0JaQqXzZuM9Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyLxdi4DWEsge/4V7+QXgu4II45xC4lQcVkiDZj0HH4DYejNGG
	ND/62lLlnhXkt6Y3Z15eOgmiIGOH6GWLjtDRxmd0YMZY/6aZnx01zD5rqiBroEhCzubVmWRt3Oh
	odDDE4j6/Olmuaa6/TEWGDwuuRRXNocW+8+1kzN1I0l3ZmLuaqwfmlCwZ8h+dIzzkc55NmUE=
X-Gm-Gg: AeBDievEEaSFlbNGXlu2fc5YSl2L7jOz7AaFDiZHMSkTuhAc/0d3lBZrAb7YsjRAGAl
	qmEHNaBDWURfAps0NyGgrQuCXaz9OAQ1R7rucZgUJAJt1R85YpUoK58gmDW9x5m2giI7kNwz6+2
	9gphrNrvQja4oLKfu6ppKsjcXWwpnxS4TdtJ1M47z1xFoVVhN55Y85AGx8wbpbWDwf6TremfTQu
	ZYsALpmXj2qjll4SzgAy0++yaEHDYavku9B/fHHGhPxlmjI3Xpaf9EI7rCzytbYg/udBptCiJH0
	IViKrGIa9lqPQI3LV981sQprXIHAFhp1LxYLguyEufn2IVkgHnMumzSgaUpSTGlGh1EIY8JpKzo
	GjX36fGOUF+4It3lEXvCRs2o3SDzF3hGsitLI237rsRIJIYCReH0J3UTVxM9QHe6oMRKeLUjP45
	peY7VJnzlz3chI0m2TF4ZRNbNvWMw=
X-Received: by 2002:a05:6122:83c3:b0:56e:f262:9113 with SMTP id 71dfb90a1353d-573a574bd4emr1580853e0c.14.1777386209861;
        Tue, 28 Apr 2026 07:23:29 -0700 (PDT)
X-Received: by 2002:a05:6122:83c3:b0:56e:f262:9113 with SMTP id 71dfb90a1353d-573a574bd4emr1580768e0c.14.1777386209190;
        Tue, 28 Apr 2026 07:23:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:28 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:12 +0200
Subject: [PATCH 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-7-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
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
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX4NbAOZ6qRNts
 vX0K97WyoxpT/dNpnblsxY/1b8lNBZVk+xX/OVIZFhsrMgbL18XnCxTEehfZsDsiQFei1+JDwo4
 FLY9zNX8LuTZJiNVhwNOyz8ozNXLbWHpb9X7LdNIFinoPY/Cv+JWFM8Y18TAZxhOVIe/aJihZlQ
 cVHO233Hu1CkR0iL3kGIbAHjO8/QXzPLrgvpkMNAO421mUUxICYC6WSlxJbqx6XPT+C4x+72vkN
 3Ji9EgL6Djtw43Qsm+IZuhL9zAmpVTC1zvazrO1d4O8GaD3EI9GaBqb0R01LuYuKXltEiUjT9QC
 X0XGjO0sgyq6QnCaAFcFLSI8EDSwuSWYeDfd53awQDhmmVzHdr//cEp3D/jrNUMtLUZAqVe5+I0
 4WATBzsUWzZP8Yiaq3kAfgX365QdE4uYbiVwWR1lVg7OtLsANpjzow+oVDcFzCtXtqvnYzqwTjK
 cCxD3svatNuG5OsxdRw==
X-Proofpoint-GUID: Q40vANb7NTRMsSHeid65YVzTG0l6LrP4
X-Proofpoint-ORIG-GUID: Q40vANb7NTRMsSHeid65YVzTG0l6LrP4
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69f0c2e2 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=teJl78XSWlBvCPfQsyoA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136

Some devices store the Bluetooth BD address in non-volatile
memory, which can be accessed through the NVMEM framework.
Similar to Ethernet or WiFi MAC addresses, add support for
reading the BD address from a 'local-bd-address' NVMEM cell.

As with the device-tree provided BD address, add a quirk to
indicate whether a device or platform should attempt to read
the address from NVMEM when no valid in-chip address is present.
Also add a quirk to indicate if the address is stored in
big-endian byte order.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h | 18 +++++++++++++++
 net/bluetooth/hci_sync.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

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
index fd3aacdea512a37c22b9a2be90c89ddca4b4d99f..f87cb6ae85c3a5754fe79f415ba05dd177f75fad 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6,6 +6,7 @@
  * Copyright 2023 NXP
  */
 
+#include <linux/nvmem-consumer.h>
 #include <linux/property.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -3588,6 +3589,54 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_nvmem - Get the Bluetooth Device Address
+ *				    (BD_ADDR) for a HCI device from
+ *				    an NVMEM cell.
+ * @hdev:	The HCI device
+ *
+ * Search for 'local-bd-address' NVMEM cell.
+ *
+ * All-zero BD addresses are rejected (unprovisioned).
+ */
+static int hci_dev_get_bd_addr_from_nvmem(struct hci_dev *hdev)
+{
+	struct device *dev = hdev->dev.parent;
+	struct nvmem_cell *cell;
+	const void *ba;
+	int err = 0;
+	size_t len;
+
+	cell = nvmem_cell_get(dev, "local-bd-address");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	ba = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(ba)) {
+		bt_dev_warn(hdev, "Error reading BD address from NVMEM (%ld)\n",
+			    PTR_ERR(ba));
+		err = PTR_ERR(ba);
+		goto done;
+	}
+
+	if (len != sizeof(bdaddr_t) || !bacmp(ba, BDADDR_ANY)) {
+		bt_dev_warn(hdev, "NVMEM BD address has incorrect format\n");
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE))
+		baswap(&hdev->public_addr, (bdaddr_t *)ba);
+	else
+		bacpy(&hdev->public_addr, (bdaddr_t *)ba);
+
+done:
+	kfree(ba);
+	return err;
+}
+
 /**
  * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
  *				       (BD_ADDR) for a HCI device from
@@ -5042,12 +5091,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
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

-- 
2.34.1


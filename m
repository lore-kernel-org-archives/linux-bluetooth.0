Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02704C77B0
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921675; cv=none; b=GY+F0olzYVNwlFwiYHdTT7PKW1UzoZdVOS6xXWiq8R62AR4yCxXufV71j2/pcMGlNCesffqaFKdL6NwqfNDmRYSNBbqPOvy091wNytdKi0t1m1rbUg4amUN1yXxNdyvMCwc8roNpjcrBjvxYjgMmpufyh+72bxM6myQ/BhdcD1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921675; c=relaxed/simple;
	bh=xfmoy+hPtoC5+UqYOV7i9p3VVCicrM1Q946rAFKBtYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ek51MZXn14AlHkKG7B/Q3OfshrHZ2ZXpXf/tFks5GxF2Fxawt5u/hw3gGD2mmZ/MSSd2FFvKexwSR0H5GWRytyrarEtUszU6HmA7XPLBXO5NpGmCLWt0CjuPcdtPKu4Gjq/EZJOACLMGZU39tbO65UHPhhT34E0fQTII7k7nuZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RmfiO339; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bqhZ4hbR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RmfiO339";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bqhZ4hbR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoAWC1468596
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Jul 2026 16:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9YSak8Ew9R23ftO3G6++eI4jZmwu0q3/SECsCEcQvU4=; b=RmfiO339KZkoqVcU
	OC2aMvDyZNB1SRsiSe4KdSthLLl9QAzoJPKGzYyRnpg+aN5IiJU5YtT6TW5gvXJH
	H7LOBPJqGiKZY3M2Oqmi7yzZwf3Lt7dHrTaVzqDINMl0dJ2BeXptzOxdZAwmp2TB
	A8SW5c2astmVOiHFj04qj2M7OF4XzpBGjCtjeyFJ24BfVr/cXFzWgF/s+p4Nm1he
	c6x7fU4Y1Kt2nF0VU9RjcdQjSAfVGVIQCvsnw7gdktfZYCscoWmcGCC8ytFkKTT2
	6AbgaHDSjlcmls9cLaGTFaDvh1ZLNr+7c1FvyGFbMYtlkfPplUxv1Stal1HPSdHy
	FIhzbg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3sn19y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 16:01:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92aea0d801dso103476185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921664; x=1783526464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YSak8Ew9R23ftO3G6++eI4jZmwu0q3/SECsCEcQvU4=;
        b=bqhZ4hbRggb/j4RDTyFBqrnwv4UID+wEcs/hc49OIJIpx4qxrGnBHvw3bG6/zfFvuX
         iqEKzB6p7UoG5O11BDmBOKAsdJwxcE0HAVn30Jvvv3kY16P+GHS+4K1GyTCwxFswHyqb
         /1NZkbGaxO3QaA5UADod0oKtXmcLc5e/sG6Zk146yXbAzXU0P3B2Rf0tY8RrVT1uKg4l
         o7fTzf42q1P6H1TlgVeGx+KuBoLilSnrZD0Ox1jHPWVeVR3YJHh8ffLCu1ZO3vMxqHMO
         vHusIDNumnOA0/X2GcB9De8qjVBZnTlQWD5D9mZZsnWPEZ8wDnvM9QruLdB6DgJe94ax
         ItQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921664; x=1783526464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9YSak8Ew9R23ftO3G6++eI4jZmwu0q3/SECsCEcQvU4=;
        b=MLQN8ZietZct2M5QnegLIGkxt0jhPw4o1/+CW9Zip/qeEEUnn49KRvaP7DJRT5IBrT
         kiGbv802TOCkvXakjSi/iTWjL+J39MzfjP7UARQ3C0Rooq5YXw11BAD85j1Zz7QxJJNq
         JEk83IfdV/zHoJUaajTdyh5rXoPj+QbAfRhdDedF2KRmUbQTKED/Al6KwcA+a7HAL9ox
         w9zHdFzv0B41mp5jXthujopSZx8zPQHCXJzHqH/VA/xMHzywqwYI3CA8FKxJ5Ohvgpa6
         wpsvsaoXpiultTWoPsTDIuUrUKlj+lRZt+zE+TmYhDskiaVzJZIKOPl5RCleRXcyWU+i
         zRIw==
X-Forwarded-Encrypted: i=1; AFNElJ/qwT2hVv/Cdtb/EnG8ls+DhjRes7DdFbzcDgGcysRPsuuVOifGtIDJnlLxgFf4wOYAAyJcpw/DcDeBEgB9oJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkN2I4g8SECWTU3XGYJiXCHiqNL+hGsMm27Yc5ZAjcXwRBzKeA
	2jXsNh+uqCB4f24X1QDFzrQn2wH01AQADKEa10V9kjf5pN9+zz41oVktWWfIP4FKfV44hRp80gC
	tfE9Jid6mxUAwzZIYuNHLKczwzrs0AZdbfsVZfWXaJS66px01Bh+S90IcuRf9y1xYn4x9UU4=
X-Gm-Gg: AfdE7ckjY/Kw/CgxAMprmtwGLmGIlJ5+nRzALducAgdvgbYe3QTp9ILeicUF6AbQVuu
	EZ3eWW0zm7VhS7+bT2oUm+IuDQzcHgi1pxjHOgZQ3j1XgO11AQsmdQEQ8Cx3i6FP4TCFlAi422n
	rIgWj9uk/ZncRmMrt7P8uP9UZIUlo0ZCIAsNwBXkz2jXCcoJxUcguPsXiSK3gAz0ImSuGoCJd8e
	GN2NBPtZD1s7U3Jl8/zbJ6uCN6lpp4yV1Ge4fGa54jlIC29kjPU7AOY15yZF9gXxbnqzsOMuUvA
	9MR6PxhORdcOKn9jdHwECVCsKlijy9dclOQevvBFtK8viWbJud6DAgwrSmh65V2Mqcj9hiyxoBl
	+41VwINxkQ5P7ucoGV+qFrrFrP4e0Dh7kXwcOrmByPYTzkgX9ddlOA+CWWfIhugAC/7ISPEUizp
	ANB8y+7uITjLSfF48TEXHGd0HWYBazpKjcztMcjPbddSLxca1tnWWzL+df2GdTCH8=
X-Received: by 2002:a05:620a:2987:b0:92b:6805:919d with SMTP id af79cd13be357-92e7b473836mr228637385a.69.1782921663928;
        Wed, 01 Jul 2026 09:01:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2987:b0:92b:6805:919d with SMTP id af79cd13be357-92e7b473836mr228543885a.69.1782921657091;
        Wed, 01 Jul 2026 09:00:57 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:31 +0200
Subject: [PATCH v7 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-7-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
X-Proofpoint-GUID: jg7Sy8Luf89ew6bj9TI_SSHIwxi_yQyD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX0cJ2dGgNOQ7t
 usrLDWP1Ybe4cJaArA6hoUFa0Ml8Q1KDblTPKhs2Y2H5QQbaCSb8P7nQZwqBW8ftoR/N7byQ/qE
 hec8ST0n8XLY5HN6pLy8BzbzErVAr4H935toIUbOejfCOXwowmjzgLIzp7QLjFalXX27gIlbB1M
 KEy99x5CjB7m5+8MtYmaqhbbVKVrNH+vErQTQ8o7r+zLovA+Ne8gi5sj5OiQrcOgtsJcECeUWiR
 tUEtsGtbwwVjq8hsCkRCsI6rRmzd6+8e0U0GaM/G2MNMOw2xgq3TH+6c/bMciU0Z3SRqNqCi+bQ
 /MVmycgC9Eykq2zLBnMtMe2vZ0F57YevvsREd5oUGKTNJzvWUTedXurC/O9gNTUhfYlUgU11N6X
 t0lJAahrD8qnUkhHPTWM4s3eUFg5qw==
X-Proofpoint-ORIG-GUID: jg7Sy8Luf89ew6bj9TI_SSHIwxi_yQyD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXxTNaqTjUAGSh
 x2XFz8wuQR65GWreFrvfa2OkgdO0CtgVOtCDpLbCrdxnnzvXDOEskkZRmPllv15cKbzvJJXSH9K
 exbjOZ3eOujbDZ9Yss5e/t7A0mipexM=
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a4539c1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=QyXUC8HyAAAA:8 a=UCHyucM7ZhvORosJgB0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607010169

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
 2 files changed, 58 insertions(+), 1 deletion(-)

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

-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF134AB14
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915861; cv=none; b=JknaQ07vb4EDy5nxt7LwWHxXI/CrpQo/hVibNzBO/jL443nP37VV56gM0oDdnpCUWJ7Y0CHpSZfJz3hRObv4hZwg8GLLOFhSZjtznZMRpdl7bpDp1OZv8lSNWqbCwreyzcHqLcu47S2s5KVtaXSS7eANbEcInEQSdS6FYmkKG/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915861; c=relaxed/simple;
	bh=/5JSpbZRWY5COHZDhN4gNF7Jnw0iPmpuvearF0ixaPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WmywoYa02f37mg5NYmQXGWUGWAOf6Cmcdv3kY2NOPswDhQmZIwFyBg5YEHhQoIvA20EXUAU7eDSTbShcemCeH2aNTJZp4Rwx0NEf9GT3mj9T4W/PpUoS99BwopKLyaarM+katt46uHtoeDQLEh2XhFa/o0hs8kWgvTRnPd16Qkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=obiN0suf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BXFb4bsi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="obiN0suf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BXFb4bsi"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658928Lt2677482
	for <linux-bluetooth@vger.kernel.org>; Mon, 8 Jun 2026 10:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=; b=obiN0sufjkJIpbxQ
	8vAJpCWlvQ6AfuEVCWzooX/FKI2cWVAgVgajihPvBG19b2Db7MnD6XFd6oaYulzd
	HhttUgGezEYy3nDqlek/pgr3mhESpR6r89Qrx6Y2GHYo1JpdXrksjyu0bzQcH082
	2tDF3hRcdu3mcZlDs0BCN/a68yp2od1bgw+XXV5+VLXiI12SSyfdVNrzy9ogRs7o
	LE+kmLmZrn0LDN+AkwK0bwz8U+CEa/3uR6JQIFDE69I32B1wF8pheSIeUyejN19b
	5Fn0uxOby9T+pET7rrfrwTM3MkLqsPfCowSflBJl3Js4mOz1E/z2v9g/sVVemFfD
	OBDSZg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrkrfeg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 10:50:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5178fc89b1bso51353031cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915857; x=1781520657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=;
        b=BXFb4bsioTn9DQ5WdCMj70RNo3T5rjnxTNB1NhcekVfgEoP+fFa2mvVfiWOKJWiUrn
         W1CMfuv+Y3SZ/snnsNERzAFvXo8SppSUDku2HFqXUdH5EWOcmhDby/ycYs0mUuP4pZnh
         aiWVDayD8dq9mtrpnuP8jDOoUizdVyXvDgA20qX59KmXsc4yoO4IxQe5txi+lIISpPrH
         MsyB1nOaQ3cO6EISfm8wqwlZ6ZW6H34rvcv6NOYa3pJ+brd3S+X+3CTK6qAPjee/Gxoy
         bt3PRMxScZ+P42BBq2l1GYa3J4m4DECNHwHqmJMXIzqGfk4iCtTMK7wZXfDjgx+BuBd0
         rgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915857; x=1781520657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kVKEAS8GhVMCCsKzWvqDs3cunTV/p/7YyYFmPXPEJtI=;
        b=EhSSqqbqZ9EBSXOtPQfctgWavxrvp48SbWW/X3At5N1SlbPl3Mei03ujK7+trQassM
         8E2RAdGwKj5rpMZhOqC1kbUoG8mwMQAn0lqfV1EX+9wlLlg42vx/4XIS2uXYM6XFapwD
         N0xUUWL78vgSe94HulUi75PYAugRtU5n5WBBLIQ3StZ2fHLhbF7UkOo31y7x7iQRdors
         /3gbX/ZKjeQKBqG64jJoBm8Mx2TQU1rfs9wD7SJRlWiS/xcwT9AwmUxW4XCUfdpJkZoe
         kRoHLIMz7rsU7O0O1YHSteIpeNkDS28iIde5xgC003KsmXyr/e27WEI1nHPVA8hp9qHr
         sr2Q==
X-Forwarded-Encrypted: i=1; AFNElJ93XSVc7swo2zAtLVaMoWgT+noN7IgSM7XUXwqFkGU9TzdHiQzFpo+vr2EMByj+ZWAdftBRuA3f2Kcf73Opg80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3DUTUCvOAV91/BMqVzR5RrrAe0aU3wY+kjz1iaXABS/JXhAp
	IBUFhKTtiNW1G2DV9lLMswp8+3HEU0lx1e+MlDpBqfDBA5ghWxUgYGgCGB1lRr4PS5xOHtXuUxO
	2itUyO5H/Jqx4NFnqHVNBqmPF1xvpVMB0tgnZa/l/zXJ+7zN+R3Zac/WEU1a6Z6vkhHfd+C4=
X-Gm-Gg: Acq92OFxtE6rA5v3zOFub/mNjH1EVNG9qbep40QImmFMuyEUTyUE+jP1+lfsAkfzqJQ
	X2+zDE1IXgeBioJzC1UiJMkHiTZj+w2sCNDMIq7gBkO4gpSMjmZQ5oOmoUpnmSHYXUrU8ovhXdi
	B+xrOTZ55VSND/S0ygwOEA7PO/KsPcbQ94i2JRl3/Ic1N/ecfubp6tcDt/rebfLjOs+UNt8UX7b
	rh+TlFZQnOMB3kIRMBPcoYGTauulSYhZIldkKgMJa52Cs0dqHH3/q6pZVpr35voMo6Zkp/iYHLU
	dxt6l5fmNdZmeUBnF3fPxy9fQ/gNA5DI3Z1TfkFusLabb47Xx7kpswmZekN+8HHyddpG9CNzogx
	E7IJd9vNfMTjEWt9OfC5xO1mqfL7N6tJy9c4f/MoXuZfBErtSdAPsC/gMGhwracZDkzQiOk5Kc6
	sF+SAO0yNftRNfda9TxuYpIzXqCCYExoPWPXgTcn4dURd8PWXY2zpabHq5FMzz1L7nSq92IphCV
	ZX2ZcgdpYPB
X-Received: by 2002:a05:622a:47c3:b0:516:d4b1:48cc with SMTP id d75a77b69052e-51795a4838emr190287431cf.8.1780915856865;
        Mon, 08 Jun 2026 03:50:56 -0700 (PDT)
X-Received: by 2002:a05:622a:47c3:b0:516:d4b1:48cc with SMTP id d75a77b69052e-51795a4838emr190286901cf.8.1780915856424;
        Mon, 08 Jun 2026 03:50:56 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:55 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:50:43 +0200
Subject: [PATCH v3 6/7] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-block-as-nvmem-v3-6-82681f50aa35@oss.qualcomm.com>
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
In-Reply-To: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 8hMOPHDSpXZdM8c1cyG2TQ60k45ezJ2X
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a269e91 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=tQ7bI2BnKgK5Av-YYOwA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 8hMOPHDSpXZdM8c1cyG2TQ60k45ezJ2X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfXzTd+kCOLS7wF
 Xes8k7ClQgiRHKXpQXGKmyIz1BXniJws4JJC2I28LX1qKLnKTo9s2/twNDC9wpTHpKhn58MjSbI
 0Yc1ioBWo8fS/GsWLtIV6NEli8dDI93XZMHUJOCBiGxAjGLPJ3tClWnVPkgMCuFQoIkPiKNaXRs
 t2PwhdWqqZ7HxeEtvBWewrWmY1Ax3EnKdWEJ6BNeh0pxzxC48OPG7H17IwTpuP1zTxp/xCC6s5U
 xUsbPLuDjUiHokoLkJ/Ba5TQ61kfKEfsYW1jfuo1rF1udRQtIYrLbc+afMDqynwZxoZX2jwcm+Q
 /hgRiJElw7r4M7+3sr04yuJfoGUpV1xwx4XzKVpPGjWII0CHvaZbQ1/fsQdw7gUUi6Yp1UA4Nhj
 /7UtCdhgmKA6rXdHXHlDbrkJjgXMoKGMQNUcy0yqy4q+16ro5OB0Jdnhqzo8bWaISxAv2E9tJw4
 MX1CApyYaO6Mc2vl/QA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080101

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
 include/net/bluetooth/hci.h | 18 ++++++++++++++++++
 net/bluetooth/hci_sync.c    | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

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
index fd3aacdea512a37c22b9a2be90c89ddca4b4d99f..589ccdfa26c1281d6eb979370523fff0d7920302 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/property.h>
+#include <linux/of_net.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3588,6 +3589,37 @@ int hci_powered_update_sync(struct hci_dev *hdev)
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
@@ -5042,12 +5074,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
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


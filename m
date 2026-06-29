Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C83FADF1
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723354; cv=none; b=QfvhaP8v2WuRkDWmdz0y4a48ZI2DfNy5ErQr24vbnT8eLUZpbRioRswVsXIuLuPYOcBdM6Qq1pLzQsBKE27tQdK6ALW/zDtiqsF1xGgtqZgIZgYXSGp9oRK4jojAj4jYaDmPyOMGUgM1az9GyxeBLbZ0f7QU7LHwDR72hb295Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723354; c=relaxed/simple;
	bh=DhpKvk+qKi33tdqHXBdyBn+qHlFJWo7f2LRbmA/QYF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SsHc3IW+6zi0nGpyq4S/AxnBt4ZLvMWNR9mTvjK7SOiy3dGk/NhE+1pNIN1+6quGw3OZkizmoAzhHGmGe25cXIlI2fOnYOUhsdXrXZFACcGRMOZHlCDJ/px1YLSwHfZzWWoeW3TxvPKTIQwuYzAy9jfn+bbVAY8zqvt8X002O+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lfDvGzah; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WyrvYIAU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lfDvGzah";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WyrvYIAU"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rGIR2101477
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=; b=lfDvGzahDOgYX5Ff
	CC0oUo4cAzW/QEmUxZrtk2fhPOP2lXAP9AD1ydUq3wZVe+kIJvPZd4keEeW7Srm+
	xAtIIasA4rAn7fdL0ErRC8xPfgZtQYiZJDgf/mPwog9Z+uvH8YmCjFRXUGdmE2nf
	J66c2Rgkld707x/0ZdocfsHcX+bKh5RAqrgSdkCLI/R0zAJ/BsaDGUxfB0V6NEjU
	he9RfcUkfK135U9WYtfobF8EAynA2buZdpGfW5vEHy3Elfoxp32GP9Hk6yGonbv4
	sfooxxl5Do+mhZNh3Kj1QFPfl6ZzZMRPG7DkQ98SxWQgp2nY4PoSfnD/P3rpAoxR
	wmzfUQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279cng4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 08:55:48 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9692df7e2feso540349241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723347; x=1783328147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=;
        b=WyrvYIAU+ZqJPtr/1psR3gvEHv8Mm/dD31TxPdeSphY3+5OvpW/CbfqGtrAsVB8x/g
         TPNycD//BJ2YmmDcAw9GEvS66tqBJaJruWP+zZS/t1OegE3jAtSy0XURPsdtBx3YpwEn
         +fyv3MVJdvbnZ9BpqfeqSG8gmNrJBY7iAevEaAOkYHVxeOhkeii+E1LRWay+3Ya40SA5
         0nQU0jOi8rEqOXdTSMpTM4bWwiVgnd+zpI236Ml10r4/IAjyG2dRQm5Pgy/t9V/FCS8o
         jvtwwJcnuBPMlnseljZ+1FN2PxTR1BSXAZ3Z7hUlretUduSuexvwjApCpqcRpwxlfvg6
         PAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723347; x=1783328147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=;
        b=ss1Ag0CZuVRsdbHGlQJwaqUyUNoqMJU3HzUzzVjUjQr2+OP3c/B1GT4ONNuclNEbww
         oy157xnL4+bQIxVdJH2NDb7TtKsv3VVXebsqdN0JI1A4xchLraUOHVlR8J22qjhzalUh
         hI2Kria+DSE6tPraubpqrfQwODBcKYiYeKOyf6khwQEp9xaqGx7whbLIwrf/9EHIOvJi
         NG8SBh6QWLIBkRvsd7aOcOy2ps3w5LfEniyAMFcdBF3DleiDCgv1MZP50O2q5CI/kitN
         3HxiROhb4L+fO+4bQTaubauVBDE+kiQLzYzQcPunogpbzNov5Y+YSeocIOgY5dNTcGea
         m0sw==
X-Forwarded-Encrypted: i=1; AHgh+RoL6sEBUABDMmcQaxBFzkLFR4yLs48DeCwMcth2IDChUwYL2K4ZTmie/L1jSYr3mOReh3NUmIE0M+P72qe60n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPwVihQNQk6jXPX/F/dkKB5a8xF89lPEJr717NVkzLyMB5qGk
	9f81AChliKRRRqnOA+yhDWENCERkM7KQJnaHbmbaf4w35Qc91Idfrg6xrxjDY7MhBAAygY2Maq5
	6xyfRJUjqU/OR6HiEx0nd9Cq5Wr8etmrPdbTihhdXH/vyU4WqcN/RqRKORZjCtVBrf9KaVp0=
X-Gm-Gg: AfdE7cmsyJUyT7XDWocb9jXzdXFbkF1/C3blbG3lsU96bYeKZ5NyU/jq83nS3kakmAK
	T/7j59eMxRmoKNI7veDqCOZpBnrwOB3HKfH7YOve5A06i+idCyffLsbB53EoQfbzF/KerQEGSiZ
	Lq2hDcWPOphAuy5d6U8m8eRoYUSc7DyVG20ms18ve4DqWBZXSLfHeZQDN63eyMHFUAcNP5v3n5d
	9W1F5XkLazTr1VuviAGSG0FOSj/HlR6Y67IO0iMU5NMCVQ/vVy2iDYmEzrBZycZmHQx8QWjpjiZ
	HVLsGMRvMZpsrnLUvlQ1UUzhcXbLPeb3YfgX8IXM+FZLBkEBPtAr8GAHic2Ox0ZHJ+moA1Z0j9r
	PENx2c/9acwicQ5MX7ugZhv93N6TqjKwny7WT3g8+mrMUz2RZSerEebci7PN0R98/wqb82irsFF
	q44epwmkLKq9ab64AVnXWM38rbtyKeR323GWrIyRgVYmHeJaKjye67Q7fOx+2TcOIlVbaLCYurd
	dgn1ia4Axd/o1+S3pHF
X-Received: by 2002:a05:6122:f05:b0:5bd:9f23:a74b with SMTP id 71dfb90a1353d-5bd9f23abbbmr1750205e0c.9.1782723347139;
        Mon, 29 Jun 2026 01:55:47 -0700 (PDT)
X-Received: by 2002:a05:6122:f05:b0:5bd:9f23:a74b with SMTP id 71dfb90a1353d-5bd9f23abbbmr1750189e0c.9.1782723346638;
        Mon, 29 Jun 2026 01:55:46 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:45 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:26 +0200
Subject: [PATCH v6 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-7-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a423314 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=tQ7bI2BnKgK5Av-YYOwA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX9SeFSbW9hvOU
 PXm2rd/dVfu/4wWXhFvy+Nd7axrnVbdmbhh1t4VxIfrkgPUEZ8C1NEZj59XaeuB0q9xc3w+8xKH
 eEDfb1YyDGM7y5aQAO3XMGSeRofi7Gc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX1ExVywycCaJJ
 9l8Y42DBbhtJyiArtWM+JprdYAxgYz8gSYW5tz+qAWGJFtMijz8qwsxBmK3ir1vGySGiZe5hcP5
 LPIA1bduJerMHf6o7Hx2hody1QnSkwE3ft5KuTYzn+GKpDHboeQkc8Za5Rue8hO9XiLYHN7rV2y
 /BvZmr+cFBWewk+BNseO39ZYMLZ7idyvNZVc2t2MXn+h0MEXMXO62rLXJQOsTyB4JMKwLZQE+6s
 OVGt6m4Y4cTHyWPBxKzm6jnohzLOhDKW1iAghOxYNRuSJ1/G/LaoeJS5e0kFjOVQ/I3oaQGbFLm
 fu+Cver6D5Bu0xQBJMGbYwuqFr1C9Eobo3U0OnFsT+agLrh9PdKUbDSS2n5wroAlRylfrUNuaN0
 Z0QYd8efZ4MXVgBzOFWb+HJnOIJFQAjGYmo2FrltEykeN87kI7Dxh2Tu5SXA1lS3Lxfei/mBd9a
 TRGobB1zwgB6El58BTg==
X-Proofpoint-GUID: b_rlSUP7VcKXsxJudK_-Btn5Yq40o6HL
X-Proofpoint-ORIG-GUID: b_rlSUP7VcKXsxJudK_-Btn5Yq40o6HL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

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


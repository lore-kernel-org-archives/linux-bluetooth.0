Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5313E5EF8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991612; cv=none; b=FGWoI+RkxA9/FsohML2uFgPVn/R70H76ntMh1Rcd5K8ZIISFZPlZqfuRSQhV0y4249/+/imgiA0irJ/FMwnBClkMW9dmNAIKRV1JyJa9HKeBktv8aEXpT3f/tpU+ywB5u29YMl4NN2d8X13SdJWSzygH+dSOBAwhQ3cauV00XDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991612; c=relaxed/simple;
	bh=jD3L8jwoh7BLSovJJN4zvcH6m1V/AR7MZ04B9wQ9s00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fttz9lf5R1Z4oGZk8nbSFnpP6NnfBDw703MuK4Ie0FezINGSx2Io0NVLbHPsVjke11dhObXnHZLCWUKFAtcXrgq6g26zvL8Mu3v8Lj418dreTy7vO7udaK/M9jboID2kp46D7dKa0REwkIYAmxgWqNCtpZu10ACtwjJXTK5dy7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HCH16y7k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EADM2Rho; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HCH16y7k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EADM2Rho"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6596xmiu1878524
	for <linux-bluetooth@vger.kernel.org>; Tue, 9 Jun 2026 07:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=; b=HCH16y7kViKLrFhs
	7UsBAF+HpVtfvq6yHiDLxz+pt8PFwySxN8mnpW1Gdfh0XVDOyxaWimOZPRIb9Y6l
	WuYg/+wd1oCH6AjumAJ2aPpG7xkNc2YACExFChrPhea6T72oOfpaFljXnqD0+aUD
	Z1fYgJzF6FAhZKI16j4THgQ7UwvIjlAQTd7Xifd428Jf/bnFybCjkE9lIi+uqpaj
	o7nWVA2f5XcNAgEXv+ZaYAZxwkA4+j4eYpdeLUIcZNmJkqcI6sDBCvKiKnQhx+A1
	LsgMIy0sOAE7ML6VDQ5/2TQqt8u86ih7bH1BBDHRJ8S0ExMqnVRPrbZrU2TtWXee
	bcEBug==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epe25r733-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 07:53:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-517600719a9so89035461cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991609; x=1781596409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=;
        b=EADM2Rho8jJ7QHq+ihpO4OvLx6V+mPk4ISvC+FlXlklIRIWNUXMm3LwFyRFS5UDwTf
         Vm4lBn29ClU64bJ0emEutXr/uqnRrqi4DjnVDfiTTB44Rip+0IdACfg+EFjQZXc8XVNx
         9L+EV89Ic4bQ2mUItfPkXUBwSdrlZ4OXr9p5w21e86GUZz0WCtFIPIMITNyWfQTjr3aE
         V9cPO4dOqMKgbLkHY9HFSlNpI2FbbjEyzZuqLHu8wuiNQawAWl5VFyof2RLVd+On6m79
         Qdk6pXuRsNKhVM1UlU0r9ucFb/8piTarAHUp+I1+nIpAxtnJeY9rHN65ItxpA6sYs7Sz
         6EFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991609; x=1781596409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=;
        b=qcR25KLj685yuGBvTYLRQm8qfniOC4QsdDDRckjgLpbSOj7woj6Ga2FLuBT7/3OpWE
         upX6VFHr5czlCeZfVyaID+7xjqGhn0gaFV3kvdR3QNziSoF7nMOCtYauW4dG2DUsMuvV
         51A1dtoqke7jL0EeDc/A2M/uVHHNRGPWAWd6KW9w1sxazYWYt8UoWSmiuSlN0/YsoLIA
         80bKJhtbV9gq21ss4b0bw1WWS2e1zFTvMozLjigdfMpnfbo1+aAhNtCd+m3n9/7/p3Bk
         BSLR/qhCCu+97dJKyphobeJEUNIJ++NzhKneH7EZU+jOJcPm3iZJS1ofB8FJikTJiznd
         uAdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aT5iqNAeseqKht+Zn8MHwxPvvWBTEw0nImwjBXXNPjUBmGl3x6i5CWMvAqqlNk0aE7iVr2BJyRJRmRNgrtYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyibVXEibe9zN4SqRwuj33ANWLXLS2Ulqz/0bqbiCwgv7vh8Q/z
	Rxwpsbv6I0HnHGB0XhF5g3w98k6NmWtwscSlDBAIfBMOI11H9M4Brn2vChkuLS8e8eI8OaFKrWv
	x/XgGScf0gZT48E3tn7bl57KEk1vWYUGuKBf48b2q3utKQ6zaoIF2ceSUmQuTmFDkY1dF3wE=
X-Gm-Gg: Acq92OGMqpUPpbwSA5QrwR4uE5sAEV5CqbrioqEoyPaZkRxb9NuoYU6U0Dkt2wMZSOc
	jbXz9OfvOumxTqBn1VwcZfOw/AS960ZtSZUyLP7t2JW/OckFofIfiExKM8sh9quEBAvoiCUA+Zm
	ITvClADpAFMRbrZ5D8NZKkkOFyqonygA7vSOW4x/T+vsdYaINDwMuTgUFVtEl0ccjrFChgWIX0/
	HpMRa+dFnWOApx6MDGTzXrvQdtQn4U/Wt8/lIjRtiw5T7n9UiDSHwDD4+VmPvoHSFeuXoWcnw7b
	+n49Lztb+rMaJitDEAZZTKglVD2no1arx6VXOGACVslEOQ4J7+pIly4wjG/wY9gkiuMVhe64SDf
	md1Bt5NzQ6SBp1UWrhQEVZgJZO5+x99g3vFSsubfKjun6rxG274zD6l8P1VJx0s3Jt++i5s7wUP
	OZcR5mvfIUpillqSj8Tg+TzfKHh+HmY6N1IoQ0m0leAEtrN4hsNxr/P7+rsn3aRzdTSEK/fP0CE
	DHaIsPsadW3
X-Received: by 2002:ac8:7612:0:b0:517:a02f:171a with SMTP id d75a77b69052e-517a02f1d7bmr164821541cf.36.1780991608570;
        Tue, 09 Jun 2026 00:53:28 -0700 (PDT)
X-Received: by 2002:ac8:7612:0:b0:517:a02f:171a with SMTP id d75a77b69052e-517a02f1d7bmr164821031cf.36.1780991608169;
        Tue, 09 Jun 2026 00:53:28 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:25 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:30 +0200
Subject: [PATCH v4 5/8] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-5-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: HSx0U6mhx3M17FZhwbj9QNu-ndMEMHGi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MyBTYWx0ZWRfX933jHDK/nYtS
 sTIt5/pVtBLPNWzLUxURLy7fgJE171WnLiibNneQ4FM8s/ypJd3W2Y3GyapIcd2BJ231ZNh1sQ3
 uEA2FJ90EC656qNcVQbmJWNnA/QWQGtpfDOTcHtISd9OZvQBT/NAGMk3HPXhjlxYQ3iMpj6w0Kp
 bccvyDeqdLd/K7/7TtPq+Vzv0nkyjIHPRQC88GqQwWnF9si4BZa2HahXiH2LKv9/gzcytqB/d4J
 qUn9LeM5i2EoRVYsldl3m/Pt/TXakEwtv9CCeDipaVJRNMpUOqBU4lTUXvhJpEHSaeOh9FxDmCa
 P7CX8eqHfOKOa3vMczcW2YoO2fGQgn+U7jyj45IH95HxapJ6fJq/mJFD/5ysOxRefjObntpWUa2
 VR/3hj6HrABP0pPSCO74MTEYWzmeWarcQ+ncDYqIEOgctWIyWBQr/s5ke7uKyRRIybSwZf9wGLi
 EhnL98EMJQk3Z4EKhHw==
X-Proofpoint-GUID: HSx0U6mhx3M17FZhwbj9QNu-ndMEMHGi
X-Authority-Analysis: v=2.4 cv=LoqiDHdc c=1 sm=1 tr=0 ts=6a27c679 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090073

Factor out the common NVMEM EUI-48 retrieval logic from
of_get_mac_address_nvmem() into a new of_get_nvmem_eui48() helper that
accepts the NVMEM cell name as a parameter. This allows other subsystems
(e.g. Bluetooth) to reuse the same lookup-validate-copy pattern with a
different cell name, without duplicating code.

of_get_mac_address_nvmem() is updated to call of_get_nvmem_eui48() with
"mac-address", preserving its existing behavior.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/linux/of_net.h |  7 +++++++
 net/core/of_net.c      | 49 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index d88715a0b3a52f87af23d47791bea3baf5be5200..7854ba555d9a55f3d020a37fe00a27ae52e0e5dc 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -15,6 +15,7 @@ struct net_device;
 extern int of_get_phy_mode(struct device_node *np, phy_interface_t *interface);
 extern int of_get_mac_address(struct device_node *np, u8 *mac);
 extern int of_get_mac_address_nvmem(struct device_node *np, u8 *mac);
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr);
 int of_get_ethdev_address(struct device_node *np, struct net_device *dev);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
@@ -34,6 +35,12 @@ static inline int of_get_mac_address_nvmem(struct device_node *np, u8 *mac)
 	return -ENODEV;
 }
 
+static inline int of_get_nvmem_eui48(struct device_node *np,
+				      const char *cell_name, u8 *addr)
+{
+	return -ENODEV;
+}
+
 static inline int of_get_ethdev_address(struct device_node *np, struct net_device *dev)
 {
 	return -ENODEV;
diff --git a/net/core/of_net.c b/net/core/of_net.c
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..75341c186123e949fbe21f1e51fce3ac74d4f56b 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -61,9 +61,7 @@ static int of_get_mac_addr(struct device_node *np, const char *name, u8 *addr)
 int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 {
 	struct platform_device *pdev = of_find_device_by_node(np);
-	struct nvmem_cell *cell;
-	const void *mac;
-	size_t len;
+	u8 mac[ETH_ALEN];
 	int ret;
 
 	/* Try lookup by device first, there might be a nvmem_cell_lookup
@@ -75,27 +73,54 @@ int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 		return ret;
 	}
 
-	cell = of_nvmem_cell_get(np, "mac-address");
+	ret = of_get_nvmem_eui48(np, "mac-address", mac);
+	if (ret)
+		return ret;
+
+	if (!is_valid_ether_addr(mac))
+		return -EINVAL;
+
+	ether_addr_copy(addr, mac);
+	return 0;
+}
+EXPORT_SYMBOL(of_get_mac_address_nvmem);
+
+/**
+ * of_get_nvmem_eui48 - Read a 6-byte EUI-48 address from a named NVMEM cell.
+ * @np:		Device node to look up the NVMEM cell from.
+ * @cell_name:	Name of the NVMEM cell (e.g. "mac-address", "local-bd-address").
+ * @addr:	Output buffer for the 6-byte address.
+ *
+ * Reads the named NVMEM cell and validates that it contains a non-zero 6-byte
+ * address. Returns 0 on success, negative errno on failure.
+ */
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr)
+{
+	struct nvmem_cell *cell;
+	const void *eui48;
+	size_t len;
+
+	cell = of_nvmem_cell_get(np, cell_name);
 	if (IS_ERR(cell))
 		return PTR_ERR(cell);
 
-	mac = nvmem_cell_read(cell, &len);
+	eui48 = nvmem_cell_read(cell, &len);
 	nvmem_cell_put(cell);
 
-	if (IS_ERR(mac))
-		return PTR_ERR(mac);
+	if (IS_ERR(eui48))
+		return PTR_ERR(eui48);
 
-	if (len != ETH_ALEN || !is_valid_ether_addr(mac)) {
-		kfree(mac);
+	if (len != ETH_ALEN || !memchr_inv(eui48, 0, ETH_ALEN)) {
+		kfree(eui48);
 		return -EINVAL;
 	}
 
-	memcpy(addr, mac, ETH_ALEN);
-	kfree(mac);
+	memcpy(addr, eui48, ETH_ALEN);
+	kfree(eui48);
 
 	return 0;
 }
-EXPORT_SYMBOL(of_get_mac_address_nvmem);
+EXPORT_SYMBOL_GPL(of_get_nvmem_eui48);
 
 /**
  * of_get_mac_address()

-- 
2.34.1


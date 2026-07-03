Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F053E3159
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086342; cv=none; b=OxiSFFC8l0vgQEeGu+Vlq53hsOpCLzERCNXJdEZcC6q6Ne0E81NSr1QjmrSb1rrv5WpP9VVwRPQu0K7UyswRh8QyrFcMo10Dx37qEpg3bZ9ApmAPHR2rcxWWecGtpF1NpZBBT0TJiY7+fC32scVxFV+uu0uY1bKwwz8hCI3U364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086342; c=relaxed/simple;
	bh=L92wgefYXvtbzOMdFEhUTkLwtCR1yYb0ZcvRRGDMuNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8OKgb+p+wL2wU4MXPR0gpg+LnIB+f4TMpr/ELoT57+rrJ0ab4fC3+fOM8sT6X0g7CfqtVZ5piUI2innum0EHIIPAdfu3oj9YcwYChDMUjWTcWEJcB7o07S8c+gPfOonPTMVrFYCSC9GfVG65RwGNgVDPUFiXelEdddJwO/U8OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mx9N6cZC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bLjsTZkG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mx9N6cZC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bLjsTZkG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BB2mC2994900
	for <linux-bluetooth@vger.kernel.org>; Fri, 3 Jul 2026 13:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=; b=mx9N6cZCjTfJfSzZ
	9gakVHWhyhkHoDOoSuJLbiWGbmKKrj3BG4vyT9i3RPwvsZinQaPETFtRLyFPy9+g
	tHYfOMQD0dMpC50r8YHvwKhtLUuz7v3Ahz2BNcI8ICN5zQFhVhHXpTfQ1/x5oFUA
	FCLodfzhAmGzhE1WJy+vQA7YldYmWFeHBvb18VM/1z42Xetg8B/fZ8fTR1STF6gO
	9g6PjI4pXr0+QxgJUNW0q6YOmJzh3OEcQABYMaY2fZ28Be0tf0OuT4H8V1RufejG
	5Aob4BYMQYEY8O6nHg1PsE0IyyTL6we8VuGNOXGZWJDtlpjFL+RCKW3NmKDE4xi2
	5MF8pw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n2mvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 13:45:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e66f9e2baso59820085a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 06:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086338; x=1783691138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=;
        b=bLjsTZkGedKKvAeMiqnGFtVt2B6H45ezDVqyMkQHw/Se2sMtF+JTnum0qXY1hiTiQu
         D17nT6u2TtV+pEgd05zWqZqsOQRD3i380wLQlyz5/wQsiUYQ0eJzYa0CuklHmAinEDKS
         Kc99LitKlureDZ7baptZoZAwbJgSPmt3KXNpRY0uur4d7+lPqQQwaDmk7xa29c5vNpxS
         mgXxKoQxGmubJNzBBHZrswVdpbsFOTCfqtNXTmB9MZJ23+m64xHbPgbuKAbJ+GBxhzWM
         aI0wrOSFIDc5dlnVRk34PC/5+5/C6Krhfu1Uc6AnNu7RbPAHGiUOHLwzH5BowbK7gA9X
         zZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086338; x=1783691138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cPeNqGPMRBWAfsA5CvuzYdqPrDk9qOkztMDjoEMaK1o=;
        b=YcYUZP/aVRNe31+8/EI9fPUHs9ycs6u0VEMyVoY+GvAytTqfzIP+XkB/Axca/AOue+
         xoPBxA8VOMZkm68qpZGzMJE56WqMC0n5xJ1KC6Bg3347guJb3pwTaCpEBeIwlHIcyvyi
         GQLwwEVGX22TPdi8XDr2C0BSFsi9m8H/Xl/L0OmHqD7CBjz1Po6zu/8+JQm62iBakbHi
         SHJADN/NrIPnsHu+5eXOYv8dwiN2iSC1Ucp4VmW3SvHzhRJReY53v8jOtD5EZCKRT34e
         3uiYJOHN1oafn2MPEcm6sC4kUBs/zZdbwCtVkCM8SbClkHwEUzsL/Em512Yysex6yG4M
         i0Dw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ud6PzXKhAlJFucUk8ftsu/Ei7CFUp3lQO30Y4f33jeyvgDgUMwnN1kIZ4gFGgKtRveLWewt8TIQTq+BDuisw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3KCWJc50nH3ATrgoC8M7saHnXp43h0BWmDnbUCCxh6aTOPKT
	9F0ghULPJRXLwlixNj17LOO2Q/3ZfdwwBoawi2yMmCENjbIF1fTjw/NRLeUpmGmMmgMKRbZ9jvq
	fvXVmSQKaRntMWIUWLx7e4PdKHDKbsrqbhJwJo0p6kYY2jRvEuJec0HyFe2cX7K+yQpiNavc=
X-Gm-Gg: AfdE7cnsMGHkLx7Bgc2lFhA8y9in2l8gwohpmzz9laOgiTt/HiEJeake8CJ0DiQEWjx
	t5nd7Z3W66ef+wwfxeI3pFZ01oBJM5rufHpAwJsBPA9En7i0qZSCd8sVdAarrAWDdPYqMeppapl
	kr2M6l9FHYcWDXE8dIWicW+pvqa7enWYiLB4i033wD0Vwbj8D4Z7CvjDr2OooF5fTTLFoNdGYQG
	xm/jp6XnI546UccQI4HgcbY/CbIFc/1dIxlUBH+OKduAXkT7/tv8U5WToXyIkdKUuiSe1vsZgbw
	SA3FUfJD2p+KpILA2E5vEK/ZKmY00UFXGLHLvsxlJXrBuZoq1QUDJK9KSLEVBnp9rDf3cjEJzU/
	+UdwqzJiJaR2pWVDB3jsR1IlM503GJFsPyxCDye7xbulTwOIPz2n1FWGqMzqBZhgawgaaJ+M7Z3
	NbvYSFigLXgN1yPyYFT664zfoRoZMLFkiLMayYpWbq5i+zTCeLJm1h4NUPDPOzRhc=
X-Received: by 2002:a05:620a:43a7:b0:92e:7068:1de6 with SMTP id af79cd13be357-92e7b43e16dmr1225936985a.56.1783086337597;
        Fri, 03 Jul 2026 06:45:37 -0700 (PDT)
X-Received: by 2002:a05:620a:43a7:b0:92e:7068:1de6 with SMTP id af79cd13be357-92e7b43e16dmr1225929785a.56.1783086337116;
        Fri, 03 Jul 2026 06:45:37 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:34 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:19 +0200
Subject: [PATCH v8 6/9] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-6-98ae32bfc49a@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX6FPj+P7TW58o
 7XoJJrXvJhOzCJg6pW1mZXvnt6HeyXpvKhmxJOtgzg4pQyT3tuHLGVAOvj6+ZIQdXE0hvI0c2vR
 sQYuqk3Yjv2zcJlkvc3jz2iBI3bsfNc=
X-Proofpoint-ORIG-GUID: SQy9T84IE1RkNv-0xBFGKBAg_RoxaUMc
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a47bd02 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: SQy9T84IE1RkNv-0xBFGKBAg_RoxaUMc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX1mBx2JQjb6xU
 IxIe38vN/fvEt7hqP9ietJ4UKbwsVHdV91/RbthSWoKfvH/zWAy+X9MDf00Y53q6pRAfE7Fuoc8
 cmu64ygIUmcZfJLI3QTw/2CgaHTlYb2BI9f06BSaCFwUi7OnOzeIzjJM51vfPRyY9o/97+Wl53w
 bABwHzkeJp7KoJCfNdvHWM8XFA0X1AGwuv6zbbtURa3GKkP6RQRkrrCnTCXNVmMRtMZ34HW54t4
 /j8JDxug2vgm+Bmu1F2bUNaxjEb7Yp6ilqufaI0CIq3JqZ/wRpXgz3pk7B/uFUusrTu/76CxH8t
 e39/nxs3jFQMmVnEC/Z5S5i2zqrtGhiTKKsP5fLE2BHo+I9M0ulC20OLjB6K2pjWg/ietqWTwmK
 TYCPO1mHmeM3bDyQgNIy0mlxqcErHZL2Uq1cq0rO/pqvmuet4PHomWrDgUxlWaxJaRZe9yLtTyk
 045O//Q6fgOHce03q1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135

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
 net/core/of_net.c      | 52 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 12 deletions(-)

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
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..999ca0e9258c41580823b80e0ef6db26617bc968 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -61,9 +61,7 @@ static int of_get_mac_addr(struct device_node *np, const char *name, u8 *addr)
 int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 {
 	struct platform_device *pdev = of_find_device_by_node(np);
-	struct nvmem_cell *cell;
-	const void *mac;
-	size_t len;
+	u8 mac[ETH_ALEN] __aligned(sizeof(u16));
 	int ret;
 
 	/* Try lookup by device first, there might be a nvmem_cell_lookup
@@ -75,27 +73,57 @@ int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
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
+	memcpy(addr, mac, ETH_ALEN);
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
+	/* Reject unprogrammed cells that read as all-zeroes or all-ones */
+	if (len != ETH_ALEN ||
+	    !memchr_inv(eui48, 0x00, ETH_ALEN) ||
+	    !memchr_inv(eui48, 0xff, ETH_ALEN)) {
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


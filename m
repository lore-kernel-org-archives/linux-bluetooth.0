Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E4492523
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921667; cv=none; b=Vy445MVie316qUovomUVK0mxNQV5Hr33eLjhrqn2F/YGIrJWvT/k0q8FlvsvJKzMKzl/ivNzXIVwZZ03/ARkFSNX6rhoKRHgivV5OAVJIYIOun+FdKvuKWz2mSm+RGvgyjyw/jKtzalmndPQGazt6NxJJX0b3/wuxPkyMSSyfj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921667; c=relaxed/simple;
	bh=6b0Jqnu0CGr/aHLEgYJK9A+WdSx4puE7YgV7L+bka1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4MJIwbVH9NaF6o0G9ns4cMnzs5YfBWYMItZStj6QG0+hYh+WhT9XHrbP05iDwisXJeZwlyFWoV+1mG331fz9Ae/YbVydmVN/Os2G1oQdLbNm2Pb1kQBNrt6tt4Do5fKO7Tf+9zeBLaPixqCYC8LGKibIxY90yKweehT1H4bTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BZKJB4Gq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d8kDDl4A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BZKJB4Gq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d8kDDl4A"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Fo8Cq1549005
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Jul 2026 16:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t0giUD+SohDjvu6JqPIFA2PNVMKYNwxQ9YxaoTjC03s=; b=BZKJB4GqHyp2aIyZ
	VaS0G0L0nXtvGM0/o2igDMHE6Bgn4FSYWPb20BGXgUlSQlQV8XxU3mQ8WVRBgyxO
	vtw5fDqzjZsJVqbuhL4lMBuo4CNA60vcPU/8pdd85/KWIuajtDaQNZKDhAaK4DVl
	9KESl3hjp4OJY1+PWLV4Bxi4I2NcuDm9RLTDSNWnjDkQnQPeek6d2pqcEILISHLa
	x4FM+XGu/yxeEULWzlJ5BOHlIuCgnaOc8ql0gSLzaJdZrjD7FadC4p57OGSxj0N1
	M0AmpR2ylGigBoPc9HZExgn1OesFrV3vIL3dzhMWHe+RadUcSo9LKLm78e60Pk2z
	H0yPyw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541r9ws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 16:01:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915c364ae3bso98211385a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921660; x=1783526460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0giUD+SohDjvu6JqPIFA2PNVMKYNwxQ9YxaoTjC03s=;
        b=d8kDDl4A7pMh9VVa6uo4V7LkEVOrtMX8EdiFT6dxTc7Y7XiRzB56YewHNFY1LndqU7
         +2wAzv+8vHtP9qRtBafq3aY1Ht3+TVZOon24WNirLIFLLHBndgudRWnZpVAoLFb+tTS+
         NKsfsu1Zo6/5OjhMZ8mkMclZ1yOID5wEqfhIvB2h7VX0cgeXgkDgEMVoDKlf5GZyzxuJ
         0Vx5+fojwtUOaB/2S4aZUfK5dOSyt1ImOhns7tCCDWx3c5WlPxH5KK79u/4rUyb1B7Nz
         OWk8+OuDLEHP9MK7zKARJlLzdVn2LOlfBdWdGj/7X12zLNGpcWrv9kKm5gOWvRqOwU0P
         962A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921660; x=1783526460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t0giUD+SohDjvu6JqPIFA2PNVMKYNwxQ9YxaoTjC03s=;
        b=OZvrfIZLufPhLduSs7hBUOLwgPXEy8ADYDAI1+b7OscNghXUwEPhsw7zmQ3etpgurE
         l1NbK/wF1KwsZ3bEHfh1aw4w219szv6yy7Rdf/2d3PohZHergZT+lyoh3gBvJpQChAQ2
         BT+UEPuF0Fv0CJaVMI8/ZJ9aB5R4RjCAAGMB4nOBVuKqYTxI2unHN21dh5zy/ZNsmpMQ
         bSE6bl1Zs+q/bJnwbimEm3Twn+DA5jtuYUcI2qubjLiEHeY+l0nl48JVxcClDbMg6MvR
         FSJXLq60UAHbl+8hsZVweJKniZ44XRwHWuF8hKLwqXEczZiq9doFw4CMqQDlovvsZJlV
         Z4bA==
X-Forwarded-Encrypted: i=1; AFNElJ9YfVLjHLbyQ2ATMz56N/r+FJyfNq1y2KHrO2QZhOE0NRwYQ3CL4vdtB2ZCMt7aulec3mWR/qz+hTSaJqvVnUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykK+X1mHpHQNeK306Z0Bv5KYF8t/Z0BslB9Wu87VpXoA0+qU18
	A/agzgMw5QzdZku4jVRBDA1r4vLflQqU7WdYevNrXFMgkQX+drIMdSGPE8fCYPhrKKAIpquA3wD
	a6kXOcGIsaYBJvKm8C7s0Fq0Ad23kOyYBqeABWocsMBGnV3qVknYGIOQ99lMuCM/lrAAgXFE=
X-Gm-Gg: AfdE7cnFOkoMRHaptF7vr7dM3cheJbmY6v+e5p49rtXmg1w2rZzT0zc8u+AapEFUNLb
	PRoWiwrpC4kKOGP3dxkYlXmlIvs01tOaMDRFpxm5pOUSMXKv5NrDxR4izGTO2Ko0wZajGfA3dEv
	D8RfQxMtSS7OakJg6vARucOEPo6i7RCzE0+1rVl5LM1sqGLLTvuDMhUoKFEh0hyyACLG1vRgRhn
	2+R6J4Js2WSGnXmIlmnIQugfxcQg7lZpc3Uz5kohKc98SYYZronPYZSu8nUJv7LotaYUGielZZP
	ldqCP7K9oX8B35SGewMRuSrVKYBK2AET1Rn+nVrR3CkYHe1YB7XmcbQ1xFUY3PUs6x9RUtQkvnm
	Nlgcw0kWq0fsREM/W6ypj0BkqTETwdA1/NQaBK4Q5Xwbz7PhBHk1Ydf+A0iX5QwhyNzsRtniIVq
	BkabXR38Gck/7hbjaq7vGSMCmTqrQ7Pb1ql4y6q7X6DdIZCukbf89V64EZ+c58j0s=
X-Received: by 2002:a05:620a:2586:b0:92e:5c56:727a with SMTP id af79cd13be357-92e78506001mr341295085a.60.1782921655658;
        Wed, 01 Jul 2026 09:00:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2586:b0:92e:5c56:727a with SMTP id af79cd13be357-92e78506001mr341219885a.60.1782921651391;
        Wed, 01 Jul 2026 09:00:51 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:47 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:30 +0200
Subject: [PATCH v7 6/9] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-6-3fe8205ef0a8@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: TVxYgLG6lzQMW-bdT2DuU5XIukv8LZCD
X-Proofpoint-ORIG-GUID: TVxYgLG6lzQMW-bdT2DuU5XIukv8LZCD
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a4539bc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXymFPGA7wBC6R
 +uYU+/OXfN+rHxv9/59pNJ6bv3zCLtQu64M8+pd4wDs4VQyCc/jYmS/5Y54f8GgRdaduhGvD69U
 Sh0gVaZVy77ZiKCs9YvPCVUraU8Up4p8l+sEOOD2HWU6J7gnXYUv3/OgFT2kO0+7lJ/DaGOEd+k
 GmVfPPghQ1W7zAAYxnsBJ5dwLTBdo0iVCSLkbSZbCMvJ0CRlaUyqNOJysaLqT0D+1ozeDETwfJD
 VP68vibmPbujiXCoUgvSiXJWHONDDg2DQGC9Vm2T6tUPu0F/6klHkds9Qa+QaDw5Ukh3BLAThsk
 24dghVfXr0I2ZFVJ8X1AN/eRDraBt0Zc5YQTfCnXmiCKI+6muM3y2vTfPm16/nU0ZWvPbCU9cQl
 QAh+kKFKGeLOMwIY9VuNXyvTOGir1Qe3dVZMiWx83iGtqtjIo9TK7akz7SaWLhi5qgiUrAUJSc0
 tgFZ9hYxn/mklf+YtEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX3SJIYaXGaSeB
 gegL0tgv5jskXNYUiK5Hc0WkVD7CTMHH2zQatuGkw5hXifBv04pC59IIvowgnw16InwMPv+e7sj
 Pm+0XI7VP4xNjfKkWuldOnpSWo15ePo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

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
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..11c1acca151266ac9287457b4050a54b08e2b5f5 100644
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


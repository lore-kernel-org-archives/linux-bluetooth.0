Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6228D84F
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661293; cv=none; b=UJEezndTT85zZD1IqwbxPOFufpssqyitxfDovO9yPZSvvlDUrNi53NRf12blwT50kw1xpbE0K8F+B/mTrQOIRHBvmBHeCIqhFDQEFGjum/IXmzpb5GqybqesOPM4/aTre4sSjB3UHD33WAN7pfQ7l3CBAjeLqFJcWLnBrtl15II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661293; c=relaxed/simple;
	bh=vGKw+wEv4m8AuXcSbM8ug5QUp/CDr75AFUCT++yOsvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQf9tJNutlmqQQVsh/JgWpJn4JSa6Xew4FbxiNYCQyMdXPHmrtyE55GogrfLm2MMMRWOqP+S8OHA2oJ9f4dUhoeSOh3UBpTLsKoJ5eGTYCmbixLVAtuiB4zrJDuCGdWzXdFtLfm0I1rt9d+HbdzWxnhhOVNWfZdhU5ISqklhK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iJND170N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z4x18B5a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iJND170N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z4x18B5a"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060ncmb2943913
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 01:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	toWGAj7SgswRPrjJQFNYvHcUGCLQpi1FqKeAVpzqbvU=; b=iJND170NW1tlBMQB
	HYoxumSS2BP8uillqDNEGwEiprL8Z7jNmZVPJApMFMAswdb9bJ5/1fFbcpSsYXM8
	Bqsy3M6n1ZGBsDyKJvrS9X2Kmt5VPPKKfi/6jeViftU15HfJ0cycqXdrXQHTw2k1
	KtTh5+2/44vamyxPnAyfJXVhEMmZabVmzQeAi1AdKzkHWnBfF3dYwlXbP2E1N3AU
	s3iVAyZUUpAD45jQieYRy+3SX6KdHNLSizY6ULzhaaCxQ3JaFittHSPyC3v762Fa
	PMw+Yj2Km5cWQ2XIReRVz9EZraWD5CGdVvxEnM9FUuEpnOoTj1Y62B/VSv1+WkqB
	AOazbQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv01ewg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 01:01:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b9fa6f808cso141527885a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 17:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661288; x=1768266088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toWGAj7SgswRPrjJQFNYvHcUGCLQpi1FqKeAVpzqbvU=;
        b=Z4x18B5aZ29slZJHb+yB7Gkth3m3eEUAKmGCCx+8jaxuCrmGnB9/muuUHJZzT8ai3w
         4zZ9YT559VD/V9R1TyyL3cRFJqRrVZW64lCkP1uN636iqOpsgvEP3TYTJ42UJUIbrbRo
         oKG7D13dqt/TkT3M6HI7nVhKxPZVrwPgA2tU5lJNA6x+Y5TxXXpUlumr4u6D0zQ2E8fB
         d4wNqd093DgxFZWmpTD9O/sIljNF+w5fKX2BPv7XnNov6hyU65mtWLmO9FbfhvP9UIJz
         yidxw0IulU/DSBGZMBrKwq+wFF4VJtlCCRr7wvjyFu5YWp7c7mOd0fSY7TQV3R5SK62b
         nzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661289; x=1768266089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=toWGAj7SgswRPrjJQFNYvHcUGCLQpi1FqKeAVpzqbvU=;
        b=rf0mobZJ1m8eIRM+IxW42rOyqupS2wy26stpYVOXEMwwqAovZI18uPdzXKsZ2g5Srj
         cjburxKZ8r1qPUYsINBc/oRqCiVJmYwgEF5iVQXoGDG/ORUf/jHal+vUvud3WSBBR+EG
         C2qmFnWJyluoA4/QuTvxDflrVt2D0TaFpLB2WmxIVEHQNr8++Unk4wxzUO0upNsNhZQI
         8rIdV4uHm5EbBfOYoC0T/+tfq54R7tfNTFFe94B03fgCk2JuVk/5evRJ1UhUF1oo8WtS
         p3EorPdFD5f3U+AyA+Z1l32s5qYol747xSMfFNm0VfmgOfts8cNYTXTqx1PBfMVO4GV/
         L9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWvGxdtllWkKV4EOho21Pzrc4+0ypjOBLkPTPcnSsOWypUL3lUn6v3C4djRI0MrVZ8sR2k7crBu6p9tD/9yZng=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy3yxVD3UUppNqqdv/XEUYYBBks9p/OUsXckXPp17ywCknq/zJ
	TOJUu83MwsCnCxn8d8KlzSg3GR0ZpNSGd9pZQPFR5oV6+krlwO2C3gJXGfOGM2xEmSJNl2NJEN8
	U+C7heqGzsp6ynhATbBxUapJJWPVJeQoPgauGs1o8gR7S8mR/2F7d2pMCQxEXfa7gY8mngPw=
X-Gm-Gg: AY/fxX64NTLm+0gzoH882HLNDAPsBoBeFC2NZvgRdDk8Keq69rjYywNiuqgKLSEIEgI
	B7ySctbLIiMraIJXn1nSrUSJmZ/pbh3QX3QtAo2p/SknV/ZYHLpUmoKoFBY0ZqsF4LJ3vAbtt+W
	rldKvMBCgcZHuOAyaYT5oDCjgt+jiBpaJ5D9OA8xr24gOxMN5vFai3dLoP1oQx3pd32g06aT+Or
	0vZ59+LcoUGe7ApDxgrwHXfkXB4M0uQ2FelJfjvYrkUVc9ELFmYKafjN9+ORJSdNJy+286CGC92
	ExjtDDf3/gb9OBvCi3FOBaw2sTdfO/I+GAVVP6xLc6NP276fbYFymMlTB6o5kgDQCciq/mOtdfq
	xrRb0gtURnNyQYP1WMR08x+CLGai43KhXWUyF6+6AYFKPbms6Sliw9MMhEZTjs6eR0eY3lrAyQe
	SCZBVlfaGs182Pg80bEos0MnI=
X-Received: by 2002:ac8:7d06:0:b0:4ee:24fc:bea3 with SMTP id d75a77b69052e-4ffa770d84fmr20866211cf.35.1767661288612;
        Mon, 05 Jan 2026 17:01:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGRIkm3qB3iAMhjMsr9K7RBdmhsGoeWiJuR1zZQW9HRAWrshi4AJ0+6RJy7rL89ggSBiDVrw==
X-Received: by 2002:ac8:7d06:0:b0:4ee:24fc:bea3 with SMTP id d75a77b69052e-4ffa770d84fmr20865361cf.35.1767661287983;
        Mon, 05 Jan 2026 17:01:27 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:25 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:14 +0200
Subject: [PATCH v2 04/14] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-4-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4482;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vGKw+wEv4m8AuXcSbM8ug5QUp/CDr75AFUCT++yOsvs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7Z98G7nWfKXlYg2gNCIQMwgRzHPZzJbxVnJ
 z1q/ZSkHjaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2QAKCRCLPIo+Aiko
 1fEZB/4tvPMVzx1O9X5hVg4SC8qKvMxE3IAdsH/tCrsqATAl0+wRT2TyB9Hn7GAeWvGOctHu3iH
 Wz1nzZlcEEGfMaeWu5SwWMpltRfuQ30OmP73iSkLDJIyDkaYgNS18F1gFf+O6ny0yTUySKvTrcD
 yyXDgiHMM2btCQT/nwRoSHoTn9L8puSf+qIsWNnwNXcYhQ//We6KROhs35aw/OlL/hwOSrlP/S/
 5HwYUn/Y4mmzJ5Htk1E8M+w9R1szu/pRNZ3IJKY3GuKUB9KSiWfh873JV70NTtpLblRXY42mIM+
 v4EhUqx2idwTvvn1tfM66om+MAtEwG9gtY9dLCdkm/h9l9Pv
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695c5ee9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JZG1H6jYz0umZupwJd8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: bRbS1ulBClkkpTc2oBIVaH6sQF5wLe4D
X-Proofpoint-ORIG-GUID: bRbS1ulBClkkpTc2oBIVaH6sQF5wLe4D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX9PGnXs1FmOv/
 Gv+0RLgMlSlZ8rP9DPFVnw9mK20qvcTKzGPMGehVgD3IfRVetN0dpj7gH8JaNbkUuUsXgQ6B8+4
 k2cy2ZPwz3u44a8aYfMIPe/VHBSALHS2P6XkNyZelsAd0xYQgLaNq09JwFCg0sDiaoMGCz7/5Oj
 L9uHS8j8VuomKmN5DD2beBZQNrX96JZfjwdo+AXenFfxkv5KvuHDnhYIQEKiU/spX4wRC535qEI
 U+foctiZXiy7v7dj7M/FUcEehmZGlNJE43LBXJ4NEf+6Y22CPd6oZEmfVrAQze8FRioaIpElRnW
 0es6eO3nRgUWsX75fp8ayaamRFsiA4imICdGkYv+kwp6D+rbndOjMhkmi4QQlUNQ/9Li3Tk1Hpq
 7gOUz/DlOXbXXFWPXjiTT44FUxLZ4Ur5fSimMQDnxxY7toG1qWvOqCGsm/2vgqj41LhlibcqFpQ
 5FIDtQBET9YHizivUnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement support for using powersequencer
for this family of ATH10k devices in addition to using regulators.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 54 ++++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath10k/snoc.h |  2 ++
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index b3f6424c17d3..3600c8eb19a3 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -11,6 +11,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc/qcom_rproc.h>
 #include <linux/of_reserved_mem.h>
@@ -1023,9 +1024,15 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power on\n");
 
+	if (ar_snoc->pwrseq) {
+		ret = pwrseq_power_on(ar_snoc->pwrseq);
+		if (ret)
+			return ret;
+	}
+
 	ret = regulator_bulk_enable(ar_snoc->num_vregs, ar_snoc->vregs);
 	if (ret)
-		return ret;
+		goto pwrseq_off;
 
 	ret = clk_bulk_prepare_enable(ar_snoc->num_clks, ar_snoc->clks);
 	if (ret)
@@ -1035,18 +1042,28 @@ static int ath10k_hw_power_on(struct ath10k *ar)
 
 vreg_off:
 	regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+pwrseq_off:
+	pwrseq_power_off(ar_snoc->pwrseq);
+
 	return ret;
 }
 
 static int ath10k_hw_power_off(struct ath10k *ar)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	int ret_seq = 0;
+	int ret_vreg;
 
 	ath10k_dbg(ar, ATH10K_DBG_SNOC, "soc power off\n");
 
 	clk_bulk_disable_unprepare(ar_snoc->num_clks, ar_snoc->clks);
 
-	return regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+	ret_vreg = regulator_bulk_disable(ar_snoc->num_vregs, ar_snoc->vregs);
+
+	if (ar_snoc->pwrseq)
+		ret_seq = pwrseq_power_off(ar_snoc->pwrseq);
+
+	return ret_vreg ? : ret_seq;
 }
 
 static void ath10k_snoc_wlan_disable(struct ath10k *ar)
@@ -1762,7 +1779,38 @@ static int ath10k_snoc_probe(struct platform_device *pdev)
 		goto err_release_resource;
 	}
 
-	ar_snoc->num_vregs = ARRAY_SIZE(ath10k_regulators);
+	/*
+	 * devm_pwrseq_get() can return -EPROBE_DEFER in two cases:
+	 * - it is not supposed to be used
+	 * - it is supposed to be used, but the driver hasn't probed yet.
+	 *
+	 * There is no simple way to distinguish between these two cases, but:
+	 * - if it is not supposed to be used, then regulator_bulk_get() will
+	 *   return all regulators as expected, continuing the probe
+	 * - if it is supposed to be used, but wasn't probed yet, we will get
+	 *   -EPROBE_DEFER from regulator_bulk_get() too.
+	 *
+	 * For backwards compatibility with DTs specifying regulators directly
+	 * rather than using the PMU device, ignore the defer error from
+	 * pwrseq.
+	 */
+	ar_snoc->pwrseq = devm_pwrseq_get(&pdev->dev, "wlan");
+	if (IS_ERR(ar_snoc->pwrseq)) {
+		ret = PTR_ERR(ar_snoc->pwrseq);
+		ar_snoc->pwrseq = NULL;
+		if (ret != -EPROBE_DEFER)
+			goto err_free_irq;
+
+		ar_snoc->num_vregs = ARRAY_SIZE(ath10k_regulators);
+	} else {
+		/*
+		 * The first regulator (vdd-0.8-cx-mx) is used to power on part
+		 * of the SoC rather than the PMU on WCN399x, the rest are
+		 * handled via pwrseq.
+		 */
+		ar_snoc->num_vregs = 1;
+	}
+
 	ar_snoc->vregs = devm_kcalloc(&pdev->dev, ar_snoc->num_vregs,
 				      sizeof(*ar_snoc->vregs), GFP_KERNEL);
 	if (!ar_snoc->vregs) {
diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
index d4bce1707696..eeaa1c009cb0 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -53,6 +53,7 @@ enum ath10k_snoc_flags {
 };
 
 struct clk_bulk_data;
+struct pwrseq_desc;
 struct regulator_bulk_data;
 
 struct ath10k_snoc {
@@ -73,6 +74,7 @@ struct ath10k_snoc {
 	struct ath10k_snoc_ce_irq ce_irqs[CE_COUNT_MAX];
 	struct ath10k_ce ce;
 	struct timer_list rx_post_retry;
+	struct pwrseq_desc *pwrseq;
 	struct regulator_bulk_data *vregs;
 	size_t num_vregs;
 	struct clk_bulk_data *clks;

-- 
2.47.3


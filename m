Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1E2481A97
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202915; cv=none; b=bGfcMJzuR8AcCT24AsBLpHT2TqCZkZRKyI8dNWV+XNdnJSZIIFrnRItqbXFjhu88XSSrDEcBSGwDlj9HbW8ijY6pXpm+TaUVcbzXJzmy2l0+UC5XtCBXpzz8TVghQWgaantfKemWtnEKS6X/qdfnCoI05jQdjQWu7ou/E+bA3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202915; c=relaxed/simple;
	bh=eDxLstZ3YgSwfZ0PeFuQrJ+uoiKZuKQRYECamWj3BTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UBRI9aGL4+8dyVY9gsU4V/rMgR3YCYYBSFMLmxlDjUIFum5kX9Rh/XWUQMJo286ojoD/xXCogHxYvLVIs1alcsdE9mJKoY3qqASEl+tAU9PQsYYlVh0AMF5L7NbkLiseLChMDAC3dXJ3Z+LFXxElEtA46kUBlPeyUKmgRfntKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dLZzHG1q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bE2+0KfX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dLZzHG1q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bE2+0KfX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFFKp2848976
	for <linux-bluetooth@vger.kernel.org>; Mon, 5 Oct 2026 12:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3rpgZ8Wulh6l2hs5o0xl4E6pGMgHsW9mZuSvFezpNgY=; b=dLZzHG1quqkM18Cp
	Y0SJ1SO13p7c+TaJjFR3d4zZnO6mtGsrmTx3cTsSNnO//WK1GvXjJvI0RQ7KUYW/
	mg6pJ+StKT/cJZVUQk4VbVPxmdIWHT+rLgZdEioCg4kkXjksdcFFT6Mlv7F/68j6
	tJG126ouUHo3yjoLtyjsTxe4uGCwnuhMCpHbIDBwINNcOH52eXJ8BxJ7wblVaFks
	Nxk9IB1PAxoaumJlHGGs4Hso6m3yNZcBiEkSeevF+YqLbgO4boXBf18erVasRD8s
	CXU0fARtLEYL7nev0e9K/J2hgqDPDOqSn5lhwfjM6azNS8r39AfiltPw3SIDn3JA
	/aia4g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49u40ctp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 12:21:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ca4a2b9c4so386248085a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 05:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791202911; x=1791807711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3rpgZ8Wulh6l2hs5o0xl4E6pGMgHsW9mZuSvFezpNgY=;
        b=bE2+0KfXlquQXVjWM2E0rMWCqUm7q2gDK4taw+Z1qugPPJQRtNj527gRyDjlA6kMrL
         7JNZ/KLgY2/3WxGyfj5eagaUl+2KXbAe4fqiXNoWneyUK5V865nJhCPxbizQTuIYOjCq
         e2mgf9rlOxjtQMnmHDxdiiFOA5RZrQBjMrVaViQ61Kn06anNPjb76UZNlQZH84n5SZTe
         nem6Z/9hq3LYut8Tf2LpT4q9XKAptm41Nu+KH/rOH9hUmTIiO8XP78+UdFcxSmcR7ccb
         uQxVna2vNW9AOO+32wTY28RLfLPEUO2lJkwlQ1lMsOjHpAoMEFgmSRe+hfhMyf9FV5vE
         vYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202911; x=1791807711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3rpgZ8Wulh6l2hs5o0xl4E6pGMgHsW9mZuSvFezpNgY=;
        b=1Ill1t3yraTgPgGz31zAzMmQhFNF1U9XQl4si48jWjhz6LG0zC18gdlwYYV9z/OKG7
         wVuNh4/Jh7v42EDzr7TDZolPYgqJkbK3FZPxE4+P3P0/jxsHkM5BnulG11YgJspdH/G/
         pBQ0ncGsizWO0qrWjtIJiUNnV5O8hRDef5oCJDa5bGF6NB+YzidX+jBdIr9uVlvO/3Lo
         L7J7SYbP4a+iLXcOK1VA50DTzD6o64NCFQ3DUbvnPHcf20E8xHBWsK3lx0+pYKLnSsP2
         T9kZrX88MBVSfxAz+LV6X6JKKRREYGoCG2h5w4zUloxxywdwuqmX7TehiNV82tOffB+V
         FnYA==
X-Forwarded-Encrypted: i=1; AKwUvBxkzQLUsIUi0GIt2C+A8qDtkGXmIHpeQZAgP+yKRsH/OuaXJv1hrq4+vML28KRvkMNaIlU+WRzMqnHSBPY23bE=@vger.kernel.org
X-Gm-Message-State: AFuF++m7h4z6oiVNwuQggunWgfwM2xlV/P0i+jPTGcdgYHYE8f0MzPvJ
	HN6/TRPGM6KoSxGRz4RJNfeqXhpcajbLwE/yPn+KS/I2SqRBOCX9JHbRQzxbKC6jO4+hE9CiaRP
	vF5MssFpyO+w/PkONtDYzt1IgyFa2+xtvOGiGQhlq/Y7GFYvDaGNVbpHEtYsu+l8s/O1jZnM=
X-Gm-Gg: AYBFou1x8O2pp8Il4mBiOhIFJYYgvBwrCz3WeEbsejpDsnjDSoMHDIaQZiDRFfh7w0D
	HW7WsD4OdO/uHoeXmp0k5q5m3Fr3mU1PTZIqNXSnMqz7hkpttnh/0+KJ4rQcRhREeMfClkr4yvz
	296ON/vmcFp9provbHcfthG45K3Wj7cU6c8Wy5+GNh6fb0ws+CAvNRmLG2eIUEZQjIAff8Qgmu0
	gzN0Jvtkhg6WuyWRRK2+JgWH1LccQMBoKpwh/o2JN3eRmX7fLsli1eyBIhDRNZM/ptTzwcq12Zb
	EwuqBEcebRrkxkizBllBwJrN6sfLlDNSG+FhieNnNUQRoE1+kA0yYO9kWJnU5hN3ibBMgijFfBa
	XdmlLlsQnI23YPltlJ1BsoiPbGV7bjH7WqYRcee9k46H2QvSafy0+N9q9FADz6Gx7nyW6Lk8ZzH
	gpGGQJRCi74ZAymltgufmRLZeLG9ENG+mFZPfA7N7YBdl2iFHq5wvllMl4rXwcsUlYNFy5VQ==
X-Received: by 2002:a05:620a:17a6:b0:939:fce5:f6d2 with SMTP id af79cd13be357-93e50fe9ae6mr1314321385a.27.1791202911100;
        Mon, 05 Oct 2026 05:21:51 -0700 (PDT)
X-Received: by 2002:a05:620a:17a6:b0:939:fce5:f6d2 with SMTP id af79cd13be357-93e50fe9ae6mr1314317685a.27.1791202910624;
        Mon, 05 Oct 2026 05:21:50 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027698f13sm324157425e9.1.2026.10.05.05.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:21:49 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 14:21:33 +0200
Subject: [PATCH v7 3/8] Bluetooth: hci_qca: Set 'bt_en_available' based on
 pwrseq power controllability
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-monza-wireless-v7-3-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
In-Reply-To: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: RP7GX3IxzSAf7MT8p7I1ur1C7cnHkE9l
X-Proofpoint-GUID: RP7GX3IxzSAf7MT8p7I1ur1C7cnHkE9l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX7C5lIDW8wMD5
 wz6jL0beIg2LaNCOLi8nyxhZzxKTIgVvW7ls/NBEucxgyHfzllAWh17fVd9M76aTqcFjBmzJvbR
 lmveeWjOMjAmi21wCKw3B8uY97GpXpE=
X-Authority-Analysis: v=2.4 cv=LuEHWXdc c=1 sm=1 tr=0 ts=6ac39660 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8YyhkPy0JF_pzLATneMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX/CB+E66TqFVq
 vCGzhV9TH3hpjVIeR2xmJ4L4wb5vFFuXNOt0tZhlgCU+4Gaisgc4O5OrX8oSBosnwUfESOeDkFt
 8Yglatezjtcgse53zrAunuWGHtwS9+ueYOjmJnvhM7ythxHnLtaHLRCGfCQvGRC3/JlmS+2WKMl
 ELH9mMN29w9L+eLG5dCyr/eyoFKCP/rwV4iZk2ytGrS3rGyJ7pwTKWXIfPfy51GU+jQzp9pV8+l
 6apoU+H9WMg29niYsjQEJzbcA94DPvXA5P5P4oDU+9W1iwYI/RdL9aIMeIIraI8q7wh8ltDDw9g
 koDx1O0PJvbA01N8wniGbKnu23Mbspf2VQinNCLdwDSkYSsJ+s60DwLTYluAZsAVshF9yxN5fOk
 kayBDxm/flcWTdc3bnSWBnrRkHK7eJahGQpf1UyOyDmOlRdSUxpk6ugztCLBfFjVozB6k2l3fgG
 47YhyJSkCZsf+wSUfQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050048

A Bluetooth device only needs the non-persistent setup if the host can
gate its power, so that it is actually reset on the next power-on. When the
power is controlled by a power sequencer, whether the host can gate it
depends on the hardware wiring, e.g. the presence of the BT_EN or
W_DISABLE2# line.

Query the generic pwrseq_is_controllable() helper whenever the BT power
comes from a sequencer, regardless of which provider it is (M2, WCN, ...).
If the power is not controllable, clear 'bt_en_available' so that
HCI_QUIRK_NON_PERSISTENT_SETUP is not set.

This is based on Manivannan's original patch that keyed the decision off
the W_DISABLE2# device tree property, it now uses the generic pwrseq helper
and handles the always-on case.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f53f95601693dcd8356b4b825776317061050f1b..20d8c5e890a8903a07c3e7e37d037c44d383e8df 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2557,7 +2557,20 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->susclk);
 		}
 	}
-	
+
+	if (qcadev->bt_power->pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+		if (!bt_en_available) {
+			/* The host cannot gate the BT power individually.
+			 * Treat it as always-on and drop the pwrseq handle.
+			 * The descriptor itself is still released by devres,
+			 * so dropping the handle here is not a leak.
+			 */
+			pwrseq_power_on(qcadev->bt_power->pwrseq);
+			qcadev->bt_power->pwrseq = NULL;
+		}
+	}
+
 	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 	if (err) {
 		BT_ERR("serdev registration failed");

-- 
2.34.1


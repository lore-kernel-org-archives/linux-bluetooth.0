Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF23C7DE1
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167235; cv=none; b=PwN6nWQKF2FPg//hKlRyjGq63YCpZAtYi90IVhzmibAk+hnC3Oh+3QqH++6jRILVHf4yLqhTUXlf3zjDeXJkg/HNbtQHzSVrShb7v0nGItjLvf90x77uH+2MybjXgtSd3W9X4xUTJ5+2oX7m7zOHVNlfwtbGDYYdPoejLaxTiGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167235; c=relaxed/simple;
	bh=43kb05RaUpjRitjlYRocMlxAa/dQVEJYd5sjO46qM7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tn+wSZxrxaFPHMR2Afx4JJSeppWlrDZRiOd5jsq+BbghPmgjccffUAxkUGcUbqw4tC4uPn/FT0q78RT3Y70KuCLPYDBukNfu9q2HXup+cs2dB3frlKFKGTIiehDBrEydoi0P6nPORBH/yzISCJBsAPdOgLMlbu6emLocXRAsVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kOytrHkc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WmVi1o4M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOytrHkc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WmVi1o4M"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlaSY3663514
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S7mjFbopEGBUByQAtuhbKuVftRTpKsVvgzJfo+Z7UEY=; b=kOytrHkceeeRRyIP
	M6KMNuNHbpM/yEMt5GtmzW17+NOWCFCQg95Q9ruyJXG+QD0dyv4VURmelXqILu5Y
	DfO6sy1jfckW7sNY24bkyYYhDwMN2O/OB99dKWlIudTOPnytw3Y/zP6lcmWyq5eT
	VwXntfwk47wZeJ52V5FN7KCf8A/SlXMOt4P+juxUdVN0y4qrd8AwTOd222baYEEK
	phJauopWD+hn1mnM9Xr4geY4v1pJ5oAd8R7zsPsj+V2yqjZoCcSuGz1rKyV/S+yu
	JJCKKdFawp6AU2AbC7YPKITgKJy5K5p4txnjI50bd8nWBRlL1S2uhNVQn6IUVjPZ
	I4LemQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp2asja8s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 15:47:09 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7f582244e9eso71961627b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167228; x=1785772028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7mjFbopEGBUByQAtuhbKuVftRTpKsVvgzJfo+Z7UEY=;
        b=WmVi1o4M6150gOd+GgfixhZE7r4h6NchELVxEXUTReX16PtfyzjFHNOK1GNZK3EFgV
         crBzib8+7TTbvCL3Rg/j4v21fEkCHDjoyBbe8of7IZkvodEqG/SOIZ3julIJcmvksc+s
         8qG4rHS1YhfeZxQHZ+0348YkomvEBdem7DLzxkX3NKM0rV0J2fW3SpONU4iLV6rp679C
         +LpbAUZrsTVmVP/k9Hh8wP1GoY+3j1qXvMVJCaY+aJlCuf3Ia7fbeBNNWQktNQLIjqdR
         7Vd32mGW+dpvIHdoLxV4whi3diZvXrkwzGNqc5SUYAukBgBAopl127naiIp6Wuh+I46B
         CJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167228; x=1785772028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S7mjFbopEGBUByQAtuhbKuVftRTpKsVvgzJfo+Z7UEY=;
        b=U0c76lJ0SeKWcxKxVMHzeyWsLvG7aBaK7URFW19t0uUHmYTi6Q6XPURwd8wUuZDW0S
         2fJbQUSKrTGmdiobCglDjijhIvsaS0gIGPV59p/VcgHhrk5Wo+BXe+kX5RxDVH84rIru
         kshAJQKScwQ61U4uslRqbOkYzxG2pwiccXvVmGUXloas1VipModmcaDmKS+4EcaqouMX
         iCSKfkN1H85P5K1A6cnL24hQPh3pOh0BkXunYU9uzgoQyVHpTY1nQB9mkoXraaHE5Rbt
         lhOkG9/T2He3e1uMBbsF6QATk/ptfOpzCpgZBe4ku9I/siJogb/BRYjTsuyiwD7WTwZh
         eZ+A==
X-Forwarded-Encrypted: i=1; AHgh+RoRhttUBqFOVyXeG6gp7tA4qAlAFfbt1O9sD/STqlgpelKOycsqlOlMJnB5PY5aHw9a0HOtlkKRFsFFwa4Z6oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTERbx9XItN1r+oD2wLktwYDYb9WvhGCcP9mvWhxkFci+KNarG
	Z2PCZ70FqpWOzIuf3gFgYqh+tcBQRWEVWhW+uk1U0JL6xpGyVVPO2W75T3lqVQic9PFvbGnv/KQ
	IrCLvvd5oUlosINmtNo4HrPMjLhPxDeNx+pq+d+3ybIEs/MJl5ZdF+WxDULvM7kbdCSb4ue0=
X-Gm-Gg: AR+sD13ktZhxrXkRtyInvF0pNUfaDl+nro/CGP6M6vRBbEuDLhrSAi4cR4p+EGoJOcN
	H72ta5yPXQfZdnDC+9vS9HPmqKi0ZDaOfJzRecu7oMPpr5771v1Trm9QFefWn43f316XOuWA3zA
	pYcwYWmROJ2ZdrQNsvrG6TTcVX/JIJPEVZnJA0jPhQY94G080D1TXyf+hBFvi7wcFVI8dRsWPev
	gTu0kxvrhQc9vd3EdOxSIaN0T5V1BbDFsvnRf9M3N+Xas5C2+f6D6rVChtjvTHPZpg7hUe0uAtM
	jsVoCNqsMj9jhErxk3fQ2sd31U2lmuR9r3O55DUX8phayqvXDLivQ5LO/JhWF8wX0AkEm3b/Q+R
	meiT/a3WeMHygm563/+cpSHdvNmdlUQ==
X-Received: by 2002:a05:690c:600e:b0:81f:3dab:372f with SMTP id 00721157ae682-81f9391cc77mr412767b3.12.1785167228502;
        Mon, 27 Jul 2026 08:47:08 -0700 (PDT)
X-Received: by 2002:a05:690c:600e:b0:81f:3dab:372f with SMTP id 00721157ae682-81f9391cc77mr412547b3.12.1785167227905;
        Mon, 27 Jul 2026 08:47:07 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657c727asm33307617b3.19.2026.07.27.08.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:47:07 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:15:01 +0530
Subject: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX4ltfbiysMKD/
 DlaEmkCH93RB9GqMM5z/t26w3dqrObZ0k0lbdF1AglR4GGJ5Hh+j/w6uk0+JokwZAVbtPhKJcUc
 S9gV8WNWg6oLxElJgERF0tAu2yPEuFvsLMAtsU2fC3N7lWg8JDhFGf8ZbxcgaIHmP2VNuPYli8D
 F3yIAHHb1x4vQQ1xezYEitgJseFjzglooqrBAZJXss0gR10a+yDra+2HsRudJjqvFR6l4C4GItR
 jWPBuKTLydpe+JacLnqKEvAh4X/wRTcEv/CKeQ/ZtJXvz+Gg4mZYIpCd/w9/vVaQpl1cXIwNMd0
 FX+cGM26mYO5WD6nLyk9poO8/h8FDe9ALLR8VRHyAgGhc/4D/h1OHhvMIYI7n+tC8+DZ0SUCvQY
 aICq6R2/p+q71Q2Ed7DMEx1E0qGRdNAq9wt0LL0w7d3m6svIizI9KUOqMZ93yjz8uCsiRKe/BxD
 B+rpxn7HhW6/Qg3E3Vw==
X-Authority-Analysis: v=2.4 cv=UPbt2ify c=1 sm=1 tr=0 ts=6a677d7d cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=o7QFpL2tXW9ehrA7-Q0A:9
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX/hkn0JjseUfP
 I8aD9wWIsOj4DOW2NbpcrAKpN3CPP8JwQ7J+dDwVVIWYJOr59vfQ2ZEfbgPb/BxlDqrUCMDB5Du
 vFhPLHSwgd0PdTjnuW8ZHmVxO5Qaijk=
X-Proofpoint-ORIG-GUID: h2kE6RVbeRcQK32EXJtpdzoaIWM1qtWh
X-Proofpoint-GUID: h2kE6RVbeRcQK32EXJtpdzoaIWM1qtWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270148

QCC2072 can be used on M.2 E-key cards where the card power resources are
described by the pcie-m2-e-connector node. In that setup, the M.2 power
sequencing provider creates the Bluetooth serdev child after matching the
QCC2072 PCI function.

Integrated non-M.2 designs need board-specific power resources. Document
only the compatible for now and leave those properties to be added with
matching driver support.

Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
controllers connected over UART.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
 .../bindings/net/bluetooth/qcom,qcc2072-bt.yaml    | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
new file mode 100644
index 000000000000..e4b281ef261f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,qcc2072-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCC2072 Bluetooth
+
+maintainers:
+  - Bartosz Golaszewski <brgl@bgdev.pl>
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+description:
+  Qualcomm QCC2072 Bluetooth controller connected over UART.
+
+  QCC2072 can be populated on an M.2 E-key card, where the card power
+  supplies and sideband signals are modeled by the pcie-m2-e-connector node.
+  The M.2 power sequencing provider creates the Bluetooth serdev device and
+  uses this compatible after matching the QCC2072 PCI function.
+
+  Integrated non-M.2 designs require board-specific power resources. Those
+  properties, together with a static devicetree example, should be added when
+  integrated non-M.2 support is added.
+
+properties:
+  compatible:
+    enum:
+      - qcom,qcc2072-bt
+
+required:
+  - compatible
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+  - $ref: qcom,bluetooth-common.yaml
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+unevaluatedProperties: false

-- 
2.34.1


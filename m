Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591762C0303
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771307270; cv=none; b=nnpiVOMF5Xp6wWl4KfdymHywrd8CStTwCXhXYZOKYLgbBRjg7jtDNYtOpwDCLkyo7gCvKOj7VGCmISLgLQZp1ZuQrpF+5hJEu08qPaXvxVR/CoGHlGuIYlZ3EhDP2OSSpAygOkcB8DDQIiz9yAmagvep/7W2hfD1XMtcszxuM0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771307270; c=relaxed/simple;
	bh=CGxDn2wQGy831CaAEyhJM4BBDVYLMNZTKDTlem8uIQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAykAhY29s3ouoJFgbpoAHsy8je/RscLIha3NBldoO8APqJryKETJ93YAQWeHEfcgIsc2/gpvfUmFIEorV+2HCTikXSEWs9WkIze/+KG3Q1y6jxdjPVNUbXI7UY5QDFlFhuJ7QSj6a6VV7lSUDZ/qwoOok9rZHSDaLkDsluacZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZvoQW4CQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=folc8mpL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZvoQW4CQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="folc8mpL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GL7iGS125852
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 05:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=t4LI1Fry9CJ
	vHO5MYeXpEHSkT1JzvPFcJjjRx2mFKr0=; b=ZvoQW4CQRgtdrlnRyB/xnQRzjJM
	np+0nH0tNzzBFaskO3XHCaLrAVdZlq6OpZzTGbSAS07Pvq3F9q5zSlA8qsCDtSoK
	hQaR4RguTEzgece33lyG4NUw6g3EwdiqGkKbbgq9qPzLOULImh7sqIyVP9EgLHaU
	xdv5JI0od60v1Hf2Vl28Xz3NOBSxt/9hKYne78oB1Tx//MwDe2ctnx8Do9v9jAUJ
	kEUGUsYqRGwN24rO0efZygcbf8r4g9DE1wZ6sZqn+RDfXjNdgZf4ZMy9+PHmB8ed
	D9D9zh5bhw3x4UIV8q+rHI+lVjmUjVxGbHvv0+61FrZpqikeNR7P56XMFDw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cbyxujde3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 05:47:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3562692068aso4380939a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 21:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771307266; x=1771912066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4LI1Fry9CJvHO5MYeXpEHSkT1JzvPFcJjjRx2mFKr0=;
        b=folc8mpL5hBVE6ZZzgBVkj1jqkrWT2rZVKulTy9k2OfXRAcu6/G+erCNFln2bj0M1o
         sQCJcJSONnU2kPC4NlGJwk15LE4Wy283ubmdPcDRpyMnu9gAZLDM6EhzAwaW73MO8Jtw
         CP/vdx4jCVwd+m0kE27ERnCCiTLzuQDPbELYtY9CDaf8aXT+UDQIBsd18Kd/uFGrKDby
         PZTh+0GzinT5muGaltbU8M+vE/knb/91OTaaVf18T/4/P6se8xZk2IkY4D8MUPanm8EH
         miKbLes8590OC95e2SnN6wmBN/GHUT4lKKjJnjU8nVjgcpBqXRV+ptaUuiUa0FDOpPkZ
         uEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771307266; x=1771912066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4LI1Fry9CJvHO5MYeXpEHSkT1JzvPFcJjjRx2mFKr0=;
        b=JZRZyc0VdiVCniyuegCpVr99OqLkOkxku1UQHrxwSHbX1vL/LWKkrGy4b2mHJYS4fD
         lEteDq0FbAVnnYu7qi81Iu021fXlqVeccTMVUMiNPSginB5+05VI6+Yway2xIezbV31E
         tG/jmtu5vi+n+Rzz8IQ74fm2Rjp3Z7ZlltJ72QPU1xubTpwU63mgzxAGDHJ7tnKUkSwn
         fVFiXubPtllzuH3u97BH95V0mSUKU2eZD17G1TT6Igq7CtW2nT8AFb+WmBy+WyzgWxhS
         B3BwLqxbllsr3I59OvlKi4c2lIwgKwRpGWyERHeSnI2QVqugasZR2Dy/Y9xYtNFQ6f3O
         p2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Az+RtGyNVw3epGuI6TbHHELtFCe+xW5i6scE4jpAaV+oJ6GOW54drmX3ANPGcWJMGvix8OYqgoKd8BYAFJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YycGCS21VS745XcI9QYnVt0MXdfcSOb3E7GvyOKXU0hcG8JVzXh
	PRVQBmWPxzRPbWfrr+wKFWmZaPnUMD3VwmG9rE2rI228apK1FMLfUMEf7rFJmQNbMo3Sg63V7JI
	1/0saJB22XJyzmkOuanjIZ4BgQbdvFLYcJj4vCpugGwDW3s+AyE4PNa136Hr4lL2JJ7WHn/0=
X-Gm-Gg: AZuq6aK7GE+P+dvKTNe0GZ4uDDsaXhTzxTBfmvM2PwQCv+BGE8lj8GCnk92eZhhqflH
	PKdsV+TZyZV5HlFqwthiXXLHtHZk1yrgQ39oT3hTtqOK4tFJCIExPIxRIWc6xCAkys1yUqwWPVV
	LhfPL59EeE2v68vIQ4aiqUL5xIM9arWHsJqdHer5Ne/cc4HAC+GT+H4Y/sZWEFiDvn5sB6AY2O6
	aUtXz6OWha2d3JKZM1THSwFXVnev/O8NbLsFB+WZxBmZ8S5EtjLcGu1lPmrgOk23xOwnNI7++L3
	O91ckMkEnuBCVwsKzZbG9ZCpUeg8WeaUJmAPPAKIcZQt+jpfjmN7u10CvibpheL+xczL5k2zHeA
	K1PQNM+GucXXYPPhYRIbPt+DEZ88pubfy0IiK5oTKNYvzGdZze1g=
X-Received: by 2002:a17:90b:3e48:b0:353:2972:74a4 with SMTP id 98e67ed59e1d1-357b51ad1c2mr9070765a91.13.1771307266218;
        Mon, 16 Feb 2026 21:47:46 -0800 (PST)
X-Received: by 2002:a17:90b:3e48:b0:353:2972:74a4 with SMTP id 98e67ed59e1d1-357b51ad1c2mr9070742a91.13.1771307265762;
        Mon, 16 Feb 2026 21:47:45 -0800 (PST)
Received: from hu-vivesahu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662fac3c1sm21429775a91.17.2026.02.16.21.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 21:47:45 -0800 (PST)
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        janaki.thota@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: bluetooth: qcom,qcc2072-bt: Split to separate schema
Date: Tue, 17 Feb 2026 11:17:30 +0530
Message-Id: <20260217054731.3058567-2-vivek.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
References: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nUeeEaCKOCfmYhZ9EyH4cHUfyUuLrIYd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NiBTYWx0ZWRfX6MdH5zTBS5IN
 FVLu4rjP48hnP51eeCUz+Ms6hsB7IHXLfdApglCas2GeaQHg5DkGsYxqoiUxX8f5Uz6GcuCyIVS
 7SSc0xqejHCHHI1H1nXd4Ewp0j7XzqFZs9tTwfvziFo8UCDMuFJ0cU+aamj6sjUxoxurtMz5q3z
 Z90jm7ie9P/8u4mu5qtBaR4zbKGZNKLvuSxfH45wqDr0Ubir24cpouu+yZsXoO0eJpj4v1MwTeh
 zBwpO0cKyupQGGUeMIGilk3WSv/58+7GSSJ0ldNW/zZfpEPGjMo9nA5rhxw2kh4OvAoIW9aNEv2
 7vf//I9G+x+18sPhQ1Np+Wauhzgs8cFgIdk7yy5kU9lbQiOEU71flFSj3O+o+AR9nV0dXAlKqrO
 74t3ksbdHKFpXr1GOmsyj5OUEtDXGFLmsxkJK1T4XE83toVnzgGj8CwsaU4TUE+NYIysRTkQPGm
 PhD0PZo1FnDhBM6t2tQ==
X-Authority-Analysis: v=2.4 cv=BpuQAIX5 c=1 sm=1 tr=0 ts=69940103 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=n3wo9_ZgQVSFQRmRku0A:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: nUeeEaCKOCfmYhZ9EyH4cHUfyUuLrIYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170046

One big Qualcomm Bluetooth schema is hardly manageable: it lists all
possible properties (19 supplies).  Split qcom,qcc2072-bt to separate
bindings, so device schema will be easier to read/maintain and list only
relevant properties.

Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
---
 .../net/bluetooth/qcom,qcc2072-bt.yaml        | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
new file mode 100644
index 000000000000..48936bb8e91c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,qcc2072-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCC2072 Bluetooth
+
+maintainers:
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+  - Vivek Sahu <vivek.sahu@oss.qualcomm.com>
+
+description:
+  Qualcomm QCC2072 is a UART-based Bluetooth controller.
+
+properties:
+  compatible:
+    enum:
+      - qcom,qcc2072-bt
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO specifier for the chip interrupt.
+
+required:
+  - compatible
+  - enable-gpios
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+  - $ref: qcom,bluetooth-common.yaml
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    serial {
+        bluetooth {
+            compatible = "qcom,qcc2072-bt";
+            enable-gpios = <&tlmm 19 IRQ_TYPE_EDGE_FALLING>;
+            max-speed = <3200000>;
+        };
+    };
-- 
2.34.1


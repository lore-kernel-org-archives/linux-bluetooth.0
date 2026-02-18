Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB1A30F549
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771415412; cv=none; b=u75qmU33WdebzCKsKhfqm7YGKLiPGaZo2WtGFZ2Ebgp8M2TKIjtlpDHjukACwtOei20zrk3mTphCgDKUhN3sPA/CSyLB6c4wyQVvtIoalhrpgqTeK2lUcqjd29P+O+ZUccEE1DUsPOT92LsSxXWvcaeGbKPwkiAvF4XK3HMB6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771415412; c=relaxed/simple;
	bh=pfnWtCP2SqzSh5qaOJ8CDGEV9I8xwYdhCVnMofQVpfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R06Nw+dIoIJXurNfnB43IQ5arSsIR/tXAHeAucdovrC+aplW/Y1GI5poiiJ8ixTTHiW17IOx7FaZl67Y5ANoL34AJfPxpyE04pWk4+FEzLDWhWvzIuIB1vF5HtcfTXGuNnyuWu0ulymtGm+sJhP+OSVE3N64PIQfcHqpJbSs+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n0abLZVi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c8vPo9Up; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n0abLZVi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c8vPo9Up"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IB4OMn1623780
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=byRIuO7+4qA
	T7Vljc7NYIoqed3IcWmvzJYq+ybzKxwM=; b=n0abLZViAjWRtOWkU92bzni0A8/
	YUQtspLyPNVUVYBE/gHhuqNHMf/ZWMCTQbQrE/yfmQUCt0aB+hSNCmq7l9kjDDU4
	/LcEjU1Blua6HykhSgEbqbnSybr712MW2fzCH21nkY2dyMUbfLuWw9zu+iCjTAzG
	XiVEmFn2bEU8SujdxF+EzCc8R5wOS/KtGWiTsDl2snRS9YAbHHS2l5IfiPnNmkTs
	tm+nte/3piWVS2lTqaW6YwsaDh9GNaf4mARQ2Hfui5arLeezIUTeRPDkhbJl5frt
	JkxI5t57W6wEv2x8E6HPx9kBlneIDCaWEbXjVcRdM91VpLQsqfWgkDzWAFg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdc7u8320-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:50:10 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6dde310601so3490805a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 03:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771415410; x=1772020210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byRIuO7+4qAT7Vljc7NYIoqed3IcWmvzJYq+ybzKxwM=;
        b=c8vPo9UpxSYL2ZJhoQeg+0DNrw2Stjxst83xVAe9ZW7icS5O755XPjOvwo2FHFZ1Go
         veaJ84TPlj14XhsGRPeON/8R6WVgPBIJHSRTvwL5nYZqUlk8JYrDRuIMrL9pV1ly/uKn
         6XeqY7ia8KlLN9s9gWJ1bjCe0ufd50dgy7+aIqACYRNSspuDCp0s/iD3v4L8ylhNaCpn
         w+078B37k9ufuLyiO5725xHY6IZCBeWq9G7aOXCiVoZaCGUCijxXS+N1s9S6+Xircw+G
         y1CdDtfoGhcj7qKvHXtyk6ll8qIqnfasobsejDEBIviGkVxVGiBL0qcB6L7ky8lQIV8H
         knGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771415410; x=1772020210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byRIuO7+4qAT7Vljc7NYIoqed3IcWmvzJYq+ybzKxwM=;
        b=MQ5L/giRvr6x7wEBuAAYq4HqgXzT3xom7uE/OsyOLrKok4YgbH3VbMsSpvVNM5qfS6
         Wume3yNiwaYyVqNvcAk0Tgj7cxh5jHH8r1YhaxDcNrKc1Bckj6Pc7yfIdS3ohCaEu6kq
         7QX1lWpQj4g+PN1NZ8yXEch+OxAqoOkhl1pk1OV0fEDa/zFVm+qvs5SFFrwSgJN8RPfM
         slB7uosoKSQIJHbdUQ4YG3FegWQWj4tUmgYY6IRV1jaFfUqgrpDPOyg2e5VfsqwcZM+l
         whdQl/ySI7zIrpU+eRJhypvp3JltebOZly1jUio9/Vmkye9op9tO2R5suojkaj+3OB9B
         o10g==
X-Forwarded-Encrypted: i=1; AJvYcCWbiFbzdu41wCIPSAuo2eI5YBHpYXQ4YLd4WxtlbnF7gSsqDNNJRrTxiVLOWVclcmuAF7C76JAnWsZ5J7X4nw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrzaas5pHfyXScHC5gq1wG7yEnX7Z4dAIDrAwaewIy3a13Jf+
	jNZ0Mz415zKflgdnUqTTU74DkmBKW6GJDEg1oNZz//o6KNDR4RVZtd1b5Ked6ZTPdgqiK9qt2UR
	czYJKtXz5l32dnklZuAcjjE6kf7At93hQvYqFYbC6vvlH+rXeQlMcOwXfNAQRwEu0AYlXMtQ=
X-Gm-Gg: AZuq6aLo5sO9mvQAMCE/ZjvhAX5TqDvQNZXZMW/SMmgekh9Y7e4FkDFfSt5SOGtGBzc
	+vdPVWa2YDY5J9uAuBgqyVi+BHpEOe5FKixfvY9gjp5vzPXwOESQbess641ygCqyrPDDiv54erv
	Nm6miwfncAegPy4clX/bPDw0RMzVxr39hfIK5gRsS+OJbeP5xqTEWtXmnjQF0c+3HWHcdAh1pjD
	dWm6zXN0mcjArvRPhvKjL8sxDVowpQl7B91+GxxQg4ab5Dtk6GBucLeaMAyz0imFQYk6sFVA9AJ
	9hFeyeguWKALYAYYRq6Te62xImV7qkdTdG208KsdE73y+ZjAAifVsTqkWTE9UCXnWlT9oR9xdj1
	D51uzdsXLfEGFjgtK3abVvTigcV6T02u8pftdTLRFM37wlcGmpeo=
X-Received: by 2002:a05:6a20:2587:b0:38d:f405:709e with SMTP id adf61e73a8af0-394fc2f2adamr1408025637.48.1771415410025;
        Wed, 18 Feb 2026 03:50:10 -0800 (PST)
X-Received: by 2002:a05:6a20:2587:b0:38d:f405:709e with SMTP id adf61e73a8af0-394fc2f2adamr1407998637.48.1771415409576;
        Wed, 18 Feb 2026 03:50:09 -0800 (PST)
Received: from hu-vivesahu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e52fd08fdsm12459222a12.6.2026.02.18.03.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 03:50:09 -0800 (PST)
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        janaki.thota@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Subject: [PATCH v5 1/2] dt-bindings: bluetooth: qcom,qcc2072-bt: add bindings for QCC2072
Date: Wed, 18 Feb 2026 17:19:54 +0530
Message-Id: <20260218114955.3970974-2-vivek.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218114955.3970974-1-vivek.sahu@oss.qualcomm.com>
References: <20260218114955.3970974-1-vivek.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 03ulJipnJuYzUK_LCFT9X6H-AP4dfVf3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEwMyBTYWx0ZWRfX/Df1c2FoiAZ+
 Xs+pQSwTn6dGKfZhoQfjY/CBrqsfP1mPmng2JveMmkRaEDgmnVCeZtX65ZLccylZzK+zU93YZ8t
 lRpPHL71NU8vH6av6M5Gr5U1bcSlz12OOo9orN2D+umIHU4dlnKEqe5FmNXVu+r6Y7TJ/HSHTwo
 cBwWnUSqDxOMD3QYOVIAXkxeBSQoKw0yfNp1Ss/OPyF3vNz2qCoc7JotYcLpCqI6djIc4kKc6Nt
 UKOLAyg4oUqMxcYFUPBmo/JeTfgLSOhCD0aJSiyjeDfyr9KlRU8gTz4PHtNq38/wbIt/QuOk+gw
 x5NQ3XW4gJl1lw4dMu2VpWr3/jS1YIkAdhsaYNilylWh9oWnoLvEzpTvygoN6Q/7hi7gJORexJa
 lMnral3NnFvPtVS9qU/HAKsojDc2NMGtDhNW3odWiM1QFN4totdYHk5cRTRN+8i66LLP8W+hJPM
 B9ldgvmvwEQSW/KDSXw==
X-Proofpoint-GUID: 03ulJipnJuYzUK_LCFT9X6H-AP4dfVf3
X-Authority-Analysis: v=2.4 cv=daCNHHXe c=1 sm=1 tr=0 ts=6995a772 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=0QCEEdivNueWlpcsm30A:9
 a=x9snwWr2DeNwDh03kgHS:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180103

QCC2072 is a WiFi/BT connectivity radios which exposes
UART as an interface for Bluetooth part.
It requires different configuartions and firmware, so
document it as a new compatible string.

Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
---
 .../net/bluetooth/qcom,qcc2072-bt.yaml        | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
new file mode 100644
index 000000000000..7b27c2c651fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
@@ -0,0 +1,47 @@
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


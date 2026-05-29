Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435ED3932F1
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077241; cv=none; b=bl2/eUDXywgLwW1P3QadRRfxCVedIEd+hvx4J9EGzuigPA4sOcCx8OV21UPIOwJzS2BMS0LisMVx0QqfIbb/0IkwUeAi3ZwsdOBAXrBfVnAI2w0GUYgWnGX/mryewrF+bjOmQ/zIxwZMf+rRKtc8UKA22AfF5o7iysM5VBCBowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077241; c=relaxed/simple;
	bh=yeQt+q6KDTBpZuq2sDms1w9xxk11F+iLVNhI5edtw9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IUI08b6Gn2HhOq+n307di18SdnaPeqCImtljWx4xRiASrbbUIMnrOISsfdCpox7v5IkOuLu9kU+mw4UvZDQul+06uimbMAN/PwJjmS/HSJwWRVY1S7/V7p70S4xnnHW/J3ft7nC0c2c5CkVFnNQlKCIzQOsCHNMjTBtVOQeFsfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T0FsDIEP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FRkZhhT3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0FsDIEP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FRkZhhT3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TH8Yng4178481
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 17:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=dkfRisFqrgZyzc/mO2h/zVdDCwLfUT8/SkR
	65NdWqWo=; b=T0FsDIEPykGq15GjT5Ytk+/6ymlRVeQgxB2YzQjWZkSFnrGPK9G
	wN3iY/CHDzoptlNzY3aA7V5NK0cOr8MqcZ4KM8/vbRaSsPRSciBIvTsDqpfKl7ZC
	LHM6eZ33SvSwc7m4w9jlYsVY4TG2tocWPS2v57Ba7xtJKxur4q9MWXFySjVrM5Re
	yd5lHLl1NnLFsSbHQq8ozODDWUlYyBREVX4wRqQVyAfqowOzIZeAaZJS1N+iJAM0
	rZpvh0BPOc9wBYKHbWeX9t67M2LMR1rQ/OdwhHA7Jub3SmB6P19EsxrHShCAFRDC
	+RFn50YUlFq5jP8Jae/k9wKmZYgAzOzW5Rw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety5wur5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 17:53:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36603ad6709so11948330a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780077238; x=1780682038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dkfRisFqrgZyzc/mO2h/zVdDCwLfUT8/SkR65NdWqWo=;
        b=FRkZhhT3LomUPSuXG4Co2+DUxSzxx7AAhokGoiJ/VlqWnTO7Z8NF9mY+OYq8QZchBQ
         fkMbTv1J6lLgYwOaziFkoCgCiaBcI/wE7AGylkehjSvW2NTCVrUxXsP6duewAzLScpAb
         aA2540CVz6OiLNDxQ+jgGQKXVAzp71Rb97AVqWVrdlQ67DHWrfx6gOuEde14mT7R+WDe
         MKPE4Qi1Xeaui4z71wfZJSloekYl0EofEseu94PEFB+xM6i2dcKHk23EDQ6XiipTyI+O
         zDO59QKjtX6qKeujDiJKrktI+LUE0n9yx6+ZN3gyXFNVy0m4kTPiyC1IlhPCFAfI2pN9
         g9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780077238; x=1780682038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkfRisFqrgZyzc/mO2h/zVdDCwLfUT8/SkR65NdWqWo=;
        b=bn8N64ypKPMmp+2n0d0ljXMyWAde/hKe83gyzM1LIV/H5RGFmi9MQNSChRTU0izoMY
         aGh/K8j65/bgBlsjKKp5tPuq1UGlgJIaK/gEEl2vaGebAuvhVvWx/iS2yjlYceyfF0eR
         3QBHTGqveB2NaVkmFTb82urvTHnY5PE5TwLCMLHowymSfcGXZUjekm5F0ncL2m7r+siq
         FFIyHphYcvTs+O7Apg0379FYiZ6L72MyND3LzPCU7Uvz1ezE2H/w0sJ1s1Eq2D+8wYCo
         AdaiVB8wCRchxf2ZZ6mYO9HQ5eqkSgcEX2rzhDhzDHQjoomRS/+4VPc/oWE1t8xcGrlv
         1Bxw==
X-Forwarded-Encrypted: i=1; AFNElJ9ifvu2+ZK0ZOyYYhiR1bQD16e+N+uI4yJ1YSRe3g9nEQbmaUj4l0txPSDFyoaYE+0PPE1dFGLkvkL/f95+jf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdgLD2T69T6ZORfJJtQnp/KgbrJJ+amsjA9X+xr2Dks85sWGg
	Rw7Z8ercPndG7gKhuGb9+4v7Rmh4AxNs0puqOOfGe0r0UKaSKIHW6xDtnSfQDjmz0Afr3H3lReS
	IO2vtXPLSobnsqzRi9usXTBaLtU4bj/CnlP2FwMcCNTEZ33ubaiiCfbdXCM/yPaKkGjKLcvY=
X-Gm-Gg: Acq92OEiTgf8VojayzghoOB0RnjUbF4yG3dULnMnAAMdpT3wwxmERu9v++eVda6AlCB
	AqeFPuhvpO1jnontxrH6PMyfogGbSaZrLYuEO8D3dDRo4gPpUzQqy8i+ljzBxLNeytg+FTVOkqa
	IrEk5YNE9VjXQBNf8v2XDL3GhK7sxowU6HzFeIGSxSHNXL1m/iL7cKzLOJqEbCtSf7zq/+6rB6D
	K8qhT488mG6U8Dl7STMSdoygR54c2zGZE/WeqJzJWByKirZ7FL5i6xYXTl2K+6BHCDWtSnaJs1A
	l/K7HzkbWAJf+VREDOT5p/qYJZu0ccEZl15zZktQS7gy4voRD58EeP1RG+iijiwxA9Qr59FPEow
	hDdhwhr2IPYMOKj5R5lD5jyiLD5zbKD/9v2wWRRAqCHmV+oBQAEsGHeL0Dm6MqQ==
X-Received: by 2002:a17:90b:1c04:b0:369:e1fa:962b with SMTP id 98e67ed59e1d1-36c684995a8mr167709a91.26.1780077237703;
        Fri, 29 May 2026 10:53:57 -0700 (PDT)
X-Received: by 2002:a17:90b:1c04:b0:369:e1fa:962b with SMTP id 98e67ed59e1d1-36c684995a8mr167668a91.26.1780077237192;
        Fri, 29 May 2026 10:53:57 -0700 (PDT)
Received: from hu-ysiddu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbd667fa4sm2088196a91.0.2026.05.29.10.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:53:56 -0700 (PDT)
From: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        rahul.samana@oss.qualcomm.com, harshitha.reddy@oss.qualcomm.com,
        dishank.garg@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Subject: [PATCH 1/4] dt-bindings: bluetooth: qcom,qcc2072-bt: add bindings for QCC2072
Date: Fri, 29 May 2026 23:23:42 +0530
Message-Id: <20260529175342.3363935-1-yepuri.siddu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zpHm9y0_syz6elUhdu1PagK0a_sIhRpT
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a19d2b7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=RzHWNqaCwg9CAr5QTIoA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zpHm9y0_syz6elUhdu1PagK0a_sIhRpT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE3OCBTYWx0ZWRfXxSuA70RPuTKb
 ahiJDoIDQhJhQM7Nqrz5htF5joJ0MoTJv2gmWM5BUybvaMuGIwq8XJKJxJpb+JiHCpNq4v42PYf
 7ZS4iCVr3COIkJe4GZjsZ5Yg8zPUuPhMILD4V9v7s8xtZlEsvT+/WEy94eCaEPTmOuWQKOftqKG
 jxddYMel5J1EavN1mRYVjnwr3yjtqWLbmh4HLgZLfS3aidxqm1MoJSGi0c4vDPSIuwS2wQQBrmB
 GFY737poORJLWHxWxcmR/yMs28pNF4Qd2AIc9jtdrAO382XU6OSaY2jbOVEK/VbYOukN9Uth16X
 RaGyJvcFszCVm3JmT0TQzcD0a6TIfN/wfIMgY7JtTkJM0bbr6CMEtmWEaBGZzyX+k4tLMdsRDzx
 aodV3kvUKmUU3FcWRGINWPoki9jyjmJZVRjnmr6n2s9qNp//rAQM72yCEZesezLBm5SJZO9TEtD
 Sp/lBJNOgmohBmc6/ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290178

Document the YAML binding schema for the Qualcomm QCC2072 UART-based
Bluetooth controller.

Unlike other Qualcomm Bluetooth chips, QCC2072 requires no external
voltage regulators. The schema inherits common Qualcomm Bluetooth
properties via qcom,bluetooth-common.yaml and serial peripheral
interface properties for the UART link.

Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
---
 .../net/bluetooth/qcom,qcc2072-bt.yaml        | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
new file mode 100644
index 000000000000..8e2f15a75d62
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
@@ -0,0 +1,38 @@
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
+required:
+  - compatible
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+  - $ref: qcom,bluetooth-common.yaml#
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial {
+        bluetooth {
+            compatible = "qcom,qcc2072-bt";
+            max-speed = <3200000>;
+        };
+    };
-- 
2.34.1


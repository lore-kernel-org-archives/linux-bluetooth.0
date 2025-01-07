Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE11E3790;
	Tue,  7 Jan 2025 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736242034; cv=none; b=bQkrdLSh5VlwsbeyTQoxnTE/BZ4MlUpbaCaffE3LIVGk0s0zQ3Omvq62FgbDcSc/sAtEo1EhbJgdCBmqhXD1gNy7i5Q+kWS21SO0lfSUxGdRrfQN5pE0bsCydFgq+ssjqIAopqdaDYFqkj3VRbCf75e2Apna8mrMY2lB9qtIP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736242034; c=relaxed/simple;
	bh=SVuO602L1GV2cWwqtewekQVghURjXfpYInc0NJInQCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6V7e2ULOAaT0glt71KEXU13lGAkmKtwF8HGPL9tLTVg9J/rRZNld+PwCnpjRNw1EYO+WJtHf7pzfxpqbk3CI/OFnimiMYOaTseKhvymoQxakOmDVWHxasiAksGcufSLpwWRobv1xjxv1qlZFLmcSKLwh+o3w/m5htWKKM6iZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hp/d/deW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hp/d/deW"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5075Lufs006140;
	Tue, 7 Jan 2025 09:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nVAK+m4J45E
	whLsH5EuEXRPeAHS+ZdO4Dl0dW/NZxgU=; b=Hp/d/deWoe6sed7i55jhzb4BTvT
	dwVmK99uOM1dnAZPddb6bMNlgPGE1q2CFn/pzY4PvBg5SqctNBpTXMgBK3lWLNUB
	79Rw7N6l0NmPX0IsV/9E5IEKdpolqw3rTGDXuL4COfL2Y9bp15ZNGMrXqfS6ABsx
	rmqYH8GoMeMvRc4KlBRqLwxWT997TYK+9zsyHAEzmXVDSEuAa3A0/AyYcYeuRxx2
	EKzGL3mvfzCbkhjMBq5qCnpeNLxvUQbwQ0o2hy7hRFM4QmMLV60i8CLkE4WBONFp
	pkHYj8yWlzO7WipDP2bkVkcrY7pV4pdXTu10ZUS2I2accJUhHPOUxS+HOqg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440x288h73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:27:01 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5079Qwp9015845;
	Tue, 7 Jan 2025 09:26:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 43xx2kj3ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:26:58 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5079Qwjf015836;
	Tue, 7 Jan 2025 09:26:58 GMT
Received: from chejiang-gv.ap.qualcomm.com (chejiang-gv.qualcomm.com [10.233.43.239])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 5079QvNE015835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 09:26:58 +0000
Received: by chejiang-gv.ap.qualcomm.com (Postfix, from userid 37913)
	id BA186F55; Tue,  7 Jan 2025 17:26:56 +0800 (CST)
From: Cheng Jiang <quic_chejiang@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com,
        quic_jiaymao@quicinc.com, quic_shuaz@quicinc.com,
        quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 RESEND 1/3] dt-bindings: net: bluetooth: qca: Expand firmware-name property
Date: Tue,  7 Jan 2025 17:26:48 +0800
Message-Id: <20250107092650.498154-2-quic_chejiang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107092650.498154-1-quic_chejiang@quicinc.com>
References: <20250107092650.498154-1-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kRrcjOusrqljfo4dsPDRq7QQFNRf1p0D
X-Proofpoint-ORIG-GUID: kRrcjOusrqljfo4dsPDRq7QQFNRf1p0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070079

Expand the firmware-name property to specify the names of NVM and
rampatch firmware to load. This update will support loading specific
firmware (nvm and rampatch) for certain chips, like the QCA6698
Bluetooth chip, which shares the same IP core as the WCN6855 but has
different RF components and RAM sizes, requiring new firmware files.

We might use different connectivity boards on the same platform. For
example, QCA6698-based boards can support either a two-antenna or
three-antenna solution, both of which work on the sa8775p-ride platform.
Due to differences in connectivity boards and variations in RF
performance from different foundries, different NVM configurations are
used based on the board ID.

So In firmware-name, if the NVM file has an extension, the NVM file will
be used. Otherwise, the system will first try the .bNN (board ID) file,
and if that fails, it will fall back to the .bin file.

Possible configurations:
firmware-name = "QCA6698/hpnv21.bin", "QCA6698/hpbtfw21.tlv";
firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";
firmware-name = "QCA6698/hpnv21.bin";

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
---
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml           | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index 7bb68311c..a6bc0b18b 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -101,7 +101,10 @@ properties:
   max-speed: true
 
   firmware-name:
-    description: specify the name of nvm firmware to load
+    minItems: 1
+    items:
+      - description: specify the name of nvm firmware to load
+      - description: specify the name of rampatch firmware to load
 
   local-bd-address: true
 
-- 
2.34.1


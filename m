Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37C44BCB5
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386200; cv=none; b=Eps2lL61QJZWAyksj7JI/9PR4bi7u2/18pL6uMPnlBXzWSwqGkcDg0BowcRTN+9VGag8/QMyputWzFsgsr0RLy6THGggUC4hpproK1c80CdqpTQ0R4cm36cLon7MvZQDeDqOikPbOSNs5+vNMT3taerLSo1KC3HZT7Isklzcq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386200; c=relaxed/simple;
	bh=dzIl8YppqJhB6Od+T2zCGC/CJ+cKszHfDpLPF2geGtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PioeJEPhbtrU2qwRBl4XsJWo2UnFNc8RFp16nign7J5DIwYSmWgFGGc6ETAanHXoqhAqVCumhLnw0mhlGl2eo41EflqfJ48p+GprdkNB5vwxafL4Aloyp2JNJ+cipaJCUlLImFqqiniuvYLx0PQXejuHjZiSd6SVCGv07S9UreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WW78sBvI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VfEeCoYe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WW78sBvI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VfEeCoYe"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SCtHvX1745003
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yCqCzlz4VIr+zRAIjiPoA3dsT7YZuy9FJGQk0vmxxKY=; b=WW78sBvIUBy1eVFU
	njJYuxlMhWipbbcVudjhYGGP+XiDYinoeKFVUBhnPDAEGLfcScUrldggbPiLQx4w
	yRGYnTpOVRigSrjJgWenphU9HcLPtD80UsQ0NPNBxJCNY+Y2nRA0oaebXe1yf2ET
	XnvV+zwf2g5DC3bcqTe4l+IIwbQ6DCiXA1shrVwUbs6Je2t1uHc0Urky9gWUYWuV
	TWmdr6s7Zws1UD2ea8CbD5W5+zyyqfWV/QYthqt5G2CR7BfPyZYhNd+ZBIO8Mmek
	Ci+ElfzTMJxdzLH8mj+xDSTUQDkGLtZwg4YwdNwabusIJW1pSgyugppW5hNzLx5u
	Ey/iMw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtryd9jfe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50df4c130dbso200061791cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386196; x=1777990996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCqCzlz4VIr+zRAIjiPoA3dsT7YZuy9FJGQk0vmxxKY=;
        b=VfEeCoYemwkTM59YTf0RVou51QvqCcBtqzIklZk7eUfFk/u/P1sJaeKwZ4ID0BT5aG
         RSwxEQReUAdmnQYKwKrhsCAb44buIOCLX2sSggIvrRASgtkc8LqLVR43JbzcwAyeMF8F
         4XN9Su5y+RAc1sgudX1dTFpfvN4RrOhnLIVatpRnC8oXYW2F/miRyXpffCqluLU2f3uy
         Y/IurEEyTmGO0psUeAAhAaQzdQbxK7YdsprsS+Q1P4VWbBOpjOSeGV/Ka98DIflKk6fJ
         JjM1WHzd/evBduwmKHf62e0wyZmaIBpbjd90oDShmEiBcTd3GYmWcI9FDk45kYYK6bek
         jOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386196; x=1777990996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yCqCzlz4VIr+zRAIjiPoA3dsT7YZuy9FJGQk0vmxxKY=;
        b=QlaVCEGZ/rJbcNlE6My6NE6ri5DmTOZNDuVo/daZEL4sdsV/WlA617CD+4f3+X3+GD
         Z9rAtfxzEFTBZSt80qYUI7ZB0yyjHuYCDwqrNAl35atHAdALUV/B8M1jQ1ncQmf+q4DT
         6dF4DRAHZWJh3IEGWBn0RqBXLo4AmN7TVOhR/DugzLBevPX3QasPgPYfuW6LoMJcpwpT
         kyYFTfROVFZ6xaErvvNjqv3qAoHj/rjpMnGp0HzIHpZkpWzBkhT8VeAFva33UKDXNBYK
         55Xs4KLjfsfUwjjFW7wR5boy7pvvXGsbjFpV2Xp4HvrQ1tg136AqEK91Z69TRUuGsear
         /rRg==
X-Forwarded-Encrypted: i=1; AFNElJ9LNQToVHvZAMzBofSIDary122tWmxlv1348d4HTfSTTYxefhDSQeweL+FOoKxxoA2GackM5YncsLSd/wPwF+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0U4i4Ewfzre2DC2fkvNAkXKY36GBtYZJGt0K7X15sTDr6Bn4N
	5EyHOOWOsdGoSraNpn4NtSpUlY2bboBlk53pK3tZndlD3GadKGZTInvx0F07xkwXUSw4c1L7UN4
	wV4CNSdChu8RKBYETnFWyfHX0calooZqKErdXDA5WbHY1t7dPb2RA2G0CIpkJVxn89isMCdE=
X-Gm-Gg: AeBDietrrZteLZy10uGhC/ygI6/v5K4IUDwSm7MtMJynctOCbi48WANNTSLiKcuft5R
	1PNR+fZs7kjasZxfCTIfEYafPuWGMbpYkZDkpHAwP3eLTEMfZHk5EYAAFKr5Nqx8rS5lTwyM2Sc
	rUxcJ5Cn4jM1hzME3yNchM8QABmuXThLSkBtWafHeVkdn2tQOMv1wHU80Yk0N/k4Grryw+3+Yy7
	qOhSOGt5oJDWWSnGsphY2JpJ1UFkh71LdM6x0m8ryWVzjq2B6bizHNPnlmjqRPw21NODnCsPuAW
	OEKOCdwkFrqJ5DgQ7EvYjgniI0SHk31t89eqDNOx/B4aM9YThzfOvAm/Db+SReF/r1k7sTs6G9s
	S/JOB93ViJIwGTJShR4UFbi2nlAPrDGN/tjB4O3VenbpbLZgmMU6XkaAm8HAyKc6DgiFCczFdhI
	eVJCEXBEy1yaLIB/21qCYZwX8uJo4=
X-Received: by 2002:ac8:5750:0:b0:509:5c6f:c0e with SMTP id d75a77b69052e-5100da85790mr39311131cf.37.1777386195960;
        Tue, 28 Apr 2026 07:23:15 -0700 (PDT)
X-Received: by 2002:ac8:5750:0:b0:509:5c6f:c0e with SMTP id d75a77b69052e-5100da85790mr39309901cf.37.1777386195170;
        Tue, 28 Apr 2026 07:23:15 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:14 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:07 +0200
Subject: [PATCH 2/9] arm64: dts: qcom: arduino-imola: Describe boot1 NVMEM
 layout
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-2-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
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
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: G7LTKXPKWXg7nXwBOPfrpmNe1w9m0clT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX5qLo+po/KgdV
 OH0x3QNCKsF9MEzGMiPledPPiShupnNSlQ3UI4rXckZ2sD5v+rucv2Vv9W+lx2BczsnJVv1ATD+
 IEHmSMRaYm8NrtxsKB37b4R1tO7OBm4renR3ByNCZqc0cPEOWBBGkjZ0PgF98YPMpSbr661to6L
 pVtQfqz9wJzdBU3tvbcg+h7J7juQQu7dSfTOGHWuobW/VXSnjgyTfDjaQ/gUj/JC0xT0z/Z0G92
 JmWizAj3dJFjX63DuBIPkiIv9KjsN19Y/Y/Lzi75ZaebjlajkKu4bpjU+cOA05RMz0F/4+h736V
 bGnDxOAGXSXKPb6JtqHEey6G5JVUAhPaBuCS9dBcCmbWLrE6r6gZwDA5At+uIbaozzOT/J1Z3t0
 qWEeuffH87hAgjZIy+XJyfmNHEs6VIaneefTL8ca5xTQoDctj3mUF/rz8vYRdpg9jIpe6YRncJi
 2Z3WeFZW3fSc7sQN8Uw==
X-Proofpoint-ORIG-GUID: G7LTKXPKWXg7nXwBOPfrpmNe1w9m0clT
X-Authority-Analysis: v=2.4 cv=cMnQdFeN c=1 sm=1 tr=0 ts=69f0c2d5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=gjCkitBQ8UzLeNF7HDgA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are realively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and
Bluetooth addresses.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..dc85cf94f71cac8666cab30ccf37cc2d2f8fd941 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,31 @@ &sdhc_1 {
 	no-sdio;
 	no-sd;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	status = "okay";
+
+	card@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+
+		partitions-boot1 {
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				wifi_mac_addr: mac-addr@4400 {
+					reg = <0x4400 0x6>;
+				};
+
+				bd_addr: bd-addr@5400 {
+					reg = <0x5400 0x6>;
+				};
+			};
+		};
+	};
 };
 
 &spi5 {

-- 
2.34.1


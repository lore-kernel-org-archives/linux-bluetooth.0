Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E914248381D
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027159; cv=none; b=QRqNGj83Vpz6DnBNkmPczW3A/j8dcGdtSIh4i5+kzQP7B31FKgCQLUdMG9QXuKkHE0yNvP41iHetpaIlU1IddldcH4D6nKKMh56KLn1Gvgkf324v/rFZyZF+HHVPz3cQhbkiLsdUHWYVXtHnziOHx0k1gh5jS9VFXc+71XE3iFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027159; c=relaxed/simple;
	bh=WoEsQQXEHcp3Z4NugaMqCjtqYrDzpmWHIggHogkIi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gs8wYVNRLoEI6z+nZIU/DW9kG6N9Qs7OmGHYibeardNIf2g8iJy4i3POROlcOBCcy7ZET7bTjsqC0+AYf9wEKaX/Z8UVPmg7SiD0C6ANe+aNvW6gkPdeGvGZAlqnrSWNomVeGTB1P+5MY+D1vUyU1edJP2DVPRrMi5m7uYvjFy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dMUkAwfR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tnr+iYDY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dMUkAwfR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tnr+iYDY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EYXWU1519211
	for <linux-bluetooth@vger.kernel.org>; Thu, 6 Aug 2026 14:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=; b=dMUkAwfRDd94ITcJ
	ThymBVvr/uAsEmhYltnLdBgOLtGCsM13SpU7I1R+KHqilUROU9paqQKO7XtDhetg
	PVBuBjYCGdqam8jYXxy5T/qiV040YQCsxhS8V8vB3mRVIEMRFD1a7zWxDwFDd5m+
	sK9D1RK+Tyo5YQvG5VFtoS6aqFxRUjKyQhEIRIt9fVHW/zuCOoXKxpJmtDhgBncg
	ePMBEnGgV1mGvbRdQysHF6yLqNCKv6W3k/MIW5i/HPTF0aoWIZzQvwUrhJ9K5FnQ
	+qqM8x4p5DhndF1jJL0mKHQ+9Nw7DYmRDAS7S1GVjh2lH9CSBrg2cKAH4yoL/jNy
	CLLUpw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvv5b01bj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 14:39:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a23afcbso24026101cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027154; x=1786631954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=Tnr+iYDYkzUXcH3Gg/w4Yw928wlkOdJHjzUauMzjBEsa6NSoewCsOfDzQiGnNNQdA+
         /78cPEVZafgfuaAh+Rb89r3gxmO6Ftr6Or/mrHHC951Z3H4646+yxiLg5BgDnNRB6f9i
         D7GOhSehre+ReyV5/gWEnjxm3/I5pRuAUkwGHsn1+AG2YzWT2LBB/1yZaZFDYcaqS4xs
         K1k1qHFRMxNFUNRN/FEZiTno5t3BZXQRnM5f6PCIqa7xkCV/k8w13wsY5mPqI5a/qW+9
         1iFhIpge+ucLbh2pdhV0oDU7WdHUrpPTttWE+Oilhb62uzM6L8XCxYtZ7zU9hVGTcihw
         Ix0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027154; x=1786631954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=FHMta+ZGyW7mfbFIRDCjP74Lfw1hh43oa3NcnOGcn8urxTMtE247kMhXoJQd8OEnh2
         wyBimTOKyyw3QCLWqBuuZp1s8106uihu24y2ty6ouMYL1pR7Gl7wZSrQ0lWqpYhIbiTn
         a0bCqBFdYSTBbcbwD9lWVyQXfo0mT2JwuuXM824j7z2923a2t01cRp6for4oBfqNQEPe
         ItQs+BvGD+GIobnk4la80hFfZWHXtD2DLn16kOlx4N4J3jRHyXjzpEBe1gOLW/yZufUW
         HQm8XyB1+UJDPAgyzHB339lCgj9plwdlFwJFp4SD7gRoOFy2UjMY+5ENTZ1e8Uaf294b
         Fabw==
X-Forwarded-Encrypted: i=1; AHgh+RoOA/GDahTn1qvU8L61RnNbfQxAYPi0VQ9eG1ypVZgawLv0OJwfjLM2AKwISwCFqrOsPmINabPEq4cgsv4cGXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4973A/YpDf0PLHFzSAk14ab1Wa8UFZeYnInNKI+jKuciLIDC
	P3J7FrrYqO/ng09+dZPkxlexj/WT8FWJNwuFgu/9KNWkt6k2UWeRg0ocPOdDXDDLUEg1zyE7/Id
	gLsziRMFkyk1z9ZTJ/KoJQIIScn+c/Pjey6XRpR10PUmE6SdN6eyuAcAEQgRmRTcea3zcfbw=
X-Gm-Gg: AR+sD12PXnIMKrsJVXIEPiXkg//SuwtCbIKt6O/8r/UE1ZCoIKcvY2qyn72+x2vImIB
	QkPcYjlD7c+Sv34r5Tg9TxYGxGvMZqHbhY9U+q3p3gsq5UqVpJOoAvVKKNQL1n+kojjSpFpcjsJ
	G6WXEk5jkbOYfecB1VOZZLYhiib67T3r7CEa/sxZoXmutI6kL3fWlNheT1ceuxLk9Ks63EWxdun
	h4ZSeeYnehaQyoS6oSdeAXueQ1WmLqTbsubStweDPiPviw9U/yHQzoZcfAWGGxs9Gh1XbBSu0Ou
	K5BwlciQ84REhhenO1TiQu4f7ijl3C2h5Lv+44dGhCS+WMRJuG5IGjwIl05cmwTx26S4nyp0UKo
	lPFsFI9AqsjthXQpgqjVpGuMOHuKFY6BcNH8EV8p/DT78OG7tFlSVFyLuFUGWCN4AZDLqHFHcMq
	Z4d9prGVR6nqtba+021wEqPNGBqn0t6uDC6BFDzmXAQqi+RqBxQQ==
X-Received: by 2002:a05:622a:1448:b0:517:8f2e:5d97 with SMTP id d75a77b69052e-52ce60c07dcmr146321921cf.22.1786027153972;
        Thu, 06 Aug 2026 07:39:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1448:b0:517:8f2e:5d97 with SMTP id d75a77b69052e-52ce60c07dcmr146320971cf.22.1786027153456;
        Thu, 06 Aug 2026 07:39:13 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:39:12 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:43 +0200
Subject: [PATCH v10 10/10] arm64: dts: qcom: arduino-imola: Add NVMEM
 layout for WiFi/BT
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-10-be598b2a5606@oss.qualcomm.com>
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
In-Reply-To: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExMyBTYWx0ZWRfX/8PiQISVQhdQ
 FpM1tsFlBN50Yr9FqysOmHbbMWFevp08G1YrdQjBNK13VniRSxToUAEiXaNJ1OwjTDSg8IpMaoO
 p3Gw6mSPQyVED8BClxMrB4aYlBpkWyxg9veoLe3z0y5L3lY8Bfx2lL3eo4aLOSYozepRx4zoUsq
 8crgawvWhWM9XgYWW6n9oo1wzBqdGA3x/J/vCD2qBb9UwNXt7l7UI1S867NqESfLzojCD0hWS3B
 ulkvQfcM18YvpM+XCh1id/abmjA4QbbDRtsY/Ck8J5hnlvDiaL/qhCkH7bNnEDcI6mEKONKBsnN
 Ax40v/4vfvCQ9qJfCJrQ3Z1sxC4qr+WuQHqZMFFhtjWlbgJ4cBhOWKM6V4oWLcJamGJtoYBtqwN
 YuejMjX+L5ZlVReot3k/9fUsII2G2qs32UEB+Jn+v+JyvmNtK+OvSL+P3vl0T1SNoKBkyIeeYk0
 wwQDKKXRC7XlX4WZu9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExMyBTYWx0ZWRfX5wIFrGtcSGFP
 koF6Z7nfqpKD65lIGMbFsJcIBviVaqOhpgZmLhhlrUj3DicJN2ItIGbo5SunE7rqHAW0KkOvxQ0
 afB4zbxNQFR/m0mByEXn2TWOSCB1jPM=
X-Proofpoint-GUID: qFdY3nR9UN6bEJY0d8G4VLxH7c9WcC2p
X-Authority-Analysis: v=2.4 cv=W4gIkxWk c=1 sm=1 tr=0 ts=6a749c95 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: qFdY3nR9UN6bEJY0d8G4VLxH7c9WcC2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060113

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are relatively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and Bluetooth
addresses, and point the WiFi and Bluetooth nodes to the appropriate
NVMEM cells to retrieve them.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..38839b8a361e76f6c1989924b16095b9d8815f66 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,33 @@ &sdhc_1 {
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
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wifi_mac_addr: mac-addr@4400 {
+				compatible = "mac-base";
+				reg = <0x4400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			bd_addr: bd-addr@5400 {
+				compatible = "mac-base";
+				reg = <0x5400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -512,6 +538,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +586,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE5401A24
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270492; cv=none; b=YutKIWSioqf6oRZ9cTprewKduccdI9KvkuM6KcwMU9d0E+ejL0L6vvljZChIrhaMp4eTEzItesQu8IvK5C2rmlaTd+nY9xzQRWuAnlUjKsqPNlz597Zz8YtU6QknmZld4jXYNYi+k10OzxZkIyQxjFMW5srGVbQ1ndHZXO2NXUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270492; c=relaxed/simple;
	bh=45LaNgBPxbRtyHZ0FmSbWF4XyTOkfAE6p0u9C1oK9dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=piqtMRcmP+o5ZDHGcBf0Tlk71g6RasX+tukFovXmI/cY8h+BFbLYyBpCCCtm8ABTC30lyECS0XqWYNsAOmoReK7RIcnlw+xxjh4DYmiOXcFOQpbTjR+mcy/2AIk4oX3F2bOxRhIpGQqe7wsvdSfFpOKChEseo4X/af6rkEv0z7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G9bbuHJn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aDDfRKsV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G9bbuHJn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aDDfRKsV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCjDoW3721700
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=; b=G9bbuHJns2jGAuQl
	c0OmC1/0RgFcZ7pu2qqlJpfgj0uKXnddJ3xd6ERtg9Mapdhviz2VhO57OIKzGvkI
	4EEsAKnu+WeJ6SpHHFNf0w6wB7C0OtHHfqPPxm6hMdJHVRmWUl/UlfzSYO2Zi3tt
	YpqODGm5tWyaKKsCqpRTKDrvuRPSHVTdRnrdIyipaf27n7w+OVs6YoTdLT0TH0ci
	WRKo8AfPax9s6U9HtnxoAtmH/2saLwqAZFP7nULUVgKyfS/ERJBRE/3KAtQrHd2z
	Zbu5Xr+GlfJ/PedbDDCY6Hfnma/rCEm7wdbusenoP0BmtcCsiRQ1Vl8mx2LxuMVe
	jixX+Q==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1cbke7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:21:28 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6751c50552dso413974137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 06:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270488; x=1781875288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=;
        b=aDDfRKsVLX+OoYZcn3QTr0Ix7AHpiG9z4IXLX5laFH8XkPVJoMGoL/z+ykTy99h+6i
         edDCgjMKntvmJWvFR84k9WzNWtQdEOVYWbToCVQcd73pppMJYgKq/nVJYcHHuJvvRX+q
         Z/kkMWENIB3VAYJicYkhkyzlRh7MfZLrZZzhbsUXZBT5/rGUOdpM9W1pTE/XwkWTTVdc
         GsvCsMq5e6Sk63a7ZyRcR2mbulGltznIa9BTWibG3+Zvgs1Lig4dSWszSIhgzQEhXrb3
         NUydsx2VSE6/01kVOAJzRJe+9eC6NmDMSl7x/tt9k05auxmzZYk20ZO25GmKNgeGpfJy
         0aSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270488; x=1781875288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JbaVcxwuW0pNu9X0F52ZmLiaxV03v+NOG21Kfuhl0U=;
        b=b7fWBsoaG6ZS2CjzygqXfZUa3+NpVwaQdb8z8kcTvoNARfQ4kPqR/o8c/fE2bbIU3+
         8qEV55xzs3iBmZYKhLVXt2Epx6vw6AKzs36bE8sqONOTjyy4b7nPnepQrzXVGqbXbJjV
         wnDxBbm0+YC+qwL/U/+SNyJj5X6k2Wk6Ss+fBJzi7MO4ziQDZUksOqllHZV1zPBSUgUf
         HkiSz3ooeW8+gx+Kipj10Y+TVfWrlBd79oA0aPLzKdgmKLlZNg1l14EruzUOimQW5n0n
         3gYNe28kUKWyMStUK8vvHphR+/uVHIddgLPQJ37ap85nLv2migLDrNNrVC53ZzeXLhwQ
         hPow==
X-Forwarded-Encrypted: i=1; AFNElJ8f7Pxl70gKvJC4bHFZ8JGGvQhjZSVmpqfr1U25OCydugVtIOxeQ+NF8N3++whnUG474XeVoYTZQZQEoTuMz2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4b682s3Tlgjo74jY276TSyFM1pjqtYQIls0iZ6qSpRkGhzp/
	4jhg9HeeQTpKM8cppt2JoBJHk9Trp6HBZ9x2Ry5r37iUH8/90gw7S37tuJLP5ZES53TFBKAMcOG
	gKgJwwzese1J9F68jUR8uVfmtEFFjW/5CNvnkWcSe4iyHb0uBME+4dOBs4S+wOwvsYpErl3k=
X-Gm-Gg: Acq92OGK3MLW8j9ioar77hV1qujswuNJNkYbLFGFRnDIgNpH/zI8z3Hcv0p+tgUP0j6
	aEiJpojpASLyZU0iKpkNXIj7BZfGxJvmJ1BeXLFfw7F4OuN8lb/T8AYbI+qAYpGPILOqdEhUUHZ
	5Nz/r7nyoDDTIxMnvfFoSghr01i+LFZh4K0+vlK5NymFgtG/MAAzm5YF4DdizxQzuWyzuuEJDL8
	oL0ggwu9uoypNQ3JemUUPnGZivwYdzQfAAX/eridsxkZYwIl1ZW8RhYdnzTEvy3+6BzfqtvKkKw
	C4jpopIS1xVVB+v1GfyphOqRMqzwRPHV6L11XvinA0NuCun9R0FRf+vhLq9RcVxKASuSEcJB+i6
	VL13n774iBdO0sZDpRjch06B5aCnLQ9wOK7joz0eVVRDvbaXv6p7Wehu5p7CrLkimL7tAthKUsu
	FKVrDM8cq0D8OFMNq73m1LgsMEaMLU92hAzz6v2kAW4qNzTpH55Oi0+20xy1qYy/WoHCao2PL1
X-Received: by 2002:a05:6102:a54:b0:650:a5d1:ee1d with SMTP id ada2fe7eead31-71e88b229famr1135181137.10.1781270487909;
        Fri, 12 Jun 2026 06:21:27 -0700 (PDT)
X-Received: by 2002:a05:6102:a54:b0:650:a5d1:ee1d with SMTP id ada2fe7eead31-71e88b229famr1135110137.10.1781270487392;
        Fri, 12 Jun 2026 06:21:27 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:21:01 +0200
Subject: [PATCH v5 9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-9-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: RmWs8yjvr-KeA1LD7byqy-M-dMOKPFsu
X-Proofpoint-ORIG-GUID: RmWs8yjvr-KeA1LD7byqy-M-dMOKPFsu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX3/KcWd9mmHRY
 bZDhwtcRzXAuD7VVLghMJr+r8CkZEKXi2S9HlxslkKYPeydLLoUflzOQFRVBa0RYSrzrRXH9aLD
 6vTNNKg1/mRrLW3BqBjcYjBWoWtq4d0=
X-Authority-Analysis: v=2.4 cv=S57pBosP c=1 sm=1 tr=0 ts=6a2c07d8 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfXzAiomX0D1HjG
 zAJIALuUPAWj1BoFpbCm9Ruvj6sX4kJfukX/A2umEkfSab5in8jeZnJ3qTvudNSKwOcAM5OOyY5
 GlLtbTKi6goxZ7ugVR6jXVqN7kl15uaq7ekZkoNxotWWSCIvKRCH/4+5i5CgZlj6poCWyxnFmSv
 u1P35eWexU5runicmMMJ135MdmbrEmSBw2uzDeGanTom+zrfmy+wAg7/DYVGUX8RyRRIOuQC37/
 qVduRlj6Sitq/P3d9xLBPcmBufBZAX3zC/5wshmUcHg3VDJoIyYi6/g1FrDcBhOreo9pqq7qBYr
 SUvLaPFoi4YgCiGZTXUyYJXJuQYcmj5tWZK68Qt6kCbLdyr+yQkGfNFy0v9Le/k6poVEz5QcUNR
 oM9x3oOz3WdbAtTAJCu6BIKeOpkH5xa9rTwCzCLoVqc5F9HCrG705eOPagphGDpMjRGj5o25Em1
 pnCrhX2NomX4uI3a2cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120122

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
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..128c7a7e76b5b089044745f5d6407d6391055fc2 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,40 @@ &sdhc_1 {
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
+			compatible = "fixed-partitions";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				wifi_mac_addr: mac-addr@4400 {
+					compatible = "mac-base";
+					reg = <0x4400 0x6>;
+					#nvmem-cell-cells = <1>;
+				};
+
+				bd_addr: bd-addr@5400 {
+					compatible = "mac-base";
+					reg = <0x5400 0x6>;
+					#nvmem-cell-cells = <1>;
+				};
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -512,6 +545,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +593,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053834519BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427272; cv=none; b=D424/o7KbbBR1ePTQepjkDlF4LNOnlG1vQxdxXFjOWS2WER9YMekOSHTuaCP64Z4UqxA/nAxEkiX1oz4bWMrQnWcMh58qTKub9x+m42w3181uXB/2UqMPSkZSnH5MaucQqbbeiW+VXErWn03YjSXimgSUOA7PXPHZ+Q09L5EEF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427272; c=relaxed/simple;
	bh=WoEsQQXEHcp3Z4NugaMqCjtqYrDzpmWHIggHogkIi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbTAIQwD1ZUmLxO2zLzeRhTAIl3/ckgX+hhARxpEdZOKqWD2e7DNC+FEmAUoBJDJALQ9x7xBma24no3Kho5Ui1WPBfAjnD8qLKlU2kXtF3g278BmMmwUWNmNknWx+Pxs3jL7xCa6K82UNKIx47w6+hCfH2khVbTcVQP8mcdtuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=otwBB6sT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XIlShTwK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="otwBB6sT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XIlShTwK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQrxU1223244
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=; b=otwBB6sTYEC5Pwgk
	p/a56NEtduZLgnFOT+mUbwZmBYWofu/93DrVNEGesvn2u1NO1kpmMFM7Y/EP7vAQ
	AO13YWtHuG0oz/mSLBXD6mnMuDZhFC/5pqiqRnorHsmA68wDO/+wRCcq4UppCqev
	eT2yaes1u/23RpAQDNO1tmdcq1oYCaPSMEpD+D91MJQ+xu4fenU/TzQh73qK61Uq
	/TMmMHfwvxlyPIhE55OFFtX+GSYHkNr1kolzgGL3vrQdxzMPiTOEwTy9YG6N8coe
	3oW3PLoWqs2jRYri8450gqjUbt6X3pksaQFP7MsW5DgGcw87aHzTbVjCx0BCZt0R
	EdMuZA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8jmrep2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:01:08 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-977601a649cso2047613241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427267; x=1786032067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=XIlShTwKkzIdXOFPe4qBOVxOT70qKjLoLWam7/CFqhqSajQQC/2ziVqrEo4e8+YtdX
         R01D6MOKpV0ENW7GOFnOIMLJXcWn7kwO6Su1VLxgvpFKrbNOUS95xuBODdy/jJt7RJiY
         8zF9TISp37I+Ob7kmTkIwkdxYmmfQvX3dqMT5+DyUZjwo/dtlcYRYuO25uoNk52csb0h
         iTW+28YL3U0/U3eYspmDAtbZEFdkA6KpkrnxbZoQgl5+BNQne2AvnFQzGdtKIyVMHfeM
         s3Ma9eXf+JDkO5UPAHT0TsNp0c4wUnnQ7DaY7kXVY7X3V4FuldjGxah8FvlAA65sB+qp
         aojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427267; x=1786032067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=rlsC0zDTPg9UetytmZljj/2EmLdivjd+3Cf0dpLeiRtYVb27LH91zCWGhFpCjLsQDu
         /2eHTAptPWAg4xs3kJmARCkN1kf701luQ1t2Kdg7JsfqKtTkOiM51QoCCarbAFkjHm8C
         nwKhlVdO7fvmADhZyr04MK/hzpwwJ0iAT5QtCu20F/KzSiygZ42W8tjGArnhJVLjvFkY
         AaSRd6tckUVP9KXNKEi8N3rC5b0SOxBGpDBu22MOezgJMxzBnFBD0McgNWdsZiCDMcik
         uh+gS9kBQRkFUvCywyT8mHXZy2aKAlh4lww+H+l3VxAR3IuUC1xUhgWPQ51LkDVi16iz
         eVlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9ygRccxZepab4o9120b0xTKmATt/TjulljkDlJIZQShna4epQNdG9BIxFmtC0+ikHKYSQbZnBfWAImC+FcV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsnwru0F7/b8n+Zr265RpMkFkltpvQpxe13oLKB069sQ0nPBXz
	JwZwOrpeJYmTmGloWUq36m0+E58Ll7ZCZarj1bSJtCfzWuKdd71lcWdsNxXEHZUYlUb0kA7klKR
	+vCHtLSni/aJWwJEnajYZdJFXFYH6yui8PloskG/ETK3ulKDjayt5dQEZ2uQlF10K5VYfWjA=
X-Gm-Gg: AR+sD13USDCd+nYLn9Yk4qhRwnNd15uKDURHTZip1DodBqgHzFess79YgQjyQ+gZR69
	xfjcovJZi6OvZGHzT47lUzSHqla/EFIy5rIRFiKQIkLCEjRsesVcOeOfCJTauKnnK/xFmLBQHrq
	FxuEnhaSExVAHgQ8cVIc6cuNk5Wz7Z5NhmTcwCG0CsANw2tr4k7Az22BeRuK2a6LlUbdf6YbUe0
	2YBaAfdjB57Woh9gMh+rpou21yGQktlFY7x9Hv0cSxRDjwEllbJkt71LL4KdFu6zxhsbD4+kGJU
	RCWp1mLDTJOmbic3l5te22LJ3lYHlDaR3VcMCkxqK7Kb0E4ZhV8A6xknpzS1NQVbM9ysBhge9u+
	0TmHB9DGeTtR7bn441LDjbcbp9/EP8EIvmT9IlucGAWyAQ8nvSSi9+6kvDOORMHfX22kQvPCVaU
	sQBd8iJUh37TUtOePxbpAgs0WcTPmMS1FIMJUl4AKdHaVLAvxHocD3
X-Received: by 2002:a05:6102:c09:b0:74a:84ea:4f6c with SMTP id ada2fe7eead31-7574ff6c30amr1313437137.15.1785427267389;
        Thu, 30 Jul 2026 09:01:07 -0700 (PDT)
X-Received: by 2002:a05:6102:c09:b0:74a:84ea:4f6c with SMTP id ada2fe7eead31-7574ff6c30amr1313267137.15.1785427266454;
        Thu, 30 Jul 2026 09:01:06 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:01:05 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:40 +0200
Subject: [PATCH v9 10/10] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-10-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=V4tNF+ni c=1 sm=1 tr=0 ts=6a6b7544 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: kMmwCT2aVTLWKJpuKQDdakJL9B4cFi98
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX1ieyNmzTmOfH
 Dou+E+uvoeUsL++jBzGLNnoEt/5SPck/EPZT0MSZpE23y2SxOLrIl7tt/qfzV5/ollM6ZcXpHvn
 fHptRMRGHNmk5pAEPehTiVevzPuL/qZgbGWTk9rt4LADFzZK9tenGDyhJ7yXyoHcxFqtNb3y9Hc
 ssV0tILhKo2I7QbUyVWHC1JXiUsfon6HqStn9PVXS/HUnO+JQMRvUA4/BObY4Pn94XTgxMclqU1
 AlREb5cyQR6JBF/JOZA/vbpS8SwdbtjWkmQhWbn3XunKflOCZt2tTmG9chZ+gTNi3kOoSSr5q0g
 +Sx68/2BvPLMct9EIoeyyC1pI0r77Pr5+ax4JVs8xvVmSX4tykJQgdKZuHiIt1Dg+TzhDWuX/Xn
 akoTNlh3fBreKA41uN5awONxzC6PKTKyOyRumRix3sBczRqgZ1cbQWCLJRl3tjdvQx7MxMnjS+A
 fDrMR+MZwzLP3/spwnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfXwVMcvKb8jEKq
 hyA/yTdrKAzZey/7haUaIUQlpCp/dA5jHpEZzarL21BIeDwmWJo6F6Ft3DB0INRKkor/FA/qH+d
 VNi55pRhlldTGXnxkfFMeQLYZqZ9PuM=
X-Proofpoint-ORIG-GUID: kMmwCT2aVTLWKJpuKQDdakJL9B4cFi98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

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


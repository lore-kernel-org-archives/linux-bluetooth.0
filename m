Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADA389472
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011034; cv=none; b=ZJOm0LDjdhX+MOzXpPmMVHkFaBtMHdGaIvJEbSzith6VZAR4mj9XKnczUUxcMxJax/ZXQgAd96MXlsRCsTygrEiKQCKH4P1yFKBY1AdzLsNQgRhLZ3JyTZekyD9MFz45i/w+1Xxxh3QYP+cWX8/KT5i27xuLn/pxi7huwD/jORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011034; c=relaxed/simple;
	bh=vCe6eRdEnoX5wrPjWditaUdOWecdI5Lh6B8J3UkVwCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tQZgoBhrrthUyXccvvaYLU40dyXSQUxW1/Htozw6kbHJemMfTdmgshV3UHrXYwRiU6BudsrX5fEBgBkypIekk2r66EPp5wrOLMYyG/sVcaQinfxkfkU9K0LeK0fk8KMffkJ34JQV1nhmaSKDcohQv9sqv2jt1/dmZbdyXl2vPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fthnKRhE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d4dbD+TH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fthnKRhE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d4dbD+TH"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61ON3fZR2432689
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 09:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xyYMQp/RAotOxbl0cC9uDXLVLev7ys7mCX0
	LhQGwDDQ=; b=fthnKRhEFw09Gcwx4k5B7ZdiJ9avCs/yC0mMvfqCZ/z7lxNQeMV
	YibXfcuFSh5WL54o9aYCcdO/wXbZB9azJO20peaqx/2cxspD0ySFn+0ljFPLNRbx
	v7+XdLNFSYIJTiIJjeJKMndIzRtCiPgcyMJGFrUxdH59URjea3w9dhGMaCUxyyN8
	H5Amg1A5AkQL2g7GJbFZqQNMDO12xdC4dAdygU6VSAfpqeU8bzJAZfBPbOFrOOxB
	CiyiemMk2lCwPRq2QV4s6oiMK3lmYc5iMCKLYBQfLQe8BGEQv/OoSjNCSi+Hp19B
	RZXMAPzIUeNxQqywFmv92etNfTNWpP3pBcQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chekjb2dw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 09:17:09 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1270a59eaacso577630c88.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772011028; x=1772615828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xyYMQp/RAotOxbl0cC9uDXLVLev7ys7mCX0LhQGwDDQ=;
        b=d4dbD+TH+/iZWh1b/2P5AscKCfr9vJrq85ehNaeL8DUaNoHwxWVi99qFCcv+agyhLG
         9PWVJJFOq/YNM0RevXNFlxAJ+Dv2vemmf1LoZipVSKUZCsIPKObd5kI7FLrEEhveHR8o
         mP0ZEFCqrUYjRWi+be7ZUPd9CmcMyC/gL5c/I3RXVh9/W/SKgnpq/5j88aVkxBLXHNyw
         ayntRAhn4qc6jm9dKO/GtVeo8i5vhFdplP0/3NdOnxtZrj8fkyLsPFF4Z1J7ENR7yVA4
         icWife8XbB29yX8hfgB2yKYcfuD3RYs0fL4r6WUZzrqziJOwkqsWkzkPzfPJe82mSXsJ
         7zDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772011028; x=1772615828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyYMQp/RAotOxbl0cC9uDXLVLev7ys7mCX0LhQGwDDQ=;
        b=p2GvLUF4N7XIT8Ru6tb83z+BrFHkWUR2o7eR7Teo3uDJJrYaBqeRjktFxXSwphGQdS
         vXtkB2CRSUnf8Xegwq45Wj2mGu8FSfWm3aKAZdPxAVIIVRcMZmnGT1gEUzp0rk1a7t1D
         SuRMJejga+vW9oltS2+2uY31cqYsad7YLYGeBMjQ4f4p14WZCr1Q58zaI47lamm/P7gD
         AjZnDfZ6Q63zrXtehXd5Kdnx0BOZG8fEN51T8fKt3HdIXn6122JNivzm0X34rvbld3Ma
         gs4Oa69I6Q/+yuaHh8E5PBMkrm1pjs8f4wEvsnBan3TWL9BIxDiGszoR3gNDEqyyj2KY
         6bAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ6Fe6d5/1shKkSnG6BJ06shhejKJ5fm/bh6SDJLGOrhDRcR+IujUVbLNTDT+J+IUC/Msasr6QByrCtJD8bKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwJ3pfUHzvU5FqvkcAGw41fT4IuXwx7r+0ED80JMdhfmOtekf
	aG9Q55go+Gzhges551tVgxWh1C42CbrGRYhzb8PlkzcPiMk4o37xAzKxgaLDWg6ZS/Vx50UTsmi
	qUJxtuiOBTchSHR2c89whrHq/I+tJHJo6ovlPa9QK2FKhW2Q+Wlk1eqkDGfnGQjSBi51JvwQ=
X-Gm-Gg: ATEYQzx5M3ZI1Qh1JE+DoUQeK1JYoWOebXUYazxFLeS7Rt8FapFnhDKWCG0TAy7cluq
	Y4pBGyV6au01u3hfsUU1sXRmgqnmUeJZm1BaO6yKFhfe9AqSxfeszBEho+KtxScGllJ5RPxDWdU
	wjIZ7DdapO4W1McBJzDBYCF1nH/L77VxQ8eZNQyI8P556cPciLpwK98wDya3bouuVRTqhYHL6WJ
	7kYi7Hg6ifLxJyRfQPuF/dAwmV4Xruykd48nfqWF55zrDLVZ/PBckYzZ7qNIY11YB/ztTRsgZmQ
	V+i1uQjEF6i2Eu6jHg2yEamjyKmaTkboMc3SBulrm0jwOU30gJCU93tkvn4KJ/GLKxq1LUArXJr
	JfMqU+Ztivqyl4p7MYcPlPXoLHYkIn1C+5Vo5a9nxw7Ib
X-Received: by 2002:a05:7022:f40f:b0:127:3480:7ca9 with SMTP id a92af1059eb24-1276acaff99mr3188819c88.2.1772011028352;
        Wed, 25 Feb 2026 01:17:08 -0800 (PST)
X-Received: by 2002:a05:7022:f40f:b0:127:3480:7ca9 with SMTP id a92af1059eb24-1276acaff99mr3188800c88.2.1772011027768;
        Wed, 25 Feb 2026 01:17:07 -0800 (PST)
Received: from hu-weiden-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167b2sm8386514eec.28.2026.02.25.01.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:17:07 -0800 (PST)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
Subject: [PATCH V3] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth support
Date: Wed, 25 Feb 2026 14:47:00 +0530
Message-Id: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RNe+3oi+ c=1 sm=1 tr=0 ts=699ebe15 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lDHZPWx9vk9YBGX9cKsA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: LEfqS3N8XOJt0UybAq1heQQLT9QHJHNE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA5MCBTYWx0ZWRfX5di4CWLUmF1i
 ugbOmvQvD65szXwt2CXe33Vc2YdZqQukXaIPaN8+5bIojT6U3HHhnWX75Q8F+8oo1yE8AgKc+tx
 X1FwhCKnUzXXvAwOzSk07v81NOez5jL0kG4vnTrR442uKhIOMkm+5xh7fkx8OfSep2/CPPJ4MJo
 I6F2X48GGm8crXg9Eg1hMHlpwph5YD49w4LDweBP26FHe4vZ/ZB0ex8AKyqvaEAzfb4oNnPgSqY
 iygo/XyOocL/R3D9B1SWCxlD6zVZbI3RLpSe14WlZDXGDWc4xo6YsxC7wyrVfvKo/KCGeEkqdgl
 TNmtqp+FOquGOEPyZ4ZzjpLl+TbcSPGHwUZcBFq+OHpHUGKF3R783XHIxjKUMJ/j6SBfCqxiJco
 cxvvyWvo37krM36ib14mZkVZPy3/bg92kGK4kF4CQ0s3tSjlPsOhN3Un3BoV41hbNJVglw7mu67
 8rfNeBkF7H780n0AqIQ==
X-Proofpoint-GUID: LEfqS3N8XOJt0UybAq1heQQLT9QHJHNE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250090

Enable BT on qcs8300-ride by adding a BT device tree node.

Since the platform uses the QCA6698 Bluetooth chip. While
the QCA6698 shares the same IP core as the WCN6855, it has
different RF components and RAM sizes, requiring new firmware
files. Use the firmware-name property to specify the NVM and
rampatch firmware to load.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
This patch depends on:
- WLAN
https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/

Changes in v3:
- Rebase patches
- Remove unintended 'output-low' from bt-en-state pinctrl
- Use prerequisite-message-id to replace prerequisite-patch-id (Konrad)
- Link to v2: https://lore.kernel.org/all/20251118140406.1551669-2-wei.deng@oss.qualcomm.com/

Changes for v2
- Update commit message, add firmware name detail
- Reorganize patchset
- Link to v1: https://lore.kernel.org/all/20251113130942.2661069-1-wei.deng@oss.qualcomm.com/
---
 arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
index 2ede6efd1afd..03c01ae630b4 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
@@ -18,6 +18,7 @@ / {
 	aliases {
 		serial0 = &uart7;
 		mmc0 = &sdhc_1;
+		serial1 = &uart2;
 	};
 
 	chosen {
@@ -107,6 +108,7 @@ wcn6855-pmu {
 		vddpcie1p3-supply = <&vreg_conn_1p35>;
 		vddpcie1p9-supply = <&vreg_conn_1p95>;
 
+		bt-enable-gpios = <&tlmm 55 GPIO_ACTIVE_HIGH>;
 		wlan-enable-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
 
 		regulators {
@@ -559,6 +561,12 @@ &sdhc_1 {
 };
 
 &tlmm {
+	bt_en_state: bt-en-state {
+		pins = "gpio55";
+		function = "gpio";
+		bias-pull-down;
+	};
+
 	pcie0_default_state: pcie0-default-state {
 		wake-pins {
 			pins = "gpio0";
@@ -633,6 +641,24 @@ wlan_en_state: wlan-en-state {
 	};
 };
 
+&uart2 {
+	status = "okay";
+	bluetooth: bluetooth {
+		compatible = "qcom,wcn6855-bt";
+		firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";
+		max-speed = <3200000>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+	};
+};
+
 &uart7 {
 	status = "okay";
 };

base-commit: 7dff99b354601dd01829e1511711846e04340a69
prerequisite-message-id: 20260122053624.4068718-1-wei.zhang@oss.qualcomm.com
-- 
2.25.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9D3ACEF1
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989196; cv=none; b=tx/ccfSJBnPDYJAgN2E192ho+TsrjNgvnO76URPd2wmL/KGQifehZwbVV1GftsHQ6FuzNfM4i3qEwCKT6JHOnI/SbHnbXPmKunWKpx2HbIG+pxVJMtb94OAr82gYt+uaNpcM1SL7c7oYUSjVvuZWyOQgb4Hds1B6IB1KO9uY6XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989196; c=relaxed/simple;
	bh=UuWiowSUkkLYBCFI2j5RmkjjfgRaPpYyPxsZlfvVpgQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vluh85rcLjOmBKdgc+OWGSb2Z+lE9zBTrYYnrnW6LIdyv2lB88/YyxbbVzyzNhvMfN+xfjTETHJREAw2HO2+t3AIk1GAzJRqtELzBJH3qQFOweZWKvzj+41W0hT+0MJrv1jA/NL3ngWvFQ3K2yvcH5QJ4sYil3nrDRle0AtcX0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qq56hS4g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EC9SQdI0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qq56hS4g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EC9SQdI0"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629nbkU4139702
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 Jul 2026 10:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=g3M8BKOQRB2G3U+jibgwRX
	tDt1cwkny9K4uSgSksDB8=; b=Qq56hS4gcggr6zWHP6OM19FMeMio98SPi+lUN3
	0H49UC4ZqoEwmDCGrNX/k9QoK3v4i3XhfJzTDwRVMU+BuYbDx8jHrchwuvxb6Spz
	5VUV8NA9IfrEJPSXgGnJ/fGviu8Ikc3xCbmO++G59wtZuuZpBM6Ab2BaWI8hELWh
	Q4UdntbVTg/3lM8WQ0tl4TnmOk68MQzlphGF89Q0GZD7nrXTaNiQTJp3OZSC8KUy
	ubrjCeoT1cPftRfxz7WhZk63woHcudBOjNEQbfnQi7XGvEKPPmcTSF9VIMW4eM+p
	VOOhYQKR8c6hPX8wyUlG7tUCOBnGgszIGkKWvLJ+koXKxxlw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5npr86p9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 10:46:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e663c29f2so54655085a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989190; x=1783593990; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g3M8BKOQRB2G3U+jibgwRXtDt1cwkny9K4uSgSksDB8=;
        b=EC9SQdI0cJA4R499RhF5eAxf5qlZ/lVlXvlIPrPgdzIsJGHJyfyFAj4hIryANDAmRp
         FclBZj5ucVZ0hy0+BAc+RNn9geUAfE4gCyyH2klPOtT4pMonhEiikAYxHNcJf8tBGAUn
         w6ZuDBJRQY+HtoFo1BNsAU5K9yadlsqctJlAvW2GdAuoG/9PKZX4pRD8rtd8f/CvxDEV
         x/bMYFYntxWcYtJ9fwcbFP+MmGbYc+E+Cg1xOUF6vOH9RLub1nagXT1PWIv40akbJiA5
         aAIIX6CEYek8xd8eYhK6lAUkOEy1KOc5ND8gs5aXyxMGV9OvLn2zBkwkze3WLvn0OBtY
         nNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989190; x=1783593990;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3M8BKOQRB2G3U+jibgwRXtDt1cwkny9K4uSgSksDB8=;
        b=m6Rpk/ezUQVVphSn0K8NAjFstd8hW15i0pqQIbIj93zRRUiy2IvbSMpNrGcHrP/GHM
         Tg3QlcBucYxjSsbErbc2ZjlAhPLaT4bvetBZU6PVWdLGy20gsfsanLeC/939DTkpsrTp
         1k/NEECoqEMKfcRMN1ueubH6/fhSM0EqbovzIBe8l24pka61uSc8iHA7B+KxR2S3t+iM
         I7rJF4QoiyhrrRVjEfdHM5jjZXr10CbFl28SP8Co2l+bG461SunLfUZAZdpI+FJ8+LNJ
         v1w5qOxSIjHA/FF/7H0geNEzs8o+lykiPKJqsRffWmqRB9X6R6MpZur+k3CfH6G3Zo5U
         YVLg==
X-Forwarded-Encrypted: i=1; AFNElJ/kTwIiK0tEvAK0tTqg/hKrSLNkWkFxEwqZs2AaRbVW+VM9U6oZOjf6yZ/m0iKVYM99chMCp1pklNqtQm3wkvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVpF7TMNEyO4QXWdR3O7Ve8EOk5xd9t0lxC9CE0mDQws1Q+OOO
	6IN2neg0e8rb8WpP59jWOz75yxSnAvqZ4KDdbNz/2BGOYILSD+YzCCwv0Qrm1EszuzIhAp6rWe8
	Scfex2elACvnMlCK6UbHbtp2tRoloH09x8pCHx76zg23suzxk5EJoJpblEE0duX2qW29wzBc=
X-Gm-Gg: AfdE7ck3RbaxKMlxbYxbAM2GauZ8HsCw93u6XSI4daxWneYTMScs/q/4umJ4LfO4H68
	uOtfFhqFRNXYEvi4LQKpLbVMXttspR85iNck3N/yDhD1JtQg48N6AnNxuBVbbwL1Q+9W6NmnIW2
	ewSR8MbGO529JTw3BZ+PKbe4pJ6+r24MlOSR13yAWwSy5OFlDHxf5BKteNg6gHNpC/jP9xoWKC+
	w+D4xAXuJI3yrSmli+nQ0yx/zDXjOSFNsu4IYeE5EXC6rVH398jANTifobdvB9R+StcZ8Jr32Pj
	IH688HGJd/LEMFeB5q2PNMskEky9/r6Cf1io/tYrSWmQypy9cnua4OORQFMIs46ErVxBmV5nzNb
	Ddrg3Ehonfn88IyHD356nvOLKj5571AfalnqDMUhsgHXZ3IZ7nnEiT4OEq7U6DIhsk807fgV/VP
	KI0L7lDGf9QDA8QiuY3bA4SD/zcyj2Om2h6fHIMC7I75eYpQ/gAtbFGvGe2JnvFNY=
X-Received: by 2002:a05:620a:178e:b0:92b:f1ba:5fad with SMTP id af79cd13be357-92e69821ad8mr1223563785a.37.1782989190100;
        Thu, 02 Jul 2026 03:46:30 -0700 (PDT)
X-Received: by 2002:a05:620a:178e:b0:92b:f1ba:5fad with SMTP id af79cd13be357-92e69821ad8mr1223561385a.37.1782989189650;
        Thu, 02 Jul 2026 03:46:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b5ae4959sm109689666b.0.2026.07.02.03.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:46:28 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v2 0/4] arm64: dts: monaco-arduino-monza: Add support for
 LGA WiFi/BT module
Date: Thu, 02 Jul 2026 12:46:12 +0200
Message-Id: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHRBRmoC/3WP3YqDMBCFX0Vy3ZH8qKmyLH2P0otoxzbQmJqx6
 e4W332jXpbeDJwD5/uYFyMMFok12YsFjJasH1KQu4x1VzNcEOw5ZSa5rHgpOTg//Bl42oA3JAK
 sOtQ9F6pXe5ZG94C9/VmBx9OWA46PxJ22krk0Myu3yb42LNdwfwbCEZyEdoIogYPQBW/Phd6Xq
 j54onx8mFvnncvT+V5crSGEpbFTk0WdCwhdwRbr1dLkw+/6VRSr9tMDUSRX3Vd1IZXgVaneXOw
 0z/M/u6Q4vykBAAA=
X-Change-ID: 20260520-monza-wireless-e6ce7f013f38
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: cqZBeBhYmS9TcvP9FpPMrrHnjSCgrha4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX6Q/zp1cMiFwf
 BoATZGUaHGeYAaSfGpAqeZHilh/R6MXrEhyfYCqfUufnTqQhjWXP/8UD6CzXNEg9H9eYXmykg0k
 mcAhI19R0I2h3CNFYsMwMsf9AJmV+Uc=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a464187 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=fyB3VsXpRON8pw57WvEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: cqZBeBhYmS9TcvP9FpPMrrHnjSCgrha4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX173oUiLK4UfI
 7p1eDzXkIOAnOgnR6UhHU3fwwLTRB+oR4sMW+h5DK2EwRZoIlZF3bg1sYo5srCTg+BLzNDrZOjp
 F1FpUmT6/RcHnCuNJH4tHXiH6Co0CHeI4ZLKMS0c0fRunaLlZz398CysO2A0FWZBhwVNysRKNSw
 Jnx1eE4aemH+KmVkebWkIWPAZHjRNFTgtgxX9UOjhMcE9FUErzMbvDZgg1PmXwoXUsCWJ/K6duz
 Sahz76n0tuQRdkhg2IKiXtyUIPbyRljUCtKzDhDyMrnzJQguEYryb8Psx0FUJl2ryx93lvt+1bm
 Y9y2GsOEyOc0955xKjreRyDFE64dfUoK7K4J2WXwYlpAoy/LhBxISGOL5/zEGQG6dUJY75MAi1T
 A0NkWt/ceYSnbqG4mGCEEoz7ZknNbjnc12Zf0Mq3nGOio6Y6aUdGNU7laj8rvjkwdUhcPZevy8c
 Iw+AF7qjdm89RjL/Opg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020111

This series describes support for the onboard WiFi/Bluetooth module
present on the Arduino VENTUNO Q (monaco) platform.

The board provides LGA pads for a wireless module. On the VENTUNO Q
these pads are populated with an NFA725B module featuring the
QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
the design is functionally compatible with the M.2 Key E.

The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
signals, as defined by the M.2 specification and handled here via
the pcie-m2 power sequencer.

This series models the hardware using the existing pwrseq framework
and connector bindings, allowing coordinated PCIe and UART bring-up.

This series depends on:
https://lore.kernel.org/linux-pci/20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v2:
- hci_qca: extract M.2 pwrseq into qca_serdev_get_m2_pwrseq() helper, called
  outside the SoC switch; drop duplicated of_graph logic and redundant
  bt_power NULL checks (Dmitry/Mani)
- dts/bindings: use qcom,pcie-m2-1418-lga-connector (fallback
  pcie-m2-e-connector) instead of the generic M.2 E-key compatible (Mani)
- Link to v1: https://lore.kernel.org/r/20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com

---
Loic Poulain (4):
      dt-bindings: connector: pcie-m2-e: Add vendor LGA connector compatible
      power: sequencing: pcie-m2: Add QCA2066 (QCNFA765) BT serdev ID
      Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
      arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support

 .../bindings/connector/pcie-m2-e-connector.yaml    |  7 +-
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts  | 64 +++++++++++++++--
 drivers/bluetooth/hci_qca.c                        | 81 ++++++++++++----------
 drivers/power/sequencing/pwrseq-pcie-m2.c          |  2 +
 4 files changed, 111 insertions(+), 43 deletions(-)
---
base-commit: aa61612ab641d7d62b0b6889f2c7c9251489f6e3
change-id: 20260520-monza-wireless-e6ce7f013f38
prerequisite-message-id: <20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com>
prerequisite-patch-id: f4a7d1957c1776051608bf3d808b2786606c1ae2
prerequisite-patch-id: 6cd3c33583a9af16b3f6f71517b16b32d8155b7c
prerequisite-patch-id: 0550c57d69cf112fd4830e62f4388db6f8bf397c
prerequisite-patch-id: cc10d8079e37ef0ba0c33d0984c95d76361df9dd
prerequisite-patch-id: d7f4bb2bb4498ac619e67a94f8b59119a5caaf26
prerequisite-patch-id: c00ce9095b2d3a412229796194828b55642d3d96
prerequisite-patch-id: 09600595c2e80b12eda3aae39af192847d0f03d0
prerequisite-patch-id: a6118ed2894c176780ba933750e1068f2819fa4c
prerequisite-patch-id: 1dee41a33e032094e8dda74ac4e0bada928573d7

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>


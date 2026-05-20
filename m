Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37883BF66B
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274915; cv=none; b=P4GxzDokQiVBjxssOhoQ5/stLKwVWTkLSY2af44LeVK8JuGtfbsmlbtv0l8S+ykMDKkEdbcmMkHYo2aF6CLniv6GtbplNR/n34OdZX7f86/BJLyZTygWEiCjly/jZW+2NX9WvqGTW4HD8AcFjWCzNb0f8i5Nu9AYhFSI9tNNZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274915; c=relaxed/simple;
	bh=sxTOeNZUCJiaLQF43tM6RQQ8yErITtuQ1DjdECwZa5A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HNV5/BDfq3aONugvWrX54Seqi6IswRGNjU74+nFkgXzfdfAa5yMjWpf31pHm/Hazh4bUTo30FPH4lsiazOyXcS0QfMrLcZTMqhOS2xuZ3uMUoaTr8HZCjdCdu14uRFG7kbTeljm82YCGOW7CR3f6cUq1gnp/p+Db5GMkg7CmxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zl66O9O6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g7w+VHH/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zl66O9O6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g7w+VHH/"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9lfm8266960
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 11:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sRQ+frqKGg6yviczCOuRmF
	JXb9EFREKQHuap6tZIl1Q=; b=Zl66O9O6yQDMjWRBijau+OX8I//BUkL2xHKjp3
	DZHD7FATKCZqIvzrFFGBxIgpZaYDkN6Unl/KVyYaCCjpvaedOdKeeBYPMaF4DEep
	HmZBY0+BCn08IELNaQGFTSgiD+yaSjwA3LjeGslunnlE7LVLAhOzeYGKZeJ1BQMy
	TeWfPVGKGULcnIY9SlTl5aJm2AtZVIHSzZPEWpKmpsyIdZt1esF7SZBDsKHZ0UJs
	Iuu7DsNbqnUt4UrRo3w9hgZ/AhsKD9g7VEhQiVNIjP+yxKYQ1b0LEt7TBSLXqOTy
	t2D62+8YJkVCqQMQv7gF1sxw8X10ZnRTq+9fh1VD5f4eUSIw==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9amxr8gn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 11:01:51 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6961e8fa90bso12344820eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 04:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779274911; x=1779879711; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRQ+frqKGg6yviczCOuRmFJXb9EFREKQHuap6tZIl1Q=;
        b=g7w+VHH/91UpwFkDEMysBQOeWdTRzlONCfoJSLaLu8Ijy78OGGsue5RJ9O955YCifC
         RS2KCkjfmWW/cwLl6ZznEz6/OmSKAwfAFikQTB05oGRwqJ29uGcwkzowUmoBiBT420WY
         nb2TlHFIoCYpDYHxun6ZTkF/wzoQdFkkNC4IcnpUpTKnIwhjIvV5K0O0IGnLY4uZK4BL
         5kFZnZH4XzBA82KJTHbWIStRe7QfES5D6xZqmog0tjZXl58TE+xyZjGJhWzXOG9O25Ji
         FYCEJLYzbHjvWZ+9ORi2mROvbXJbt9oZbV1G1rYAXkfIB6Da91vgWpganmfLSqBWjQmq
         JFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779274911; x=1779879711;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRQ+frqKGg6yviczCOuRmFJXb9EFREKQHuap6tZIl1Q=;
        b=remslcO4Rtoo5+ge171L8BpqLtHZLcJgJ0T0EcgibRrrUsvHg7qh05h2dGPDu4M/4o
         rmZ3EDSeWnzNlWTQluWT3zBmsAnC8DJ1vY8ywWXrF/BwFxeaXBH/uonn+uhBBGw54Jul
         Rzu2jZANKQ/CEyNAAK9XYsIRRGkeqmDftyZ0qtJcM3JPwowxlvKPzCxTQYiUSy06tGzZ
         wtTSseuzI8bQRRnBMWjg6L4tZrjLR2IgPGmq0tHWTbRiKuePWayoei29H9kNuW6hEhd5
         N7FZDnbpilZ9kuilFNC3Pa5R9OLij3HuerKQ6MJ54qzlW+dnw/FrjtJifRQMhJwh3crl
         2Aow==
X-Forwarded-Encrypted: i=1; AFNElJ97lF2XJcQZySDysXtcbZkhyHGJiyVwqhGlO48GNJqt1dEjeFMteZIdHqwTDblheNlCzG6g2Ggu9IgxPkcFzks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyd2FRndJ+ma6uigbRl/JipihxZ2/nCVCjO59h68FKRkFcGcy
	urOs0tpIAZduAfNk9w/G/CFlIbQTSgQgidWbGvfj6zupUS+by4yKT2iqFATaec1P8w8JqK4eq1o
	kDAnvA/RveilDfGSXqWYnh965uq3y+LkNXrnHa+s0ZK7j7QaITbrIUa3hnp/IeHRd6sIZeJY=
X-Gm-Gg: Acq92OHwf3+/tAwL2DZyWIR7q1eSkXW4XYdwRj8ny0ZT9bN62wz3JLi4894Pb6GZ2XU
	D+gAH7Xyk7tMTrV+6Q5B52r+YEk1jK19LZ9DsX6D6emC3bdMmioaZzuAfwfRt0Jli0xh64SAwSc
	f3RdvwQrlX+OZaNlSstBuf44gYDhx75joFzRJuf1EjZn3Cw/Y1U4R0G2PaICyPl3Xud8zgo1EAy
	t5wmpkKUJHshrGjObphdo2D77nFtrqkYRWaUZpPAPAG3bwZdhJ5qpjTZsVuTtcD6OnCutwq5GkP
	LsC23c1jJyyrNQhJyQHSqRMWeaB/SkX9k35yY6qD+UwIP/xyVVwU5HYY7zCGhZh8XYgQZ1DDFb6
	Rcai/k02BqDdZp7CLzBLzxX5ukq/XjEsNtMwmG80E4C+wkyn5Euf1FOjEVmfi7QrUTJlUmy6Rso
	s2of/Ao+0gUOM2vafx
X-Received: by 2002:a05:6820:4cc2:b0:69b:73d8:60ba with SMTP id 006d021491bc7-69c942e0844mr16305600eaf.21.1779274911111;
        Wed, 20 May 2026 04:01:51 -0700 (PDT)
X-Received: by 2002:a05:6820:4cc2:b0:69b:73d8:60ba with SMTP id 006d021491bc7-69c942e0844mr16305529eaf.21.1779274910402;
        Wed, 20 May 2026 04:01:50 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:9d48:e1ec:d837:6344])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4eb6320sm840310266b.59.2026.05.20.04.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:01:49 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH 0/3] arm64: dts: monaco-arduino-monza: Add support for LGA
 WiFi/BT module
Date: Wed, 20 May 2026 13:01:41 +0200
Message-Id: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJWUDWoC/yWN2wqDMBBEf0Xy3JUYL7FSSv+j+BB1bQON0ayXU
 vHfG/Vl4AzMmZUROo3EimBlDmdN2nYeokvA6rfqXgi68cwEFxlPBQdju5+CRTv8IBFgVqNseRS
 3cc78qHfY6u8hfJYnOxwm7x3Pkhk/U4e3CG6nlkvoF0c4gBFQjTAL4BDJhFdNIvM0vj4sUThM6
 lNbY0If9/2rUoSwN3osglmGEbg6YeW2/QFWRIry1gAAAA==
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: BbotcTXrL7Yg9XpOOs1M3YammGrqXKdJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEwNiBTYWx0ZWRfX+2pFuv3nwbAa
 9ETeDvQz0xVrSXQW9x3snMdMJT4wC27T2UxDKyA0tOaWbK9GELiWBXZ9rygtbnE7qVLCWebm1f/
 JIBd/+CaXWPlfVDsejWnzh4ehcoYJKndTkUYSntOyl6kyrexinpUjKqcrYrQjNRokCLrW94hA/P
 48ifltrXVXYqZ+ZHqN5YSlkpU9KsCFL0bfnisS1O01zRij9u14QQEeWBYvJhlcD6NnXHnDntz/k
 KUoz2ugwybVXS8pUM9PtUdCy4imM8wwyH/VHnznB/CQFyrb7NH4pfKafEmP7GZG/YqrykyQJn2N
 mGTHaBJwGUeXtIFSDz0bVEYH8ZZJbCYaiAKq4+ee0vX/gdHegTR3kUZweUZrMN1quHiPh79csbQ
 9j1YP3CzICE6ou40v47Om9oYKjiXGfmTupU315iXsuE+THzd46b4YlvSevBDKAd08ymU+4rYfMO
 0GdUutjIqW/DXBzWFVQ==
X-Authority-Analysis: v=2.4 cv=TO11jVla c=1 sm=1 tr=0 ts=6a0d949f cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pLl2yMwwk8GGFzfygZEA:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-ORIG-GUID: BbotcTXrL7Yg9XpOOs1M3YammGrqXKdJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200106

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

Patch 1 registers the QCA2066 PCI device ID (17cb:1103) in the
pwrseq-pcie-m2 serdev ID table so the Bluetooth device is created
automatically when the PCIe function is enumerated.

Patch 2 updates hci_qca to retrieve the "uart" power sequencer
target via the OF graph and use it for Bluetooth power control
instead of a dedicated GPIO.

Patch 3 adds the required Device Tree description for the board.

This series depends on:
https://lore.kernel.org/linux-pci/20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Loic Poulain (3):
      power: sequencing: pcie-m2: Add QCA2066 (QCNFA765) BT serdev ID
      Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
      arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support

 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++++++++++
 drivers/bluetooth/hci_qca.c                       | 33 +++++-------
 drivers/power/sequencing/pwrseq-pcie-m2.c         |  2 +
 3 files changed, 80 insertions(+), 20 deletions(-)
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


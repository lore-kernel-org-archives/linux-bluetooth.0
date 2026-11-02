Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636853;
	b=d/K9ZARm3S10ClXYc3hgwegMNhnB7wwDJzh6qLjKudR6YKwB+VVEE2MwvCceJCRDZRrM
	 JdPQDiIkEIZwKmMRFSi4jfPkvJN2X4En4HWociLYS/GQGE3Rx1AEIFcI/4u4oYeBr7bCJ
	 t8Bdn5sLTYUNQ0DLQXNR7NPTQV+yigRzqIAHTxodsA/+KvQPXoST2I/h7VAipB9wRPDmh
	 sjmy+pPROxq23vrWjJn6ZDDiegtRJHfr3yYNCQ0Kox5ZEJjODc5ZNi+K6il26o65cI9jN
	 /IuxIsW1hJkykNAfy9ddCCgPE6eY7Y7Lu23DKMLzGtysis+jmqevmmmKkx7dRqPGiUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636853;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TFECovovrz1IBCzplEHcZQgm6wJQZNlKH/xJkkihk50=;
	b=YiG+eTi9e8zwErZQayu2EucuzYHD6VTfY0vMkyVI2Yx1KJWYwaB7JQcoePjjcTUxQEmm
	 naRbaa5dhg9/5yfUQelR6VUsTA26UjjqudWRX5N7GTKcDEKUVMNrrXcFAaxyyGt8vhExT
	 g+iQdZWL+BObgdo4d6bSHD1tuBmcG3ExGbTwkX0JOcODB31FS3cNMdtyMvz6dI7jzvT6X
	 hK7eYURQu5W7/aLXtcFtF9JeBf0bOc0oTBo4cVQaI2GEWG1D/F0/DbcXWIn3zp1LJ5L+l
	 CgQf7jp7tl/tDa0xfV1RehPrtSVDMUwX4gQe8ezBE3z4zvAwA7RXLus7LUkx0e4OgVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MJ1Ttwjl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e0yVK81R;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39984607229D
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 16:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39984607229D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MJ1Ttwjl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e0yVK81R
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpRkY846152
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 16:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TFECovovrz1IBCzplEHcZQgm6wJQZNlKH/xJkkihk50=; b=MJ1TtwjltUBTCZIZ
	vkdCnWqJp4W0PBWwPG54tU6pylbjungc3QPNB9ChDjaJ945T3KvatiCbw5AGKe1s
	/1Nxv+PX/ad543VkSES+HpDJFkUjnqq/RNchx5Ul5P8F/5mIfVZAWF0OPgem3lR9
	eJ62wngM8FimSI2tuaUw/ySPSn9i5+frdXRBTWvubnJmWvysjHzA0+bJrSwm+4e1
	BOoWkowk7CWJt8sKDi+1uuu7Ft2r/CCkd7lTqT5BqGlsdu6RPVsufcmJdJZlUKL+
	Nj4GFKHecmuZAeVQlQbzDnVmAihO83FDjQf+XD96aS1gsy26ngY6YpAYyRdDrAqh
	TCZLEg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1tnyc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 16:27:32 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98a9c848bf0so446604241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 08:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793636851; x=1794241651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFECovovrz1IBCzplEHcZQgm6wJQZNlKH/xJkkihk50=;
        b=e0yVK81RiZOqFz+eRCJ2H3gRjQEBRUEp7wkw+1UA0PHMSCpVa1+g02eEmOR8bne+Mj
         o4f43nibMMrIXjZFa9V5v8iIrxYhEoPvNbHKRWj6H8fWzu4LgBYYjPA4aXuC7r+M34Mn
         1ujjN4RLTtFSJJ8YmVReM08qjoJCDA/erGAje1UUEVt4d8Xn6w4HJBE3MRPmS74H0AAp
         V/Quht1o3z8SbEz+N2fowmbhH1Z2AK40/j2a2bS5itnamA68519UJn+s+VA838tQ9ogm
         lRZYpqKxCkMCAfmYwjZMKCwtZ2/HH45CqszRA1tJ8pBEXID6J2Bp2Hr1ZgSQj7OH3oye
         DTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636851; x=1794241651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFECovovrz1IBCzplEHcZQgm6wJQZNlKH/xJkkihk50=;
        b=i77IWTaRp9HK1cGu+ZllFMWZnoqnRv9syoHTo/eFoRbJhdeJOgQW4hqh2Pjc0r7CcW
         H31iwnvGiz4yAcmUJlb+8xTjInlv3gC191sxzLRJIlrTTqZlB+16R90Qqq5Xmf7RaDsR
         +SjmLBLCoSDTzZkULXQGbnHQWsUOg5sJlXTRmJRWWDFKFvQCLEoULihKsB4R4VhURFZ+
         b9j6k6/ys7/8SvosWmpf99C+LXcDFWokhy7OTY0g7jtnzOYIXslftkw4Nzn3RAPNqBuI
         Q5dqQd49o07W1aiOTTtcPz1OQGiNDPcBRHWG36Qk7gWA9J/UeqX1oOO0ODj8Il+iKtiq
         Z3ig==
X-Forwarded-Encrypted: i=1; AKwUvBwUbivFgY5nIxSpic6p4FOoJgZcaAnLb29b/6BQJBzwgO7KPQ4mKn7f+LE6SIo5rlN0iiZWyDFNHG2NWW805Vs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Z9xVUXbmFtJnwovK9bue96mYT1M11GfUzPAendtqPnU9JkJpl
	lB1jpFxCgFcUVVxTc09b7iLWdP71USebzCHeBYFIvjyyNE8UI2pg+DqU1GR8Nim0PR7TmtG2ikr
	BoLF8R9cqQfK5CSzWS4tecNFs1KEpdet/vQU+gkKbSM97lLj0kRuRmcdItfdIdq9kRgCG708=
X-Gm-Gg: AYBFou3CK2rrdFQz3rGIrjI+n5GRszfyKHKrA9/2r4sCzG3Yk5r20tsAvt9kBINK0ZJ
	5A+SPud0g8O2R2F7cSol52EsPnTO099bDsGWioybdfL2sTzeVO815Gaaf0KvsolzUm4MscH88vY
	ZyrXfUxSd2Iw4SF6jrx7AfChZZU/X1UBx6GPCp356KVCfr8FRWbhGQ7IZQzhWEqow5XW9T4UGWg
	yf3xk0EKpcUN9AXnFLAtm3WzpNykSEAhZ0aSjerJ8+EN7PKjbQm0LHsWgzIbZdfqbiciE3jkVpy
	CIrgCW0ArQRzmlwIwFaFpOSVBn7nABsgJ212iAkURlqBicgbMtbDOq2fOomLtUyukYAdLmoYmi8
	Ce7L7WNARQqcMFxj0Y8ApyX2ANLNQgZkr9xZwHdL7oWmCSSwf6ewH7xSTiiL4yaUH0Oquuu0DA/
	/CH8RGMr0PT+7WaD7yN1dHPghGQCpjqZiuyKrWVgxH0BmPN9G5WNXOmuJobAYYVj7QJj1NWN6rC
	RWHCSzWbZ/z4JeyFUnwJZSHAGHz
X-Received: by 2002:a05:6102:689a:b0:7c3:7286:b7ea with SMTP id ada2fe7eead31-7d072c18c5fmr4049278137.17.1793636851099;
        Mon, 02 Nov 2026 08:27:31 -0800 (PST)
X-Received: by 2002:a05:6102:689a:b0:7c3:7286:b7ea with SMTP id ada2fe7eead31-7d072c18c5fmr4049269137.17.1793636850566;
        Mon, 02 Nov 2026 08:27:30 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b959c1sm20490695f8f.45.2026.11.02.08.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:27:29 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 17:27:21 +0100
Subject: [PATCH v12 2/2] block: implement NVMEM provider
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-block-as-nvmem-v12-2-f4a2a681087d@oss.qualcomm.com>
References: <20261102-block-as-nvmem-v12-0-f4a2a681087d@oss.qualcomm.com>
In-Reply-To: <20261102-block-as-nvmem-v12-0-f4a2a681087d@oss.qualcomm.com>
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
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: O3cwPI6MPFmid-xwLzt3LykAgwPSKl0j
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae8b9f4 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=VT4XjZGOAAAA:8 a=71DuYGxFrHUPmPLwgxgA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2NSBTYWx0ZWRfX0xHmQ8E+B+sH
 SivGeQLpr14FmzrzVD48Yfs5BJ/unnd+i1dEMUh1IdDjwtTQmSFdTbeFz9QMQAFOIEilJQ83+Wd
 02yNZnq+jIErzFkQ7GldKhIi2lF+4iNE/D2bKr4zjqghOt3HobOR1J9A8XmqEdy0Sh9SlZMJJOg
 Ow4B2wd6twiQgKsx+eVWsName/6Op+3Raq0QX/9PqyOnAyNaPyvDVy1tbSSBv6FrPvh1yIKFZ8e
 snmrcMDt0XjSD03uprW9qrJuprg9qqYlzOlPD8pfgxgNAANKrQztQGkYNZ1X2/xH+zVLhFjIuX4
 tQTDn4eHsjuprCmgOZp+UESpYw9DLG7M9b8NvXAfrCPFyhCKhj3zKLHTCgyeU0HDBBQjeinRHEP
 zfTP00ac/EE2GnroDB/oYmz3jYIs8hecAASl/Wia+vZ0nldx+66BOzWSl1d/21rjMJ8IukLgdX4
 73Q6E2APX0uGNW2yF7Q==
X-Proofpoint-GUID: O3cwPI6MPFmid-xwLzt3LykAgwPSKl0j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2NSBTYWx0ZWRfX3f2QVxkpLuLu
 cMrgfx+we60fpeLVWphvsWSdDwukJCq25nS32MHUaK1N21KZQjop7BGtK6crPI9VaqzmICfmoZK
 wuD39ubd+GPxPxWB8DDSDUFdgODv8NE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020065

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing the partition in device tree for the kernel and
Wi-Fi drivers accessing it via the NVMEM layer.

NVMEM is registered for a block device whose OF node describes an NVMEM
layout, either via an "nvmem-layout" child or by being a "fixed-layout"
node itself (e.g. an eMMC boot partition associated through its mmc-card
node).

The NVMEM device is a read-only side channel onto a block device.
Each read opens the block device with BLK_OPEN_EXCL to keep other
exclusive openers away for the duration of the access.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 block/Kconfig             |  11 +++++
 block/Makefile            |   1 +
 block/blk-nvmem.c         | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   8 ++++
 block/genhd.c             |   4 ++
 block/partitions/core.c   |   5 +++
 include/linux/blk_types.h |   4 ++
 7 files changed, 145 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 70e4a66d941ff66ecb0ec34f4f7eff7fd1e4be40..4899ad572c71ffdbb62460d57623216254893ddc 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -209,6 +209,17 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  exposing factory-provisioned data such as MAC addresses or Wi-Fi
+	  calibration blobs to the drivers that consume them. This is
+	  typically used on embedded devices where such data is stored in a
+	  dedicated area of an eMMC, instead of a separate EEPROM or OTP.
+
 source "block/partitions/Kconfig"
 
 config BLK_PM
diff --git a/block/Makefile b/block/Makefile
index e7bd320e3d6971a8abf584f5de42776bb54e8216..8200297fbcbab304beb4239d0c33da07011c3ed9 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
 					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
+obj-$(CONFIG_BLK_NVMEM)                += blk-nvmem.o
diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
new file mode 100644
index 0000000000000000000000000000000000000000..69b69184e16303444c9cb2dc816d5679daeb13c4
--- /dev/null
+++ b/block/blk-nvmem.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * block device NVMEM provider
+ *
+ * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Useful on devices using a whole disk or a partition (e.g. an eMMC boot
+ * partition) to store MAC addresses, Bluetooth addresses or Wi-Fi
+ * calibration EEPROM data.
+ *
+ * The NVMEM device is a side channel onto a block device that stays fully
+ * usable. This is somewhat mitigated by opening the device exclusively.
+ */
+
+#include <linux/device.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/nvmem-provider.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/property.h>
+
+#include "blk.h"
+
+static int blk_nvmem_reg_read(void *priv, unsigned int from,
+			      void *val, size_t bytes)
+{
+	struct block_device *bdev = priv;
+	struct file *bdev_file;
+	loff_t pos = from;
+	ssize_t ret;
+
+	/* open and prevent other exclusive openers */
+	bdev_file = bdev_file_open_by_dev(bdev->bd_dev,
+					  BLK_OPEN_READ | BLK_OPEN_EXCL,
+					  blk_nvmem_reg_read, NULL);
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+
+	if (file_bdev(bdev_file) != bdev) {
+		fput(bdev_file);
+		return -ENODEV;
+	}
+
+	ret = kernel_read(bdev_file, val, bytes, &pos);
+	fput(bdev_file);
+
+	if (ret < 0)
+		return ret;
+	if (ret != bytes)
+		return -EIO;
+	return 0;
+}
+
+int blk_nvmem_add(struct block_device *bdev)
+{
+	struct device *dev = &bdev->bd_device;
+	struct device_node *np = dev_of_node(dev);
+	struct nvmem_config config = {
+		.id		= NVMEM_DEVID_NONE,
+		.owner		= THIS_MODULE,
+		.word_size	= 1,
+		.stride		= 1,
+		.read_only	= true,
+		.root_only	= true,
+		.ignore_wp	= true,
+	};
+	struct nvmem_device *nvmem;
+	struct device_node *child;
+
+	/* skip devices which do not have a device tree node */
+	if (!np)
+		return 0;
+
+	/*
+	 * The layout is described either by an "nvmem-layout" child node or
+	 * by the device node itself being a "fixed-layout" container.
+	 */
+	child = of_get_child_by_name(np, "nvmem-layout");
+	if (child)
+		of_node_put(child);
+	else if (!of_device_is_compatible(np, "fixed-layout"))
+		return 0;
+
+	if (bdev_nr_bytes(bdev) > INT_MAX) {
+		dev_warn(dev, "block device too large to be an NVMEM\n");
+		return 0;
+	}
+
+	config.dev = dev;
+	config.name = dev_name(dev);
+	config.priv = bdev;
+	config.reg_read = blk_nvmem_reg_read;
+	config.size = bdev_nr_bytes(bdev);
+	config.of_node = np;
+
+	nvmem = nvmem_register(&config);
+	if (IS_ERR(nvmem))
+		return dev_err_probe(dev, PTR_ERR(nvmem),
+				     "Failed to register NVMEM device\n");
+
+	bdev->bd_nvmem = nvmem;
+
+	return 0;
+}
+
+void blk_nvmem_del(struct block_device *bdev)
+{
+	nvmem_unregister(bdev->bd_nvmem);
+	bdev->bd_nvmem = NULL;
+}
diff --git a/block/blk.h b/block/blk.h
index ed21724726223f777f40be15f82fdeb9da89beb0..4d9e3952b1561a467417482cd516cdc97358d093 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -837,4 +837,12 @@ static inline void blk_debugfs_unlock(struct request_queue *q,
 	memalloc_noio_restore(memflags);
 }
 
+#ifdef CONFIG_BLK_NVMEM
+int blk_nvmem_add(struct block_device *bdev);
+void blk_nvmem_del(struct block_device *bdev);
+#else
+static inline int blk_nvmem_add(struct block_device *bdev) { return 0; }
+static inline void blk_nvmem_del(struct block_device *bdev) {}
+#endif
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/genhd.c b/block/genhd.c
index 10ca8b4d6eea7ed3910271ca3af74479e2081d6d..6c45b8eb8dfad14fa2fbfa98177154f24af49a07 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -417,6 +417,8 @@ static void add_disk_final(struct gendisk *disk)
 		 */
 		dev_set_uevent_suppress(ddev, 0);
 		disk_uevent(disk, KOBJ_ADD);
+
+		blk_nvmem_add(disk->part0);
 	}
 
 	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
@@ -708,6 +710,8 @@ static void __del_gendisk(struct gendisk *disk)
 
 	disk_del_events(disk);
 
+	blk_nvmem_del(disk->part0);
+
 	/*
 	 * Prevent new openers by unlinked the bdev inode.
 	 */
diff --git a/block/partitions/core.c b/block/partitions/core.c
index eee954df1ac6ef7dd4f02ad5c9d49aed778bf015..c83227710584a6feb25c8abae3b319cfae9cce5b 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -289,6 +289,8 @@ void drop_partition(struct block_device *part)
 	xa_erase(&part->bd_disk->part_tbl, bdev_partno(part));
 	kobject_put(part->bd_holder_dir);
 
+	blk_nvmem_del(part);
+
 	device_del(&part->bd_device);
 	put_device(&part->bd_device);
 }
@@ -406,6 +408,9 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	/* suppress uevent if the disk suppresses it */
 	if (!dev_get_uevent_suppress(ddev))
 		kobject_uevent(&pdev->kobj, KOBJ_ADD);
+
+	blk_nvmem_add(bdev);
+
 	return bdev;
 
 out_del:
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 0cc09b975d8ffbd45ca3dc47533a71f8e8164de6..8026bd763a0710b60b9553a49783efbaf81aeb9f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -15,6 +15,7 @@
 struct bio_set;
 struct bio;
 struct bio_integrity_payload;
+struct nvmem_device;
 struct page;
 struct io_context;
 struct cgroup_subsys_state;
@@ -73,6 +74,9 @@ struct block_device {
 	int			bd_writers;
 #ifdef CONFIG_SECURITY
 	void			*bd_security;
+#endif
+#ifdef CONFIG_BLK_NVMEM
+	struct nvmem_device	*bd_nvmem;
 #endif
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast

-- 
2.34.1


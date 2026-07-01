Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D442B740
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921655; cv=none; b=mwFO8q4MAwmcgJTltcvUhf8Tmg8hrudiFov6LvTwnrsFBQ/xXPx1eghFx3kZiLy5w/X9ybNNshn/NdK8jEEDUbF4sX0USXZzwx9gd0WEBJzMfxFD7e0OxtkziFDAUbpH0ht7XroU+wGEWVWZ0YJRWG2RP5Px9Og32Koor8iigMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921655; c=relaxed/simple;
	bh=sL87l+fR0fxeRESx/GCRKGWxg1ci/hNuvJqQzq58rT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rv6ot5iKgZrISnD+QGZnCtSadIXZllIf+MuuGxDrfwq9oZUaaAM1l981TBG6ct++lG/Q2+bef+Ud+LIO8fGr7lpM9CjZ8usKrj+7kYBe8DYNxWOMbr8eMluvKnsYSRrK04gpleN+gTkoY0T88TKf9mhSK4niV0bzRNlhG8BUypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=omlpQsSr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bPS0GAyX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="omlpQsSr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bPS0GAyX"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Fo74N1548958
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Jul 2026 16:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ruF9ANzInv8cVmA5nRWoHkeo1OOBUskTgPEB+I0ZmEc=; b=omlpQsSr1sOyXZ+r
	KQ0kNoc7sLp5coqaxzsAE06W/YYe1Dyja3tUHpMfFosx25/rgMdpfKrckoSSSV7E
	hZyvCCkKGn+cPoRC+Vs6Xd6CqQ7+QnO7JirFDkCPxbtFnkNJ/gnW9lSbDdpzeCGc
	rs9TX1O6gL3ZAtzPoN8LgFPUMEHdQOwZnwwbCaxW3aDrhEWP3nPTmSw/seMiB+dR
	aS2d7YfFiNpL8z9jf3wlW2L3yDYvkm8PYyZuvz/c07XhWyMYnY4I446LtR008FwM
	TUN+Kpmhc2V0QyHwKOOdWaBmRNStyQQi3ZPwi0k1yo6HIEAcrhcon67WSC61+JSn
	Ed1blg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541r9v0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 16:00:47 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-73a8aba30a4so732432137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921647; x=1783526447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruF9ANzInv8cVmA5nRWoHkeo1OOBUskTgPEB+I0ZmEc=;
        b=bPS0GAyXdihfYx0A+iHkxQGNYfWxpwjeubWmfR1EXsVGcFQa1BLNpQe/b9ErenwECI
         jBJeuREEiT0juX6Nc1JbKTSRz63amtVloZVKU9qBpKXx5fol1F+iesw7NA4/X4ZZG15W
         qtE7sRytn6sdIZjd0gnjQhJTcjne64xq3o1uKWZfs8+pmwKkrJV15UTNkqrvv5nZn1CI
         CzhzWwoDDgCrhwQcaFgpDHPdmUNHA71RlkCvRMgAPkgeafvOxWJ3NULrCwJzhGuvm4zN
         Gcy8rMqHKVUT4hZyoZapJPdahsts/6ZGsBnvUBpNk8G3bIBNRVwfxzVaEpa1H9wfy+XZ
         45aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921647; x=1783526447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ruF9ANzInv8cVmA5nRWoHkeo1OOBUskTgPEB+I0ZmEc=;
        b=np4S+NqNdf5DPwMZ51ldKrZlXZ9UQXP+BrHI8srPtpJ6JQexcuk+hp13Yymwsds8W5
         N8ofFUSp+Yz9V5N4ornpfGbbTZFJQT4aTK5upNjqKGggm5wHvuN3S7uhdmrLtM8WdzDg
         F9Y1w8qwxRMUu1IbKUEiKc1QNy9wAUVECWpbBVvbxrbimMlEqTdOgLlDPwtYIvAezd+E
         28inIpRFxcCKKOXwRobDFm+GBDXH6By5txoAqkWv/J5x09LUVW6QG1XA52SBNogLqfqq
         6dxeT9DQOdIaQsPc3tMPCnYhOJdPAsoI8NGwD+Mk0jM5yc43qkAYNTXXOExi3pm2AqYT
         QdKg==
X-Forwarded-Encrypted: i=1; AHgh+RouovUlzm23udWQ3SE/wAxApSYCeENtkspeZVn7Z/GWHm1gTHPaSXiR5f2CmIkvyZNjQibqHN75WjYrqo536RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+yZ1XNqjy2fL4Ul5NHlpDwyvK4xwc7LKPKA1ga6fBCZLhTkm
	tLo5ncqdlbqrJlSTqHEgR3WbWfByuHqFTgGB3d7f/6G0kNjk5iRCDgouELVId3q/QX8E/RVD2Ue
	i9BU/e7apOK2ytFNzRJzG3kGljjyLXaLWTUY9bGwSr1aNzFDzeW6C2ZT54TGrwd/OuTJvnmA=
X-Gm-Gg: AfdE7clTZGXHIAKKgD9xKVCZsc9K/Zpff8JRQfDKM3P709bUVQsKZFH3B2n1Uehug2v
	oGD8L6F0BdTmAXGvzofWo6qvZmq9wPSqhPGpzGqj1gbCeFIhjDd/4V9D0y/QSopeIcRv5+eBUBK
	4CaqltXykdyLEWWigxA7jfVjQ2Kc+h3uh926u65vibYv3L2t7uPxEMZ28k/S3GvMrLKLAPWkcDG
	JIbm4IAphYq6iq5gwaOKIk9N52fTkY/hA/ll//pXM1dr/0K/QL6iMcZ1bOS5Vx6N9auU5Xu+cW1
	ZWZkViB6+njfl7GJrH9wdCyf5EM7CBsamrUj9y4KZzQGumZGf+t/TEDdmx+pYW7+N1HbJHc1zYc
	yZXD0/FNusu7Jyknp2d6NkNRrifHl+sQFWFTIXDgmqXdWvFtjP7w/M/fAYILnx6PDH4F5dmrH6H
	grkg7o8bk6yvxdb+TbGDCpULY9LWnXS/PcEQn+SK+14gbYiCgLeaa+2oEwRZo7baI=
X-Received: by 2002:a05:6102:1804:b0:735:d53f:259e with SMTP id ada2fe7eead31-73bd2842dd8mr1872880137.5.1782921646498;
        Wed, 01 Jul 2026 09:00:46 -0700 (PDT)
X-Received: by 2002:a05:6102:1804:b0:735:d53f:259e with SMTP id ada2fe7eead31-73bd2842dd8mr1872784137.5.1782921645053;
        Wed, 01 Jul 2026 09:00:45 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:44 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:29 +0200
Subject: [PATCH v7 5/9] block: implement NVMEM provider
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-5-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: y4RH8VX_EKC-9g66GtV01eU1n6gI-f6-
X-Proofpoint-ORIG-GUID: y4RH8VX_EKC-9g66GtV01eU1n6gI-f6-
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a4539af cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VT4XjZGOAAAA:8
 a=EUspDBNiAAAA:8 a=QS6QONgytJYYblx7mpIA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX88Xuuw+fEMyN
 Wk1kJZMw8y9IqqTyXIaMKWN4+0bvLMO5KvzzBOZigBmt2bdw12elMWPdYyItNeN93jy/cgvGTMC
 S9rPJwoVYeQgBqeGgO0gvRb6WIwFy//PjUrzYtZO/iQYzas0Mq59FM8YJJVOhSlhfDzyCMsOKWt
 ySybp40mCPOyUvaEHZxkj/PlEliBMsNmc2e+MIWrTAkaH/vUtbZ5WsAwEbqcC3VTS1JqGB4GKd4
 A6jYaGOe84WhL2xi5yz4uAffBqX30SY60sfSEdieKIHP3IpPe8LWUSarq7V+29x5TRjn9UXvnc3
 WVL0U9doLMnDvcG4clQK30cDVbIg27faHzORz891TGQQzNnfgEivFfN684Cn6hDQxbSP0/N4z0D
 ffcjzYb9XMWKbn/9E9Z5mksLQz6IKF52DYsMQcywus9mnZnvrjZP14YICWDhYf2L+lcy8G7QxBX
 T8fxjN8cftxZrIHVgcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXxWDGTK6wqWq1
 e4qbVTr2hcbOIvO7/2RTu9L3kSTgqaS/hLfDQ0OcS/5SjP0JUMXKSwgXVrr9OZA+/G5nTDfvwni
 1j7nlLjqz7cgzjpZn7yX16mlS1uqVVk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

From: Daniel Golle <daniel@makrotopia.org>

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing the partition in device tree for the kernel and
Wi-Fi drivers accessing it via the NVMEM layer.

NVMEM is registered for a block device whose OF node describes an NVMEM
layout, either via an "nvmem-layout" child or by being a "fixed-layout"
node itself (e.g. an eMMC boot partition associated through its mmc-card
node).

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 block/Kconfig             |   9 ++++
 block/Makefile            |   1 +
 block/blk-nvmem.c         | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   8 ++++
 block/genhd.c             |   4 ++
 include/linux/blk_types.h |   4 ++
 6 files changed, 135 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc33473683706f75c92bdf8b648f7c 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  typically used with eMMC to store MAC addresses or Wi-Fi
+	  calibration data on embedded devices.
+
 source "block/partitions/Kconfig"
 
 config BLK_PM
diff --git a/block/Makefile b/block/Makefile
index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a8800ea266190a43b3e63d 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
 					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
+obj-$(CONFIG_BLK_NVMEM)                += blk-nvmem.o
diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
new file mode 100644
index 0000000000000000000000000000000000000000..49e9b5d4410d5e935c4ad9674c6909453fe027ff
--- /dev/null
+++ b/block/blk-nvmem.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * block device NVMEM provider
+ *
+ * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Useful on devices using a partition on an eMMC for MAC addresses or
+ * Wi-Fi calibration EEPROM data.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/file.h>
+#include <linux/nvmem-provider.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/pagemap.h>
+#include <linux/property.h>
+
+#include "blk.h"
+
+static int blk_nvmem_reg_read(void *priv, unsigned int from, void *val, size_t bytes)
+{
+	dev_t devt = (dev_t)(uintptr_t)priv;
+	size_t bytes_left = bytes;
+	loff_t pos = from;
+	int ret = 0;
+
+	struct file *bdev_file __free(fput) =
+		bdev_file_open_by_dev(devt, BLK_OPEN_READ, NULL, NULL);
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+
+	while (bytes_left) {
+		pgoff_t f_index = pos >> PAGE_SHIFT;
+		struct folio *folio;
+		size_t folio_off;
+		size_t to_read;
+
+		folio = read_mapping_folio(bdev_file->f_mapping, f_index, NULL);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			break;
+		}
+
+		folio_off = offset_in_folio(folio, pos);
+		to_read = min(bytes_left, folio_size(folio) - folio_off);
+		memcpy_from_folio(val, folio, folio_off, to_read);
+		pos += to_read;
+		bytes_left -= to_read;
+		val += to_read;
+		folio_put(folio);
+	}
+
+	return ret;
+}
+
+int blk_nvmem_add(struct block_device *bdev)
+{
+	struct device *dev = &bdev->bd_device;
+	struct nvmem_config config = {};
+
+	/* skip devices which do not have a device tree node */
+	if (!dev_of_node(dev))
+		return 0;
+
+	/* skip devices without an nvmem layout defined */
+	struct device_node *child __free(device_node) =
+		of_get_child_by_name(dev_of_node(dev), "nvmem-layout");
+	if (!child && !of_device_is_compatible(dev_of_node(dev), "fixed-layout"))
+		return 0;
+
+	/*
+	 * skip block device too large to be represented as NVMEM devices,
+	 * nvmem_config.size is a signed int
+	 */
+	if (bdev_nr_bytes(bdev) > INT_MAX) {
+		dev_warn(dev, "block device too large to be an NVMEM provider\n");
+		return 0;
+	}
+
+	config.id = NVMEM_DEVID_NONE;
+	config.dev = dev;
+	config.name = dev_name(dev);
+	config.owner = THIS_MODULE;
+	config.priv = (void *)(uintptr_t)dev->devt;
+	config.reg_read = blk_nvmem_reg_read;
+	config.size = bdev_nr_bytes(bdev);
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.ignore_wp = true;
+	config.of_node = to_of_node(dev->fwnode);
+
+	bdev->bd_nvmem = nvmem_register(&config);
+	if (IS_ERR(bdev->bd_nvmem))
+		return dev_err_probe(dev, PTR_ERR(bdev->bd_nvmem),
+				     "Failed to register NVMEM device\n");
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
index ec4674cdf2ead4fd259ff5fc42401f591e684ee9..ed0c10168ba7be10855509637f824a9cea2b9ccb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -757,4 +757,12 @@ static inline void blk_debugfs_unlock(struct request_queue *q,
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
index 7d6854fd28e95ae9134309679a7c6a937f5b7db8..1b2382de6fb30c1e5f60f45c04dc03ed3bf5d5f2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -421,6 +421,8 @@ static void add_disk_final(struct gendisk *disk)
 		 */
 		dev_set_uevent_suppress(ddev, 0);
 		disk_uevent(disk, KOBJ_ADD);
+
+		blk_nvmem_add(disk->part0);
 	}
 
 	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
@@ -704,6 +706,8 @@ static void __del_gendisk(struct gendisk *disk)
 
 	disk_del_events(disk);
 
+	blk_nvmem_del(disk->part0);
+
 	/*
 	 * Prevent new openers by unlinked the bdev inode.
 	 */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c09e0ceaac41ba59e86fb0c4efc64..6ed173c649025b95cce9253b27f68f2c7dbab8eb 100644
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


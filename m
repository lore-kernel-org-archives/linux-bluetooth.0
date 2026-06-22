Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F2328B5E
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139950; cv=none; b=rvbnfAiuXO/HZJeBNthVfwaYG6htmL51z1yTaZbkBDLWSsA5sugJAx+spMayMqW6uVIFqyy3AOpwvY7b2u1FnTrSm1/QQwFTBbsHNZsXa/d2V94CGc5i/yYjvooLrBJynvWWcJ1br3fWwyPD5R5RDXiyMdAoIux9qKpT8errybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139950; c=relaxed/simple;
	bh=gtdxpeDCPXJnoqczVLM4bqxIwx5PDjFJLCIseCO6uPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTJKpFwWh5pTGRE521HGi3VCZV8+UHWgFg6CT91WmqMRSBrzhrVTh5S+NQvp8yFWiwvw9NemXVUcvtVx9q8Q7L06zkYmOf3lUtddpYaFJ8W+CRn+6xl+EuWCmTgmXpoHYMHeB761HLuqlo091ib0PNU0N5kfeIzM+vfTggYk4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DydO/tk+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HEryQQ3M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DydO/tk+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HEryQQ3M"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDSSYC1120793
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V0hnYSsyp9tNtKrK+c49aUINayymi5eAWdZv9/f/PLc=; b=DydO/tk+z+qjYb9n
	GLKgxHPv7VINzreYfuCjQEskDEG4Vh+JUVVJeN4FLiS9NqTS3eCMX6r5MaL4739L
	d2t2fmFo3DkXFrNe653l2vxD2twd7uTEGI9sNWzCPuZEnkDx9asqw/B7LTan5UVH
	g4tKcXcvs1im5NuEmJwtITSL8ftcPgGNvp0tJBDaX51do91gJpXoxsqzqU5oihSk
	TYIz38vzaIr8C19+enQN7hkxf6o6sgNNSpLNJOqfSa/RvNLewx7SUIbINwzQkeuK
	v7gcYxrZTyQZ+IHPZ2kvRq8B2tOe+oLHvRZILVkm3dx6sqsh30M8BeVQ/KDKiILZ
	1VYuSg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5ye8abm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:27 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b1795119so181357c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139947; x=1782744747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0hnYSsyp9tNtKrK+c49aUINayymi5eAWdZv9/f/PLc=;
        b=HEryQQ3MedakLb23tA5l0TzZVpWPxjif8UYTAfEWpV6wB31XCQEC9m/ufGoz/HhFrB
         jBXQliwmBLYq7O90tistVBoYar6PQlmVqfkkCYaf78wTwJ1OTcZ7jvM+51U1df4XLZQN
         iS/wkXiTccF9MVdH96/e2I8eh2it3bKErskAr0n9l8tnn484A5W68ZT0ixvp52dKRbBg
         meQzkk/OI1LLLQCeR9W6PM09nmkTSoWP+EGPQgODyJLxDDJGxc+AF/lYhV2SYvmnew2U
         WSGxInhYHnWaJyvOMzCk14UI5wMe7yu4N4Emwrb+PA5US460i7MqVhyTqBHTf+rXTTX5
         jb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139947; x=1782744747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V0hnYSsyp9tNtKrK+c49aUINayymi5eAWdZv9/f/PLc=;
        b=FlXAaXF1zOfsreF88Hj9IHBVlOYY1gJB+iTUPkkkeYiSytkfXBxCX2QJMuv7FFWnRG
         ZQhpWIGThzJ5P/AQ3+paJyOOf3B+Z9GEDslSIBgfLR7mmfg3cNX6YpOtBEnCniXN9NaV
         pUuCfsN757OCSByCZJJkzlfREE85m6FSblclG19E9E1fIeXc4KMfDuNV+5a4bHS0LQDS
         7DTz3kXk0ISY+lGHs87xhRePk4skOf0cfvlNeGuALMlrdDQ0tZT5leGaxFZnbAPkcmp1
         9IN6oixCXJM0IucO7zlKYK7iooY3SkTzOc39gJnac1zhz/huPWJe3hq2+T4hiC8LCUqf
         yYeg==
X-Forwarded-Encrypted: i=1; AHgh+RrWFoA3RpqHuK8UETF9FwJmlaeKZ/MxXBCDRKXyxUuqfHoxFRldZId9DmgcNsLr8L64QWsMOLuoGnPfrZBIfEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl1gIFwh9QwZkLAQYx+5JXXTCVYqUtDGRMZWGMfxLP0tg29imi
	ePXnAF14Kw/Y8iN4AY6FN1aUjSRsB5+/3kM8i764s17tnoMPtW0fbtL5sDxZU+xczsmbEJShA1N
	6+5nYj7Sc8y+/tOqC9Xy/+MSyrGyAkzzmIMyduxRSKYUrLa9td+o3ff4O6r81oVy2NjejTOY=
X-Gm-Gg: AfdE7cltvssmVDlf8LECVWUfoUZguop4rlNcvU+bThkd0JE2eD0HyYQLbsWWWaDLquZ
	sFOi8zWs0w+hv49NFZRHMvFJ4sBnEpdUM0T/bam7MC4vqS449GXbZ1aWijEN/4fVun3WHFy0p90
	HeqlaBJx4xeuPOZwSUlYh6sruHmm3VnqmkKwq7p5ecFT/aL+y/vnHE/7nS4J9SVskymPRWE6gQC
	szN3c8rK6mTOykKsoVZPM7onloeju6Vx+fOfEx4XzAAadwXO9auHtXDfV5hFeZrAFRa9dspM7fT
	nID/MN7KSkiV9jGdFA6W8fss2pJrVRwMyz+DsRv832uQto0Oyo2u0Jy3hWvQmEva3pvI+yy3JCE
	woWNF26vkSuPnGHQbM9urMBilAN9qA7wudU5u0m9t59qMcF0X0mTsp8KDVQ==
X-Received: by 2002:a05:7300:c86:b0:304:3c33:7afd with SMTP id 5a478bee46e88-30c520988camr220552eec.1.1782139946485;
        Mon, 22 Jun 2026 07:52:26 -0700 (PDT)
X-Received: by 2002:a05:7300:c86:b0:304:3c33:7afd with SMTP id 5a478bee46e88-30c520988camr220526eec.1.1782139945704;
        Mon, 22 Jun 2026 07:52:25 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:25 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:24 -0700
Subject: [PATCH 11/13] Bluetooth: btusb: Move struct btusb_data and macros
 into btusb.h
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-11-11f936d84e72@oss.qualcomm.com>
References: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
In-Reply-To: <20260622-bt_bugfix-v1-0-11f936d84e72@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: I_K1OX7CM5LmKBZR-QP3lSfIwr3nd8m9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX5cTEc31NzPQM
 hXA6JZY1qHeDaAHzexQXCIsNINYN24Uqu+k0AkBOJIwTYa8wewkEyaI3r+TobRudqyItao4vv8+
 ZqgKekqzAhzv3LatA63izlJE2D/MBUc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX7xDE27tLY4Au
 g5cupV3s4WhRjIHMI64CAkF7kZhj+SU2i6DqPwzPaLNXEjUFboUD/bHvTm5YWewfl4L7Usf3UxA
 RiqQrbVtjUqImE5/OA+ZQuaRYwn+12NwtteIFUmuLzHrd7Cng9WieYqaf7mJeRj2+y52DYkko8+
 h2qORPXFtaDNY+BMM2G5MhU04h2nO9PYhApjKCk9GATd6fpjYUu8Jx33mYQNQe394bfUVi4/z3f
 d9xaUBSWhy0K/kwiv9KgNhg6B8SFedWl4c0JHIni87wjC2wKWErYwPjy1AsmWoo5YnoxPpvsM21
 Khn4RvkaD5u96Thj+N6PCDElyZhe0O4MUyMoE2C8T0rKyjyf/zk768myHQS8oZhBhY/GqFXx57r
 ISPzv/2diEQ12ROOhuA19HYvE7Vc9qzpgc3IsJWux919hCYYcLjLhenClGrt3p/uJXnEiUYUUtL
 T7pX0ioJTa2ykImDoCA==
X-Proofpoint-GUID: I_K1OX7CM5LmKBZR-QP3lSfIwr3nd8m9
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a394c2b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Dei6p5SHAAAA:8 a=7ErfrF5Y_EYtAn6cJgkA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=M-Yerj1wOn-OpK7r_3ei:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

btusb.c is growing large as vendor-specific code accumulates. Ideally,
btusb.c contains only the default implementation while vendor-specific
code lives in separate files for easier maintenance.

The newly added btusb.h also reduces unnecessary data copies in hooks
like btusb_mtk_setup().

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 119 +--------------------------------------
 drivers/bluetooth/btusb.h | 139 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+), 118 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 21e125db1b1f..0d0bd7b559c6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -23,6 +23,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/hci_drv.h>
 
+#include "btusb.h"
 #include "btintel.h"
 #include "btbcm.h"
 #include "btrtl.h"
@@ -38,36 +39,6 @@ static bool reset = true;
 
 static struct usb_driver btusb_driver;
 
-#define BTUSB_IGNORE			BIT(0)
-#define BTUSB_DIGIANSWER		BIT(1)
-#define BTUSB_CSR			BIT(2)
-#define BTUSB_SNIFFER			BIT(3)
-#define BTUSB_BCM92035			BIT(4)
-#define BTUSB_BROKEN_ISOC		BIT(5)
-#define BTUSB_WRONG_SCO_MTU		BIT(6)
-#define BTUSB_ATH3012			BIT(7)
-#define BTUSB_INTEL_COMBINED		BIT(8)
-#define BTUSB_INTEL_BOOT		BIT(9)
-#define BTUSB_BCM_PATCHRAM		BIT(10)
-#define BTUSB_MARVELL			BIT(11)
-#define BTUSB_SWAVE			BIT(12)
-#define BTUSB_AMP			BIT(13)
-#define BTUSB_QCA_ROME			BIT(14)
-#define BTUSB_BCM_APPLE			BIT(15)
-#define BTUSB_REALTEK			BIT(16)
-#define BTUSB_BCM2045			BIT(17)
-#define BTUSB_IFNUM_2			BIT(18)
-#define BTUSB_CW6622			BIT(19)
-#define BTUSB_MEDIATEK			BIT(20)
-#define BTUSB_WIDEBAND_SPEECH		BIT(21)
-#define BTUSB_INVALID_LE_STATES		BIT(22)
-#define BTUSB_QCA_WCN6855		BIT(23)
-#define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	BIT(24)
-#define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
-#define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
-#define BTUSB_ACTIONS_SEMI		BIT(27)
-#define BTUSB_BARROT			BIT(28)
-
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
@@ -943,94 +914,6 @@ struct btqca_data {
 	struct qca_dump_info qca_dump;
 };
 
-#define BTUSB_MAX_ISOC_FRAMES	10
-
-#define BTUSB_INTR_RUNNING	0
-#define BTUSB_BULK_RUNNING	1
-#define BTUSB_ISOC_RUNNING	2
-#define BTUSB_SUSPENDING	3
-#define BTUSB_DID_ISO_RESUME	4
-#define BTUSB_BOOTLOADER	5
-#define BTUSB_DOWNLOADING	6
-#define BTUSB_FIRMWARE_LOADED	7
-#define BTUSB_FIRMWARE_FAILED	8
-#define BTUSB_BOOTING		9
-#define BTUSB_DIAG_RUNNING	10
-#define BTUSB_OOB_WAKE_ENABLED	11
-#define BTUSB_HW_RESET_ACTIVE	12
-#define BTUSB_TX_WAIT_VND_EVT	13
-#define BTUSB_WAKEUP_AUTOSUSPEND	14
-#define BTUSB_USE_ALT3_FOR_WBS	15
-#define BTUSB_ALT6_CONTINUOUS_TX	16
-#define BTUSB_HW_SSR_ACTIVE	17
-
-struct btusb_data {
-	struct hci_dev       *hdev;
-	struct usb_device    *udev;
-	struct usb_interface *intf;
-	struct usb_interface *isoc;
-	struct usb_interface *diag;
-	unsigned isoc_ifnum;
-
-	unsigned long flags;
-
-	bool poll_sync;
-	int intr_interval;
-	struct work_struct  work;
-	struct work_struct  waker;
-	struct delayed_work rx_work;
-
-	struct sk_buff_head acl_q;
-
-	struct usb_anchor deferred;
-	struct usb_anchor tx_anchor;
-	int tx_in_flight;
-	spinlock_t txlock;
-
-	struct usb_anchor intr_anchor;
-	struct usb_anchor bulk_anchor;
-	struct usb_anchor isoc_anchor;
-	struct usb_anchor diag_anchor;
-	struct usb_anchor ctrl_anchor;
-	spinlock_t rxlock;
-
-	struct sk_buff *evt_skb;
-	struct sk_buff *acl_skb;
-	struct sk_buff *sco_skb;
-
-	struct usb_endpoint_descriptor *intr_ep;
-	struct usb_endpoint_descriptor *bulk_tx_ep;
-	struct usb_endpoint_descriptor *bulk_rx_ep;
-	struct usb_endpoint_descriptor *isoc_tx_ep;
-	struct usb_endpoint_descriptor *isoc_rx_ep;
-	struct usb_endpoint_descriptor *diag_tx_ep;
-	struct usb_endpoint_descriptor *diag_rx_ep;
-
-	struct gpio_desc *reset_gpio;
-
-	__u8 cmdreq_type;
-	__u8 cmdreq;
-
-	unsigned int sco_num;
-	unsigned int air_mode;
-	bool usb_alt6_packet_flow;
-	int isoc_altsetting;
-	int suspend_count;
-	const struct usb_device_id *match_id;
-
-	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
-	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
-	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
-
-	int (*setup_on_usb)(struct hci_dev *hdev);
-
-	int (*suspend)(struct hci_dev *hdev);
-	int (*resume)(struct hci_dev *hdev);
-	int (*disconnect)(struct hci_dev *hdev);
-
-	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
-};
-
 static void btusb_reset(struct hci_dev *hdev)
 {
 	struct btusb_data *data;
diff --git a/drivers/bluetooth/btusb.h b/drivers/bluetooth/btusb.h
new file mode 100644
index 000000000000..ad13c7d44836
--- /dev/null
+++ b/drivers/bluetooth/btusb.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  Generic Bluetooth USB driver
+ *
+ *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
+ */
+
+#ifndef __BTUSB_H
+#define __BTUSB_H
+
+#include <linux/usb.h>
+#include <linux/skbuff.h>
+#include <linux/workqueue.h>
+#include <linux/spinlock.h>
+#include <linux/gpio/consumer.h>
+#include <net/bluetooth/hci_core.h>
+
+/* driver_info flags */
+#define BTUSB_IGNORE			BIT(0)
+#define BTUSB_DIGIANSWER		BIT(1)
+#define BTUSB_CSR			BIT(2)
+#define BTUSB_SNIFFER			BIT(3)
+#define BTUSB_BCM92035			BIT(4)
+#define BTUSB_BROKEN_ISOC		BIT(5)
+#define BTUSB_WRONG_SCO_MTU		BIT(6)
+#define BTUSB_ATH3012			BIT(7)
+#define BTUSB_INTEL_COMBINED		BIT(8)
+#define BTUSB_INTEL_BOOT		BIT(9)
+#define BTUSB_BCM_PATCHRAM		BIT(10)
+#define BTUSB_MARVELL			BIT(11)
+#define BTUSB_SWAVE			BIT(12)
+#define BTUSB_AMP			BIT(13)
+#define BTUSB_QCA_ROME			BIT(14)
+#define BTUSB_BCM_APPLE			BIT(15)
+#define BTUSB_REALTEK			BIT(16)
+#define BTUSB_BCM2045			BIT(17)
+#define BTUSB_IFNUM_2			BIT(18)
+#define BTUSB_CW6622			BIT(19)
+#define BTUSB_MEDIATEK			BIT(20)
+#define BTUSB_WIDEBAND_SPEECH		BIT(21)
+#define BTUSB_INVALID_LE_STATES		BIT(22)
+#define BTUSB_QCA_WCN6855		BIT(23)
+#define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	BIT(24)
+#define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
+#define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
+#define BTUSB_ACTIONS_SEMI		BIT(27)
+#define BTUSB_BARROT			BIT(28)
+
+#define BTUSB_MAX_ISOC_FRAMES	10
+
+/* btusb_data flags */
+#define BTUSB_INTR_RUNNING	0
+#define BTUSB_BULK_RUNNING	1
+#define BTUSB_ISOC_RUNNING	2
+#define BTUSB_SUSPENDING	3
+#define BTUSB_DID_ISO_RESUME	4
+#define BTUSB_BOOTLOADER	5
+#define BTUSB_DOWNLOADING	6
+#define BTUSB_FIRMWARE_LOADED	7
+#define BTUSB_FIRMWARE_FAILED	8
+#define BTUSB_BOOTING		9
+#define BTUSB_DIAG_RUNNING	10
+#define BTUSB_OOB_WAKE_ENABLED	11
+#define BTUSB_HW_RESET_ACTIVE	12
+#define BTUSB_TX_WAIT_VND_EVT	13
+#define BTUSB_WAKEUP_AUTOSUSPEND	14
+#define BTUSB_USE_ALT3_FOR_WBS	15
+#define BTUSB_ALT6_CONTINUOUS_TX	16
+#define BTUSB_HW_SSR_ACTIVE	17
+
+struct btusb_data {
+	struct hci_dev       *hdev;
+	struct usb_device    *udev;
+	struct usb_interface *intf;
+	struct usb_interface *isoc;
+	struct usb_interface *diag;
+	unsigned int isoc_ifnum;
+
+	unsigned long flags;
+
+	bool poll_sync;
+	int intr_interval;
+	struct work_struct  work;
+	struct work_struct  waker;
+	struct delayed_work rx_work;
+
+	struct sk_buff_head acl_q;
+
+	struct usb_anchor deferred;
+	struct usb_anchor tx_anchor;
+	int tx_in_flight;
+	spinlock_t txlock;
+
+	struct usb_anchor intr_anchor;
+	struct usb_anchor bulk_anchor;
+	struct usb_anchor isoc_anchor;
+	struct usb_anchor diag_anchor;
+	struct usb_anchor ctrl_anchor;
+	spinlock_t rxlock;
+
+	struct sk_buff *evt_skb;
+	struct sk_buff *acl_skb;
+	struct sk_buff *sco_skb;
+
+	struct usb_endpoint_descriptor *intr_ep;
+	struct usb_endpoint_descriptor *bulk_tx_ep;
+	struct usb_endpoint_descriptor *bulk_rx_ep;
+	struct usb_endpoint_descriptor *isoc_tx_ep;
+	struct usb_endpoint_descriptor *isoc_rx_ep;
+	struct usb_endpoint_descriptor *diag_tx_ep;
+	struct usb_endpoint_descriptor *diag_rx_ep;
+
+	struct gpio_desc *reset_gpio;
+
+	__u8 cmdreq_type;
+	__u8 cmdreq;
+
+	unsigned int sco_num;
+	unsigned int air_mode;
+	bool usb_alt6_packet_flow;
+	int isoc_altsetting;
+	int suspend_count;
+	const struct usb_device_id *match_id;
+
+	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
+
+	int (*setup_on_usb)(struct hci_dev *hdev);
+
+	int (*suspend)(struct hci_dev *hdev);
+	int (*resume)(struct hci_dev *hdev);
+	int (*disconnect)(struct hci_dev *hdev);
+
+	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
+};
+
+#endif /* __BTUSB_H */

-- 
2.34.1


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9ED3A7D7A
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930316; cv=none; b=LgJkoIJkV9u66UrGfgUu0FWEv+Ihb8q8Jsx2hWTkVxMojNBC5tOET6Vp/4ifNdBcdgzSL9JCJH1Q5s4ee+5MzcKhJjgK9j6DH3N+vz4C3QGdTsxsXa+994VJEKFYU/v9UMWm60fCc5eL4M4FfVywEXLjvb8WjMSYPI0W3UDiaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930316; c=relaxed/simple;
	bh=hpchJ8oIwNHVqZ/IDVTnEKQ1xW3KkhA0v6PGpo3s/QA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=roGpzeESw/cAHio0zQ2Z0QOHYEA0PkIAjA7dE9NMvlHEkC4DpGvfmUFgoQR9Aex8EuB9sZhfaHlS+ZcwR52B31/DEE4QpXssm4WLkA9n1adBTOJh+0OZR6ZHhy3N70NhXjGUnY6As+CVy9kpZ7PtfuOkSNaZ+47RtJw9u8OEBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZCAwF60i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QX+9xlfX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZCAwF60i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QX+9xlfX"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6Nwsd674466
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 08:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=W21uO3xrVijf73jPAR9SQX
	K3IjRZJ+4KTpB2EqYCmK0=; b=ZCAwF60iuy6NgsBvMNSOR3CeVgXELNhVqtfktf
	Ur5fGABvc8dREKVFmygJ39kckBCYTbSSMHDGSGGs5q/LHCmP9CVEMxriSidrdcsU
	QeoKaB46xcMNo+5Ex3HvZxpKQsAybbEwmKydT4vVX19KGSpfClNmI6SRTia9mphg
	1X0hSaIlszBmNtpE1HzSTZwsKgiIFrT1UfOzNe00Tzm1JdGJS+G0HbLzaub83G4r
	MFUsQ0SDZqVJzQDg7W6uLvl98zFpbXmw5p+FUERG90GetlNdodTVuySz7f9r4L5A
	lYB5Ni6fxuV5x32k61nJR44IhvtHCAdFv/8hVOLn7dfKB6FQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbecgn51y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 08:11:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-380f3670853so981767a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 01:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783930308; x=1784535108; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W21uO3xrVijf73jPAR9SQXK3IjRZJ+4KTpB2EqYCmK0=;
        b=QX+9xlfXonASnw4f+rXaRJ38lVNuqXjlRoC3QqHr7w2/zDjDtnb8rPK0ugNzcchIQR
         ifMog+BBoZd0BMfQ1r1b/DmNENe8NprqtGQ3zpv92HbVj9IjGaQir+YoVztzEBKC/anX
         Btztq6taT0kAk4hdEX0vGOOYqJIy1MgzRVG6N23xPCaJ6v6iMdV9JzO5TYen3q28P2qW
         FWMHEoDYbHOk11QV8KlrWWRd6qVhBbdnRROjr5EuAFoHkGQyU8q3ohbSxKUyqxw0WHYy
         BRoP4KGWWaZfENdq454v1IexSOeaBFt+o/J4dYRcN/DiJTILaIojSmID6qBpQ5YoCt54
         RjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783930308; x=1784535108;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W21uO3xrVijf73jPAR9SQXK3IjRZJ+4KTpB2EqYCmK0=;
        b=Ti6ing6puVtjDlsGFJefGG8H5hJP4JQDaMxItcAeENbdKlTgbq2bH48UI8QAJQ7wLe
         QWdSTkv0ZpHmIgZU8/sRFffJ/KwORT/2Y9iwpt2qDg312RT/36whb6UpZ7YCWJWySaN4
         j+FJjMLWRDs5Bvmf1U28btwC1KFpl97d143WwJ5lIp3dvg7g06mcNQAQggv4rWDZOjtd
         UpC9VHNyCdIhyIdg/z2G92T1LyjM2KwwzqTkzWYneEtOY+vB+fCvUz8HfG4TTgKg3gem
         lUUdm6/hcodk8512xEjnMDesA/Jcn+O61qKEKug/XZmobuuhBbHZEiflH8jwfaMdgciy
         bYXw==
X-Forwarded-Encrypted: i=1; AHgh+RqABmxzF3iILvNw9mBzCIH+Og22OcyE4W1Uz4/4AtJLquUiokmSn4GgXApAfnvV1AyWwotwGLx1dhQz80nAKGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL3c2AbzEusxB5iCLerr1GLEte0mXUx9yw9bLppr2Tq9BK2fWV
	eP2YMjvAS1W2n41s6MsYwT7RYIeCiPuReVlIbgzIWv4IyeTCKtgDc4v4uwCYuQaoMyhJ2Ic1V4S
	FuQahHGN28T/Ejh3VeWU2EDMkQSXYUPTGXN1tEvdrXjjonOaVSCFHLwm09jN6pKEF57UgrBpZVN
	0tYBA=
X-Gm-Gg: AfdE7cmfLTZICuYOVXdIBW57m/VG/ugYtXnZgIFJFZ9kPQPo562P3qZ853bHPOwdlbr
	5Beh9XCiba4VOFtY+B0Huz5HM+wcZviDCu7eJrAv46uH+SLTFVjmZtOHgCzVaGjAEdi7EYzwm0Y
	zFeLPd2EKNTwXnbTmM/18gqa7Mhw2lF/vtr5w74BREOK9kOi93oriekkhQCLXP1KSLk/PhDNaWL
	65V6F1BYxgluI29WM5c9oNpPYKzMoSM3GrV5xe9B6YF71obG0RbUPZoVlWvH5cp4WTpu1fsT3Fl
	QwgEHA2CYNeLeKncwpZa611fMW/FObj6It5yLEgzvP0K1GEGw7GZEY/sJFw+BGc7IpGJ5V4sJ3Z
	vM3xsGJR1+2uBln36PbKViuFrYqzf0eJLWYhke5jOIpKOqwsD7qR3z+KMmg==
X-Received: by 2002:a17:90b:51cc:b0:381:6cf0:d5f5 with SMTP id 98e67ed59e1d1-38dc780f503mr6426430a91.5.1783930306550;
        Mon, 13 Jul 2026 01:11:46 -0700 (PDT)
X-Received: by 2002:a17:90b:51cc:b0:381:6cf0:d5f5 with SMTP id 98e67ed59e1d1-38dc780f503mr6426385a91.5.1783930305391;
        Mon, 13 Jul 2026 01:11:45 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm74277851eec.14.2026.07.13.01.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:11:44 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 01:11:44 -0700
Subject: [PATCH] Bluetooth: btusb: Add support for Qualcomm QCC2072
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260713-btusb_qcom-v1-1-39cabc0dd601@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAL+dVGoC/0XMTQqDMBCG4avIrBvIRDEhVykiSRzbLOpPolIQ7
 96hKXT5DvM9J2RKkTLY6oRER8xxnjjwVkF4uulBIg7coKRqpcZa+G3Pvl/D/BLaeTTkzehNAB4
 sicb4/mL3rnSidWdzK8c/aasCSvMD+XdhNSiplVB1KxvXkMEB7YHQXdcHVdROkakAAAA=
X-Change-ID: 20260713-btusb_qcom-7ab18eb8fb8c
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX6A+95iNcTg5g
 +3caRsPaYThUgDsUCwuSB2M0ZqhHBcmB2446Ub2xwP9So4w/V7E7pHmbUu20h826J9xqzHw25v1
 ++7JyF/VqvHtss7n/VMJ0/PRusuTq2o=
X-Proofpoint-ORIG-GUID: Iaz0pu41NX70Y7VXN3C9s0dTDqbiqymw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX8kYXwW8XsxFW
 nNbA4hx8cKtRiB95AJ8E1ixdTICGcL0CvSrCaN7NSZRtJG83vVOkWfbf5hMFRfewoqOA2lYyzCm
 DklLS+dXaI6oC19dCv9R6cFdmPdoRzUON6EmO1ExQmKohKMfwpILr37U9GmM101/ttupcSZ4GDh
 IdyNv9Q4H9HbxxTg5B4UIcZ2x6Tp8sMrukJgxsYsajzP2Y+jnwn/1+rBRnbPrv9MfeBDShKhW2B
 duHQvtvfg58RFE1oPRS/xrpZnq9S4zZjGPalo61JqKmQuKfys3Gyyn0mc3yfURBh3JUOJF3d0Kk
 FSPI5d4bUUhEqsjFDlCWRCJWnRcg+eurcdb1xseizxYifDU5xrwQY1deRcusWPT+7Gf0x2qJA/b
 TaqhdEOYU7BBfBjvwQMdbkC9rYs0424kC1MvVxqEu7MR0NxznhsPSj+8Zit2IQW2IcXmD0El56O
 3f5EXUboblsqeusP4gg==
X-Proofpoint-GUID: Iaz0pu41NX70Y7VXN3C9s0dTDqbiqymw
X-Authority-Analysis: v=2.4 cv=KM9qylFo c=1 sm=1 tr=0 ts=6a549dc5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=e3IgJkg0_sA7cZlYWVIA:9 a=2NnaZ24ErsFeWgEi:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130084

QCC2072 is a multi-subsystem chip; it has subsystem PERI (Peripheral)
to support BT function module, and BT is connected to PERI by an
internal link, as shown below:

       USB I/F
                 (Peripheral)   (Bluetooth)
                _______________________________
BTHOST -------- |      PERI ----------BT       |
                |______________________________|
               (other on-chip subsystems omitted)

A multi-subsystem chip differs from a BT-only chip in that:
- PERI has its own command/event/ACL traffic alongside BT's
- PERI has its own firmware (PATCH and NVM) to download
- PERI has its own memdump that needs to be collected
- The setup code needs to interact with PERI directly

To avoid adding large vendor-specific code into the BTUSB main
file, add btusb_qcom.c/.h to support multi-subsystem BT chips.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Note: this v1 is an early, still-maturing revision (~40 days of work), posted
now rather than later to get directional feedback before I invest further --
I'd rather find out early if the overall approach is wrong. It also lets
dependent work on our side proceed in parallel. Comments on the overall
design and direction are especially welcome; finer details will be polished
in later revisions.
---
 drivers/bluetooth/Makefile     |    1 +
 drivers/bluetooth/btusb_main.c |   69 +-
 drivers/bluetooth/btusb_qcom.c | 3706 ++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btusb_qcom.h |   41 +
 4 files changed, 3815 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 8b436c6de8b7..d518320b235e 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -52,5 +52,6 @@ hci_uart-$(CONFIG_BT_HCIUART_AML)	+= hci_aml.o
 hci_uart-objs				:= $(hci_uart-y)
 
 btusb-y				:= btusb_main.o
+btusb-y				+= btusb_qcom.o
 
 CONTEXT_ANALYSIS := y
diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index e914ed043dc9..c97e2fff926c 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -27,6 +27,7 @@
 #include "btbcm.h"
 #include "btrtl.h"
 #include "btmtk.h"
+#include "btusb_qcom.h"
 
 #define VERSION "0.8"
 
@@ -67,6 +68,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
+#define BTUSB_QCOM			BIT(29)
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -414,6 +416,10 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x2c7c, 0x0132), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* QCOM Msubsys chipset QCC2072 */
+	{ USB_DEVICE(0x0cf3, 0xea00), .driver_info = BTUSB_QCOM |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = BTUSB_WRONG_SCO_MTU },
@@ -1351,8 +1357,7 @@ static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
 	return 0;
 }
 
-static int __maybe_unused btusb_recv_acl_hdev(struct hci_dev *hdev,
-					      struct sk_buff *skb)
+static int btusb_recv_acl_hdev(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 
@@ -4117,6 +4122,45 @@ static struct hci_drv btusb_hci_drv = {
 	.specific_handlers	= btusb_hci_drv_specific_handlers,
 };
 
+
+/*
+ * ============================================================================
+ * QCOM support
+ * ============================================================================
+ */
+
+static int btusb_recv_intr_qcom(struct btusb_data *data, void *buffer, int count)
+{
+	unsigned long flags;
+	int err = 0;
+
+	spin_lock_irqsave(&data->rxlock, flags);
+	data->evt_skb = btusb_qcom_recv_intr(data->hdev, data->evt_skb, buffer, count,
+					      &err);
+	spin_unlock_irqrestore(&data->rxlock, flags);
+
+	return err;
+}
+
+static int btusb_recv_bulk_qcom(struct btusb_data *data, void *buffer, int count)
+{
+	unsigned long flags;
+	int err = 0;
+
+	spin_lock_irqsave(&data->rxlock, flags);
+	data->acl_skb = btusb_qcom_recv_bulk(data->hdev, data->acl_skb, buffer, count,
+					     &err);
+	spin_unlock_irqrestore(&data->rxlock, flags);
+
+	return err;
+}
+
+/*
+ * ============================================================================
+ * QCOM support end
+ * ============================================================================
+ */
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -4217,6 +4261,9 @@ static int btusb_probe(struct usb_interface *intf,
 	} else if (id->driver_info & BTUSB_QCA_WCN6855) {
 		/* Allocate extra space for QCA WCN6855 device */
 		priv_size += sizeof(struct btqca_data);
+	} else if (id->driver_info & BTUSB_QCOM) {
+		/* Allocate extra space for QCOM device */
+		priv_size += btusb_qcom_hdev_priv_size();
 	}
 
 	data->recv_acl = hci_recv_frame;
@@ -4375,6 +4422,24 @@ static int btusb_probe(struct usb_interface *intf,
 		hci_set_msft_opcode(hdev, 0xFD70);
 	}
 
+	if (id->driver_info & BTUSB_QCOM) {
+		struct btusb_qcom *xdata = btusb_qcom_xport_data(hdev);
+
+		xdata->idVendor  = id->idVendor;
+		xdata->idProduct = id->idProduct;
+		xdata->reset_gpio = data->reset_gpio;
+		xdata->prepare_reset = btusb_prepare_reset;
+		xdata->send_frame = btusb_send_frame;
+		xdata->recv_acl   = btusb_recv_acl_hdev;
+		xdata->recv_event = btusb_recv_event_hdev;
+
+		data->recv_intr = btusb_recv_intr_qcom;
+		data->recv_bulk = btusb_recv_bulk_qcom;
+
+		hdev->send  = btusb_qcom_send_frame;
+		hdev->setup = btusb_qcom_setup;
+	}
+
 	if (id->driver_info & BTUSB_AMP) {
 		/* AMP controllers do not support SCO packets */
 		data->isoc = NULL;
diff --git a/drivers/bluetooth/btusb_qcom.c b/drivers/bluetooth/btusb_qcom.c
new file mode 100644
index 000000000000..75ec8e781e37
--- /dev/null
+++ b/drivers/bluetooth/btusb_qcom.c
@@ -0,0 +1,3706 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Bluetooth USB transport for Qualcomm BT chips
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/args.h>
+#include <linux/bitfield.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/sizes.h>
+#include <linux/unaligned.h>
+#include <linux/usb.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/coredump.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btusb_qcom.h"
+
+/*
+ * ============================================================================
+ * Qualcomm DFU (Device Firmware Update) — rampatch/NVM download vendor cmds
+ * ============================================================================
+ */
+
+/* QDFU USB vendor command codes (bRequest) */
+#define QDFU_BT_CMD_VSC_REQ_DOWNLOAD_LOCAL	0x01
+#define QDFU_BT_CMD_CHECK_TARGET_STATE	0x05
+#define QDFU_BT_CMD_GET_TARGET_VERSION	0x09
+#define QDFU_BT_CMD_VSC_REQ_DOWNLOAD_REMOTE	0x10
+#define QDFU_BT_CMD_RESET_PERI_HCI			0x11
+#define QDFU_BT_CMD_ACTIVATE_REMOTE_BTSS	0x12
+#define QDFU_BT_CMD_BT_ENABLE_RESET		0x13
+
+/* QDFU target status bits (u8 bitmask from QDFU_BT_CMD_CHECK_TARGET_STATE) */
+#define QDFU_BT_STATE_LOADING_LOCAL		BIT(3)
+#define QDFU_BT_STATE_PATCHED_REMOTE	BIT(4)
+#define QDFU_BT_STATE_NVMED_REMOTE		BIT(5)
+#define QDFU_BT_STATE_NVMED_LOCAL		BIT(6)
+#define QDFU_BT_STATE_PATCHED_LOCAL		BIT(7)
+
+/* QDFU_BT_CMD_GET_TARGET_VERSION response */
+struct qdfu_bt_version {
+	__le32	rom_version;
+	__le32	patch_version;
+	__le32	soc_ver;
+	__be16	board_id;
+	__le16	flag;
+	u8	reserved[4];
+} __packed;
+
+struct qdfu_bt_id {
+	u32 rom_version;
+	u32 patch_version;
+	u32 soc_id;
+	u16 board_id;
+};
+
+static inline int qdfu_recv_vendor_req(struct hci_dev *hdev, u8 request,
+				       u16 value, void *buf, u16 size)
+{
+	struct btusb_qcom *xdata = btusb_qcom_xport_data(hdev);
+
+	return usb_control_msg_recv(xdata->udev, 0, request,
+				    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_ENDPOINT,
+				    value, 0, buf, size,
+				    USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+}
+
+static inline int qdfu_send_vendor_req(struct hci_dev *hdev, u8 request,
+				       u16 value, const void *buf, u16 size)
+{
+	struct btusb_qcom *xdata = btusb_qcom_xport_data(hdev);
+
+	return usb_control_msg_send(xdata->udev, 0, request,
+				    USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_ENDPOINT,
+				    value, 0, buf, size,
+				    USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+}
+
+static int qdfu_vsc_req_download(struct hci_dev *hdev, u8 request,
+				 const void *buf, u16 size)
+{
+	int ret;
+
+	if (request != QDFU_BT_CMD_VSC_REQ_DOWNLOAD_LOCAL &&
+	    request != QDFU_BT_CMD_VSC_REQ_DOWNLOAD_REMOTE) {
+		bt_dev_err(hdev,
+			   "QDFU download invalid request code 0x%02x", request);
+		return -EINVAL;
+	}
+
+	ret = qdfu_send_vendor_req(hdev, request, 0, buf, size);
+	if (ret)
+		bt_dev_err(hdev,
+			   "QDFU download request 0x%02x failed: %pe",
+			   request, ERR_PTR(ret));
+
+	return ret;
+}
+
+static int qdfu_get_target_state(struct hci_dev *hdev, u8 *state_ptr)
+{
+	int ret;
+	u8 state;
+
+	ret = qdfu_recv_vendor_req(hdev, QDFU_BT_CMD_CHECK_TARGET_STATE, 0,
+				   &state, sizeof(state));
+	if (!ret)
+		*state_ptr = state;
+	else
+		bt_dev_err(hdev,
+			   "Failed to get QDFU target state: %pe",
+			   ERR_PTR(ret));
+
+	return ret;
+}
+
+static int qdfu_get_target_version(struct hci_dev *hdev, struct qdfu_bt_id *id_info)
+{
+	struct qdfu_bt_version dfu_ver;
+	u16 board_id = 0;
+	int ret;
+
+	ret = qdfu_recv_vendor_req(hdev, QDFU_BT_CMD_GET_TARGET_VERSION, 0,
+				   &dfu_ver, sizeof(dfu_ver));
+	if (ret) {
+		bt_dev_err(hdev,
+			   "Failed to get QDFU target version: %pe",
+			   ERR_PTR(ret));
+		return ret;
+	}
+
+	id_info->rom_version = le32_to_cpu(dfu_ver.rom_version);
+	id_info->patch_version = le32_to_cpu(dfu_ver.patch_version);
+	id_info->soc_id = le32_to_cpu(dfu_ver.soc_ver);
+
+	if ((le16_to_cpu(dfu_ver.flag) >> 8) == 0x80)
+		board_id = be16_to_cpu(dfu_ver.board_id);
+
+	/* Take 0xffff as invalid board ID */
+	if (board_id == 0xffff)
+		board_id = 0;
+
+	id_info->board_id = board_id;
+
+	return 0;
+}
+
+static int qdfu_activate_remote_btss(struct hci_dev *hdev, bool on,
+				     unsigned int wait_us)
+{
+	u8 status = 0;
+	int ret;
+
+	ret = qdfu_recv_vendor_req(hdev, QDFU_BT_CMD_ACTIVATE_REMOTE_BTSS, on,
+				   &status, sizeof(status));
+	if (ret) {
+		bt_dev_err(hdev, "QDFU Failed to %s remote BTSS: %pe",
+			   str_on_off(on), ERR_PTR(ret));
+		return ret;
+	}
+
+	switch (status) {
+	case 0:
+		bt_dev_info(hdev, "QDFU Remote BTSS turned %s", str_on_off(on));
+		fsleep(wait_us);
+		break;
+	case 0x17:
+		bt_dev_info(hdev, "QDFU Remote BTSS already %s", str_on_off(on));
+		break;
+	default:
+		bt_dev_err(hdev,
+			   "QDFU Remote BTSS %s failed, unexpected status 0x%02x",
+			   str_on_off(on), status);
+		ret = -ENODEV;
+	}
+
+	return ret;
+}
+
+static int qdfu_reset_peri_hci(struct hci_dev *hdev)
+{
+	int ret;
+
+	ret = qdfu_send_vendor_req(hdev, QDFU_BT_CMD_RESET_PERI_HCI, 0, NULL, 0);
+	if (ret) {
+		bt_dev_err(hdev, "QDFU Failed to reset peripheral HCI: %pe",
+			   ERR_PTR(ret));
+		return ret;
+	}
+	bt_dev_info(hdev, "QDFU Peripheral HCI reset done");
+	fsleep(20 * 1000);
+
+	return 0;
+}
+
+static int qdfu_sw_reset(struct hci_dev *hdev)
+{
+	int ret;
+
+	ret = qdfu_send_vendor_req(hdev, QDFU_BT_CMD_BT_ENABLE_RESET, 0, NULL, 0);
+	if (ret) {
+		bt_dev_dbg(hdev, "Failed to trigger SW reset: %pe",
+			   ERR_PTR(ret));
+	}
+
+	BT_INFO("QDFU SW reset done");
+
+	return 0;
+}
+
+/*
+ * qdfu_poll_state - wait for DFU target status flags to reach a wanted state
+ * @hdev: the HCI device to poll
+ * @state_ptr: optional storage for the last status read; may be NULL
+ * @set: true to wait until @flags are all set, false until all cleared
+ * @flags: the status flag bits to wait on
+ *
+ * Repeatedly reads the DFU target status until @flags reach the requested
+ * state, a status read fails, or the overall timeout expires.
+ *
+ * Return: 0 on success, -ETIMEDOUT on timeout, or a negative errno on read
+ *	failure.
+ */
+static int qdfu_poll_state(struct hci_dev *hdev, u8 *state_ptr, bool set, u8 flags)
+{
+	int err, ret;
+	u8 dfu_state;
+
+	if (!state_ptr)
+		state_ptr = &dfu_state;
+
+	ret = read_poll_timeout(qdfu_get_target_state, err,
+				err || (set ? (*state_ptr & flags) == flags
+					    : !(*state_ptr & flags)),
+				5 * 1000,
+				3000 * 1000, true,
+				hdev, state_ptr);
+	if (ret) {
+		bt_dev_err(hdev,
+			   "Timed out waiting for QDFU state flags 0x%02x to be %s: %pe",
+			   flags, set ? "set" : "cleared", ERR_PTR(ret));
+		return ret;
+	}
+
+	return err;
+}
+
+/*
+ * ============================================================================
+ * Qualcomm HCI (QHCI) — common definitions between BT-HCI and PERI-HCI
+ * ============================================================================
+ */
+
+/*
+ * struct qhci_cmd_spec - command/response contract for one synced command
+ * @opcode: command opcode to match in the response; 0xffff = invalid
+ * @sub_code: command sub-opcode to match; 0xff = invalid
+ * @event: expected event-code sequence, terminated by 0xffff
+ */
+struct qhci_cmd_spec {
+	u16  opcode;
+	u8   sub_code;
+	u16  event[3];
+};
+
+#define QHCI_MATCH_RESULT(status)	(0x100 | (u8)(status))
+#define QHCI_MATCH_STATUS(ret)		((u8)(ret))
+
+/*
+ * typedef qhci_rsp_match_fn - match a received event against a command spec
+ * @spec: the spec to match
+ * @rsp: the received event skb to match the spec
+ *
+ * Return: < 0 on structural error, 0 if not matched, or >= 0x100 when matched
+ *	(the low 8 bits carry the HCI status code).
+ */
+typedef int (*qhci_rsp_match_fn)(const struct qhci_cmd_spec *spec,
+				  struct sk_buff *rsp);
+
+/*
+ * struct qhci_req - per-command sync request, stack allocated by the sender
+ * @pkt_type: packet type; reserved for BT, not checked yet
+ * @spec: the spec to wait for
+ * @req_rsp: response skb on success, NULL for a send-only request, or
+ *	ERR_PTR on failure
+ * @index: cursor into @spec->event[]
+ */
+struct qhci_req {
+	u8				 pkt_type;
+	const struct qhci_cmd_spec	*spec;
+	struct sk_buff			*req_rsp;
+	u8				 index;
+};
+
+struct qhci_sync {
+	spinlock_t		lock;
+	struct completion	done;
+	struct qhci_req		*req;
+};
+
+/* QHCI BT controller version */
+struct qhci_btc_ver {
+	u32 product_id;
+	u32 soc_ver;
+	u16 rom_ver;
+	u16 patch_ver;
+	u8  sec_ver;
+};
+
+#define QHCI_MEMDUMP_SEQ_LAST		0xFFFF
+#define QBT_VSE_CLASS_DATALOG 0x01
+#define QBT_VSE_TYPE_MEMDUMP  0x08
+#define PERI_EV_CRASH_DUMP_MEM	0x04
+
+/*
+ * struct qhci_memdump_vse - one memdump segment, common to all 4 channels
+ * @evt: HCI vendor event code, always HCI_EV_VENDOR
+ * @plen: event parameter length
+ * @ev_class: vendor event class, identifies this as a memdump event
+ * @ev_type: vendor event type, identifies this as a memdump event
+ * @seqno: segment sequence number; 0 = first, QHCI_MEMDUMP_SEQ_LAST = last
+ * @subsys: subsystem this segment belongs to (see enum qhci_subsys)
+ * @segdata: payload of a middle or last segment
+ * @dump_size: total dump size, valid only in the first segment (@seqno == 0)
+ * @first_segdata: payload of the first segment, following @dump_size
+ *
+ * Sent on all 4 memdump channels (BT/PERI x event/ACL) after the
+ * transport-specific header is stripped. The first segment carries
+ * @dump_size ahead of its payload; later segments carry payload only.
+ */
+struct qhci_memdump_vse {
+	u8     evt;
+	u8     plen;
+	u8     ev_class;
+	u8     ev_type;
+	__le16 seqno;
+	u8     subsys;
+	union {
+		u8 segdata[0];
+		struct {
+			__le32 dump_size;
+			u8 first_segdata[];
+		} __packed;
+	};
+} __packed;
+
+/*
+ * Subsystem field appears in a QHCI command/response/event: Peripheral
+ * (PERI) or Trust Management Engine Lite (TME-L).
+ */
+enum qhci_subsys {
+	QHCI_SUBSYS_PERI,
+	QHCI_SUBSYS_BT,
+	QHCI_SUBSYS_UWB,
+	QHCI_SUBSYS_TMEL,
+	QHCI_SUBSYS_MAX,
+};
+
+/* pseudo subsys used during memdump collection */
+#define QHCI_SUBSYS_INVALID	QHCI_SUBSYS_MAX
+
+static const char * const qhci_subsys_name[] = {
+	[QHCI_SUBSYS_PERI]	= "PERI",
+	[QHCI_SUBSYS_BT]	= "PERI BT",
+	[QHCI_SUBSYS_UWB]	= "UWB",
+	[QHCI_SUBSYS_TMEL]	= "TME-L",
+	[QHCI_SUBSYS_INVALID]	= "BT",
+};
+
+/*
+ * ============================================================================
+ * Qualcomm BT common part
+ * ============================================================================
+ */
+
+/* driver-perspective BT controller (BTC) category */
+enum qbtc_category {
+	QBTC_CAT_LEGACY,
+	QBTC_CAT_UNIFIED,
+	QBTC_CAT_MSUBSYS,
+	QBTC_CAT_MAX,
+};
+
+static const char * const qbtc_cat_name[] = {
+	[QBTC_CAT_LEGACY]  = "legacy",
+	[QBTC_CAT_UNIFIED] = "unified",
+	[QBTC_CAT_MSUBSYS] = "multi-subsys",
+};
+
+/* BTC subsystems we care about that support the BT function module */
+enum qbtc_subsys {
+	QBTC_SUBSYS_PERI,
+	QBTC_SUBSYS_TMEL,
+	QBTC_SUBSYS_MAX,
+};
+
+#define QBTC_SUBSYS_INVALID QBTC_SUBSYS_MAX
+
+static const char * const qbtc_subsys_name[] = {
+	[QBTC_SUBSYS_PERI] = "PERI",
+	[QBTC_SUBSYS_TMEL] = "TME-L",
+};
+
+struct qbtc_subsys_data {
+	struct qhci_btc_ver ver;
+	u16	board_id;
+	char	build_info[256];
+};
+
+/* BTC has PERI*/
+#define QBT_FLAG_SUBSYS_PERI	BIT(0)
+#define QBT_FLAG_SUBSYS_TMEL  BIT(1)
+/* enable MEMDUMP */
+#define QBT_FLAG_ENABLE_MEMDUMP	BIT(4)
+/* disable BTC logging or not during post setup phase */
+#define QBT_FLAG_DISABLE_BTC_LOG BIT(5)
+/* enable AOSP vendor extension */
+#define QBT_FLAG_ENABLE_AOSP_EXT    BIT(13)
+#define QBT_FLAG_ENABLE_MSFT_EXT    BIT(14)
+/* BTC supports software reset */
+#define QBT_FLAG_SW_RESET    BIT(15)
+/* Take foundary as a factor to select NVM */
+#define QBT_FLAG_MULTI_FOUNDRY BIT(16)
+/* select NVM based on board ID to download */
+#define QBT_FLAG_BID_NVM  BIT(17)
+/* fall back to the default NVM if no board-ID-specific NVM exists */
+#define QBT_FLAG_NVM_FALLBACK  BIT(18)
+/* do PERI HCI reset by QHCI instead of QDFU */
+#define QBT_FLAG_RESET_PERI_HCI BIT(19)
+
+/*
+ * enum qbth_work_bit - bits in btqcom_data.work_flags (BT HOST, BTH)
+ * @QBTH_WORK_RESET_HDEV: request to reset hdev
+ */
+enum qbth_work_bit {
+	QBTH_WORK_RESET_HDEV,
+};
+
+/*
+ * enum qbth_misc_bit - bits in btqcom_data.misc_flags
+ * @QBTH_MISC_MEMDUMP_READY: memdump registration succeeded
+ * @QBTH_MISC_MEMDUMP_ACTIVE: a memdump happens
+ * @QBTH_MISC_RESET_ACTIVE: a reset is in progress
+ */
+enum qbth_misc_bit {
+	QBTH_MISC_MEMDUMP_READY,
+	QBTH_MISC_MEMDUMP_ACTIVE,
+	QBTH_MISC_RESET_ACTIVE,
+};
+
+/* this subsystem's memdump is waiting for collection */
+#define QMD_FLAG_PENDING_PERI	BIT(0)
+#define QMD_FLAG_PENDING_BT	BIT(1)
+#define QMD_FLAG_PENDING_TMEL	BIT(2)
+#define QMD_FLAG_PENDING_MASK	(QMD_FLAG_PENDING_PERI | \
+				 QMD_FLAG_PENDING_BT | \
+				 QMD_FLAG_PENDING_TMEL)
+
+/*
+ * struct btqcom_memdump - for collecting memdump from a QHCI subsys
+ * @size: total memdump size to collect
+ * @subsys: QHCI subsys this memdump belongs to
+ * @seqno: next expected sequence number
+ * @from: which channel this memdump comes from, marked by hci_skb_pkt_type()
+ * @rx_size: memdump bytes received so far
+ */
+struct btqcom_memdump {
+	u32 size;
+	int subsys;
+	u16 seqno;
+	u8 from;
+
+	u32 rx_size;
+};
+
+/*
+ * struct btqcom_data - transport-independent per-device common data, allocated as hci priv
+ * @drv_name: driver name
+ * @btc_name: driver-perspective BTC name
+ * @category: driver-perspective BTC category (legacy/unified/multi-subsys)
+ * @flags: QBT_FLAG_* bits selecting features for the device
+ * @board_id: BT board ID
+ * @ver: BT version
+ * @build_info: BT firmware build info string
+ * @cmd_sync: per-device QHCI command/response sync mechanism
+ * @xport_data: opaque transport-specific data (e.g. struct btusb_qcom for USB)
+ * @hdev: the owning HCI device
+ * @work_flags: flags made from QBTH_WORK_* bits defined above
+ * @work: deferred work executed in process context
+ * @misc_flags: flags made from QBTH_MISC_* bits defined above
+ * @md_flags: QMD_FLAG_PENDING_* flags tracking per-subsystem memdump collection
+ * @md_state: devcoredump state as notified by the devcoredump core
+ * @md: in-flight memdump collection track
+ * @subsys: per-subsystem info (version, board ID, build info) for MSUBSYS chips
+ */
+struct btqcom_data {
+	const char *drv_name;
+	const char *btc_name;
+	enum qbtc_category category;
+	unsigned long flags;
+	u16	board_id;
+	struct qhci_btc_ver ver;
+	char	build_info[128];
+	struct qhci_sync cmd_sync;
+
+	void *xport_data;
+	struct hci_dev *hdev;
+
+	unsigned long		work_flags;
+	struct work_struct	work;
+
+	unsigned long misc_flags;
+	unsigned long md_flags;
+	enum devcoredump_state md_state;
+	struct btqcom_memdump md;
+	struct qbtc_subsys_data subsys[QBTC_SUBSYS_MAX];
+};
+
+static inline void btqcom_recv_diag(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	*(u8 *)skb_push(skb, 1) = hci_skb_pkt_type(skb);
+	hci_recv_diag(hdev, skb);
+}
+
+/*
+ * ============================================================================
+ * BTC identification and information tables
+ * ============================================================================
+ */
+
+/* rare board ID to custom firmware folder map */
+struct qbtc_bid_fwdir {
+	u16 board_id;
+	const char *fw_dir;
+};
+
+/*
+ * struct qbtc_info - BTC information and default configuration
+ * @category: driver-perspective BTC category (legacy/unified/multi-subsys)
+ * @flags: QBT_FLAG_* — BTC attributes and default configuration
+ * @fw_dir: firmware folder, "qca" if NULL
+ * @custom_fw_table: {}-terminated array or NULL
+ */
+struct qbtc_info {
+	enum qbtc_category category;
+	unsigned long flags;
+	const char *fw_dir;
+	const struct qbtc_bid_fwdir *custom_fw_table;
+};
+
+/*
+ * struct qbtc_id - BTC ID entry in qbtc_id_table[] below
+ * @rom_version: ID to match against rom_version read from BTC
+ * @name: driver-perspective BTC name
+ * @btc_info: BTC information and default configuration, != NULL
+ */
+struct qbtc_id {
+	u32		rom_version;
+	const char	*name;
+	const struct qbtc_info *btc_info;
+};
+
+/* unified BTC here */
+#define QBTC_INFO_FLAGS_UNIFIED	(QBT_FLAG_BID_NVM | QBT_FLAG_ENABLE_MEMDUMP | \
+				 QBT_FLAG_ENABLE_AOSP_EXT | QBT_FLAG_ENABLE_MSFT_EXT)
+
+static const struct qbtc_info qbtc_unified_base = {
+	.category = QBTC_CAT_UNIFIED,
+	.flags    = QBTC_INFO_FLAGS_UNIFIED,
+};
+
+static const struct qbtc_info qbtc_unified_wcn6855_base = {
+	.category = QBTC_CAT_UNIFIED,
+	.flags    = QBTC_INFO_FLAGS_UNIFIED | QBT_FLAG_MULTI_FOUNDRY,
+};
+
+static const struct qbtc_bid_fwdir wcn6855_v21_custom_fwdir[] = {
+	{ 0x030A, "qca/QCA2066" },
+	{ 0x030B, "qca/QCA2066" },
+	{ },
+};
+
+static const struct qbtc_info qbtc_unified_wcn6855_v21 = {
+	.category        = QBTC_CAT_UNIFIED,
+	.flags           = QBTC_INFO_FLAGS_UNIFIED | QBT_FLAG_MULTI_FOUNDRY,
+	.custom_fw_table = wcn6855_v21_custom_fwdir,
+};
+
+/* multi-subsys BTC here */
+#define QBTC_INFO_FLAGS_MSUBSYS	(QBTC_INFO_FLAGS_UNIFIED | QBT_FLAG_SUBSYS_PERI | \
+				 QBT_FLAG_SW_RESET | QBT_FLAG_NVM_FALLBACK)
+
+static const struct qbtc_info qbtc_msubsys_qcc2072 = {
+	.category = QBTC_CAT_MSUBSYS,
+	.flags    = QBTC_INFO_FLAGS_MSUBSYS,
+	.fw_dir   = "qca/QCC2072",
+};
+
+static const struct qbtc_id qbtc_id_table[] = {
+	{ 0x00130100, "WCN6855 1.0", &qbtc_unified_wcn6855_base },
+	{ 0x00130200, "WCN6855 2.0", &qbtc_unified_wcn6855_base },
+	{ 0x00130201, "WCN6855 2.1", &qbtc_unified_wcn6855_v21 },
+	{ 0x00190200, "WCN785x 2.0", &qbtc_unified_base },
+	{ 0x00220100, "QCC2072 1.x", &qbtc_msubsys_qcc2072 },
+	{ }
+};
+
+/*
+ * ============================================================================
+ * Qualcomm BT-HCI vendor-specific command/response/event
+ * ============================================================================
+ */
+
+/* reserved BT ACL handle for enhanced logging */
+#define QBT_HANDLE_ENHANCED_LOGGING 0xEDC
+/* reserved BT ACL handle for memdump */
+#define QBT_HANDLE_MEMDUMP 0xEDD
+
+struct qbt_vse_comm {
+	struct hci_event_hdr hdr;
+	u8   ev_class;
+	u8   ev_type;
+} __packed;
+#define QBT_VSE_COMM_SIZE	(sizeof(struct qbt_vse_comm))
+
+/*
+ * Unless otherwise noted, the VSCs below respond with a CCE, grouped by
+ * { opcode, { sub-code, response } }.
+ */
+
+/* BT EDL (Embedded Downloader) opcode and its sub-codes */
+#define BT_DOWNLOAD_OPCODE	0xFC00
+
+#define BDL_EDL_PATCH_GETVER	0x19
+struct cce_edl_patch_getver {
+	u8	status;
+	u8	sub_opcode;
+	u8	plen;
+	__le32	product_id;
+	__le16	patch_ver;
+	__le16	rom_ver;
+	__le32	soc_ver;
+} __packed;
+
+#define BDL_GET_BOARD_ID	0x23
+struct cce_get_board_id {
+	u8	status;
+	u8	sub_opcode;
+	u8	plen;
+	__be16	board_id;
+} __packed;
+
+#define	BDL_GET_BUILD_INFO 0x20
+struct cce_get_build_info {
+	u8	status;
+	u8	sub_opcode;
+	u8	plen;
+	u8	data[];
+} __packed;
+
+/* BT DEBUG opcode and its sub-opcodes */
+#define BT_DEBUG_OPCODE		0xFC0C
+
+/* no response */
+#define BDBG_ERROR_FATAL_CMD	0x26
+
+/* BDA write opcode */
+#define BT_WRITE_BDA_OPCODE	0xFC14
+
+/* BTC logging opcode and its sub-opcodes */
+#define BT_HOST_LOG_OPCODE	0xFC17
+
+#define BHL_ENH_ENABLE_LOG	0x14
+struct qbt_cce_generic {
+	u8	status;
+	u8	sub_opcode;
+} __packed;
+
+/*
+ * QBT_CHECK_CCE_GENERIC - regard the received CCE as the specified type
+ *	and do a sanity check
+ * @_skb: the received CCE
+ * @cce_type: the CCE type interpret @_skb as
+ * @_sub_code: expected sub_opcode
+ *
+ * It is safe to evaluate @_skb and @_sub_code more than once for its
+ * usages.
+ *
+ * Returns a negative errno on failure, 0 on success, or error status code
+ * otherwise.
+ */
+#define QBT_CHECK_CCE_GENERIC(_skb, cce_type, _sub_code)		\
+({									\
+	cce_type *_cce_ptr;						\
+	int _err = 0;							\
+	do {								\
+		if (_skb->len < sizeof(cce_type)) {			\
+			_err = -EBADMSG;				\
+			break;						\
+		}							\
+		_cce_ptr = (void *)_skb->data;				\
+		if (_cce_ptr->sub_opcode != _sub_code) {			\
+			_err = -EILSEQ;					\
+			break;						\
+		}							\
+		if (_cce_ptr->status) {					\
+			_err = _cce_ptr->status;			\
+			break;						\
+		}							\
+	} while (0);							\
+	_err;								\
+})
+
+/* check the @plen field on top of QBT_CHECK_CCE_GENERIC() */
+#define QBT_CHECK_CCE_PLEN(_skb, cce_type, _sub_code)			\
+({									\
+	cce_type *_cce_ptr;						\
+	int _err = 0;							\
+	do {								\
+		_err = QBT_CHECK_CCE_GENERIC(_skb, cce_type, _sub_code);\
+		if (_err)						\
+			break;						\
+		_cce_ptr = (void *)_skb->data;				\
+		if (_skb->len - offsetofend(cce_type, plen) !=		\
+		    _cce_ptr->plen) {					\
+			_err = -EMSGSIZE;				\
+			break;						\
+		}							\
+	} while (0);							\
+	_err;								\
+})
+
+/*
+ * qbt_edl_patch_getver - read BTC version info
+ * @hdev: the HCI device to query
+ * @ver: output version info, filled on success
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int qbt_edl_patch_getver(struct hci_dev *hdev, struct qhci_btc_ver *ver)
+{
+	struct cce_edl_patch_getver *cce;
+	struct sk_buff *skb;
+	const u8 cmd[] = { BDL_EDL_PATCH_GETVER };
+	int err;
+
+	skb = __hci_cmd_sync_ev(hdev, BT_DOWNLOAD_OPCODE, sizeof(cmd),
+				cmd, 0, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		goto out;
+	}
+
+	err = QBT_CHECK_CCE_PLEN(skb, struct cce_edl_patch_getver, cmd[0]);
+	if (err)
+		goto out_free_skb;
+
+	cce = (void *)skb->data;
+	ver->product_id = le32_to_cpu(cce->product_id);
+	ver->soc_ver    = le32_to_cpu(cce->soc_ver);
+	ver->rom_ver    = le16_to_cpu(cce->rom_ver);
+	ver->patch_ver  = le16_to_cpu(cce->patch_ver);
+
+	bt_dev_dbg(hdev, "QCOM Product ID   :0x%08x", ver->product_id);
+	bt_dev_dbg(hdev, "QCOM SOC Version  :0x%08x", ver->soc_ver);
+	bt_dev_dbg(hdev, "QCOM ROM Version  :0x%04x", ver->rom_ver);
+	bt_dev_dbg(hdev, "QCOM Patch Version:0x%04x", ver->patch_ver);
+
+	if (ver->soc_ver == 0 || ver->rom_ver == 0)
+		err = -EILSEQ;
+
+out_free_skb:
+	kfree_skb(skb);
+
+	if (err > 0) {
+		bt_dev_dbg(hdev, "QCOM version response status error 0x%02x",
+			   err);
+		err = -bt_to_errno(err);
+	}
+out:
+	if (err)
+		bt_dev_err(hdev, "QCOM failed to get version (%pe)", ERR_PTR(err));
+
+	return err;
+}
+
+/*
+ * qbt_edl_get_board_id - get BTC board ID
+ * @hdev: the HCI device to query
+ * @board_id: output board ID, filled on success
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int qbt_edl_get_board_id(struct hci_dev *hdev, u16 *board_id)
+{
+	struct cce_get_board_id *cce;
+	struct sk_buff *skb;
+	const u8 cmd[] = { BDL_GET_BOARD_ID };
+	int err;
+
+	skb = __hci_cmd_sync_ev(hdev, BT_DOWNLOAD_OPCODE, sizeof(cmd),
+				cmd, 0, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		goto out;
+	}
+
+	err = QBT_CHECK_CCE_PLEN(skb, struct cce_get_board_id, cmd[0]);
+	if (err)
+		goto out_free_skb;
+
+	cce = (void *)skb->data;
+	*board_id = be16_to_cpu(cce->board_id);
+	/* Take 0xffff as invalid board ID */
+	if (*board_id == 0xffff)
+		*board_id = 0;
+	bt_dev_info(hdev, "QCOM Board ID: 0x%04x", *board_id);
+
+out_free_skb:
+	kfree_skb(skb);
+
+	if (err > 0) {
+		bt_dev_dbg(hdev, "QCOM board ID response status error 0x%02x",
+			   err);
+		err = -bt_to_errno(err);
+	}
+out:
+	if (err)
+		bt_dev_err(hdev, "QCOM failed to get board ID (%pe)", ERR_PTR(err));
+
+	return err;
+}
+
+/*
+ * qbt_edl_get_build_info - get BTC build info string
+ * @hdev: the HCI device to query
+ * @build_info: output build info string, allocated on success; caller frees
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int qbt_edl_get_build_info(struct hci_dev *hdev, char **build_info)
+{
+	struct cce_get_build_info *cce;
+	struct sk_buff *skb;
+	const u8 cmd[] = { BDL_GET_BUILD_INFO };
+	int err;
+
+	skb = __hci_cmd_sync_ev(hdev, BT_DOWNLOAD_OPCODE, sizeof(cmd),
+				cmd, 0, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		goto out;
+	}
+
+	err = QBT_CHECK_CCE_PLEN(skb, struct cce_get_build_info, cmd[0]);
+	if (err)
+		goto out_free_skb;
+
+	cce = (void *)skb->data;
+	*build_info = kmemdup_nul(cce->data, cce->plen, GFP_KERNEL);
+	if (!*build_info) {
+		err = -ENOMEM;
+		goto out_free_skb;
+	}
+
+	bt_dev_info(hdev, "QCOM Build Info: %s", *build_info);
+
+out_free_skb:
+	kfree_skb(skb);
+
+	if (err > 0) {
+		bt_dev_err(hdev, "QCOM build info response status error 0x%02x",
+			   err);
+		err = -bt_to_errno(err);
+	}
+out:
+	if (err)
+		bt_dev_err(hdev, "QCOM failed to get build info (%pe)", ERR_PTR(err));
+
+	return err;
+}
+
+/*
+ * qbt_write_bda - set the controller's BD address
+ * @hdev: the HCI device to configure
+ * @bdaddr: the address to set
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int qbt_write_bda(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	bdaddr_t bdaddr_swapped;
+	int err;
+
+	/* The controller expects the address in reversed byte order. */
+	baswap(&bdaddr_swapped, bdaddr);
+
+	err = __hci_cmd_sync_status(hdev, BT_WRITE_BDA_OPCODE,
+				    sizeof(bdaddr_swapped), &bdaddr_swapped,
+				    HCI_INIT_TIMEOUT);
+	if (err < 0) {
+		bt_dev_err(hdev, "QCOM set BD address failed: %pe",
+			   ERR_PTR(err));
+		return err;
+	}
+	if (err > 0) {
+		bt_dev_err(hdev, "QCOM set BD address status error 0x%02x",
+			   err);
+		return -bt_to_errno(err);
+	}
+
+	bt_dev_dbg(hdev, "QCOM BD address set to %pMR", bdaddr);
+
+	return 0;
+}
+
+/*
+ * qbt_error_fatal_cmd - trigger a controller-side fatal error for debugging
+ * @hdev: the HCI device to command
+ */
+static void qbt_error_fatal_cmd(struct hci_dev *hdev)
+{
+	static const u8 param[] = { BDBG_ERROR_FATAL_CMD };
+	int err;
+
+	err = __hci_cmd_send(hdev, BT_DEBUG_OPCODE, sizeof(param), param);
+	if (err < 0)
+		bt_dev_err(hdev, "QCOM error fatal cmd failed: %d", err);
+}
+
+/*
+ * qbt_config_btc_logging - configure BTC enhanced logging
+ * @hdev: the HCI device to configure
+ * @flags: logging configuration flags, normally 1 (enable) or 0 (disable)
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int qbt_config_btc_logging(struct hci_dev *hdev, u8 flags)
+{
+	struct sk_buff *skb;
+	const u8 cmd[] = { BHL_ENH_ENABLE_LOG, flags };
+	int err;
+
+	skb = __hci_cmd_sync_ev(hdev, BT_HOST_LOG_OPCODE, sizeof(cmd),
+				cmd, 0, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		goto out;
+	}
+
+	err = QBT_CHECK_CCE_GENERIC(skb, struct qbt_cce_generic, BHL_ENH_ENABLE_LOG);
+	if (err)
+		goto out_free_skb;
+
+	bt_dev_dbg(hdev, "QCOM BTC logging configured (flags=0x%02x)", flags);
+
+out_free_skb:
+	kfree_skb(skb);
+
+	if (err > 0) {
+		bt_dev_dbg(hdev, "QCOM BTC logging status error 0x%02x", err);
+		err = -bt_to_errno(err);
+	}
+out:
+	if (err)
+		bt_dev_err(hdev, "QCOM BTC logging config failed (%pe)", ERR_PTR(err));
+
+	return err;
+}
+
+/*
+ * ============================================================================
+ * Qualcomm PERI (Peripheral) HCI for multi-subsystem chips
+ * ============================================================================
+ */
+
+/* BT host ID in PERI command/event/ACL */
+#define QHCI_HOST_ID_BT 0
+
+struct peri_cmd_hdr {
+	u8	host_id;
+	__le16	opcode;
+	u8	plen;
+} __packed;
+#define PERI_CMD_HDR_SIZE (sizeof(struct peri_cmd_hdr))
+#define PERI_CMD_PKT	0x31
+
+struct peri_evt_hdr {
+	u8	host_id;
+	u8	evt;
+	u8	plen;
+} __packed;
+#define PERI_EVT_HDR_SIZE	(sizeof(struct peri_evt_hdr))
+#define PERI_EVT_PKT	0x34
+#define PERI_MAX_EVT_SIZE	(HCI_MAX_EVENT_SIZE + 1)
+
+struct peri_acl_hdr {
+	u8	host_id;
+	__le16	handle;
+	__le16	dlen;
+} __packed;
+#define PERI_ACL_HDR_SIZE	(sizeof(struct peri_acl_hdr))
+#define PERI_ACL_PKT	0x32
+#define PERI_MAX_FRAME_SIZE	(HCI_MAX_FRAME_SIZE + 1)
+
+/* reserved PERI ACL handle for enhanced logging */
+#define QPERI_HANDLE_ENHANCED_LOGGING 0xEC0
+/* reserved PERI ACL handle for memdump */
+#define QPERI_HANDLE_MEMDUMP 0xEC1
+
+/* PERI events */
+
+#define EV_CLASS_PERI	0xF0
+
+/* common part every PERI event has */
+struct peri_ev_comm {
+	struct peri_evt_hdr hdr;
+	u8   ev_class;
+	u8   ev_type;
+} __packed;
+#define PERI_EV_COMM_SIZE	(sizeof(struct peri_ev_comm))
+
+#define PERI_EV_CMD_STATUS	0x00
+struct peri_ev_cmd_status {
+	struct peri_evt_hdr hdr;
+	u8   ev_class;
+	u8   ev_type;
+	u8   status;
+	u8   ncmd;
+	__le16	opcode;
+} __packed;
+#define PERI_EV_CS_SIZE	(sizeof(struct peri_ev_cmd_status))
+
+#define PERI_EV_CMD_COMPLETE	0x01
+struct peri_ev_cmd_complete {
+	struct peri_evt_hdr hdr;
+	u8	 ev_class;
+	u8	 ev_type;
+	u8     ncmd;
+	__le16   opcode;
+	u8	data[];
+} __packed;
+#define PERI_EV_CC_SIZE	(sizeof(struct peri_ev_cmd_complete))
+
+#define PERI_EV_SUBSYS_ACTIVATE_COMPLETE	0x02
+struct peri_ev_subsys_activate_complete {
+	struct peri_evt_hdr hdr;
+	u8	ev_class;
+	u8	ev_type;
+	u8      subsys;
+	u8	action;
+} __packed;
+
+#define PERI_EV_SUBSYS_PATCH_NOTIFICATION	0x03
+struct peri_ev_subsys_patch_notification {
+	struct peri_evt_hdr hdr;
+	u8	ev_class;
+	u8	ev_type;
+	u8	status;
+	u8	subsys;
+} __packed;
+
+#define PERI_EV_HARDWARE_ERROR	0x06
+struct peri_ev_hardware_error {
+	struct peri_evt_hdr hdr;
+	u8	ev_class;
+	u8	ev_type;
+	u8	code;
+} __packed;
+
+/* PERI commands grouped by { opcode, { sub_opcode, command, response } } */
+
+/* Download opcode and its sub_opcodes */
+#define PERI_OP_DOWNLOAD	0xFFF0
+
+#define	PDL_GET_BUILD_INFO 0x09
+struct peri_cmd_generic {
+	struct peri_cmd_hdr hdr;
+	u8 sub_opcode;
+	u8 subsys;
+} __packed;
+struct peri_cce_get_build_info {
+	struct peri_ev_cmd_complete cc;
+	u8	status;
+	u8	sub_opcode;
+	u8	subsys;
+	u8	plen;
+	u8	data[];
+} __packed;
+
+/* Generic opcode and its sub_codes */
+#define PERI_OP_GENERIC	0xFFF1
+
+#define PGN_PERI_RESET	0x03
+#define PGN_INITATE_BT_CRASH 0x05
+struct peri_cmd_simple {
+	struct peri_cmd_hdr	hdr;
+	u8	sub_opcode;
+} __packed;
+struct peri_cce_simple {
+	struct peri_ev_cmd_complete cc;
+	u8	status;
+	u8	sub_opcode;
+} __packed;
+
+static const char *qhci_pkt_type_name(u8 pkt_type)
+{
+	const char *pkt_type_name = "Unknown";
+
+	switch (pkt_type) {
+	case HCI_EVENT_PKT:
+		pkt_type_name = "BT EVT";
+		break;
+	case PERI_EVT_PKT:
+		pkt_type_name = "PERI EVT";
+		break;
+	case HCI_ACLDATA_PKT:
+		pkt_type_name = "BT ACL";
+		break;
+	case PERI_ACL_PKT:
+		pkt_type_name = "PERI ACL";
+		break;
+	default:
+		break;
+	}
+
+	return pkt_type_name;
+}
+
+static inline struct peri_evt_hdr *qperi_event_hdr(const struct sk_buff *skb)
+{
+	return (struct peri_evt_hdr *)skb->data;
+}
+
+static inline struct peri_acl_hdr *qperi_acl_hdr(const struct sk_buff *skb)
+{
+	return (struct peri_acl_hdr *)skb->data;
+}
+
+static inline __u16 qperi_acl_handle(const struct sk_buff *skb)
+{
+	struct peri_acl_hdr *hdr = qperi_acl_hdr(skb);
+
+	return hci_handle(__le16_to_cpu(hdr->handle));
+}
+
+/* PERI command sync — match functions and response table */
+
+static int peri_match_cse(const struct qhci_cmd_spec *spec,
+			  struct sk_buff *rsp)
+{
+	const struct peri_ev_cmd_status *cse = (const void *)rsp->data;
+
+	if (rsp->len != sizeof(*cse))
+		return -EBADMSG;
+	if (le16_to_cpu(cse->opcode) != spec->opcode)
+		return 0;
+	return QHCI_MATCH_RESULT(cse->status);
+}
+
+/*
+ * Simple CCE match — covers PERI commands whose CCE begins with
+ * struct peri_cce_simple (status + sub_opcode).
+ *
+ * Must be updated if a command's CCE is not compatible.
+ */
+static int peri_match_cce(const struct qhci_cmd_spec *spec,
+			  struct sk_buff *rsp)
+{
+	const struct peri_cce_simple *cce = (const void *)rsp->data;
+
+	if (rsp->len < sizeof(*cce))
+		return -EBADMSG;
+	if (le16_to_cpu(cce->cc.opcode) != spec->opcode)
+		return 0;
+	if (spec->sub_code == 0xff)
+		return QHCI_MATCH_RESULT(cce->status);
+	if (cce->sub_opcode != spec->sub_code)
+		return 0;
+	return QHCI_MATCH_RESULT(cce->status);
+}
+
+static int peri_match_subsys_activate_complete(const struct qhci_cmd_spec *spec,
+					       struct sk_buff *rsp)
+{
+	if (rsp->len != sizeof(struct peri_ev_subsys_activate_complete))
+		return -EBADMSG;
+	return QHCI_MATCH_RESULT(0);
+}
+
+static int peri_match_subsys_patch_notification(const struct qhci_cmd_spec *spec,
+						struct sk_buff *rsp)
+{
+	const struct peri_ev_subsys_patch_notification *ev =
+					(const void *)rsp->data;
+
+	if (rsp->len != sizeof(*ev))
+		return -EBADMSG;
+	return QHCI_MATCH_RESULT(ev->status);
+}
+
+/*
+ * Indexed directly by ev_type.
+ * Must be updated if a new command's response is not listed here.
+ */
+static const qhci_rsp_match_fn qperi_rsp_table[] = {
+	[PERI_EV_CMD_STATUS]                = peri_match_cse,
+	[PERI_EV_CMD_COMPLETE]              = peri_match_cce,
+	[PERI_EV_SUBSYS_ACTIVATE_COMPLETE]  = peri_match_subsys_activate_complete,
+	[PERI_EV_SUBSYS_PATCH_NOTIFICATION] = peri_match_subsys_patch_notification,
+};
+
+/*
+ * peri_sync_recv - check if the event completes the pending sync command,
+ *	and if so wake its sender
+ * @hdev: the HCI device
+ * @sync: the command sync data, includes the command spec to check the
+ *	event against
+ * @skb: the received event
+ *
+ * Returns a negative errno if the event is malformed,
+ * 0 if no command sync is pending or the event is not matched,
+ * > 0 match result QHCI_MATCH_RESULT() for the matched event.
+ */
+static int peri_sync_recv(struct hci_dev *hdev, struct qhci_sync *sync,
+			  struct sk_buff *skb)
+{
+	const struct peri_ev_comm *comm = (const void *)skb->data;
+	unsigned long flags;
+	struct qhci_req *req;
+	int ret = 0;
+	u16 ev_type;
+	u8 status = 0x00;
+
+	/* fast path — no lock needed */
+	req = READ_ONCE(sync->req);
+	if (!req)
+		return 0;
+
+	ev_type = comm->ev_type;
+	spin_lock_irqsave(&sync->lock, flags);
+
+	req = sync->req;
+	if (!req)
+		goto out_unlock;
+
+	if (req->spec->event[req->index] != ev_type)
+		goto out_unlock;
+
+	ret = QHCI_MATCH_RESULT(0x00);
+	if (qperi_rsp_table[ev_type]) {
+		ret = qperi_rsp_table[ev_type](req->spec, skb);
+		if (!ret)
+			goto out_unlock;
+
+		/* matched bad frame */
+		if (ret < 0) {
+			req->req_rsp = ERR_PTR(ret);
+			goto out_wakeup;
+		}
+
+		status = QHCI_MATCH_STATUS(ret);
+		if (status) {
+			req->req_rsp = ERR_PTR(-bt_to_errno(status));
+			btqcom_recv_diag(hdev, skb);
+			goto out_wakeup;
+		}
+	}
+
+	if (req->spec->event[req->index + 1] != 0xffff) {
+		req->index++;
+		btqcom_recv_diag(hdev, skb);
+		goto out_unlock;
+	}
+
+	req->req_rsp = skb;
+out_wakeup:
+	if (ret < 0)
+		bt_dev_dbg(hdev, "PERI cmd opcode(0x%04x) sub_code(0x%02x): error(%pe) on ev_type(0x%02x)",
+			   req->spec->opcode, req->spec->sub_code, ERR_PTR(ret), ev_type);
+	else if (status)
+		bt_dev_err(hdev, "PERI cmd opcode(0x%04x) sub_code(0x%02x): status error(0x%02x) on ev_type(0x%02x)",
+			   req->spec->opcode, req->spec->sub_code, status, ev_type);
+	else
+		bt_dev_dbg(hdev, "PERI cmd opcode(0x%04x) sub_code(0x%02x): succeeded on ev_type(0x%02x)",
+			   req->spec->opcode, req->spec->sub_code, ev_type);
+
+	WRITE_ONCE(sync->req, NULL);
+	spin_unlock_irqrestore(&sync->lock, flags);
+	complete(&sync->done);
+	return ret;
+
+out_unlock:
+	spin_unlock_irqrestore(&sync->lock, flags);
+	return ret;
+}
+
+/*
+ * __qperi_xfer_sync_sk - send a frame and wait for its response
+ * @hdev: the HCI device
+ * @skb: the frame to send if it != NULL
+ * @spec: command/response spec describing the wanted event if it != NULL
+ * @timeout: time in jiffies to wait for the wanted event
+ *
+ * Returns ERR_PTR() on failure,
+ * NULL on send-only success (@spec is NULL),
+ * the response skb the sender is waiting for.
+ */
+static struct sk_buff *__qperi_xfer_sync_sk(struct hci_dev *hdev,
+					    struct sk_buff *skb,
+					     const struct qhci_cmd_spec *spec,
+					     unsigned int timeout)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	struct qhci_sync *sync = &qbt_data->cmd_sync;
+	struct qhci_req req = { .pkt_type = PERI_EVT_PKT, .spec = spec };
+	unsigned long flags;
+	int ret = 0;
+
+	if (!skb && !spec)
+		return ERR_PTR(-EINVAL);
+
+	/* send only — no wait */
+	if (!spec) {
+		ret = hdev->send(hdev, skb);
+		if (ret < 0)
+			kfree_skb(skb);
+		return ret < 0 ? ERR_PTR(ret) : NULL;
+	}
+
+	reinit_completion(&sync->done);
+	spin_lock_irqsave(&sync->lock, flags);
+	sync->req = &req;
+	spin_unlock_irqrestore(&sync->lock, flags);
+
+	if (skb) {
+		ret = hdev->send(hdev, skb);
+		if (ret < 0) {
+			kfree_skb(skb);
+			goto out;
+		}
+	}
+
+	if (!wait_for_completion_timeout(&sync->done, timeout)) {
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	return req.req_rsp;
+
+out:
+	spin_lock_irqsave(&sync->lock, flags);
+	WRITE_ONCE(sync->req, NULL);
+	if (!IS_ERR_OR_NULL(req.req_rsp))
+		dev_kfree_skb_irq(req.req_rsp);
+	spin_unlock_irqrestore(&sync->lock, flags);
+	return ERR_PTR(ret);
+}
+
+/*
+ * __qperi_cmd_sync_sk - send a command and wait for its response
+ * @hdev: the HCI device
+ * @cmd: the command to send if it != NULL
+ * @cmd_len: length of @cmd
+ * @spec: command/response spec describing the wanted event if it != NULL
+ *
+ * Returns ERR_PTR() on failure,
+ * NULL on send-only success (@spec is NULL),
+ * the response skb the sender is waiting for.
+ */
+static struct sk_buff *__qperi_cmd_sync_sk(struct hci_dev *hdev,
+					   const void *cmd, size_t cmd_len,
+					    const struct qhci_cmd_spec *spec)
+{
+	struct sk_buff *skb = NULL;
+
+	if (cmd) {
+		skb = bt_skb_alloc(cmd_len, GFP_KERNEL);
+		if (!skb)
+			return ERR_PTR(-ENOMEM);
+		hci_skb_pkt_type(skb) = PERI_CMD_PKT;
+		skb_put_data(skb, cmd, cmd_len);
+	}
+
+	return __qperi_xfer_sync_sk(hdev, skb, spec, HCI_INIT_TIMEOUT);
+}
+
+/* PERI functions */
+
+#define __PERI_CMD_INIT_SUBSYS_0(...)
+#define __PERI_CMD_INIT_SUBSYS_1(_subsys, ...)	.subsys = (_subsys),
+
+#define __PERI_CMD_INITIALIZER(cmd, _opcode, _sub_opcode, _subsys...) {	\
+	.hdr = {							\
+		.host_id = QHCI_HOST_ID_BT,				\
+		.opcode  = cpu_to_le16(_opcode),			\
+		.plen    = sizeof(cmd) - sizeof((cmd).hdr),		\
+	},								\
+	.sub_opcode = (_sub_opcode),					\
+	CONCATENATE(__PERI_CMD_INIT_SUBSYS_, COUNT_ARGS(_subsys))(_subsys)	\
+}
+
+/* Pass 0xffff as event if no events are expected */
+#define __PERI_CMD_SPEC_INITIALIZER(_opcode, _sub_code, _events...) {	\
+	.opcode   = (_opcode),						\
+	.sub_code = (_sub_code),					\
+	.event    = { _events, 0xffff },					\
+}
+
+#define __QPERI_CHECK_CCE_PLEN(_skb, cce_type)				\
+({									\
+	cce_type *_cce_ptr;						\
+	int _err = 0;							\
+									\
+	do {								\
+		if (_skb->len < sizeof(cce_type)) {			\
+			_err = -EBADMSG;				\
+			break;						\
+		}							\
+		_cce_ptr = (void *)_skb->data;				\
+		if (_skb->len - offsetofend(cce_type, plen) !=		\
+		    _cce_ptr->plen) {					\
+			_err = -EMSGSIZE;				\
+			break;						\
+		}							\
+	} while (0);							\
+	_err;								\
+})
+
+/*
+ * qperi_get_subsys_build_info - get subsystem build info string
+ * @hdev: the HCI device to query
+ * @subsys: the subsystem to query
+ * @build_info: output build info string, allocated on success; caller frees
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int qperi_get_subsys_build_info(struct hci_dev *hdev, u8 subsys, char **build_info)
+{
+	static const struct qhci_cmd_spec spec =
+		__PERI_CMD_SPEC_INITIALIZER(PERI_OP_DOWNLOAD, PDL_GET_BUILD_INFO,
+					    PERI_EV_CMD_COMPLETE);
+	struct peri_cmd_generic cmd =
+		__PERI_CMD_INITIALIZER(cmd, PERI_OP_DOWNLOAD, PDL_GET_BUILD_INFO, subsys);
+	struct peri_cce_get_build_info *cce;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = __qperi_cmd_sync_sk(hdev, &cmd, sizeof(cmd), &spec);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	ret = __QPERI_CHECK_CCE_PLEN(skb, struct peri_cce_get_build_info);
+	if (ret)
+		goto out;
+
+	cce = (void *)skb->data;
+	if (cce->subsys != subsys) {
+		ret = -EILSEQ;
+		goto out;
+	}
+
+	*build_info = kmemdup_nul(cce->data, cce->plen, GFP_KERNEL);
+	if (!*build_info) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = 0;
+out:
+	kfree_skb(skb);
+	if (ret)
+		bt_dev_err(hdev, "get %s build info failed: %pe",
+			   qhci_subsys_name[subsys], ERR_PTR(ret));
+
+	return ret;
+}
+
+/*
+ * qperi_hci_reset - reset PERI HCI
+ * @hdev: the HCI device to reset
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int qperi_hci_reset(struct hci_dev *hdev)
+{
+	static const struct qhci_cmd_spec spec =
+		__PERI_CMD_SPEC_INITIALIZER(PERI_OP_GENERIC, PGN_PERI_RESET,
+					    PERI_EV_CMD_COMPLETE,
+					    PERI_EV_SUBSYS_PATCH_NOTIFICATION);
+	struct peri_cmd_simple cmd =
+		__PERI_CMD_INITIALIZER(cmd, PERI_OP_GENERIC, PGN_PERI_RESET);
+	const struct peri_ev_subsys_patch_notification *patch_notif_ev;
+	struct sk_buff *skb;
+	int ret = 0;
+
+	skb = __qperi_cmd_sync_sk(hdev, &cmd, sizeof(cmd), &spec);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	patch_notif_ev = (const void *)skb->data;
+	if (patch_notif_ev->subsys != QHCI_SUBSYS_PERI)
+		ret = -EILSEQ;
+
+	kfree_skb(skb);
+	if (ret)
+		bt_dev_err(hdev, "PERI HCI reset failed: %pe", ERR_PTR(ret));
+	else
+		bt_dev_info(hdev, "PERI HCI reset successfully");
+	return ret;
+}
+
+/*
+ * qperi_initiate_bt_crash - initiate a BT subsystem crash
+ * @hdev: the HCI device
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int qperi_initiate_bt_crash(struct hci_dev *hdev)
+{
+	static const struct qhci_cmd_spec spec =
+		__PERI_CMD_SPEC_INITIALIZER(PERI_OP_GENERIC, PGN_INITATE_BT_CRASH,
+					    PERI_EV_CMD_STATUS);
+	struct peri_cmd_simple cmd =
+		__PERI_CMD_INITIALIZER(cmd, PERI_OP_GENERIC, PGN_INITATE_BT_CRASH);
+	struct sk_buff *skb;
+
+	skb = __qperi_cmd_sync_sk(hdev, &cmd, sizeof(cmd), &spec);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	kfree_skb(skb);
+	bt_dev_info(hdev, "PERI initiate BT crash successfully");
+	return 0;
+}
+
+/*
+ * ============================================================================
+ * btqcom common functions
+ * ============================================================================
+ */
+
+/*
+ * btqcom_set_bdaddr - set BD address, for hdev->set_bdaddr()
+ * @hdev: the HCI device
+ * @bdaddr: the BD address to set
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int btqcom_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	int ret;
+
+	ret = __hci_reset_sync(hdev);
+	if (ret) {
+		bt_dev_err(hdev, "HCI reset before set BD address failed: %pe",
+			   ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = qbt_write_bda(hdev, bdaddr);
+
+	return ret;
+}
+
+/*
+ * btusb_do_reset_work - HCI cmd sync work function to do reset
+ * @hdev: the HCI device to reset
+ * @data: unused
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int btusb_do_reset_work(struct hci_dev *hdev, void *data __maybe_unused)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	struct btusb_qcom *xdata = btusb_qcom_xport_data(hdev);
+	struct gpio_desc *reset_gpio = xdata->reset_gpio;
+	int ret;
+
+	if (test_and_set_bit(QBTH_MISC_RESET_ACTIVE, &qbt_data->misc_flags)) {
+		bt_dev_info(hdev, "reset already in progress");
+		return 0;
+	}
+
+	if (xdata->prepare_reset)
+		xdata->prepare_reset(hdev);
+
+	if (reset_gpio) {
+		bt_dev_info(hdev, "hardware reset");
+		gpiod_set_value_cansleep(reset_gpio, 0);
+		fsleep(200 * 1000);
+		gpiod_set_value_cansleep(reset_gpio, 1);
+		return 0;
+	}
+
+	/*
+	 * SW reset and USB reset both talk to the device, so wake it once.
+	 * This is not an unbalanced PM reference since the device will reset.
+	 */
+	ret = usb_autopm_get_interface(xdata->intf);
+	if (ret) {
+		bt_dev_err(hdev, "reset: autopm get failed: %pe", ERR_PTR(ret));
+		clear_bit(QBTH_MISC_RESET_ACTIVE, &qbt_data->misc_flags);
+		return ret;
+	}
+
+	if (qbt_data->flags & QBT_FLAG_SW_RESET) {
+		if (!qdfu_sw_reset(hdev))
+			return 0;
+	}
+
+	bt_dev_info(hdev, "usb reset");
+	clear_bit(QBTH_MISC_RESET_ACTIVE, &qbt_data->misc_flags);
+	usb_queue_reset_device(xdata->intf);
+
+	return 0;
+}
+
+static void btusb_qcom_reset_sync(struct hci_dev *hdev)
+{
+	int ret;
+
+	hci_dev_lock(hdev);
+	ret = hci_cmd_sync_queue_once(hdev, btusb_do_reset_work, NULL, NULL);
+	if (ret)
+		bt_dev_err(hdev, "failed to queue reset: %pe", ERR_PTR(ret));
+	hci_dev_unlock(hdev);
+}
+
+static void btqcom_work(struct work_struct *work)
+{
+	struct btqcom_data *qbt_data = container_of(work, struct btqcom_data, work);
+
+	if (test_and_clear_bit(QBTH_WORK_RESET_HDEV, &qbt_data->work_flags))
+		btusb_qcom_reset_sync(qbt_data->hdev);
+}
+
+static void btqcom_reset_async(struct hci_dev *hdev)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+
+	set_bit(QBTH_WORK_RESET_HDEV, &qbt_data->work_flags);
+	schedule_work(&qbt_data->work);
+}
+
+/* For hdev->reset() callback */
+static void btusb_qcom_reset(struct hci_dev *hdev)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+
+	if (test_bit(QBTH_MISC_MEMDUMP_ACTIVE, &qbt_data->misc_flags)) {
+		bt_dev_info(hdev, "refuse reset due to memdump in progress");
+		return;
+	}
+
+	if (test_bit(HCI_RUNNING, &hdev->flags)) {
+		btusb_qcom_reset_sync(hdev);
+		return;
+	}
+
+	bt_dev_info(hdev, "reset directly");
+	btusb_do_reset_work(hdev, NULL);
+}
+
+/* For hdev->classify_pkt_type() callback */
+static u8 btusb_qcom_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return hci_skb_pkt_type(skb);
+}
+
+/* For hdev->shutdown() callback */
+static int btusb_qcom_shutdown(struct hci_dev *hdev)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	struct btusb_qcom *xdata = btusb_qcom_xport_data(hdev);
+	int ret = 0;
+
+	if (qbt_data->category == QBTC_CAT_MSUBSYS) {
+		ret = usb_autopm_get_interface(xdata->intf);
+		if (ret < 0) {
+			bt_dev_err(hdev, "shutdown: autopm get failed: %pe",
+				   ERR_PTR(ret));
+			return ret;
+		}
+
+		ret = qdfu_activate_remote_btss(hdev, false, 20 * 1000);
+
+		usb_autopm_put_interface(xdata->intf);
+	} else {
+		ret = __hci_reset_sync(hdev);
+		if (ret)
+			bt_dev_err(hdev, "HCI reset on shutdown failed: %pe",
+				   ERR_PTR(ret));
+	}
+
+	if (!ret)
+		bt_dev_info(hdev, "QCOM shutdown succeeded");
+
+	return ret;
+}
+
+/*
+ * ============================================================================
+ * Msubsys memdump design
+ * ============================================================================
+ */
+
+/*
+ * Design compatible with BT-only BTC:
+ *
+ * +--------------+----------+--------------+----------+     +--------------+----------+
+ * | subsys_A     | subsys_A | subsys_B     | subsys_B | ... | subsys_N     | subsys_N |
+ * | 512B header  | memdump  | 512B header  | memdump  |     | 512B header  | memdump  |
+ * | by dmp_hdr() |   data   | (appended    |   data   |     | (appended    |   data   |
+ * |              |          |  as data)    |          |     |  as data)    |          |
+ * +--------------+----------+--------------+----------+     +--------------+----------+
+ *
+ * 1) All subsystems' memdumps are collected into a SINGLE file.
+ * 2) Each subsys_X header records the size of its own memdump data.
+ * 3) On the 1st segment of the 1st subsys: call hci_devcd_init() with
+ *    dump_size — for BT-only BTC, the dump_size carried in the segment
+ *    itself; for msubsys BTC, the sum of the max dump size of every
+ *    subsystem it has.
+ * 4) On the 1st segment of the 2nd and later subsys: call hci_devcd_append()
+ *    to append its 512B header as ordinary memdump data.
+ * 5) On the last segment of a subsys: call hci_devcd_complete() if there is
+ *    no pending subsystem memdump left to collect.
+ * 6) On the hardware error event (either PERI or BT), which always comes
+ *    after all memdumps have been reported by the BTC: call
+ *    hci_devcd_complete() there if it has not been called yet, since a
+ *    subsystem's memdump is optional.
+ */
+
+/*
+ * For BT-only BTC, or when the memdump comes from the BT channel
+ * (HCI_EVENT_PKT or HCI_ACLDATA_PKT) on a msubsys BTC, there is no real
+ * subsys — use the pseudo QHCI_SUBSYS_INVALID for these cases.
+ */
+
+static const u32 btqcom_memdump_maxsize[] = {
+	[QHCI_SUBSYS_PERI]	= SZ_256K,
+	[QHCI_SUBSYS_BT]	= SZ_1M,
+	[QHCI_SUBSYS_UWB]	= 0,
+	[QHCI_SUBSYS_TMEL]	= SZ_256K,
+	[QHCI_SUBSYS_INVALID]	= SZ_1M,
+};
+
+/* each subsys's memdump pending flag in struct btqcom_data's md_flags */
+static const u32 btqcom_memdump_flags[] = {
+	[QHCI_SUBSYS_PERI]	= QMD_FLAG_PENDING_PERI,
+	[QHCI_SUBSYS_BT]	= QMD_FLAG_PENDING_BT,
+	[QHCI_SUBSYS_UWB]	= 0,
+	[QHCI_SUBSYS_TMEL]	= QMD_FLAG_PENDING_TMEL,
+	[QHCI_SUBSYS_INVALID]	= QMD_FLAG_PENDING_BT,
+};
+
+/* whether subsys @s is enabled for memdump collection */
+#define BTQCOM_SUBSYS_MEMDUMP_ENABLED(s) \
+	((s) == QHCI_SUBSYS_PERI || \
+	 (s) == QHCI_SUBSYS_BT)
+
+/*
+ * btqcom_memdump_hdr - write the common memdump text header
+ * @hdev: the HCI device the memdump belongs to
+ * @skb: the devcoredump skb to append the header to
+ */
+static void btqcom_memdump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	struct btqcom_memdump *md = &qbt_data->md;
+	const char *vendor = "Qualcomm";
+	/* don't use skb_tailroom(): observed to differ from requested alloc_size - skb->len */
+	int tail_size = MAX_HCI_DEVCD_HDR_SIZE - skb->len;
+	struct qbtc_subsys_data *subsys_data;
+	struct qhci_btc_ver *btc_ver;
+	const char *build_info;
+	char buf[MAX_HCI_DEVCD_HDR_SIZE];
+	u16 board_id;
+	int len;
+
+	/* 1 char + '\n' at least */
+	if (tail_size < 2)
+		return;
+
+	len  = snprintf(buf, sizeof(buf), "Driver: %s\n", qbt_data->drv_name);
+	len += snprintf(buf + len, sizeof(buf) - len, "Vendor: %s\n", vendor);
+	len += snprintf(buf + len, sizeof(buf) - len, "Controller Name: %s\n",
+			qbt_data->btc_name);
+	len += snprintf(buf + len, sizeof(buf) - len, "Dump Size: %u\n", md->size);
+	len += snprintf(buf + len, sizeof(buf) - len, "Channel: %s\n",
+			qhci_pkt_type_name(md->from));
+	len += snprintf(buf + len, sizeof(buf) - len, "Subsys: %s\n",
+			qhci_subsys_name[md->subsys]);
+
+	switch (md->subsys) {
+	case QHCI_SUBSYS_PERI:
+		subsys_data = &qbt_data->subsys[QBTC_SUBSYS_PERI];
+		btc_ver = &subsys_data->ver;
+		board_id = subsys_data->board_id;
+		build_info = subsys_data->build_info;
+		break;
+	case QHCI_SUBSYS_TMEL:
+		subsys_data = &qbt_data->subsys[QBTC_SUBSYS_TMEL];
+		btc_ver = &subsys_data->ver;
+		board_id = subsys_data->board_id;
+		build_info = subsys_data->build_info;
+		break;
+	default:
+		btc_ver = &qbt_data->ver;
+		board_id = qbt_data->board_id;
+		build_info = qbt_data->build_info;
+		break;
+	}
+
+	len += snprintf(buf + len, sizeof(buf) - len, "SoC Version: 0x%08x\n",
+			btc_ver->soc_ver);
+	len += snprintf(buf + len, sizeof(buf) - len, "ROM Version: 0x%04x\n",
+			btc_ver->rom_ver);
+	len += snprintf(buf + len, sizeof(buf) - len, "Patch Version: 0x%04x\n",
+			btc_ver->patch_ver);
+	len += snprintf(buf + len, sizeof(buf) - len, "Board ID: 0x%04x\n",
+			board_id);
+	len += snprintf(buf + len, sizeof(buf) - len, "Firmware Version: %s\n",
+			build_info);
+
+	if (len > tail_size) {
+		bt_dev_warn(hdev, "Common dump header truncated (%d -> %d bytes)",
+			    len, tail_size);
+		buf[tail_size - 1] = '\n';
+		len = tail_size;
+	}
+
+	skb_put_data(skb, buf, len);
+}
+
+/*
+ * btusb_qcom_memdump_hdr - write the devcoredump text header for BTUSB
+ * @hdev: the HCI device the memdump belongs to
+ * @skb: the devcoredump skb to append the header to
+ *
+ * Used as the dmp_hdr_t callback for hci_devcd_register().
+ */
+static void btusb_qcom_memdump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btusb_qcom *xdata = btusb_qcom_xport_data(hdev);
+	char *pad;
+	int pad_len;
+	int tail_size;
+	char buf[64];
+	int len;
+
+	btqcom_memdump_hdr(hdev, skb);
+
+	tail_size = MAX_HCI_DEVCD_HDR_SIZE - skb->len;
+	/* 1 char + '\n' at least */
+	if (tail_size < 2)
+		return;
+
+	len  = snprintf(buf, sizeof(buf), "VID: 0x%04x\n", xdata->idVendor);
+	len += snprintf(buf + len, sizeof(buf) - len, "PID: 0x%04x\n",
+			xdata->idProduct);
+
+	if (len > tail_size) {
+		bt_dev_warn(hdev, "dump header truncated (%d -> %d bytes)",
+			    len, tail_size);
+		buf[tail_size - 1] = '\n';
+		len = tail_size;
+	}
+
+	skb_put_data(skb, buf, len);
+
+	tail_size = MAX_HCI_DEVCD_HDR_SIZE - skb->len;
+	/* min tail_size for the end marker (sizeof() - '\0') + 1 char + '\n' */
+	if (tail_size < (int)sizeof(HCI_DEVCD_HDR_END) + 1) {
+		bt_dev_warn(hdev, "memdump header may be truncated");
+		return;
+	}
+
+	pad_len = tail_size - (int)(sizeof(HCI_DEVCD_HDR_END) - 1);
+	pad = skb_put(skb, pad_len);
+	memset(pad, 'P', pad_len - 1);
+	pad[pad_len - 1] = '\n';
+}
+
+/* Used as the notify_change_t callback for hci_devcd_register(). */
+static void btqcom_memdump_notify(struct hci_dev *hdev, int state)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	enum devcoredump_state old_state = qbt_data->md_state;
+
+	bt_dev_dbg(hdev, "QCOM memdump state: %s -> %s",
+		   hci_devcd_state_name(old_state),
+		    hci_devcd_state_name(state));
+
+	qbt_data->md_state = state;
+}
+
+/* Used as the coredump_t callback for hci_devcd_register(). */
+static void btusb_qcom_trigger_memdump(struct hci_dev *hdev)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+
+	if (qbt_data->category == QBTC_CAT_MSUBSYS)
+		qperi_initiate_bt_crash(hdev);
+	else
+		qbt_error_fatal_cmd(hdev);
+}
+
+/* handle received memdump frame here*/
+
+static inline void btqcom_reset_memdump(struct btqcom_memdump *md)
+{
+	memset(md, 0x00, sizeof(*md));
+	md->subsys  = QHCI_SUBSYS_INVALID;
+}
+
+/*
+ * btqcom_submit_memdump - submit one memdump segment to HCI devcoredump
+ * @hdev: the HCI device the memdump comes from
+ * @skb: the memdump segment payload
+ *
+ * See the "Msubsys memdump design" block above for the overall scheme this
+ * implements.
+ *
+ * Return: 0 on success,
+ *	1 if the memdump ended normally,
+ *	a negative errno on failure.
+ */
+static int btqcom_submit_memdump(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	struct btqcom_memdump *md = &qbt_data->md;
+	unsigned int seg_len = skb->len;
+	unsigned int dump_size = 0;
+	struct sk_buff *hdr_skb = NULL;
+	bool is_first_subsys = false;
+	int ret = 0;
+
+	if (md->seqno == 0) {
+		if (!test_and_set_bit(QBTH_MISC_MEMDUMP_ACTIVE, &qbt_data->misc_flags)) {
+			is_first_subsys = true;
+			if (qbt_data->category == QBTC_CAT_MSUBSYS) {
+				qbt_data->md_flags = QMD_FLAG_PENDING_BT | QMD_FLAG_PENDING_PERI;
+				dump_size = btqcom_memdump_maxsize[QHCI_SUBSYS_BT] +
+					    MAX_HCI_DEVCD_HDR_SIZE +
+					    btqcom_memdump_maxsize[QHCI_SUBSYS_PERI];
+
+				if (qbt_data->flags & QBT_FLAG_SUBSYS_TMEL) {
+					qbt_data->md_flags |= QMD_FLAG_PENDING_TMEL;
+					dump_size += MAX_HCI_DEVCD_HDR_SIZE +
+						     btqcom_memdump_maxsize[QHCI_SUBSYS_TMEL];
+				}
+			} else {
+				qbt_data->md_flags = btqcom_memdump_flags[QHCI_SUBSYS_INVALID];
+				dump_size = md->size;
+			}
+		}
+
+		if (is_first_subsys) {
+			bt_dev_dbg(hdev, "md_flags: 0x%lx", qbt_data->md_flags);
+			ret = hci_devcd_init(hdev, dump_size);
+			if (ret) {
+				dev_kfree_skb_irq(skb);
+				bt_dev_err(hdev, "memdump init failed: %pe",
+					   ERR_PTR(ret));
+				return ret;
+			}
+		} else if (qbt_data->md_flags) {
+			hdr_skb = alloc_skb(MAX_HCI_DEVCD_HDR_SIZE, GFP_ATOMIC);
+			if (hdr_skb) {
+				btqcom_memdump_hdr(hdev, hdr_skb);
+				if (hdr_skb->len < MAX_HCI_DEVCD_HDR_SIZE)
+					skb_put_zero(hdr_skb,
+						     MAX_HCI_DEVCD_HDR_SIZE - hdr_skb->len);
+				ret = hci_devcd_append(hdev, hdr_skb);
+			} else {
+				ret = -ENOMEM;
+			}
+			if (ret) {
+				hci_devcd_abort(hdev);
+				dev_kfree_skb_irq(skb);
+				bt_dev_err(hdev, "append memdump header failed: %pe",
+					   ERR_PTR(ret));
+				return ret;
+			}
+		} else {
+			ret = -EILSEQ;
+			dev_kfree_skb_irq(skb);
+			bt_dev_err(hdev, "refuse %s memdump: previous memdump already aborted",
+				   qhci_subsys_name[md->subsys]);
+			return ret;
+		}
+	}
+
+	ret = hci_devcd_append(hdev, skb);
+	if (ret) {
+		hci_devcd_abort(hdev);
+		bt_dev_err(hdev, "append memdump failed: %pe", ERR_PTR(ret));
+		return ret;
+	}
+
+	md->rx_size += seg_len;
+	if (md->seqno == QHCI_MEMDUMP_SEQ_LAST) {
+		if (md->rx_size == md->size)
+			bt_dev_info(hdev, "%s memdump complete: All collected",
+				    qhci_subsys_name[md->subsys]);
+		else
+			bt_dev_warn(hdev, "%s memdump complete: Partial collected %u/%u",
+				    qhci_subsys_name[md->subsys], md->rx_size, md->size);
+
+		qbt_data->md_flags &= ~btqcom_memdump_flags[md->subsys];
+		if (qbt_data->md_flags) {
+			btqcom_reset_memdump(md);
+			md->seqno = QHCI_MEMDUMP_SEQ_LAST;
+			bt_dev_dbg(hdev, "md_flags: 0x%lx", qbt_data->md_flags);
+			return 0;
+		}
+
+		ret = hci_devcd_complete(hdev);
+		if (ret) {
+			hci_devcd_abort(hdev);
+			bt_dev_err(hdev, "memdump complete failed: %pe",
+				   ERR_PTR(ret));
+		} else {
+			bt_dev_info(hdev, "ALL memdump completed");
+			ret = 1;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * btqcom_collect_memdump - parse and collect one memdump segment from @skb
+ * @hdev: the HCI device the @skb comes from
+ * @skb: the received frame, possibly a memdump segment
+ *
+ * Return: 0 if @skb is not a memdump frame,
+ *	1 if @skb was consumed as a memdump segment,
+ *	a negative errno on malformed memdump segment.
+ */
+static int btqcom_collect_memdump(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	struct btqcom_memdump *md = &qbt_data->md;
+	const struct qhci_memdump_vse *vse = NULL;
+	const unsigned char *data = skb->data;
+	u8 pkt_type = hci_skb_pkt_type(skb);
+	u8 md_ev_class = 0;
+	u8 md_ev_type = 0;
+	unsigned int len = skb->len;
+	unsigned int skip_len = 0;
+	u32 dump_size = 0;
+	u16 seq_no;
+	int subsys = QHCI_SUBSYS_INVALID;
+	int ret = 0;
+
+	switch (pkt_type) {
+	case HCI_EVENT_PKT:
+		md_ev_class = QBT_VSE_CLASS_DATALOG;
+		md_ev_type  = QBT_VSE_TYPE_MEMDUMP;
+		break;
+	case PERI_EVT_PKT:
+		skip_len = sizeof_field(struct peri_evt_hdr, host_id);
+		md_ev_class = EV_CLASS_PERI;
+		md_ev_type  = PERI_EV_CRASH_DUMP_MEM;
+		break;
+	case HCI_ACLDATA_PKT:
+		if (hci_handle(__le16_to_cpu(hci_acl_hdr(skb)->handle)) !=
+		    QBT_HANDLE_MEMDUMP)
+			return 0;
+		skip_len = HCI_ACL_HDR_SIZE;
+		md_ev_class = QBT_VSE_CLASS_DATALOG;
+		md_ev_type  = QBT_VSE_TYPE_MEMDUMP;
+		break;
+	case PERI_ACL_PKT:
+		if (qperi_acl_handle(skb) != QPERI_HANDLE_MEMDUMP)
+			return 0;
+		skip_len = PERI_ACL_HDR_SIZE;
+		md_ev_class = EV_CLASS_PERI;
+		md_ev_type  = PERI_EV_CRASH_DUMP_MEM;
+		break;
+	default:
+		return 0;
+	}
+
+	data += skip_len;
+	len  -= skip_len;
+
+	if (len < offsetofend(struct qhci_memdump_vse, ev_type))
+		return 0;
+
+	vse = (const struct qhci_memdump_vse *)data;
+	if (vse->evt != HCI_EV_VENDOR ||
+	    vse->ev_class != md_ev_class ||
+	    vse->ev_type != md_ev_type)
+		return 0;
+
+	/* Signature matched: always consumed from here — either a good
+	 * frame (continues below) or a bad one (goto out_abort_md).
+	 */
+	ret = 1;
+	if (len < offsetofend(struct qhci_memdump_vse, subsys)) {
+		bt_dev_err(hdev, "bad memdump segment: no subsys");
+		ret = -EILSEQ;
+		goto out_abort_md;
+	}
+
+	if (pkt_type == PERI_EVT_PKT || pkt_type == PERI_ACL_PKT) {
+		if (!BTQCOM_SUBSYS_MEMDUMP_ENABLED(vse->subsys))
+			return 0;
+		subsys = vse->subsys;
+	}
+
+	seq_no = le16_to_cpu(vse->seqno);
+	if (seq_no == 0) {
+		if (len < offsetofend(struct qhci_memdump_vse, dump_size)) {
+			bt_dev_err(hdev, "bad first memdump segment: no dump_size");
+			ret = -EILSEQ;
+			goto out_abort_md;
+		}
+
+		dump_size = le32_to_cpu(vse->dump_size);
+		bt_dev_info(hdev, "memdump size to collect: %u", dump_size);
+		if (!dump_size || dump_size > btqcom_memdump_maxsize[subsys]) {
+			bt_dev_err(hdev, "wrong memdump dump_size: %u", dump_size);
+			ret = -EILSEQ;
+			goto out_abort_md;
+		}
+
+		btqcom_reset_memdump(md);
+		md->from   = pkt_type;
+		md->subsys = subsys;
+		md->size   = dump_size;
+
+	} else {
+		if (md->subsys != subsys) {
+			bt_dev_err(hdev, "wrong memdump subsys: expected(%d), coming(%d)",
+				   md->subsys, subsys);
+			ret = -EILSEQ;
+			goto out_abort_md;
+		}
+
+		if (seq_no != QHCI_MEMDUMP_SEQ_LAST && seq_no != md->seqno) {
+			bt_dev_err(hdev, "wrong memdump seqno: expected(%u), coming(%u)",
+				   md->seqno, seq_no);
+			ret = -EILSEQ;
+			goto out_abort_md;
+		}
+	}
+
+	if (seq_no == QHCI_MEMDUMP_SEQ_LAST)
+		md->seqno = QHCI_MEMDUMP_SEQ_LAST;
+
+	/* a good segment: trim to payload before submitting */
+	if (seq_no)
+		skb_pull(skb, vse->segdata - skb->data);
+	else
+		skb_pull(skb, vse->first_segdata - skb->data);
+
+	ret = btqcom_submit_memdump(hdev, skb);
+	if (!ret) {
+		if (md->seqno == QHCI_MEMDUMP_SEQ_LAST)
+			md->seqno = 0;
+		else
+			md->seqno = seq_no + 1;
+		return 1;
+	}
+	ret = 1;
+	goto out_reset_md;
+
+out_abort_md:
+	if (qbt_data->md_flags) {
+		hci_devcd_abort(hdev);
+		bt_dev_err(hdev, "abort memdump");
+	}
+
+out_reset_md:
+	btqcom_reset_memdump(md);
+	qbt_data->md_flags = 0;
+
+	return ret;
+}
+
+/*
+ * qbt_handle_hwerror_evt - handle a BT hardware error event
+ * @hdev: the HCI device the @skb comes from
+ * @skb: the received frame to check and handle
+ *
+ * Forces hci_devcd_complete() if a memdump is still pending, and schedules
+ * an async reset if a memdump ever happened.
+ *
+ * Return: 0 if not a hardware error event, or a standalone one,
+ *	1 if a hardware error event due to memdump,
+ *	a negative errno if the event is malformed.
+ */
+static int qbt_handle_hwerror_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	const struct hci_ev_hardware_error *hwerr_evt = NULL;
+
+	if (hci_event_hdr(skb)->evt != HCI_EV_HARDWARE_ERROR)
+		return 0;
+
+	if (skb->len == HCI_EVENT_HDR_SIZE + sizeof(*hwerr_evt)) {
+		hwerr_evt = (const void *)(skb->data + HCI_EVENT_HDR_SIZE);
+		bt_dev_dbg(hdev, "BT hardware error event (0x%02x)",
+			   hwerr_evt->code);
+	} else {
+		bt_dev_err(hdev, "BT hardware error event too short (%u bytes)",
+			   skb->len);
+	}
+
+	if (qbt_data->md_flags) {
+		int res;
+
+		res = hci_devcd_complete(hdev);
+		if (res)
+			bt_dev_err(hdev, "memdump complete on BT hw error event failed: %pe",
+				   ERR_PTR(res));
+		else
+			bt_dev_info(hdev, "memdump completed on BT hw error event");
+
+		qbt_data->md_flags = 0;
+	}
+
+	if (!test_and_clear_bit(QBTH_MISC_MEMDUMP_ACTIVE, &qbt_data->misc_flags))
+		return !hwerr_evt ? -EBADMSG : 0;
+
+	dev_kfree_skb_irq(skb);
+	bt_dev_info(hdev, "drop BT hw error event due to reset after memdump");
+	btqcom_reset_async(hdev);
+
+	return 1;
+}
+
+/*
+ * qperi_handle_hwerror_evt - handle a PERI hardware error event
+ * @hdev: the HCI device the @skb comes from
+ * @skb: the received frame to check and handle
+ *
+ * Forces hci_devcd_complete() if a memdump is still pending, and schedules
+ * an async reset if a memdump ever happened, otherwise converts to a BT
+ * hardware error event and passes it upward.
+ *
+ * Return: 0 if not a PERI hardware error event, or a standalone one,
+ *	1 if a hardware error event due to memdump.
+ */
+static int qperi_handle_hwerror_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	const struct peri_ev_hardware_error *hwerr_evt = (const void *)skb->data;
+	/* Unspecified Error */
+	u8 hwerr_code = 0x1f;
+
+	if (hwerr_evt->ev_class != EV_CLASS_PERI ||
+	    hwerr_evt->ev_type != PERI_EV_HARDWARE_ERROR)
+		return 0;
+
+	if (skb->len == sizeof(*hwerr_evt)) {
+		hwerr_code = hwerr_evt->code;
+		bt_dev_info(hdev, "PERI hardware error (0x%02x)", hwerr_code);
+	} else {
+		hwerr_evt = NULL;
+		bt_dev_err(hdev, "PERI hw error event too short (%u bytes)",
+			   skb->len);
+	}
+
+	if (qbt_data->md_flags) {
+		int res;
+
+		res = hci_devcd_complete(hdev);
+		if (res)
+			bt_dev_err(hdev, "memdump complete on PERI hw error event failed: %pe",
+				   ERR_PTR(res));
+		else
+			bt_dev_info(hdev, "memdump completed on PERI hw error event");
+
+		qbt_data->md_flags = 0;
+	}
+
+	if (!test_and_clear_bit(QBTH_MISC_MEMDUMP_ACTIVE, &qbt_data->misc_flags)) {
+		struct hci_event_hdr *hdr;
+
+		skb_trim(skb, 0);
+		hdr = skb_put(skb, sizeof(*hdr));
+		hdr->evt = HCI_EV_HARDWARE_ERROR;
+		hdr->plen = sizeof(hwerr_code);
+		skb_put_u8(skb, hwerr_code);
+		hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+
+		bt_dev_dbg(hdev, "BT hardware error event (0x%02x) converted from PERI",
+			   hwerr_code);
+		return 0;
+	}
+
+	dev_kfree_skb_irq(skb);
+	bt_dev_info(hdev, "drop PERI hw error event due to reset after memdump");
+	btqcom_reset_async(hdev);
+
+	return 1;
+}
+
+/*
+ * btqcom_recv_frame - common recv_frame path for every frame
+ * @hdev: the HCI device the @skb comes from
+ * @skb: the assembled frame to check and handle
+ *
+ * Every assembled frame lands here first, filters out non-BT frames, and
+ * supports cmd sync, memdump, and hardware error event handling currently.
+ *
+ * Return: 0 if @skb was not consumed,
+ *	1 if @skb was consumed,
+ *	a negative errno on a malformed frame.
+ */
+static int btqcom_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	u8 pkt_type = hci_skb_pkt_type(skb);
+	int ret = 0;
+
+	switch (pkt_type) {
+	case HCI_EVENT_PKT:
+		if (hci_event_hdr(skb)->evt == HCI_EV_VENDOR &&
+		    skb->len < QBT_VSE_COMM_SIZE) {
+			bt_dev_err(hdev, "VSE too short (%u bytes)", skb->len);
+			ret = -EBADMSG;
+			goto out;
+		}
+
+		ret = qbt_handle_hwerror_evt(hdev, skb);
+		if (ret)
+			goto out;
+
+		break;
+	case PERI_EVT_PKT:
+		if (skb->len < PERI_EV_COMM_SIZE) {
+			bt_dev_err(hdev, "PERI event too short (%u bytes)", skb->len);
+			ret = -EBADMSG;
+			goto out_diag;
+		}
+
+		ret = peri_sync_recv(hdev, &qbt_data->cmd_sync, skb);
+		if (ret < 0)
+			goto out_diag;
+		else if (ret > 0)
+			goto out;
+
+		ret = qperi_handle_hwerror_evt(hdev, skb);
+		if (ret < 0)
+			goto out_diag;
+		else if (ret > 0)
+			goto out;
+
+		break;
+	case HCI_ACLDATA_PKT:
+	case PERI_ACL_PKT:
+		break;
+	default:
+		goto out;
+	}
+
+	if (test_bit(QBTH_MISC_MEMDUMP_READY, &qbt_data->misc_flags)) {
+		ret = btqcom_collect_memdump(hdev, skb);
+		if (ret)
+			goto out;
+	}
+
+out_diag:
+	pkt_type = hci_skb_pkt_type(skb);
+	switch (pkt_type) {
+	case PERI_EVT_PKT:
+	case PERI_ACL_PKT:
+		btqcom_recv_diag(hdev, skb);
+		ret = 1;
+		break;
+	case HCI_ACLDATA_PKT: {
+		u16 handle = hci_handle(__le16_to_cpu(hci_acl_hdr(skb)->handle));
+
+		if (handle == QBT_HANDLE_ENHANCED_LOGGING) {
+			btqcom_recv_diag(hdev, skb);
+			ret = 1;
+		} else if (handle == QBT_HANDLE_MEMDUMP) {
+			btqcom_recv_diag(hdev, skb);
+			ret = 1;
+		}
+		break;
+	}
+	default:
+		break;
+	}
+
+out:
+	return ret;
+}
+
+/*
+ * ============================================================================
+ * QDFU firmwre downloading
+ * ============================================================================
+ */
+
+#define QBT_FW_PATH_MAX  96
+
+enum qbt_fw_type {
+	QBT_FW_PATCH,
+	QBT_FW_NVM,
+	QBT_FW_MAX,
+};
+
+#define QBT_PATCH_TYPE_TLV		0x01
+#define QBT_NVM_TYPE_TLV		0x02
+struct qbt_tlv_file_hdr {
+	u8	type;
+	u8	length[3];
+} __packed;
+
+struct qbt_patch_tlv_hdr {
+	struct  qbt_tlv_file_hdr tlv_hdr;
+	__le32	total_len;
+	__le32	patch_data_len;
+	u8	sign_ver;
+	u8	sign_algo;
+	u8	download_cfg;
+	u8	image_type;
+	__le16	product_id;
+	__le16	rom_ver;
+	__le16	patch_ver;
+	u8	reserved1[2];
+	__le32	anti_rollback_ver;
+	__le32	serial_low;
+	__le16	serial_high;
+	u8	debug_option;
+	u8	reserved2;
+	__le32	entry_addr;
+} __packed;
+
+struct qbt_nvm_tlv_hdr {
+	struct  qbt_tlv_file_hdr tlv_hdr;
+} __packed;
+
+/*
+ * struct qdfu_dlfw_cfg - QDFU firmware download config
+ * @desc: short description for logging (e.g. "PERI patch", "PERI NVM")
+ * @fw_type: QBT_PATCH_TYPE_TLV or QBT_NVM_TYPE_TLV
+ * @ready_flag: QDFU_BT_STATE_* flag that marks fw downloaded or not
+ * @hdr_size: expected TLV header size for @fw_type
+ * @request: QDFU_BT_CMD_VSC_REQ_DOWNLOAD_(LOCAL|REMOTE)
+ * @settle_us: time to wait after download for the controller to settle
+ * @get_fwpath: build firmware file path, return number of paths or error
+ * @check_fw: check firmware, return 0 on success or a negative errno
+ * @send_fw: send firmware, return 0 on success or a negative errno
+ * @get_settle_us: get the time to wait for BTC to settle
+ * @post_setup: run after download, return 0 on success or a negative errno
+ */
+struct qdfu_dlfw_cfg {
+	const char	*desc;
+	u8		fw_type;
+	u8		ready_flag;
+	u8		hdr_size;
+	u8		request;
+	u32		settle_us;
+	int (*get_fwpath)(struct hci_dev *hdev, const struct qdfu_dlfw_cfg *fwcfg,
+			  const struct qbtc_info *info, const struct qdfu_bt_id *ctrl_id,
+			  char *fwname, size_t max_size);
+	int (*check_fw)(struct hci_dev *hdev, const struct qdfu_dlfw_cfg *fwcfg,
+			const struct qbtc_info *info, const struct qdfu_bt_id *ctrl_id,
+			const struct firmware *fw);
+	int (*send_fw)(struct hci_dev *hdev, const struct qdfu_dlfw_cfg *fwcfg,
+		       const struct qbtc_info *info, const struct qdfu_bt_id *ctrl_id,
+		       const struct firmware *fw);
+	int (*get_settle_us)(struct hci_dev *hdev, const struct qdfu_dlfw_cfg *fwcfg,
+			     const struct qbtc_info *info, const struct qdfu_bt_id *ctrl_id);
+	int (*post_setup)(struct hci_dev *hdev, const struct qdfu_dlfw_cfg *fwcfg,
+			  const struct qbtc_info *info, const struct qdfu_bt_id *ctrl_id);
+};
+
+static int btusb_get_subsys(const struct qdfu_dlfw_cfg *fwcfg);
+
+static void qhci_to_qdfu_id(struct qdfu_bt_id *dfu_id,
+			    const struct qhci_btc_ver *ver, u16 board_id)
+{
+	dfu_id->rom_version   = (u32)ver->product_id << 16 | ver->rom_ver;
+	dfu_id->patch_version = ver->patch_ver;
+	dfu_id->soc_id        = ver->soc_ver;
+	dfu_id->board_id      = board_id;
+}
+
+static void qdfu_to_qhci_id(const struct qdfu_bt_id *dfu_id,
+			    struct qhci_btc_ver *ver, u16 *board_id)
+{
+	ver->product_id = upper_16_bits(dfu_id->rom_version);
+	ver->rom_ver    = lower_16_bits(dfu_id->rom_version);
+	ver->patch_ver  = dfu_id->patch_version;
+	ver->soc_ver    = dfu_id->soc_id;
+	*board_id       = dfu_id->board_id;
+}
+
+static int btusb_get_qdfu_id_hci(struct hci_dev *hdev,
+				 struct qdfu_bt_id *dfu_id)
+{
+	struct qhci_btc_ver hci_ver;
+	u16 board_id;
+	int ret;
+
+	ret = qbt_edl_patch_getver(hdev, &hci_ver);
+	if (ret)
+		return ret;
+
+	ret = qbt_edl_get_board_id(hdev, &board_id);
+	if (ret)
+		return ret;
+
+	qhci_to_qdfu_id(dfu_id, &hci_ver, board_id);
+
+	return 0;
+}
+
+static int btqcom_post_setup_unified_bt(struct hci_dev *hdev)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	u8 btc_log_enabled = !(qbt_data->flags & QBT_FLAG_DISABLE_BTC_LOG);
+	char *build_info = NULL;
+	int res;
+
+	qbt_config_btc_logging(hdev, btc_log_enabled);
+
+	if (qbt_data->flags & QBT_FLAG_ENABLE_AOSP_EXT)
+		hci_set_aosp_capable(hdev);
+
+	if (qbt_data->flags & QBT_FLAG_ENABLE_MSFT_EXT)
+		hci_set_msft_opcode(hdev, 0xFD70);
+
+	res = qbt_edl_get_build_info(hdev, &build_info);
+	if (!res) {
+		strscpy(qbt_data->build_info, build_info,
+			sizeof(qbt_data->build_info));
+		bt_dev_info(hdev, "BT Build Info: %s", build_info);
+		kfree(build_info);
+	}
+
+	res = __hci_reset_sync(hdev);
+	if (res)
+		bt_dev_err(hdev, "HCI reset failed: %pe", ERR_PTR(res));
+	else
+		bt_dev_dbg(hdev, "QCOM unified BT post setup done");
+
+	return res;
+}
+
+static const char *btusb_get_fw_folder(const struct qbtc_info *info,
+				       const struct qdfu_bt_id *id)
+{
+	const char *fw_folder = "qca";
+	const struct qbtc_bid_fwdir *custom_fwdir;
+
+	if (info->fw_dir)
+		fw_folder = info->fw_dir;
+
+	if (!info->custom_fw_table)
+		return fw_folder;
+
+	for (custom_fwdir = info->custom_fw_table; custom_fwdir->board_id; custom_fwdir++) {
+		if (custom_fwdir->board_id == id->board_id) {
+			fw_folder = custom_fwdir->fw_dir;
+			break;
+		}
+	}
+
+	return fw_folder;
+}
+
+/*
+ * btusb_get_patch_path - build the patch firmware file path
+ * @hdev: the HCI device to build the path for
+ * @fwcfg: the firmware download config
+ * @info: BTC info for this hdev
+ * @ctrl_id: BTC QDFU ID
+ * @fwname: output buffer for the built path
+ * @max_size: size of @fwname
+ *
+ * Return: 1 path written into @fwname, or a negative errno on failure.
+ */
+static int btusb_get_patch_path(struct hci_dev *hdev,
+				const struct qdfu_dlfw_cfg *fwcfg,
+				 const struct qbtc_info *info,
+				 const struct qdfu_bt_id *ctrl_id,
+				 char *fwname, size_t max_size)
+{
+	const char *fw_folder = btusb_get_fw_folder(info, ctrl_id);
+	int subsys;
+	int len;
+
+	subsys = btusb_get_subsys(fwcfg);
+
+	if (subsys == QBTC_SUBSYS_INVALID) {
+		/* BT function unit. */
+		len = snprintf(fwname, max_size, "%s/rampatch_usb_%08x.bin",
+			       fw_folder, ctrl_id->rom_version);
+		goto out;
+	}
+
+	switch (subsys) {
+	case QBTC_SUBSYS_PERI:
+		len = snprintf(fwname, max_size, "%s/peripatch_usb_%08x.bin",
+			       fw_folder, ctrl_id->rom_version);
+		break;
+	case QBTC_SUBSYS_TMEL:
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
+	}
+
+out:
+	if (len >= max_size)
+		return -ENAMETOOLONG;
+
+	return 1;
+}
+
+/*
+ * btusb_get_nvm_path - build the NVM firmware file path(s)
+ * @hdev: the HCI device to build the path for
+ * @fwcfg: the firmware download config
+ * @info: BTC info for this hdev
+ * @ctrl_id: BTC QDFU ID
+ * @fwname: output buffer for the built path(s)
+ * @max_size: size of @fwname
+ *
+ * @fwname may hold two NUL-terminated paths back-to-back: a board-ID path
+ * followed by a fallback path, when NVM fallback is enabled.
+ *
+ * Return: number of paths (1 or 2) written into @fwname, or a negative
+ *	errno on failure.
+ */
+static int btusb_get_nvm_path(struct hci_dev *hdev,
+			      const struct qdfu_dlfw_cfg *fwcfg,
+			       const struct qbtc_info *info,
+			       const struct qdfu_bt_id *ctrl_id,
+			       char *fwname, size_t max_size)
+{
+	const char *fw_folder = btusb_get_fw_folder(info, ctrl_id);
+	int subsys;
+	int len = 0;
+	const char *foundry_str = NULL;
+	const char *prefix = NULL;
+	bool has_bid = false;
+	bool need_fb = false;
+	char fw_fb[QBT_FW_PATH_MAX] = { 0 };
+
+	subsys = btusb_get_subsys(fwcfg);
+	if (subsys == QBTC_SUBSYS_INVALID) {
+		/* BT function unit. */
+		prefix = "nvm_usb";
+	} else {
+		switch (subsys) {
+		case QBTC_SUBSYS_PERI:
+			prefix = "perinvm_usb";
+			break;
+		case QBTC_SUBSYS_TMEL:
+			return -EOPNOTSUPP;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (info->flags & QBT_FLAG_MULTI_FOUNDRY) {
+		u8 foundry = FIELD_GET(GENMASK(15, 12), ctrl_id->soc_id);
+
+		switch (foundry) {
+		/* GlobalFoundries */
+		case 0x01:
+			foundry_str = "_gf";
+			break;
+		default:
+			break;
+		}
+	}
+
+	if ((info->flags & QBT_FLAG_BID_NVM) && ctrl_id->board_id) {
+		has_bid = true;
+		if (info->flags & QBT_FLAG_NVM_FALLBACK)
+			need_fb = true;
+	}
+
+	len = snprintf(fwname, max_size, "%s/%s_%08x", fw_folder, prefix, ctrl_id->rom_version);
+	if (len >= max_size)
+		return -ENAMETOOLONG;
+
+	if (foundry_str) {
+		len += snprintf(fwname + len, max_size - len, "%s", foundry_str);
+		if (len >= max_size)
+			return -ENAMETOOLONG;
+	}
+
+	if (!has_bid) {
+		len += snprintf(fwname + len, max_size - len, ".bin");
+		if (len >= max_size)
+			return -ENAMETOOLONG;
+		return 1;
+	}
+
+	if (need_fb) {
+		int fb_len = snprintf(fw_fb, sizeof(fw_fb), "%s.bin", fwname);
+
+		if (fb_len >= sizeof(fw_fb))
+			return -ENAMETOOLONG;
+
+		len += snprintf(fwname + len, max_size - len, "_%04x.bin",
+				ctrl_id->board_id);
+		if (len >= max_size)
+			return -ENAMETOOLONG;
+
+		/* fwname holds two NUL-terminated strings back-to-back:
+		 * [board-id path '\0'][fallback path '\0']
+		 * Verify the buffer fits both before writing.
+		 */
+		if (len + fb_len + 2 > max_size)
+			return -ENAMETOOLONG;
+
+		len += 1;
+		snprintf(fwname + len, max_size - len, "%s", fw_fb);
+		return 2;
+	}
+
+	len += snprintf(fwname + len, max_size - len, "_%04x.bin", ctrl_id->board_id);
+	if (len >= max_size)
+		return -ENAMETOOLONG;
+
+	return 1;
+}
+
+/* check the TLV file header; return 0 on success, or a negative errno */
+static int qbt_check_tlv_file(struct hci_dev *hdev, const struct firmware *fw, u8 file_type)
+{
+	const struct qbt_tlv_file_hdr *tlv_hdr = (const struct qbt_tlv_file_hdr *)fw->data;
+	size_t file_len;
+
+	if (fw->size < sizeof(*tlv_hdr))
+		return -ENODATA;
+
+	if (tlv_hdr->type != file_type)
+		return -EINVAL;
+
+	file_len = get_unaligned_le24(tlv_hdr->length) + sizeof(*tlv_hdr);
+	if (file_len != fw->size)
+		return -EBADF;
+
+	return 0;
+}
+
+/*
+ * btusb_check_patch_tlv - validate a patch TLV file against the BTC
+ *	before download
+ * @hdev: the HCI device to validate the file for
+ * @fwcfg: the firmware download config (unused)
+ * @info: BTC info for this hdev (unused)
+ * @ctrl_id: BTC QDFU ID
+ * @fw: the firmware to validate
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int btusb_check_patch_tlv(struct hci_dev *hdev,
+				 const struct qdfu_dlfw_cfg *fwcfg __maybe_unused,
+				 const struct qbtc_info *info __maybe_unused,
+				 const struct qdfu_bt_id *ctrl_id,
+				 const struct firmware *fw)
+{
+	const struct qbt_patch_tlv_hdr *patch_hdr = (const void *)fw->data;
+	u32 fw_rom_version;
+	u32 fw_patch_version;
+	int ret;
+
+	ret = qbt_check_tlv_file(hdev, fw, QBT_PATCH_TYPE_TLV);
+	if (ret) {
+		bt_dev_err(hdev, "Check patch TLV file header failed: %pe", ERR_PTR(ret));
+		return ret;
+	}
+
+	if (fw->size < sizeof(*patch_hdr)) {
+		bt_dev_err(hdev, "DFU patch header truncated (%zu bytes, header needs %zu)",
+			   fw->size, sizeof(*patch_hdr));
+		return -ENODATA;
+	}
+
+	if (likely(upper_16_bits(ctrl_id->rom_version))) {
+		fw_rom_version = (le16_to_cpu(patch_hdr->product_id) << 16) |
+				 le16_to_cpu(patch_hdr->rom_ver);
+	} else {
+		bt_dev_warn(hdev, "TLV patch check: product_id missing in rom_version 0x%08x",
+			    ctrl_id->rom_version);
+		fw_rom_version = le16_to_cpu(patch_hdr->rom_ver);
+	}
+
+	fw_patch_version = le16_to_cpu(patch_hdr->patch_ver);
+
+	if (fw_rom_version != ctrl_id->rom_version) {
+		bt_dev_err(hdev,
+			   "DFU patch ROM 0x%08x does not match controller 0x%08x",
+			   fw_rom_version, ctrl_id->rom_version);
+		return -EINVAL;
+	}
+
+	if (fw_patch_version < ctrl_id->patch_version) {
+		bt_dev_err(hdev,
+			   "DFU patch version 0x%x older than controller 0x%x, anti-rollback",
+			   fw_patch_version, ctrl_id->patch_version);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+/* validate a NVM TLV file against the BTC*/
+static int btusb_check_nvm_tlv(struct hci_dev *hdev, const struct qdfu_dlfw_cfg *fwcfg,
+			       const struct qbtc_info *info, const struct qdfu_bt_id *id,
+			       const struct firmware *fw)
+{
+	int ret;
+
+	ret = qbt_check_tlv_file(hdev, fw, QBT_NVM_TYPE_TLV);
+	if (ret) {
+		bt_dev_err(hdev, "Check NVM TLV file header failed: %pe", ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * qdfu_send_fw - send a firmware image via QDFU to BTC
+ * @hdev: the HCI device to send the firmware to
+ * @fwcfg: the firmware download config
+ * @info: BTC info for this hdev (unused)
+ * @ctrl_id: BTC QDFU ID (unused)
+ * @firmware: the firmware image to send, header included
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int qdfu_send_fw(struct hci_dev *hdev,
+			const struct qdfu_dlfw_cfg *fwcfg,
+			 const struct qbtc_info *info __maybe_unused,
+			 const struct qdfu_bt_id *ctrl_id __maybe_unused,
+			 const struct firmware *firmware)
+{
+	struct btusb_qcom *xdata = btusb_qcom_xport_data(hdev);
+	unsigned int pipe = usb_sndbulkpipe(xdata->udev, 0x02);
+	const size_t xfer_size = SZ_4K;
+	const unsigned int xfer_timeout_ms = 3000;
+	const u8 *ptr = firmware->data;
+	size_t seg_size, size;
+	int snd_len, ret;
+	u8 *buf;
+
+	ret = qdfu_vsc_req_download(hdev, fwcfg->request, (void *)ptr, fwcfg->hdr_size);
+	if (ret)
+		return ret;
+
+	ptr += fwcfg->hdr_size;
+	size = firmware->size - fwcfg->hdr_size;
+
+	/* ep2 needs time to switch from ACL to DFU function mode. */
+	fsleep(20 * 1000);
+
+	buf = kmalloc(xfer_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	while (size) {
+		seg_size = min_t(size_t, size, xfer_size);
+		memcpy(buf, ptr, seg_size);
+
+		snd_len = 0;
+		ret = usb_bulk_msg(xdata->udev, pipe, buf, seg_size, &snd_len,
+				   xfer_timeout_ms);
+		if (ret < 0) {
+			bt_dev_err(hdev,
+				   "QDFU bulk send failed at offset %zu: %pe",
+				   ptr - firmware->data, ERR_PTR(ret));
+			break;
+		}
+
+		if (seg_size != snd_len) {
+			bt_dev_err(hdev,
+				   "QDFU bulk short write (%d of %zu bytes) at offset %zu",
+				   snd_len, seg_size, ptr - firmware->data);
+			ret = -EIO;
+			break;
+		}
+
+		ptr += seg_size;
+		size -= seg_size;
+	}
+
+	kfree(buf);
+	return ret;
+}
+
+/* get the time (us) to wait for BTC to settle */
+static int btusb_get_settle_us(struct hci_dev *hdev __maybe_unused,
+			       const struct qdfu_dlfw_cfg *fwcfg,
+				const struct qbtc_info *info __maybe_unused,
+				const struct qdfu_bt_id *id __maybe_unused)
+{
+	return fwcfg->settle_us;
+}
+
+static int btusb_post_setup_unified_bt(struct hci_dev *hdev,
+				       const struct qdfu_dlfw_cfg *fwcfg __maybe_unused,
+					const struct qbtc_info *info __maybe_unused,
+					const struct qdfu_bt_id *id __maybe_unused)
+{
+	return btqcom_post_setup_unified_bt(hdev);
+}
+
+static int btusb_post_setup_msubsys_peri(struct hci_dev *hdev, const struct qdfu_dlfw_cfg *fwcfg,
+					 const struct qbtc_info *info, const struct qdfu_bt_id *id)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	struct qbtc_subsys_data *s = &qbt_data->subsys[QBTC_SUBSYS_PERI];
+	char *build_info = NULL;
+	int res;
+
+	res = qperi_get_subsys_build_info(hdev, QHCI_SUBSYS_PERI, &build_info);
+	if (!res) {
+		strscpy(s->build_info, build_info, sizeof(s->build_info));
+		bt_dev_info(hdev, "PERI Build Info: %s", build_info);
+		kfree(build_info);
+	}
+
+	if (qbt_data->flags & QBT_FLAG_RESET_PERI_HCI)
+		res = qperi_hci_reset(hdev);
+	else
+		res = qdfu_reset_peri_hci(hdev);
+	if (!res)
+		bt_dev_dbg(hdev, "PERI post setup succeeded");
+
+	return res;
+}
+
+/*
+ * btusb_dlfw_qdfu - download a firmware image via QDFU
+ * @hdev: the HCI device to download the firmware to
+ * @fwcfg: the firmware download config
+ * @info: BTC info for this hdev
+ * @ctrl_id: BTC QDFU ID
+ *
+ * Return: 1 if downloaded, 0 if already downloaded, or a negative errno
+ *	on failure.
+ */
+static int btusb_dlfw_qdfu(struct hci_dev *hdev,
+			   const struct qdfu_dlfw_cfg *fwcfg,
+			     const struct qbtc_info *info,
+			     const struct qdfu_bt_id *ctrl_id)
+{
+	const struct firmware *fw = NULL;
+	char fw_name[QBT_FW_PATH_MAX * 2];
+	const char *loaded_name;
+	u8 state, state_new;
+	int n_paths;
+	int ret;
+
+	bt_dev_dbg(hdev, "download %s", fwcfg->desc);
+	ret = qdfu_get_target_state(hdev, &state);
+	if (ret)
+		goto out;
+
+	if (state & fwcfg->ready_flag) {
+		bt_dev_info(hdev, "%s already downloaded", fwcfg->desc);
+		goto out;
+	}
+
+	n_paths = fwcfg->get_fwpath(hdev, fwcfg, info, ctrl_id, fw_name, sizeof(fw_name));
+	if (n_paths < 0) {
+		bt_dev_err(hdev, "Failed to get %s path: %pe",
+			   fwcfg->desc, ERR_PTR(n_paths));
+		ret = n_paths;
+		goto out;
+	}
+	bt_dev_dbg(hdev, "%s path: %s", fwcfg->desc, fw_name);
+	if (n_paths == 2)
+		bt_dev_dbg(hdev, "%s fallback path: %s", fwcfg->desc,
+			   fw_name + strlen(fw_name) + 1);
+
+	loaded_name = fw_name;
+	ret = request_firmware(&fw, fw_name, &hdev->dev);
+	if (ret == -ENOENT && n_paths == 2) {
+		bt_dev_warn(hdev, "Failed to request %s %s: %pe",
+			    fwcfg->desc, loaded_name, ERR_PTR(ret));
+		loaded_name = fw_name + strlen(fw_name) + 1;
+		ret = request_firmware(&fw, loaded_name, &hdev->dev);
+	}
+	if (ret) {
+		bt_dev_err(hdev, "Failed to request %s %s: %pe",
+			   fwcfg->desc, loaded_name, ERR_PTR(ret));
+		goto out;
+	}
+	bt_dev_info(hdev, "Requested %s %s", fwcfg->desc, loaded_name);
+
+	ret = fwcfg->check_fw(hdev, fwcfg, info, ctrl_id, fw);
+	if (ret)
+		goto out_free_fw;
+	bt_dev_dbg(hdev, "%s check succeeded", fwcfg->desc);
+
+	ret = fwcfg->send_fw(hdev, fwcfg, info, ctrl_id, fw);
+	if (ret)
+		goto out_free_fw;
+	bt_dev_dbg(hdev, "%s send succeeded", fwcfg->desc);
+
+	ret = qdfu_poll_state(hdev, &state_new, true, fwcfg->ready_flag);
+	if (ret)
+		goto out_free_fw;
+	if (state_new != state)
+		bt_dev_info(hdev, "%s state: 0x%02x -> 0x%02x",
+			    fwcfg->desc, state, state_new);
+
+	if (fwcfg->settle_us)
+		fsleep(fwcfg->settle_us);
+
+	if (fwcfg->post_setup)
+		ret = fwcfg->post_setup(hdev, fwcfg, info, ctrl_id);
+
+	if (!ret) {
+		bt_dev_info(hdev, "download %s successfully", fwcfg->desc);
+		ret = 1;
+	}
+
+out_free_fw:
+	release_firmware(fw);
+out:
+	if (ret < 0)
+		bt_dev_err(hdev, "download %s failed: %pe", fwcfg->desc, ERR_PTR(ret));
+	return ret;
+}
+
+static const struct qdfu_dlfw_cfg dfu_dlfw_cfgs_bt[QBTC_CAT_MAX][QBT_FW_MAX] = {
+	[QBTC_CAT_UNIFIED][QBT_FW_PATCH] = {
+		.desc          = "patch",
+		.ready_flag    = QDFU_BT_STATE_PATCHED_LOCAL,
+		.request       = QDFU_BT_CMD_VSC_REQ_DOWNLOAD_LOCAL,
+		.hdr_size      = sizeof(struct qbt_patch_tlv_hdr),
+		.fw_type       = QBT_PATCH_TYPE_TLV,
+		.settle_us     = 10 * 1000,
+		.get_fwpath    = btusb_get_patch_path,
+		.check_fw      = btusb_check_patch_tlv,
+		.send_fw       = qdfu_send_fw,
+		.get_settle_us = btusb_get_settle_us,
+		.post_setup    = NULL,
+	},
+	[QBTC_CAT_UNIFIED][QBT_FW_NVM] = {
+		.desc          = "NVM",
+		.ready_flag    = QDFU_BT_STATE_NVMED_LOCAL,
+		.request       = QDFU_BT_CMD_VSC_REQ_DOWNLOAD_LOCAL,
+		.hdr_size      = sizeof(struct qbt_nvm_tlv_hdr),
+		.fw_type       = QBT_NVM_TYPE_TLV,
+		.settle_us     = 40 * 1000,
+		.get_fwpath    = btusb_get_nvm_path,
+		.check_fw      = btusb_check_nvm_tlv,
+		.send_fw       = qdfu_send_fw,
+		.get_settle_us = btusb_get_settle_us,
+		.post_setup    = btusb_post_setup_unified_bt,
+	},
+	[QBTC_CAT_MSUBSYS][QBT_FW_PATCH] = {
+		.desc          = "BT patch",
+		.ready_flag    = QDFU_BT_STATE_PATCHED_REMOTE,
+		.request       = QDFU_BT_CMD_VSC_REQ_DOWNLOAD_REMOTE,
+		.hdr_size      = sizeof(struct qbt_patch_tlv_hdr),
+		.fw_type       = QBT_PATCH_TYPE_TLV,
+		.settle_us     = 30 * 1000,
+		.get_fwpath    = btusb_get_patch_path,
+		.check_fw      = btusb_check_patch_tlv,
+		.send_fw       = qdfu_send_fw,
+		.get_settle_us = btusb_get_settle_us,
+		.post_setup    = NULL,
+	},
+	[QBTC_CAT_MSUBSYS][QBT_FW_NVM] = {
+		.desc          = "BT NVM",
+		.ready_flag    = QDFU_BT_STATE_NVMED_REMOTE,
+		.request       = QDFU_BT_CMD_VSC_REQ_DOWNLOAD_REMOTE,
+		.hdr_size      = sizeof(struct qbt_nvm_tlv_hdr),
+		.fw_type       = QBT_NVM_TYPE_TLV,
+		.settle_us     = 60 * 1000,
+		.get_fwpath    = btusb_get_nvm_path,
+		.check_fw      = btusb_check_nvm_tlv,
+		.send_fw       = qdfu_send_fw,
+		.get_settle_us = btusb_get_settle_us,
+		.post_setup    = btusb_post_setup_unified_bt,
+	},
+};
+
+static const struct qdfu_dlfw_cfg dfu_dlfw_cfgs_subsys[QBTC_SUBSYS_MAX][QBT_FW_MAX] = {
+	[QBTC_SUBSYS_PERI][QBT_FW_PATCH] = {
+		.desc          = "PERI patch",
+		.ready_flag    = QDFU_BT_STATE_PATCHED_LOCAL,
+		.request       = QDFU_BT_CMD_VSC_REQ_DOWNLOAD_LOCAL,
+		.hdr_size      = sizeof(struct qbt_patch_tlv_hdr),
+		.fw_type       = QBT_PATCH_TYPE_TLV,
+		.settle_us     = 10 * 1000,
+		.get_fwpath    = btusb_get_patch_path,
+		.check_fw      = btusb_check_patch_tlv,
+		.send_fw       = qdfu_send_fw,
+		.get_settle_us = btusb_get_settle_us,
+		.post_setup    = NULL,
+	},
+	[QBTC_SUBSYS_PERI][QBT_FW_NVM] = {
+		.desc          = "PERI NVM",
+		.ready_flag    = QDFU_BT_STATE_NVMED_LOCAL,
+		.request       = QDFU_BT_CMD_VSC_REQ_DOWNLOAD_LOCAL,
+		.hdr_size      = sizeof(struct qbt_nvm_tlv_hdr),
+		.fw_type       = QBT_NVM_TYPE_TLV,
+		.settle_us     = 20 * 1000,
+		.get_fwpath    = btusb_get_nvm_path,
+		.check_fw      = btusb_check_nvm_tlv,
+		.send_fw       = qdfu_send_fw,
+		.get_settle_us = btusb_get_settle_us,
+		.post_setup    = btusb_post_setup_msubsys_peri,
+	},
+};
+
+static int btusb_get_subsys(const struct qdfu_dlfw_cfg *fwcfg)
+{
+	int subsys, fw_type;
+
+	for (subsys = 0; subsys < QBTC_SUBSYS_MAX; subsys++) {
+		for (fw_type = 0; fw_type < QBT_FW_MAX; fw_type++) {
+			if (&dfu_dlfw_cfgs_subsys[subsys][fw_type] == fwcfg)
+				return subsys;
+		}
+	}
+
+	return QBTC_SUBSYS_INVALID;
+}
+
+/*
+ * btusb_qcom_setup_unified - setup for a unified BTC
+ * @hdev: the HCI device to set up
+ * @info: BTC info for this hdev
+ * @ctrl_id: BTC QDFU ID
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int btusb_qcom_setup_unified(struct hci_dev *hdev,
+				    const struct qbtc_info *info,
+				     const struct qdfu_bt_id *ctrl_id)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	enum qbtc_category btc_cat = info->category;
+	const struct qdfu_dlfw_cfg *bt_cfgs = dfu_dlfw_cfgs_bt[btc_cat];
+	struct qdfu_bt_id bt_id;
+	int ret;
+
+	hci_set_quirk(hdev, HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
+
+	ret = btusb_dlfw_qdfu(hdev, &bt_cfgs[QBT_FW_PATCH], info, ctrl_id);
+	if (ret < 0)
+		goto out;
+
+	ret = qdfu_get_target_version(hdev, &bt_id);
+	if (ret)
+		goto out;
+
+	ret = btusb_dlfw_qdfu(hdev, &bt_cfgs[QBT_FW_NVM], info, &bt_id);
+	if (ret < 0)
+		goto out;
+
+	qdfu_to_qhci_id(&bt_id, &qbt_data->ver, &qbt_data->board_id);
+
+	ret = 0;
+out:
+	return ret;
+}
+
+/*
+ * btusb_qcom_setup_msubsys - setup for a multi-subsystem BTC
+ * @hdev: the HCI device to set up
+ * @info: BTC info for this hdev
+ * @ctrl_id: BTC QDFU ID
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+static int btusb_qcom_setup_msubsys(struct hci_dev *hdev,
+				    const struct qbtc_info *info,
+				     const struct qdfu_bt_id *ctrl_id)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	struct qbtc_subsys_data *peri_subsys = &qbt_data->subsys[QBTC_SUBSYS_PERI];
+	const struct qdfu_dlfw_cfg *peri_cfgs =
+		dfu_dlfw_cfgs_subsys[QBTC_SUBSYS_PERI];
+	const struct qdfu_dlfw_cfg *bt_cfgs = dfu_dlfw_cfgs_bt[QBTC_CAT_MSUBSYS];
+	struct qdfu_bt_id peri_id, bt_id_hci;
+	int ret;
+	u8 state, state_new;
+
+	memset(&peri_id, 0x00, sizeof(peri_id));
+	hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
+
+	ret = qdfu_get_target_state(hdev, &state);
+	if (ret)
+		goto out;
+
+	/* If a local download is already in progress, wait for it to drain
+	 * before starting our own.
+	 */
+	if (state & QDFU_BT_STATE_LOADING_LOCAL) {
+		ret = qdfu_poll_state(hdev, &state_new, true,
+				      QDFU_BT_STATE_PATCHED_LOCAL |
+				      QDFU_BT_STATE_NVMED_LOCAL);
+		if (!ret) {
+			if (state != state_new)
+				bt_dev_info(hdev, "PERI firmware state: 0x%02x -> 0x%02x",
+					    state, state_new);
+			bt_dev_info(hdev, "PERI firmware downloaded by another host.");
+			goto activate_btss;
+		} else if (ret != -ETIMEDOUT) {
+			goto out;
+		}
+		bt_dev_warn(hdev, "Other host PERI download failed, taking over.");
+	}
+
+	ret = btusb_dlfw_qdfu(hdev, &peri_cfgs[QBT_FW_PATCH], info, ctrl_id);
+	if (ret < 0)
+		goto out;
+
+	ret = qdfu_get_target_version(hdev, &peri_id);
+	if (ret)
+		goto out;
+
+	ret = btusb_dlfw_qdfu(hdev, &peri_cfgs[QBT_FW_NVM], info, &peri_id);
+	if (ret < 0)
+		goto out;
+
+activate_btss:
+	/* refresh PERI fw info ever downloaded by us or another host */
+	if (!ret) {
+		char *build_info = NULL;
+		int res;
+
+		res = qperi_get_subsys_build_info(hdev, QHCI_SUBSYS_PERI,
+						  &build_info);
+		if (!res) {
+			strscpy(peri_subsys->build_info, build_info,
+				sizeof(peri_subsys->build_info));
+			bt_dev_info(hdev, "PERI Build Info: %s", build_info);
+			kfree(build_info);
+		}
+	}
+	if (!peri_id.rom_version) {
+		ret = qdfu_get_target_version(hdev, &peri_id);
+		if (ret)
+			goto out;
+	}
+
+	ret = qdfu_activate_remote_btss(hdev, false, 100 * 1000);
+	if (ret)
+		goto out;
+
+	ret = qdfu_activate_remote_btss(hdev, true, 100 * 1000);
+	if (ret)
+		goto out;
+
+	ret = btusb_get_qdfu_id_hci(hdev, &bt_id_hci);
+	if (ret)
+		goto out;
+
+	if (bt_id_hci.rom_version != peri_id.rom_version ||
+	    bt_id_hci.soc_id != peri_id.soc_id ||
+	    bt_id_hci.board_id != peri_id.board_id) {
+		bt_dev_info(hdev, "QCOM BT-HCI ROM Version: 0x%08x",
+			    bt_id_hci.rom_version);
+		bt_dev_info(hdev, "QCOM BT-HCI Patch Version: 0x%08x",
+			    bt_id_hci.patch_version);
+		bt_dev_info(hdev, "QCOM BT-HCI SoC Version: 0x%08x",
+			    bt_id_hci.soc_id);
+		bt_dev_info(hdev, "QCOM BT-HCI Board ID: 0x%04x",
+			    bt_id_hci.board_id);
+	}
+
+	ret = btusb_dlfw_qdfu(hdev, &bt_cfgs[QBT_FW_PATCH], info, &bt_id_hci);
+	if (ret < 0)
+		goto out;
+
+	ret = btusb_get_qdfu_id_hci(hdev, &bt_id_hci);
+	if (ret)
+		goto out;
+
+	ret = btusb_dlfw_qdfu(hdev, &bt_cfgs[QBT_FW_NVM], info, &bt_id_hci);
+	if (ret < 0)
+		goto out;
+
+	qdfu_to_qhci_id(&peri_id, &peri_subsys->ver, &peri_subsys->board_id);
+	qdfu_to_qhci_id(&bt_id_hci, &qbt_data->ver, &qbt_data->board_id);
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static void btusb_qcom_setup_early(struct hci_dev *hdev)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	struct btusb_qcom *xdata = btusb_qcom_xport_data(hdev);
+
+	qbt_data->hdev = hdev;
+
+	xdata->intf = to_usb_interface(hdev->dev.parent);
+	xdata->udev = interface_to_usbdev(xdata->intf);
+	qbt_data->xport_data = xdata;
+
+	hdev->set_bdaddr        = btqcom_set_bdaddr;
+	hdev->shutdown          = btusb_qcom_shutdown;
+	hdev->reset          = btusb_qcom_reset;
+	hdev->classify_pkt_type = btusb_qcom_classify_pkt_type;
+}
+
+static void btusb_qcom_setup_common(struct hci_dev *hdev)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	int res;
+
+	clear_bit(QBTH_MISC_MEMDUMP_READY, &qbt_data->misc_flags);
+	if (qbt_data->flags & QBT_FLAG_ENABLE_MEMDUMP) {
+		res = hci_devcd_register(hdev, btusb_qcom_trigger_memdump,
+					 btusb_qcom_memdump_hdr,
+					 btqcom_memdump_notify);
+		if (!res)
+			set_bit(QBTH_MISC_MEMDUMP_READY, &qbt_data->misc_flags);
+	}
+	bt_dev_info(hdev, "QCOM devcoredump %s",
+		    str_enabled_disabled(test_bit(QBTH_MISC_MEMDUMP_READY, &qbt_data->misc_flags)));
+
+	hci_set_quirk(hdev, HCI_QUIRK_SIMULTANEOUS_DISCOVERY);
+	hci_set_quirk(hdev, HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED);
+
+	spin_lock_init(&qbt_data->cmd_sync.lock);
+	init_completion(&qbt_data->cmd_sync.done);
+
+	INIT_WORK(&qbt_data->work, btqcom_work);
+}
+
+static void btusb_qcom_setup_late(struct hci_dev *hdev)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	char buf[512];
+	int len = 0;
+
+	hci_set_hw_info(hdev, "%s", qbt_data->btc_name);
+
+	if (qbt_data->category == QBTC_CAT_MSUBSYS) {
+		struct qbtc_subsys_data *s = &qbt_data->subsys[QBTC_SUBSYS_PERI];
+
+		len += snprintf(buf + len, sizeof(buf) - len,
+				"PERI: %s\n", s->build_info);
+	}
+	len += snprintf(buf + len, sizeof(buf) - len, "BT: %s", qbt_data->build_info);
+	hci_set_fw_info(hdev, "%s", buf);
+}
+
+/*
+ * ============================================================================
+ * btusb_qcom.h API implementations
+ * ============================================================================
+ */
+
+/*
+ * btusb_qcom_setup - setup a BTC
+ * @hdev: the HCI device to set up
+ *
+ * Used as the hdev->setup() callback. Identifies the BTC, then dispatches
+ * setup based on driver-perspective category.
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int btusb_qcom_setup(struct hci_dev *hdev)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	const struct qbtc_id *id_entry = qbtc_id_table;
+	struct qdfu_bt_id ctrl_id;
+	int ret;
+
+	btusb_qcom_setup_early(hdev);
+
+	ret = qdfu_get_target_version(hdev, &ctrl_id);
+	if (ret)
+		goto out;
+
+	while (id_entry->rom_version) {
+		if (id_entry->rom_version == ctrl_id.rom_version)
+			break;
+		id_entry++;
+	}
+
+	if (!id_entry->rom_version) {
+		ret = -ENODEV;
+		bt_dev_err(hdev, "Detected unsupported BT controller:");
+	} else {
+		bt_dev_info(hdev, "Detected %s BT controller: %s",
+			    qbtc_cat_name[id_entry->btc_info->category],
+			    id_entry->name);
+	}
+
+	bt_dev_info(hdev, "QCOM ROM Version  : 0x%08x", ctrl_id.rom_version);
+	bt_dev_info(hdev, "QCOM Patch Version: 0x%08x", ctrl_id.patch_version);
+	bt_dev_info(hdev, "QCOM SoC Version  : 0x%08x", ctrl_id.soc_id);
+	bt_dev_info(hdev, "QCOM Board ID     : 0x%04x", ctrl_id.board_id);
+
+	if (ret)
+		goto out;
+
+	if (!qbt_data->drv_name)
+		qbt_data->drv_name = dev_driver_string(hdev->dev.parent);
+	qbt_data->btc_name = id_entry->name;
+	qbt_data->category = id_entry->btc_info->category;
+	qbt_data->flags    = id_entry->btc_info->flags;
+
+	btusb_qcom_setup_common(hdev);
+	switch (qbt_data->category) {
+	case QBTC_CAT_LEGACY:
+		ret = -EOPNOTSUPP;
+		break;
+	case QBTC_CAT_UNIFIED:
+		ret = btusb_qcom_setup_unified(hdev, id_entry->btc_info, &ctrl_id);
+		break;
+	case QBTC_CAT_MSUBSYS:
+		ret = btusb_qcom_setup_msubsys(hdev, id_entry->btc_info, &ctrl_id);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+out:
+	if (!ret) {
+		btusb_qcom_setup_late(hdev);
+		bt_dev_info(hdev, "QCOM BTUSB setup succeeded");
+	} else {
+		bt_dev_err(hdev, "QCOM BTUSB setup failed: %pe", ERR_PTR(ret));
+	}
+	return ret;
+}
+
+/*
+ * btusb_qcom_send_frame - send both BT and non-BT frame to BTC
+ * @hdev: the HCI device to send the frame to
+ * @skb: the frame to send
+ *
+ * Used as the hdev->send() callback. Maps PERI_CMD_PKT/PERI_ACL_PKT to
+ * HCI_COMMAND_PKT/HCI_ACLDATA_PKT so the transport's generic send_frame()
+ * can route them like ordinary BT-HCI packets.
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int btusb_qcom_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btusb_qcom *xdata = btusb_qcom_xport_data(hdev);
+	u8 pkt_type = hci_skb_pkt_type(skb);
+
+	if (pkt_type == PERI_CMD_PKT)
+		hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
+	else if (pkt_type == PERI_ACL_PKT)
+		hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
+
+	return xdata->send_frame(hdev, skb);
+}
+
+/*
+ * RX reassembly state, stashed in hci_skb_pkt_seqnum(skb) between calls:
+ * QRX_STATE_INDICATOR - determining the frame type
+ * QRX_STATE_HEADER    - receiving the packet header
+ * QRX_STATE_DATA      - receiving the payload
+ */
+enum {
+	QRX_STATE_INDICATOR,
+	QRX_STATE_HEADER,
+	QRX_STATE_DATA,
+};
+
+/*
+ * btusb_qcom_recv_intr - reassemble data from the intr endpoint to frame
+ * @hdev: the HCI device the data comes from
+ * @skb: the in-progress frame, or NULL to start a new one
+ * @buffer: raw bytes received from the interrupt endpoint
+ * @count: number of bytes in @buffer
+ * @err: output error code
+ *
+ * Called from the USB interrupt completion path with raw bytes. Feeds each
+ * completed frame to btqcom_recv_frame(), then back to BTUSB via
+ * xdata->recv_event() if not intercepted.
+ *
+ * Return: the in-progress frame to resume on the next call, or NULL
+ *	otherwise.
+ */
+struct sk_buff *btusb_qcom_recv_intr(struct hci_dev *hdev, struct sk_buff *skb,
+				     void *buffer, int count, int *err)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+	struct btusb_qcom *xdata = btusb_qcom_xport_data(hdev);
+	enum qbtc_category btc_cat = qbt_data->category;
+	int rx_state;
+	int len;
+	int res;
+	u8 pkt_type;
+
+	*err = 0;
+	while (count) {
+		if (!skb) {
+			u8 host_id = *(u8 *)buffer;
+
+			skb = bt_skb_alloc(PERI_MAX_EVT_SIZE, GFP_ATOMIC);
+			if (!skb) {
+				*err = -ENOMEM;
+				break;
+			}
+
+			/* host_id == QHCI_HOST_ID_BT marks a peripheral event,
+			 * which carries an extra leading byte over the
+			 * standard HCI event.
+			 */
+			if (host_id == QHCI_HOST_ID_BT) {
+				hci_skb_pkt_type(skb) = PERI_EVT_PKT;
+				hci_skb_pkt_seqnum(skb) = QRX_STATE_HEADER;
+				hci_skb_expect(skb) = PERI_EVT_HDR_SIZE;
+			} else {
+				hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+				hci_skb_pkt_seqnum(skb) = QRX_STATE_HEADER;
+				hci_skb_expect(skb) = HCI_EVENT_HDR_SIZE;
+			}
+		}
+
+		len = min_t(uint, hci_skb_expect(skb), count);
+		skb_put_data(skb, buffer, len);
+
+		count -= len;
+		buffer += len;
+		hci_skb_expect(skb) -= len;
+
+		if (hci_skb_expect(skb))
+			continue;
+
+		rx_state = hci_skb_pkt_seqnum(skb);
+		if (rx_state == QRX_STATE_DATA)
+			goto frame_done;
+
+		hci_skb_pkt_seqnum(skb) = QRX_STATE_DATA;
+		pkt_type = hci_skb_pkt_type(skb);
+		if (pkt_type == PERI_EVT_PKT)
+			hci_skb_expect(skb) = qperi_event_hdr(skb)->plen;
+		else if (pkt_type == HCI_EVENT_PKT)
+			hci_skb_expect(skb) = hci_event_hdr(skb)->plen;
+
+		if (hci_skb_expect(skb))
+			continue;
+
+frame_done:
+		if (count && count < HCI_EVENT_HDR_SIZE) {
+			bt_dev_warn(hdev,
+				    "Unexpected continuation: %d bytes",
+				    count);
+			if (btc_cat != QBTC_CAT_MSUBSYS)
+				count = 0;
+		}
+
+		hci_skb_pkt_seqnum(skb) = 0;
+
+		/* btqcom_recv_frame() return value:
+		 *   < 0  malformed  -> drop the frame
+		 *   = 0  unclaimed  -> back to BTUSB core, goes upward
+		 *   > 0  intercepted -> already consumed
+		 */
+		res = btqcom_recv_frame(hdev, skb);
+
+		if (res < 0) {
+			bt_dev_dbg(hdev,
+				   "dropping intr pkt type 0x%02x: %pe %*ph",
+				   hci_skb_pkt_type(skb), ERR_PTR(res),
+				   min_t(int, skb->len, 16), skb->data);
+			dev_kfree_skb_irq(skb);
+		} else if (res == 0) {
+			xdata->recv_event(hdev, skb);
+		}
+		skb = NULL;
+	}
+
+	return skb;
+}
+
+/*
+ * btusb_qcom_recv_bulk - reassemble data from the bulk endpoint to frame
+ * @hdev: the HCI device the data comes from
+ * @skb: the in-progress frame, or NULL to start a new one
+ * @buffer: raw bytes received from the bulk endpoint
+ * @count: number of bytes in @buffer
+ * @err: output error code
+ *
+ * Called from the USB bulk completion path with raw bytes. Feeds each
+ * completed frame to btqcom_recv_frame(), then back to BTUSB via
+ * xdata->recv_acl() if not intercepted.
+ *
+ * Return: the in-progress frame to resume on the next call, or NULL
+ *	otherwise.
+ */
+struct sk_buff *btusb_qcom_recv_bulk(struct hci_dev *hdev, struct sk_buff *skb,
+				     void *buffer, int count, int *err)
+{
+	struct btusb_qcom *xdata = btusb_qcom_xport_data(hdev);
+	struct peri_acl_hdr *peri_hdr;
+	u16 peri_handle;
+	int rx_state;
+	int res;
+	int len;
+	u8 pkt_type;
+
+	*err = 0;
+	while (count) {
+		if (!skb) {
+			skb = bt_skb_alloc(PERI_MAX_FRAME_SIZE, GFP_ATOMIC);
+			if (!skb) {
+				*err = -ENOMEM;
+				break;
+			}
+			hci_skb_pkt_seqnum(skb) = QRX_STATE_INDICATOR;
+			hci_skb_expect(skb) = HCI_ACL_HDR_SIZE;
+		}
+
+		len = min_t(uint, hci_skb_expect(skb), count);
+		skb_put_data(skb, buffer, len);
+
+		count -= len;
+		buffer += len;
+		hci_skb_expect(skb) -= len;
+
+		if (hci_skb_expect(skb))
+			continue;
+
+		rx_state = hci_skb_pkt_seqnum(skb);
+		switch (rx_state) {
+		case QRX_STATE_INDICATOR:
+			hci_skb_pkt_seqnum(skb) = QRX_STATE_HEADER;
+			peri_hdr = qperi_acl_hdr(skb);
+			peri_handle = qperi_acl_handle(skb);
+			if (peri_hdr->host_id == QHCI_HOST_ID_BT &&
+			    peri_handle >= 0xEC0 && peri_handle <= 0xECF) {
+				hci_skb_pkt_type(skb) = PERI_ACL_PKT;
+				hci_skb_expect(skb) = PERI_ACL_HDR_SIZE - HCI_ACL_HDR_SIZE;
+				continue;
+			}
+			hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
+			fallthrough;
+
+		case QRX_STATE_HEADER:
+			pkt_type = hci_skb_pkt_type(skb);
+			if (pkt_type == PERI_ACL_PKT)
+				hci_skb_expect(skb) = le16_to_cpu(qperi_acl_hdr(skb)->dlen);
+			else if (pkt_type == HCI_ACLDATA_PKT)
+				hci_skb_expect(skb) = le16_to_cpu(hci_acl_hdr(skb)->dlen);
+
+			if (hci_skb_expect(skb) > PERI_MAX_FRAME_SIZE - skb->len) {
+				dev_kfree_skb_irq(skb);
+				skb = NULL;
+				*err = -EILSEQ;
+				return NULL;
+			}
+			hci_skb_pkt_seqnum(skb) = QRX_STATE_DATA;
+			if (hci_skb_expect(skb))
+				continue;
+			fallthrough;
+
+		case QRX_STATE_DATA:
+			break;
+		}
+
+		hci_skb_pkt_seqnum(skb) = 0;
+		res = btqcom_recv_frame(hdev, skb);
+		if (res < 0) {
+			bt_dev_dbg(hdev,
+				   "dropping bulk pkt type 0x%02x: %pe %*ph",
+				   hci_skb_pkt_type(skb), ERR_PTR(res),
+				   min_t(int, skb->len, 32), skb->data);
+			dev_kfree_skb_irq(skb);
+		} else if (res == 0) {
+			xdata->recv_acl(hdev, skb);
+		}
+		skb = NULL;
+	}
+
+	return skb;
+}
+
+/* size of the hci priv area */
+int btusb_qcom_hdev_priv_size(void)
+{
+	return sizeof(struct btqcom_data) + sizeof(struct btusb_qcom);
+}
+
+/* get vendor transport (USB) specific data */
+struct btusb_qcom *btusb_qcom_xport_data(struct hci_dev *hdev)
+{
+	struct btqcom_data *qbt_data = hci_get_priv(hdev);
+
+	return (struct btusb_qcom *)(qbt_data + 1);
+}
diff --git a/drivers/bluetooth/btusb_qcom.h b/drivers/bluetooth/btusb_qcom.h
new file mode 100644
index 000000000000..779029e777b1
--- /dev/null
+++ b/drivers/bluetooth/btusb_qcom.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Bluetooth USB transport for Qualcomm BT chips
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __BTUSB_QCOM_H
+#define __BTUSB_QCOM_H
+
+#include <linux/types.h>
+#include <linux/skbuff.h>
+#include <linux/usb.h>
+
+#include <net/bluetooth/hci_core.h>
+
+struct btusb_qcom {
+	__u16                 idVendor;
+	__u16                 idProduct;
+	struct usb_device    *udev;
+	struct usb_interface *intf;
+	struct gpio_desc *reset_gpio;
+
+	void (*prepare_reset)(struct hci_dev *hdev);
+	int (*send_frame)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
+	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
+};
+
+int btusb_qcom_hdev_priv_size(void);
+struct btusb_qcom *btusb_qcom_xport_data(struct hci_dev *hdev);
+
+int btusb_qcom_setup(struct hci_dev *hdev);
+int btusb_qcom_send_frame(struct hci_dev *hdev, struct sk_buff *skb);
+
+struct sk_buff *btusb_qcom_recv_intr(struct hci_dev *hdev, struct sk_buff *skb,
+				     void *buffer, int count, int *err);
+
+struct sk_buff *btusb_qcom_recv_bulk(struct hci_dev *hdev, struct sk_buff *skb,
+				     void *buffer, int count, int *err);
+#endif

---
base-commit: 1d926925b0a44e13b6cc88c2e11e32760c6d7253
change-id: 20260713-btusb_qcom-7ab18eb8fb8c
prerequisite-change-id: 20260708-btusb_prep_qcc2072-23604a4e81d1:v1
prerequisite-patch-id: d24f13d85762481619b49e6e35e752d5a43e6af7
prerequisite-patch-id: 720e02fa1f62f6742d370179e23464a273663a9d
prerequisite-patch-id: 22999f84adb2fa448bf8babfe1842ab89ba4c869
prerequisite-patch-id: a63df9e5f7e952d2cd8d3dbfa0a34736a6789881
prerequisite-patch-id: 40aad889451114ddb9683fa1ae158b2ab90c1d30
prerequisite-patch-id: c87ebec131e4ffeb1e7ac755f95adbf5b6904793

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>


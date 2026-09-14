Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F63264FD
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354064; cv=none; b=hpuG8b2y9Ot3vGGCs60V0lOpApSHvmTM414bLE3UO/0TBcbwydgtcM3Q/3zvPMkA+rww7Dml91lTXl+zKbhyBAreJv0g0xIjktHWhSMhi8vSiGf+edq73UgBZpv08280KTmyiW5b12tcjV8m0kneo+PAufV6cK81ig4YupUTUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354064; c=relaxed/simple;
	bh=TH5vzca/DE4IuRYl8j+UF5OPl0hEyeQJ+vZNfQPGOzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnY8TCPOnr5NeC2Qus6//Ey10o1oo+sChWztX+tvTPIRBYM+YdnZb1X4AhcU+I/qNHFbGmbMOLdQ4/ofr57O3RZ35LSKOAOQHW7hQJVPgiMAY1+iVXt6eBwu53sRIZGhBTr8vXs2hXM6Tss59r6e+cSN9A/5XXCGsypkpeAMU34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BGZFiSx5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UgYu8ePr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BGZFiSx5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UgYu8ePr"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E2eeZT2241369
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wbT1Cc1NciLh6CzE4VxkkwHzDMNo9OI1Hd3+UmFrYNQ=; b=BGZFiSx5ip9NnQ+t
	qzGrMdXzxQIqfyID3f9pS5Ib8p0zGyYzKs3UXVCCc/GYrYTINHlHWjK9ZmsYC+Wi
	DrGwZgaVKjP6c7j/pFwLCrUMVwDoGWmRC6rXlivED1z+UADJe6heMzj6LJAswYTj
	+pWq0JPsr2YmnoDX5MAm9Z7uJHxZEDrW2KekcJxRtZ85ySeKRQLfDoWGoyxsAIMK
	nfbMIj/vk/EAYGoVefHztjc8gnRN/dZuMNgagRO9BMD95bbjETI2B8wVVcK70Brf
	9Uv1jUttAOIH8z4+HR3CvpeoQI4jhySP9NSjXdldHqKb80zJF5pW3uKeKRkyotM3
	0K4adQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmywh4kh1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 02:47:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc0eee75dso1211952a91.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 19:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789354061; x=1789958861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wbT1Cc1NciLh6CzE4VxkkwHzDMNo9OI1Hd3+UmFrYNQ=;
        b=UgYu8ePrv6mhG869iO+CHqJun78wX9SlsayFuYwn1665z3H/BKB2UjTiLT0ueQfL8K
         SiKwKU33sJjiIzzPg0LJHgXlwiio5bfKFL15U/FoVYA30pPY5C8s8qE+IVieP24fuRjW
         G7NTcZIfmI1aLf0BbA5RY5l5pLClnubfGVZcqM2IGlFZe2b8kQGGRaOXGUuBKVL7TNqf
         gNUpu73j/qhxe9EGo5DyP/Kgmf3DqJviMsx8/vR4XwmQjjlgXEJxgW1Ixyt60aa8txQn
         nxsVILr3XWGrm/fMc6T7DJ+Fxl0Pl5JipEh03z6N7hleYrqtDwf8r9Z6c0yFD7eWJqow
         uhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354061; x=1789958861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wbT1Cc1NciLh6CzE4VxkkwHzDMNo9OI1Hd3+UmFrYNQ=;
        b=V2dAG0x4nTIOYRekGQuBfeYebHxgjmHe0sgzhPTDtjZRsjxzPGdPig9WA+qwLmrxm0
         TuZ1p0rsoA+/lgTNs3GohadUe3LGTS98+LeswLTDj9uSWMMqMu7ESqXp1NAlw8xspvor
         L7OGDqSB9ClWbHjHk7BDEEeMYSsz5t+SnXUQb6gJS1k30a9ZFgBMpFgIAw0k4E8yBuxi
         ZnZmLrieVnV2MVkd4K4uXkrvzog6XrplptF+ex5/83x1IzUnfn0un5MgjCM0k7qbA8/L
         APj0f/4wizIhekbR3ElIOzKyjK1v62gYLZkjaeIuK5f2cDPDGKWBafrE6h2oROleksdC
         valQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvsBZmDLVxPUt/+vgd9cPdfFArmijHFBSDeVfvgv5az7Z2H5kRHCY/3UX2JaqXACy/k+lhNfZn9Y6ptC2YeP8=@vger.kernel.org
X-Gm-Message-State: AFuF++mclZIRBTuhup5fUFkSvjCrP9sb+pobvRvF6ttpb7cVSXe0pGXt
	OYMbAOtfLqpq+Wyqw0Pdn3fBIBBt2+E+kiDtsiDT66Q1YnDg4S3mL/4ViQ2xsOH3rzm0NPlf2H+
	lCZMMl94cH+5QSptBwLH+qlT2ueYw7Gf4vM9PmVvmlaU2aVbQJ7orDexG1AxbIBZnsSeo7Pk=
X-Gm-Gg: AYBFou3VoQgWrqNxszgmHCnAZFjXMuP8XAllX2GyQwdu1wflWOBv33tvRDora/0/SKi
	VH+J3lmIDIR8cYIsi5QELJ9GPAxjSJOELjo+d3hhh/lPdjQLnMKiRFHn7wcFqwnT/rpzsK//cpG
	3mmbzDyEt96XrJQzRkv0zryhsuPN1B6o5ipTSyH1drepiMXc7cEIqHedULNvYHLJMHd0BwPMPWa
	lLi+DKi+twmzzo2jfgdm/b6du4yu2OblXmqnPMi0g4jeGKQJFf7nHHbI250WZZCakTa63Ql57zp
	jPm2v/FyYn4enfzbFdHw3arr9qhw6U5W5ov5NwrRI1ucDj+RGYk8CsSxxmz07vNU2LRRVPrCljI
	nzpuPQoV0cb8CoJoSrq2mmHzwCqqh7Hutv08RZ8BkOUREp7I=
X-Received: by 2002:a17:90b:4f:b0:398:bada:832b with SMTP id 98e67ed59e1d1-39dec251bf8mr895719a91.6.1789354060821;
        Sun, 13 Sep 2026 19:47:40 -0700 (PDT)
X-Received: by 2002:a17:90b:4f:b0:398:bada:832b with SMTP id 98e67ed59e1d1-39dec251bf8mr895695a91.6.1789354060327;
        Sun, 13 Sep 2026 19:47:40 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed295esm25945014eec.15.2026.09.13.19.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 19:47:39 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 19:46:44 -0700
Subject: [PATCH v6 2/4] Bluetooth: Add generic support for vendor packets
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-btusb_qcc2072-v6-2-137898715844@oss.qualcomm.com>
References: <20260913-btusb_qcc2072-v6-0-137898715844@oss.qualcomm.com>
In-Reply-To: <20260913-btusb_qcc2072-v6-0-137898715844@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: zw3eXCexh613zXJY1m83uNk9aq16pjCA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAzNSBTYWx0ZWRfX+U6D5u45YhBJ
 fbFQPMyMNiaf8MkuIpzuo0JJPeOXfvGASZ46+dGR7GCg5H8LAaHzqocuoPmhVkYD3R3Ys9GGsVe
 P3jdwjU8slHnBdsvq6sGfYvbjaTNrg6dmEqj0xscHJicmTftqg//TUYf5k/yANeJDbbVpY3HNCL
 IgrfhdjWYmV5u8E8rYSWZyGyGFiNz8cIU84uhvyUZpjNUQMSF0gqBux88rsIdOlEl/NPz/o04g+
 mOHiEeJcwmUqN+ba4hT3DH7blsplzy7LYy4PuEKNKn3XuEWiIGhxrXJJXf6dyxddroOVedRiwok
 wM/ISBNnh+K5r7BsiZH5s+rK+wQq6OcPA6c44KqONL3bvGbo7ixisGp6WnXs9YP4B76nnEbQsDS
 pjzeIs87/V/od+M3DCoGQ1yW74CLFeZDKhQwSFXgOIMWSKsTRGahf5ALN2u8DLzpghtcHzJq303
 krvos8A+Wq6lTL23uzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAzNSBTYWx0ZWRfXyiUu8SFeasbX
 +669+FErh5PC6PtMi53zflDiJ5RnmytHJvfVAnPij8TH7yoD4V+528AybwXPeu1PuLEIkRLbnTh
 zeyIQb7eUQTLVT8CT7sOiMnm21Z3Rgs=
X-Proofpoint-ORIG-GUID: zw3eXCexh613zXJY1m83uNk9aq16pjCA
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6aa7604d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=rupOQ6kNMCESZWuvRX8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_01,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140035

The virtual HCI_VENDOR_PKT (0xff) has been defined but never used by
the BT core. Now, there is a requirement to implement it, as follows:

For Qualcomm multi-subsystem BT chips, the transport wire carries both
BT-HCI and PERI-HCI packets, where PERI is a subsystem in the chip, take
the upcoming QCC2072 as an example:

    Packet type                 BT-HCI indicator   PERI-HCI indicator
    -----------------------------------------------------------------
    CMD (Host -> Controller)    0x01               0x31
    ACL Data (bidirectional)    0x02               0x32
    EVENT (Controller -> Host)  0x04               0x34

There are also BT ACL packets with vendor-reserved handles found in
existing device drivers, as shown below:

+--------+--------+---------------------------+
| Vendor | Handle | Purpose                   |
+--------+--------+---------------------------+
| QCOM   | 0xEDD  | Firmware coredump         |
|        | 0xEDC  | Firmware enhanced logging |
+--------+--------+---------------------------+
| MTK    | 0xFC6F | Firmware coredump         |
|        | 0x05FF | Firmware debug logging 1  |
|        | 0x05FE | Firmware debug logging 2  |
+--------+--------+---------------------------+
| NXP    | 0xFFF  | Firmware coredump         |
+--------+--------+---------------------------+

Implement HCI_VENDOR_PKT to generically support such vendor packets,
which don't follow BT SIG's vendor-extension framework:

- Log them in btmon as they appear on the wire.
- Add hdev->recv_vendor_pkt() to handle them in hci_rx_work().
- Add hci_send_vendor_frame() to send them to the device driver.
- Allow them to flow over HCI_CHANNEL_USER, nested inside HCI_VENDOR_PKT.

Also solve the same issues that the commit below fixes for
HCI_EV_VENDOR, which follows BT SIG's vendor-extension framework:

commit 0bd606b31d40 ("Bluetooth: hci_event: Introduce
handle_ev_vendor() for HCI_EV_VENDOR")

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 include/net/bluetooth/hci_core.h |  5 +++++
 include/net/bluetooth/hci_mon.h  |  2 ++
 net/bluetooth/hci_core.c         | 45 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_sock.c         |  8 +++++++
 4 files changed, 60 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c12cd6873f65..b26004a05368 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -23,16 +23,17 @@
 #ifndef __HCI_CORE_H
 #define __HCI_CORE_H
 
 #include <linux/idr.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
 #include <linux/spinlock.h>
 #include <linux/srcu.h>
+#include <linux/uio.h>
 
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_drv.h>
 #include <net/bluetooth/hci_sync.h>
 #include <net/bluetooth/hci_sock.h>
 #include <net/bluetooth/coredump.h>
 
 /* HCI priority */
@@ -641,16 +642,18 @@ struct hci_dev {
 #endif
 
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
 	int (*setup)(struct hci_dev *hdev);
 	int (*shutdown)(struct hci_dev *hdev);
 	int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
+	/* Receive HCI_VENDOR_PKT */
+	void (*recv_vendor_pkt)(struct hci_dev *hdev, struct sk_buff *skb);
 	/* Handle HCI_EV_VENDOR; return true if handled, false otherwise */
 	bool (*handle_ev_vendor)(struct hci_dev *hdev, struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	void (*hw_error)(struct hci_dev *hdev, u8 code);
 	int (*post_init)(struct hci_dev *hdev);
 	int (*set_diag)(struct hci_dev *hdev, bool enable);
 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 	void (*reset)(struct hci_dev *hdev);
@@ -2395,16 +2398,18 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
 	}
 
 	return 0;
 }
 
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
+int hci_send_vendor_frame(struct hci_dev *hdev, struct iov_iter *iter);
+
 int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
 		   const void *param);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 		 const void *param);
 void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb);
diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 4b2a0af4ed58..7710688c0d30 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -45,16 +45,18 @@ struct hci_mon_hdr {
 #define HCI_MON_CTRL_OPEN	14
 #define HCI_MON_CTRL_CLOSE	15
 #define HCI_MON_CTRL_COMMAND	16
 #define HCI_MON_CTRL_EVENT	17
 #define HCI_MON_ISO_TX_PKT	18
 #define HCI_MON_ISO_RX_PKT	19
 #define HCI_MON_DRV_TX_PKT	20
 #define HCI_MON_DRV_RX_PKT	21
+#define HCI_MON_VENDOR_TX_PKT	22
+#define HCI_MON_VENDOR_RX_PKT	23
 
 struct hci_mon_new_index {
 	__u8		type;
 	__u8		bus;
 	bdaddr_t	bdaddr;
 	char		name[8] __nonstring;
 } __packed;
 #define HCI_MON_NEW_INDEX_SIZE 16
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 46453bc4ca25..c71c1e7e1f37 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2912,16 +2912,18 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 			    type == PA_LINK)
 				hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
 		}
 		break;
 	case HCI_SCODATA_PKT:
 		break;
 	case HCI_ISODATA_PKT:
 		break;
+	case HCI_VENDOR_PKT:
+		break;
 	case HCI_DRV_PKT:
 		break;
 	default:
 		kfree_skb(skb);
 		return -EINVAL;
 	}
 
 	/* Incoming skb */
@@ -3048,16 +3050,51 @@ static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 static int hci_send_conn_frame(struct hci_dev *hdev, struct hci_conn *conn,
 			       struct sk_buff *skb)
 {
 	hci_conn_tx_queue(conn, skb);
 	return hci_send_frame(hdev, skb);
 }
 
+/**
+ * hci_send_vendor_frame - Send an HCI_VENDOR_PKT frame to the HCI driver
+ * @hdev: The HCI device
+ * @iter: iov_iter carrying the frame
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int hci_send_vendor_frame(struct hci_dev *hdev, struct iov_iter *iter)
+{
+	struct sk_buff *skb;
+	unsigned int len;
+
+	if (WARN_ON(!iov_iter_is_kvec(iter)))
+		return -EINVAL;
+
+	/* Vendor frames are opaque, the caller guarantees the size. */
+	len = (unsigned int)iov_iter_count(iter);
+	if (!len)
+		return -EINVAL;
+
+	skb = bt_skb_alloc(len, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	if (!copy_from_iter_full(skb_put(skb, len), len, iter)) {
+		kfree_skb(skb);
+		return -EFAULT;
+	}
+
+	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
+
+	return hci_send_frame(hdev, skb);
+}
+EXPORT_SYMBOL(hci_send_vendor_frame);
+
 /* Send HCI command */
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 		 const void *param)
 {
 	struct sk_buff *skb;
 
 	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
 
@@ -4063,16 +4100,24 @@ static void hci_rx_work(struct work_struct *work)
 			hci_scodata_packet(hdev, skb);
 			break;
 
 		case HCI_ISODATA_PKT:
 			BT_DBG("%s ISO data packet", hdev->name);
 			hci_isodata_packet(hdev, skb);
 			break;
 
+		case HCI_VENDOR_PKT:
+			BT_DBG("%s Vendor packet", hdev->name);
+			if (hdev->recv_vendor_pkt)
+				hdev->recv_vendor_pkt(hdev, skb);
+			else
+				kfree_skb(skb);
+			break;
+
 		default:
 			kfree_skb(skb);
 			break;
 		}
 	}
 }
 
 static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 070ca388f9ac..406b70ecaf33 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -228,16 +228,17 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 				continue;
 		} else if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
 			if (!bt_cb(skb)->incoming)
 				continue;
 			if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT &&
 			    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
 			    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
 			    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT &&
+			    hci_skb_pkt_type(skb) != HCI_VENDOR_PKT &&
 			    hci_skb_pkt_type(skb) != HCI_DRV_PKT)
 				continue;
 		} else {
 			/* Don't send frame to other channel types */
 			continue;
 		}
 
 		if (!skb_copy) {
@@ -385,16 +386,22 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 			opcode = cpu_to_le16(HCI_MON_SCO_TX_PKT);
 		break;
 	case HCI_ISODATA_PKT:
 		if (bt_cb(skb)->incoming)
 			opcode = cpu_to_le16(HCI_MON_ISO_RX_PKT);
 		else
 			opcode = cpu_to_le16(HCI_MON_ISO_TX_PKT);
 		break;
+	case HCI_VENDOR_PKT:
+		if (bt_cb(skb)->incoming)
+			opcode = cpu_to_le16(HCI_MON_VENDOR_RX_PKT);
+		else
+			opcode = cpu_to_le16(HCI_MON_VENDOR_TX_PKT);
+		break;
 	case HCI_DRV_PKT:
 		if (bt_cb(skb)->incoming)
 			opcode = cpu_to_le16(HCI_MON_DRV_RX_PKT);
 		else
 			opcode = cpu_to_le16(HCI_MON_DRV_TX_PKT);
 		break;
 	case HCI_DIAG_PKT:
 		opcode = cpu_to_le16(HCI_MON_VENDOR_DIAG);
@@ -1863,16 +1870,17 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		 * since that gets enforced when binding the socket.
 		 *
 		 * However check that the packet type is valid.
 		 */
 		if (hci_skb_pkt_type(skb) != HCI_COMMAND_PKT &&
 		    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
 		    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
 		    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT &&
+		    hci_skb_pkt_type(skb) != HCI_VENDOR_PKT &&
 		    hci_skb_pkt_type(skb) != HCI_DRV_PKT) {
 			err = -EINVAL;
 			goto drop;
 		}
 
 		skb_queue_tail(&hdev->raw_q, skb);
 		queue_work(hdev->workqueue, &hdev->tx_work);
 	} else if (hci_skb_pkt_type(skb) == HCI_COMMAND_PKT) {

-- 
2.34.1


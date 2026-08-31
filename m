Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89DC3C872A
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788152653; cv=none; b=L5ZEUpYhXS2RO8vq2apRle40HCUoKQ0QVCDpHlgWKKzu6PAv+vojvzAyH7LSjZcumK9VO7nS2ghBaMUhYk/YeLaAfmHOSlQe7igApaBq6Uq0mEBDEspzD40qnypTU3RtPuh5F1TegRg59umsm36heaHyFwUr70hprvJ9yDn10Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788152653; c=relaxed/simple;
	bh=uUVPUrGFA10msfIRW6krbBOpPZL32DRp3KsMsoURUig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qt5klLmva/WqEzcoTcBBxVQFnDGZAT6qp1uklVkrY4XhBDL4PO9EsIISOCvUgQfKKRZcwb5UNBenQ5iCi3szLjSXIcfKH7S4Ry6NEjst7yfD3ca2NO/AfrlOZlgalW5UeYHOJGYaQjwWd3CcRHg7fx3stZW5k5YTF0uZ2q5weUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pXfRMi/3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jUnGddQl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pXfRMi/3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jUnGddQl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52VHh2680012
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bSc/pQVqA7NGcheRiqxdNQj4kNtXU/GjwgcJvI8t3HE=; b=pXfRMi/3IBKwkxqE
	lXMv0Auc0rkd/jR3LzwiEZVkNebDCk56Mfjb03xI0PqqrLz5Y32js1mmdpzi1k0N
	xEtEgyZIQGIOdGKVyxWWiKUPFKuY0GhagZwuHttB2/UbEvf98o4IwB/u6MFaVEaK
	xX38dW+qq56+dd/UV7OYyCPqW+HAEbWJ+KykMaJErovhz7M6gWm5JBDPo1fKpfn0
	+ViiBKamlPrMbotaOIQPptKqB9b9+wOlQh1oKAhjNp+Y+YsliQxf1x+MLengEpVo
	Vr49jH7CPU7zRcmrpdOoEKPzCZGujsSLmNoEOadjIIOOs0iFjHeQrXGhp8RBSyxB
	dy5M/g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqhwcn96-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 05:04:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-387087245e4so846505a91.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 22:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788152649; x=1788757449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bSc/pQVqA7NGcheRiqxdNQj4kNtXU/GjwgcJvI8t3HE=;
        b=jUnGddQl3H8wwDt12JJAHnmOnn7v44A3Qu9KJcwEOF3eLxR4nigH8kdF+tWTYwgbFy
         GGhmDZwEZ1UcFHJ91+Ecd4znJ8/gn1DTrZxreoHuvnjyEw9o5mb3lgD56IaUgkawHXbi
         ebvOYSi5tQOSpb1hgoCgOa8fvZ+dt1v1yCco2XZogu2lvNXAhiODW1zMz8gWPOjKpUjl
         ++fEIuQ/fnxEb9ED2FAirHYQzE03wZtDoKUn/m8rNcKQugR5u4vLv4wzIt6nHYi9ANdG
         ZRbLft6tGl0goc6QtgQdIFhBByXlOxkUayHOBTnYqUOWmKM9TyRX8LZqxCVkl8ozX1a/
         XAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788152649; x=1788757449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bSc/pQVqA7NGcheRiqxdNQj4kNtXU/GjwgcJvI8t3HE=;
        b=VHm3+cX5FwP82/blW1dXuR07AKuWV0euqr+9uyVRpHMSGdYrwtgCUFTHNQe1iNu4HI
         486spL7q2wPUxGEciuos039RMrGpgkptaUFoMObMu0qkXB94JlsA1ru+x+Vi61Iq9nuw
         nC0kETx5qxM0aaB0IymzAMoE9UXsNctiAFAdacvx1+V1ZVsqJWXpJwd9Nsqi5Rv6UHhd
         vlydAWe6iJkOsh67jnkrIT/sAyIo/cXW34FRWj5AA/fz0rrnv61E8wmpOwF3DJTiNlKj
         VS6Et/ZLuGQ/FQwgx8/mckFIzQ49WwRw1jk4742b2OvVJ7SNZYQlXrvbSigR8MZVO002
         62dA==
X-Forwarded-Encrypted: i=1; AKwUvBxD+bOZCyCuk6PQNMRyp6YclNsIskcj7vbYS/bZm6tEdyGHcry3u/N0roTBafp9uvyUlSgIfJJDdl5HOURhYP4=@vger.kernel.org
X-Gm-Message-State: AFuF++ki5zfd1uiVaU55j510PNP7x+vVaivJnW8lyKIvYOJg7MS1E2A4
	ojo+fbZOiOVvBk33L05deaqqttg3aqrByt5uxuXXfp750/k9pEP9NrWPnO0RoHYEIB0XY5zeN+1
	UloEDtXs0L0Rv18/9A88EeK6S7GrEl5xBWGBv7VJ+DKShQ+y12SLknSKLgL+VbJs7o6SamQQ=
X-Gm-Gg: AYBFou3jnoimnqjmKV/UyKKW++7LwV1lHMtg572LVQ4RIMVUUThrP/zMgezGHHkPnJ9
	YJxmfUcW43d4/QB0YRd5vZgY5D5EWdGfDslkBiFdrMeHY6AZsL0rPVyjgM4IxLU67CpNy1xOHtg
	1XRROm8yXlfvH5KAUuy+p6hw6E1lTkriRngdbU+JO9wJGP+gdL/SketUIDMo7U93HEaQvYQ63Nx
	QrCqh+S+JoS29OKMKGqE7iR4PwmIGbyPn/Vc023XaEYaGfuEaV6tsHhfuOvBkJzyZCaCdPNQ/n/
	QWo6KMS/gQbMTALco9DoXS0SgaRyMmh68aYPTwTB/UrX6d4qA3Ke9gocqCFnmZKHOhg9POjTJ1J
	rjeli03ywBKnT5z3Chal+GJAFSblAexNDYpy+GSHE3rO2Klo=
X-Received: by 2002:a17:90b:3e50:b0:398:bac0:238d with SMTP id 98e67ed59e1d1-398bac026a5mr10691031a91.5.1788152649179;
        Sun, 30 Aug 2026 22:04:09 -0700 (PDT)
X-Received: by 2002:a17:90b:3e50:b0:398:bac0:238d with SMTP id 98e67ed59e1d1-398bac026a5mr10690969a91.5.1788152648523;
        Sun, 30 Aug 2026 22:04:08 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0df264csm43017912c88.14.2026.08.30.22.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:04:07 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 30 Aug 2026 22:03:51 -0700
Subject: [PATCH v2 2/4] Bluetooth: Add generic support for vendor HCI
 packets
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-btusb_qcc2072-v2-2-5c0e0c9dd98b@oss.qualcomm.com>
References: <20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b@oss.qualcomm.com>
In-Reply-To: <20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: BF2HucjDfLDYlndQTuPsnfLs9dChtCkA
X-Proofpoint-ORIG-GUID: BF2HucjDfLDYlndQTuPsnfLs9dChtCkA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfX73L8y9LhNXBM
 o33GOaX7pTv+20dLZqV874xosEooighxmAOlDxZMEsUJpp/ScjBw0/sv3U/pc8gDmz0bNPe5GiF
 bsprVCtP0q4+UMcaauEYYLO7X4o7iMk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfX26oYkU55gVF8
 amNeqoaM8CvySROOhIRlrwSCNv76pW7KMZaz6HXCrWJMzcqaxIHmIbUJNsmneRYtf2qPYIBrfyg
 AuXYTBfiW9eNou94viDLA8XwH/FQYazSwzJ10pzaKTPelqwZyu7jJZ7FdFze212JaiXHFqKoDPy
 pg7ANhHIjOZNaYjlTbpcV5qIh7qJbH6wIndjggySsH8Q0b+pG1quD+URkqgAlNBRV78J2e7NoPh
 EzYDYfsicUqts5jjB9dpWgvfQMI+I+InLrD++6H7GP1F7QAr1PpXw8C3R3VYg3/BI77/SbX7RDV
 fSHnq815zNRdBZ4LcH5jLXkI10ewKAICoq040gepPbA9nP7o/kVcuJoOyqOohS29V+AjgtM+ecb
 EOc1FH5k8kqPjoa1FxukiREkKtYW637H2CQ23CLPwM/35PTtkMHpbipmqaIiQyHkJ5k10LxTot4
 dTl36RKTNSEkCAGOsSw==
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=6a950b4a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=o_hDFpOKkKxfARKC_FYA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310041

The virtual HCI_VENDOR_PKT (0xff) has been defined but never used by
the BT core. Now, there is a requirement to implement it, as follows:

For Qualcomm multi-subsystem BT chips, the transport wire carries both
BT-HCI and PERI-HCI frames, where PERI is a subsystem in the chip, take
the upcoming QCC2072 as an example:

    Packet type                 BT-HCI indicator   PERI-HCI indicator
    -----------------------------------------------------------------
    CMD (Host -> Controller)    0x01               0x31
    ACL Data (bidirectional)    0x02               0x32
    EVENT (Controller -> Host)  0x04               0x34

Implement HCI_VENDOR_PKT to generically support vendor HCI packets:

- Log them in btmon as they appear on the wire.
- Allow userspace to send/receive them over HCI_CHANNEL_USER, gate RX
  with the new socket option BT_RECV_VENDOR_PKT, off by default to
  avoid regressions for existing applications.
- Add hdev->recv_vendor_pkt() to handle them in hci_rx_work().
- Add hci_send_vendor_frame() to send an HCI_VENDOR_PKT frame.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous version:
https://lore.kernel.org/all/20260722-support_vendor_hci-v2-2-132b506460a4@oss.qualcomm.com

Changes since previous version:
- Change BT_RECV_VENDOR_PKT type from int to u32
- Rename macro and enum from *_RCV_* to *_RECV_*
- Improve the commit title and message
---
 include/net/bluetooth/bluetooth.h |  6 +++++
 include/net/bluetooth/hci.h       |  1 +
 include/net/bluetooth/hci_core.h  |  5 ++++
 include/net/bluetooth/hci_mon.h   |  2 ++
 net/bluetooth/hci_core.c          | 44 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_sock.c          | 53 +++++++++++++++++++++++++++++++++++----
 6 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index b624da5026f5..f9b380060976 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -251,16 +251,22 @@ struct bt_codecs {
 #define BT_ISO_BASE		20
 
 /* Socket option value 21 reserved */
 
 #define BT_PKT_SEQNUM		22
 
 #define BT_SCM_PKT_SEQNUM	0x05
 
+/*
+ * Control receiving HCI_VENDOR_PKT over HCI_CHANNEL_USER, off
+ * by default to avoid regressions for existing applications.
+ */
+#define BT_RECV_VENDOR_PKT	23
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
 void bt_warn(const char *fmt, ...);
 __printf(1, 2)
 void bt_err(const char *fmt, ...);
 #if IS_ENABLED(CONFIG_BT_FEATURE_DEBUG)
 void bt_dbg_set(bool enable);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1641d879dbda..0145f629cdd5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -393,16 +393,17 @@ enum {
 	HCI_RAW,
 
 	HCI_RESET,
 };
 
 /* HCI socket flags */
 enum {
 	HCI_SOCK_TRUSTED,
+	HCI_SOCK_RECV_VENDOR_PKT,
 	HCI_MGMT_INDEX_EVENTS,
 	HCI_MGMT_UNCONF_INDEX_EVENTS,
 	HCI_MGMT_EXT_INDEX_EVENTS,
 	HCI_MGMT_EXT_INFO_EVENTS,
 	HCI_MGMT_OPTION_EVENTS,
 	HCI_MGMT_SETTING_EVENTS,
 	HCI_MGMT_DEV_CLASS_EVENTS,
 	HCI_MGMT_LOCAL_NAME_EVENTS,
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
index 88df159d3393..2663654cdf60 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2911,16 +2911,18 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -3047,16 +3049,50 @@ static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
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
+	size_t len;
+
+	if (WARN_ON(!iov_iter_is_kvec(iter)))
+		return -EINVAL;
+
+	len = iov_iter_count(iter);
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
 
@@ -4051,16 +4087,24 @@ static void hci_rx_work(struct work_struct *work)
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
index 070ca388f9ac..4b328fa8dff4 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -224,22 +224,26 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 			    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
 			    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT)
 				continue;
 			if (is_filtered_packet(sk, skb))
 				continue;
 		} else if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
 			if (!bt_cb(skb)->incoming)
 				continue;
-			if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT &&
-			    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
-			    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
-			    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT &&
-			    hci_skb_pkt_type(skb) != HCI_DRV_PKT)
+			if (hci_skb_pkt_type(skb) == HCI_VENDOR_PKT) {
+				if (!hci_sock_test_flag(sk, HCI_SOCK_RECV_VENDOR_PKT))
+					continue;
+			} else if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT &&
+				   hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
+				   hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
+				   hci_skb_pkt_type(skb) != HCI_ISODATA_PKT &&
+				   hci_skb_pkt_type(skb) != HCI_DRV_PKT) {
 				continue;
+			}
 		} else {
 			/* Don't send frame to other channel types */
 			continue;
 		}
 
 		if (!skb_copy) {
 			/* Create a private copy with headroom */
 			skb_copy = __pskb_copy_fclone(skb, 1, GFP_ATOMIC, true);
@@ -385,16 +389,22 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -1863,16 +1873,17 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
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
@@ -2012,16 +2023,17 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 	return err;
 }
 
 static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
+	u32 opt_u32;
 	u16 opt;
 
 	BT_DBG("sk %p, opt %d", sk, optname);
 
 	if (level == SOL_HCI)
 		return hci_sock_setsockopt_old(sock, level, optname, optval,
 					       optlen);
 
@@ -2045,16 +2057,33 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
 		hci_pi(sk)->mtu = opt;
 		break;
 
+	case BT_RECV_VENDOR_PKT:
+		if (hci_pi(sk)->channel != HCI_CHANNEL_USER) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
+		err = copy_safe_from_sockptr(&opt_u32, sizeof(opt_u32),
+					     optval, optlen);
+		if (err)
+			break;
+
+		if (opt_u32)
+			hci_sock_set_flag(sk, HCI_SOCK_RECV_VENDOR_PKT);
+		else
+			hci_sock_clear_flag(sk, HCI_SOCK_RECV_VENDOR_PKT);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
 	}
 
 done:
 	release_sock(sk);
 	return err;
@@ -2127,16 +2156,17 @@ static int hci_sock_getsockopt_old(struct socket *sock, int level, int optname,
 	return err;
 }
 
 static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 			       sockopt_t *sopt)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
+	u32 opt_u32;
 	u16 mtu;
 
 	BT_DBG("sk %p, opt %d", sk, optname);
 
 	if (level == SOL_HCI)
 		return hci_sock_getsockopt_old(sock, level, optname, sopt);
 
 	if (level != SOL_BLUETOOTH)
@@ -2148,16 +2178,29 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 	case BT_SNDMTU:
 	case BT_RCVMTU:
 		mtu = hci_pi(sk)->mtu;
 		if (copy_to_iter(&mtu, sizeof(mtu), &sopt->iter_out) !=
 		    sizeof(mtu))
 			err = -EFAULT;
 		break;
 
+	case BT_RECV_VENDOR_PKT:
+		if (hci_pi(sk)->channel != HCI_CHANNEL_USER) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
+		opt_u32 = hci_sock_test_flag(sk, HCI_SOCK_RECV_VENDOR_PKT) ?
+			  1 : 0;
+		if (copy_to_iter(&opt_u32, sizeof(opt_u32),
+				 &sopt->iter_out) != sizeof(opt_u32))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
 	}
 
 	release_sock(sk);
 	return err;
 }

-- 
2.34.1


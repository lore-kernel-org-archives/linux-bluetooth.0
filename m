Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77C444719
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770760; cv=none; b=q8XoEe+6Hi6ZYxYtpgxT9Vj5DxuOAztMbmbTzg2mI/ZUgJosV/6gpGuk0Yvm9W7Xui+Clx/U7R8z9zdZNVMbmAzQrszuumr6oD6to+y4M7IzDJnHtZaKEunnzRjAD8n1wC41YlUZ/ZkbVb/qv5MKBlciGu8VccsRlBYc2ViPBBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770760; c=relaxed/simple;
	bh=bEfX1ELACmc7lyhTNYzShAwd0GgmXQffKLWrTnYgTjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uL1xVVciDiCQibWPVif6BF/ZoG3Yw/Y1sYl5rrkawUk6+HMbLhR2f/8osFrrnuHJN/YvaCo784Oe9romucNaAVX1BDc9ZobNS5FOBSkCZ/lf8QQpoF/FBVKcvEJpYoAZRzsg8PSjuL9+z5bZXM8n8lHqoDDlOrMRUshX9Bjo+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EnHYvDXc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UXa5AJRW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EnHYvDXc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UXa5AJRW"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777MAp2838817
	for <linux-bluetooth@vger.kernel.org>; Mon, 7 Sep 2026 08:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ueZgO7ADVyLe0V0vHbVULzVjaUIMwuE5zCfC0Y+haxo=; b=EnHYvDXcUX3Poh06
	ToI8EHxHZRBdP1cCYotVwRLI4O/kJZWMWRztU493Vudc37ZBuT5SLO0Lmu62HTWd
	l2QjvVICy3lpPzwN2y35Cj7xUrzKrc9DHXDlhImESK5/ez479ComfTtdjjKLN+6q
	FMfQaACm4RsVZX+2ZQWrp8lEP//BztSsWx/YtkyPZTLDZpLGGNgPTiFkPsL+UiQa
	Mrv93H0INXlIJIWoMjWXZmnmsaAXH4G4xKKiC2q0jrwjCLfVp10/3K1TbRW537qK
	9jTEqGHkUPaZIWFnRIpqXR/SKvmkfLYDCfHRnwcgNsvUzvwp1H4QYJcpU7u0brWN
	WN/oRA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuep1pp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 08:45:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-384d033f7f5so912977a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788770757; x=1789375557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ueZgO7ADVyLe0V0vHbVULzVjaUIMwuE5zCfC0Y+haxo=;
        b=UXa5AJRWrJcdz8u6GaJUsGtOpI5FVPhFArCBuidG//atbRb/YtNDP9YPkjyX5d2rzx
         gMVyN0hBZXuyxkA7zWb2PUJpYcRvM4UjOuku6eQpxBRZtS4K6kTVWPCc/v4FRHB/JMn1
         bQsY1GHjElKQU8u+DbG1ggwrcWVP2v6gHjWJ0VPo3biMINkYonJJ+GwoBSER/mDzGDI8
         0bf1LuzkkgeWRUrVrqT2uZAT7WL3Bc1Acnrd/8OWYAbTk7Kwr1tZ8fQmTF+Ht38frKuA
         lzL6Hdru8BKmunRuBnG1tUoNpWbXNseyOCiDA57zr2wrW4zoc0oxZD6za7B4zxg4KeEk
         R+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788770757; x=1789375557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ueZgO7ADVyLe0V0vHbVULzVjaUIMwuE5zCfC0Y+haxo=;
        b=QkqJuZzbq9HJkgdkQ8TPvTUzWYP79zY1B9OL1PJB4Tgu9ZDMeUX5aVa3O34EoNL9LB
         VJN01PeDsCxYTzOO8r5nm89LVrxlucIChfPeySVGQfNRps0Vv0ZL5iepQkjSvx3xkqKP
         qLsWex0qRrsepGlKnmY9GQPbdE5j8TfFMnre8kzeonzz9hl7SuhpGaQGfUBcgNs75YZu
         OOF6F6Z3P/9cElG+ay2P1IVom64ngifq/IN6sofBjkWAucVAexLn+ITfNQxv8RLi2Wzn
         6Ms/fipiSpGeoiSKLRX6YU7NpTig4FE+LdBlrJ4ieI/s9iRsfTgzkfifVHdZTLnnHiMQ
         NK0w==
X-Forwarded-Encrypted: i=1; AKwUvBzO1T0zzLs2yPcJXc6FiMtjCiAioSapaHXFiNecEYXAPvZ3yXcrNBwAvLfLxpgkyJ4gaRQCl3jBgLujG6lK5K4=@vger.kernel.org
X-Gm-Message-State: AFuF++kNnmhgPW6EW9lRL9X5a8ZHZNpizaGtlLfZ5D1yaG5kwu70gw3e
	purCBXWNqFL0SdFbisRN1aw72p5ODnnVDL2BH7q9QruOZ2siUsDf+LusbAP6j9ACv5nC6c45zXC
	0NI8iapuHAO1debR7ZtOJftebA93OLqDDT7XOQ4xm2dzwbAl9t9PiPVtxKvnNyehFQqIKoWULBa
	SFXL8=
X-Gm-Gg: AYBFou2fkTTo7yX+CmTtUmeTjNt6trPPmYwhjmEeYmy1ZZ1XzQe7pJLoo2aI0Xa8xea
	J4cri8f0HPqKAKSdPvEFokmeUm6Qe+qvz0xmHj6zcgZ9hGACXzSJLJHtLU+3eX7kpMr5Hg+Ra+z
	M/VQuQt08WFqQY+0pXqwFG62w5H7mwoUXof0whT2bqTFMsWje6ieZq7qk9CphoWd3B8CUTJkW8h
	JgpRlah1nI7evyo4w7yIgWYpLZt7M+ueHtRmXS7CtIPG7Mg+lkEmoJyLHu/kPRc2wUQ9ddEBSxe
	EC4myzbj5Nkjbzw/0LpEcXnH5MfzqjNm4A4boGesryeXLS/b+4disnTobPnPqUQzer1y+qGBUz0
	L0oIEHBkJUt76rH3XDO0bloNloqk1sxU2VLLfBLkNqQ/z60U=
X-Received: by 2002:a17:90b:3882:b0:396:a47f:d38f with SMTP id 98e67ed59e1d1-39b268ce386mr20895085a91.3.1788770756816;
        Mon, 07 Sep 2026 01:45:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3882:b0:396:a47f:d38f with SMTP id 98e67ed59e1d1-39b268ce386mr20895053a91.3.1788770756355;
        Mon, 07 Sep 2026 01:45:56 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm23622117c88.13.2026.09.07.01.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:45:55 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 01:45:39 -0700
Subject: [PATCH v3 2/4] Bluetooth: Add generic support for vendor packets
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-btusb_qcc2072-v3-2-1f65350b03b8@oss.qualcomm.com>
References: <20260907-btusb_qcc2072-v3-0-1f65350b03b8@oss.qualcomm.com>
In-Reply-To: <20260907-btusb_qcc2072-v3-0-1f65350b03b8@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX/dWDB82SmXKY
 0X38oM1dL9gSI/4lY8EB7+klVGpc4Veq6MyYR/zgEnS6VHFRqz2A4kuBKPVNznjemrbmGE/DrYE
 znnD7De3c0hQBjpnSKrnToFod2OE3EALUUQJ6HLxWjP9PphmpRad8T2KVJGjTF0phiEpbqa9NnC
 UVIOubnpfWGswPLGzg7LkaFr3m+/dskY9rMmQwDoAQ3Aoui3fleeL4cKg7UV+eHPX0Uj54otryB
 I5NsdmM+2nyNhlRbogz+3rXDnfJosSUoDGJiInEHJo8sUO60MggR0quiq1WNktrV2vLXcFpV3sk
 +fFuPvt5edv6J3o8DMLoq3JiwVJjHy8im/tNJGFl2yM2KMHTMc6L8QvmEDuxGxjpLuCzuu+hQHG
 RAh7Ib+Rr5sH23h/f/F/OFTdZatM0uh83nECfNhJ07CdbyvGo5XV8VW1hh96QnuAFetYN4jg4le
 /9RjW244jCqv0gyZ1eg==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9e79c5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=rupOQ6kNMCESZWuvRX8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 6vBokE-64ADyIiYhOexfwhaGBlbo2CtP
X-Proofpoint-ORIG-GUID: 6vBokE-64ADyIiYhOexfwhaGBlbo2CtP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA5NCBTYWx0ZWRfX2yKc2FrOTmc9
 Zz48a6Ri9L9Z2GD7EqRsF0h24b5LrNTnuLZ6MC+FnpL5b71RwDURYjfz/1pxWVX1WX1NOeg4cJk
 w3/aP9SeDvgZnhJnkDNn6Ffnq0irHW4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070094

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
index 66840df8c020..40a225d41cc3 100644
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
@@ -3047,16 +3049,51 @@ static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
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
 
@@ -4051,16 +4088,24 @@ static void hci_rx_work(struct work_struct *work)
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


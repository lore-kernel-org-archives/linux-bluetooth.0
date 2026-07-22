Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD1439F82
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737479; cv=none; b=WtYklL6z+O4gCdO16loq7YMQycegzvnq8PStXmamekGc2ploHmTKt7mXaHzFiLmwy41LHoa5lShhtshLL1IR1IAWNYjryjLLjYIYUZXdoSqlJT8P3ut30rKS1vYHBVLB+eAQP44Cd5x5o81+PUbfQKvGsPzy1bqJuTITIyyRRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737479; c=relaxed/simple;
	bh=W/APSbXoE3Axn9ZWUkFSUufYWQNnk7m+N50KBsxLGwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fmghUALmVJtSc8t9Rt3QXQZDYwtsD/SIJi3pT4aBuE+kJBd2tYq1KvToDt1M0ObeSFuR6UhNNm/RK6oU5st1Fyp+Cg/GhrEwBBzsUNovWYOZc1OS8+dj7FeSlPNSRigfEDt0rC3m8zLojbHS+DxBNyXA90rDlwa+Xxe1AokBBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H97IPDGt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yio2fNiw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H97IPDGt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yio2fNiw"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFXvXt1146369
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+h/2TMKEJac8Gd0kMzL2pVaT9OZjXwWeomRCsweesLI=; b=H97IPDGt7yCjtDWT
	6M2DtQ9pZYSX1jIeQbWwJnre1jfe8CZsh6DuFadRLj6Oqi1UjAAtpil9RsxhxzBM
	XHtDXtiMvGTg+cuPRYqydVxhjYLhOiPqRl04fosNV75H1Ya18C1Fc4oFV4LzQ4kW
	s/vzMWmx9k/EHn5JAUZWDEJiOk+wPFNmXkyCEIqErWJlk9L2EQtlE1LotUAA4r3c
	0d9Yrb4dg6RdBkEKpWFCIw7b8hU228TUy+m73hcKJK6UVOeIRrvwI+bUtRJ4Eq5r
	HzPCP5MXBKObkhmooafIpOHwZ8CBafn77/EC77NFwN6Zr5paxAyDoSQf7KaLH1d5
	x1jlfA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjntn36mu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:24:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce756aa72eso89335ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784737475; x=1785342275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+h/2TMKEJac8Gd0kMzL2pVaT9OZjXwWeomRCsweesLI=;
        b=Yio2fNiwdvrri4uuHqsvbCSzC0Kbf5J6M9wsEXxSt+iS21rAGImyjCdzWaGTVvZFc8
         k5/14TCbmekrediMKpxUlPSWmTEpbNBUyQBNAPAV/IUvefkLA50cqNeY+hcrU3JV9Nx4
         cP7E+WxL06F3XtYqLpVX259gvoTontzBMztZn9Grj4Ydag+3XR1rXaG3kcQsNX1gelfT
         rKtXFi/lHeGy75pAokaNfWLWm6NvZeku2TmcI6xLLLZUbX0RIf1V3E9X7qFUMJVL3eW/
         2iRMJmY7RhkUgDQg8q0wEZMQmKsJ9q1S46nuxAdrpLbpojKjpJPpkvS+kR78qju/04lO
         OOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737475; x=1785342275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+h/2TMKEJac8Gd0kMzL2pVaT9OZjXwWeomRCsweesLI=;
        b=PPVdqUdvmN35GYY4dtV1gpQcbNGCx4Cjpo4OABRoggmfXuCVjy9rtERgNiLTV4i4X6
         5CCppB3/aLtPPDn+qtuioUs1r6zWN2wSLRlHyN+4Iij6EeLwXce1L+uS3T+gpLXjEfst
         QXbZckw9k6JWrjDeOXklRP/t+1UpGeJW62n3vNIQEBVHABPcf3NHeOTkOLYLeFgBsfL8
         65LE99l3AZGfsowPn3NYoIbzWYOpDEswWnF59ByC/y4MrLtbBqRfnTcLWJP0NdNJ8kNs
         Vb0idUZhO8/w+mPukMzKkJZpj+7kuPOW26keXbjsbQAI6ZoLdpp6Jhx4AgqZ1VXz8/p5
         2eew==
X-Forwarded-Encrypted: i=1; AHgh+RpdIzkwO0muUOHyMFJXHsLLhrcjz57nQEbQdMrIwENHZALkYzvjh/Qvl3D2MzuyUqBfXBZHhPahUxPz0YayKHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweQE9TEf8a20d6z87Tt6TMegQcxpkOpDB5nSIvZWyggKzDo99I
	TdrFXDjqMJf/wjR/lDNGHpTqBLbIU7J5/pMR1hOa82ewe2AYMZ3TwJ3AXTxI8/GqNtk4t3DPMDH
	WwGyx9n904cCn09OAzdsDWSxS9DovJcu4QMIAKMC5DwA8D+2Uf8xph6h03Rtk7RymxeXYdJ4=
X-Gm-Gg: AR+sD13mrPW225Zjp+FoHSCozEwBUDtO28qgAvBxe4Z88uSLzdOjn9LCcLB3iTMDjXk
	/vAuheSutSZulr0rnfzLAUyQfzxizUgHzK9I5n4AIVb7wT4X/kNXMZCFeISsx0hh+35HuyjDg1X
	Been8gDcJXLn3brrKAw8rqcSwNMRB252ZhacLQLKXZMeVpeuZXpNwIuYmJZzd7FFm+ODSptVkYp
	sBW1TPfTj/tTJ+SPnqJzUrF0WXyR2tDPPo8V+KLWqV1p3NT1UIU6n/MsjMdw+NxuvnEtIgZwUl1
	VmZQgrSZpG01OpRY6z8kY3LFuuLGAdBBykiJybhB7wrBwzeqhKDmuhn9f+QuLbwNk0WgKBYOMHg
	46nkzUFct8RxDwWhxID0wfCQbwh+QBSNpt4q0uidLv6hfiN0=
X-Received: by 2002:a17:903:230d:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2cf8017d572mr68555355ad.0.1784737475200;
        Wed, 22 Jul 2026 09:24:35 -0700 (PDT)
X-Received: by 2002:a17:903:230d:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2cf8017d572mr68555085ad.0.1784737474581;
        Wed, 22 Jul 2026 09:24:34 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc9d932sm10569970eec.12.2026.07.22.09.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:24:33 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:24:21 -0700
Subject: [PATCH RFC v2 2/3] Bluetooth: Add generic support for vendor HCI
 frames using HCI_VENDOR_PKT
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-support_vendor_hci-v2-2-132b506460a4@oss.qualcomm.com>
References: <20260722-support_vendor_hci-v2-0-132b506460a4@oss.qualcomm.com>
In-Reply-To: <20260722-support_vendor_hci-v2-0-132b506460a4@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=AJsSZ1gA c=1 sm=1 tr=0 ts=6a60eec4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6DYPQAbK-MwNJFPfgmcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: DUaOJk2tJanv-bIK1Wn2Ji9SSQzqPq1g
X-Proofpoint-ORIG-GUID: DUaOJk2tJanv-bIK1Wn2Ji9SSQzqPq1g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2MSBTYWx0ZWRfX0ierp63ND6B7
 Nrpk4+jJCBDV57agGCj7EZx5pS52OkVA2Xv0pI52u8uKUju+v+fYkCikQgfaYJ0Q40ClQjmENDs
 p5ub4BJIbFqAAJc9qOpQkFFeZJYrV0Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2MSBTYWx0ZWRfX1DqHM7LiTyFZ
 y3yNkgZbieNaIkPL2OQoaIOYdNEiITLca6qphE1vKuocwHwPuZuKBuunK3qEOrK+cSTkIU+tpSW
 LbWTaLXS64vsy9ltl5qRjSOAocY0bTftgUAHmub29T61qdseZdQx325muG3DunTPpEAsR+vseo5
 zuVtr7wzdN6Fc9R7HB68nIZcIzZ6ZJlEOa2Y/Psbb0s9Emeo5vTNGDPcZTL1sjePRE1k7jV5V9U
 Xhf9EKVEF3Pp0aw5zuqjR5fiJdVAo8t5dHo1VYUGNtmhGvNVrHo8pDkO75EGJCYsFzAFNodmkdb
 aBxxhOr2CJpgYZKYu4T+6f494HAP9CEv69VY/p9l5PXe+QLceWxOXQVLxK2eVLaVJMU/ZSFC0pT
 v4ri/ndOVxwTnpkWmt9MV8lvbZ9k8QBIddWYsoguDxnp9WOS6cRkEokvZEyC/ue7tVfuwQWZ3k5
 qq2Wqty+IkwZGw89qIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220161

The virtual HCI_VENDOR_PKT (0xff) has been defined but never used by
the BT core. Now, there is a requirement to implement it, as follows:

For Qualcomm multi-subsystem BT chips, the transport wire carries both
BT-HCI and PERI-HCI frames. PERI is a subsystem on the chip. Take the
upcoming QCC2072 support as an example:

    Packet type                 BT-HCI indicator   PERI-HCI indicator
    -----------------------------------------------------------------
    CMD (Host -> Controller)    0x01               0x31
    ACL Data (bidirectional)    0x02               0x32
    EVENT (Controller -> Host)  0x04               0x34

To generically support vendor HCI frames:

- Show them in btmon logs as they appear on the wire.
- Allow userspace to send/receive them via HCI_CHANNEL_USER, with a
  socket option to control RX, defaulting off to eliminate regression
  risk for existing applications.
- Add hdev->recv_vendor_pkt() to handle vendor frames in hci_rx_work()
  like BT frame handlers.
- Add hci_send_vendor_frame() API similar to existing __hci_cmd_send().

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 include/net/bluetooth/bluetooth.h |  2 ++
 include/net/bluetooth/hci.h       |  1 +
 include/net/bluetooth/hci_core.h  |  4 +++
 include/net/bluetooth/hci_mon.h   |  2 ++
 net/bluetooth/hci_core.c          | 38 ++++++++++++++++++++++++++++
 net/bluetooth/hci_sock.c          | 53 +++++++++++++++++++++++++++++++++++----
 6 files changed, 95 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index b624da5026f5..d9870a43a2c4 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -256,6 +256,8 @@ struct bt_codecs {
 
 #define BT_SCM_PKT_SEQNUM	0x05
 
+#define BT_RCV_VENDOR_PKT	23
+
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 50f0eef71fb1..ac97550cbdba 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -398,6 +398,7 @@ enum {
 /* HCI socket flags */
 enum {
 	HCI_SOCK_TRUSTED,
+	HCI_SOCK_RCV_VENDOR_PKT,
 	HCI_MGMT_INDEX_EVENTS,
 	HCI_MGMT_UNCONF_INDEX_EVENTS,
 	HCI_MGMT_EXT_INDEX_EVENTS,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e7133ff87fbf..428261591288 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -28,6 +28,7 @@
 #include <linux/rculist.h>
 #include <linux/spinlock.h>
 #include <linux/srcu.h>
+#include <linux/uio.h>
 
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_drv.h>
@@ -645,6 +646,7 @@ struct hci_dev {
 	int (*setup)(struct hci_dev *hdev);
 	int (*shutdown)(struct hci_dev *hdev);
 	int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
+	void (*recv_vendor_pkt)(struct hci_dev *hdev, struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	void (*hw_error)(struct hci_dev *hdev, u8 code);
 	int (*post_init)(struct hci_dev *hdev);
@@ -2327,6 +2329,8 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
+int hci_send_vendor_frame(struct hci_dev *hdev, struct iov_iter *iter);
+
 int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
 		   const void *param);
 
diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 4b2a0af4ed58..7710688c0d30 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -50,6 +50,8 @@ struct hci_mon_hdr {
 #define HCI_MON_ISO_RX_PKT	19
 #define HCI_MON_DRV_TX_PKT	20
 #define HCI_MON_DRV_RX_PKT	21
+#define HCI_MON_VENDOR_TX_PKT	22
+#define HCI_MON_VENDOR_RX_PKT	23
 
 struct hci_mon_new_index {
 	__u8		type;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1e324c05af24..90807562e8ed 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2917,6 +2917,8 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 	case HCI_ISODATA_PKT:
 		break;
+	case HCI_VENDOR_PKT:
+		break;
 	case HCI_DRV_PKT:
 		break;
 	default:
@@ -3053,6 +3055,33 @@ static int hci_send_conn_frame(struct hci_dev *hdev, struct hci_conn *conn,
 	return hci_send_frame(hdev, skb);
 }
 
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
@@ -4057,6 +4086,15 @@ static void hci_rx_work(struct work_struct *work)
 			hci_isodata_packet(hdev, skb);
 			break;
 
+		case HCI_VENDOR_PKT:
+			BT_DBG("%s Vendor packet with type 0x%2.2x",
+			       hdev->name, hci_skb_pkt_type(skb));
+			if (hdev->recv_vendor_pkt)
+				hdev->recv_vendor_pkt(hdev, skb);
+			else
+				kfree_skb(skb);
+			break;
+
 		case HCI_DRV_PKT:
 			kfree_skb(skb);
 			break;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 070ca388f9ac..060c265e2c53 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -229,12 +229,16 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 		} else if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
 			if (!bt_cb(skb)->incoming)
 				continue;
-			if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT &&
-			    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
-			    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
-			    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT &&
-			    hci_skb_pkt_type(skb) != HCI_DRV_PKT)
+			if (hci_skb_pkt_type(skb) == HCI_VENDOR_PKT) {
+				if (!hci_sock_test_flag(sk, HCI_SOCK_RCV_VENDOR_PKT))
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
@@ -390,6 +394,12 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -1868,6 +1878,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
 		    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
 		    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT &&
+		    hci_skb_pkt_type(skb) != HCI_VENDOR_PKT &&
 		    hci_skb_pkt_type(skb) != HCI_DRV_PKT) {
 			err = -EINVAL;
 			goto drop;
@@ -2017,6 +2028,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
+	int opt_int;
 	u16 opt;
 
 	BT_DBG("sk %p, opt %d", sk, optname);
@@ -2050,6 +2062,23 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 		hci_pi(sk)->mtu = opt;
 		break;
 
+	case BT_RCV_VENDOR_PKT:
+		if (hci_pi(sk)->channel != HCI_CHANNEL_USER) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
+		err = copy_safe_from_sockptr(&opt_int, sizeof(opt_int),
+					     optval, optlen);
+		if (err)
+			break;
+
+		if (opt_int)
+			hci_sock_set_flag(sk, HCI_SOCK_RCV_VENDOR_PKT);
+		else
+			hci_sock_clear_flag(sk, HCI_SOCK_RCV_VENDOR_PKT);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -2132,6 +2161,7 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
+	int opt_int;
 	u16 mtu;
 
 	BT_DBG("sk %p, opt %d", sk, optname);
@@ -2153,6 +2183,19 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_RCV_VENDOR_PKT:
+		if (hci_pi(sk)->channel != HCI_CHANNEL_USER) {
+			err = -ENOPROTOOPT;
+			break;
+		}
+
+		opt_int = hci_sock_test_flag(sk, HCI_SOCK_RCV_VENDOR_PKT) ?
+			  1 : 0;
+		if (copy_to_iter(&opt_int, sizeof(opt_int),
+				 &sopt->iter_out) != sizeof(opt_int))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;

-- 
2.34.1


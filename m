Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79E3A9601
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784524443; cv=none; b=eBtrvFI2a+JsviParpufhYVHYvYPt7+yTYM9nRVspY8uDaH91383WchynkLyrbE9YXNBy9fbqckfHH/J/5LYTTBvThMyyLEiDdxuaNzKsr9cTw9poulo2qrD+7DcgplaGY0bLD2daAiIlncl1iQ4TQk7967fNz1VFKyg+Kjr9NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784524443; c=relaxed/simple;
	bh=ZETauEXzG5EEsXHCHNu+/+QiAEohdzAr2I8JzDMcBw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Quuhf9Dy2oec+I20i39l0jFH/kwikrhF+guVaHGegWGs24iD13rS+JdRh7LgQ8emf5f04omm6GhZN000jWz/QwUqG2cHVCFfxG7JfeDi5H8AfdE4KyoEcbuGMNz3mlASHI5+b32yRl8huJo2rSEH/fC/hWgZ8JyiQ9j+5O0e1os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aq+PiJeJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RcgNYW8j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aq+PiJeJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RcgNYW8j"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNt1bt757341
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wtIFGoSBRcKLFYscg1P2Xh
	manSfP8q5tPz3vP9DYLG8=; b=Aq+PiJeJey/JVsvNOY4SlEJvXoc+XbkGBKEDYj
	5iSJmYQX+hNGjNzlZ7Qz0gbCLdixo6CsaJKASphKV4K6P59lnaelPD6HtQcpK1Qx
	/vMaCs952Q0zG0nKaW5v/713ZAAxiCtkGKRV6b+SWdIbEH4dQJhHS+PpzeBJhpY/
	DjZ1T4Ox0FAedy9k1waILlzfn2CpZS+1+hMNT5KAyDY3TQy1f7Fy6TgQcWp8I79K
	hm16A/KyHfOi/7QUY5pKPtie8FZE3aDhhJPLfvgWLfA8YjzrM1kW3nClLcYRH0Gx
	GkLL5i20vE0WstlCcr1agS+Pev1+loNctxyhBG8ziEA5IHbw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnmekx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 05:14:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc7ea29141so45413615ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 22:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784524439; x=1785129239; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wtIFGoSBRcKLFYscg1P2XhmanSfP8q5tPz3vP9DYLG8=;
        b=RcgNYW8jpOvyibTOeOywLRveePnzQFpuciRGC7rgQZeuFOWcCpFPAanUoYW0kVAkMR
         iTPSyFN2H68bNa/rrKTkWnoJo83QvgG0mxkrWRG0XH99U/7zsFvDN3Y4fZDjel07oG7g
         ftQWn8AAqNQ9AeAdU2AT0vFsbxtIleLmSmu9e+V/yJ+QXnV5qwfWlD5ObrTCRfPayF6X
         YSiaxGw/2bUmlulvQvE/I2XyIkrU2YzDejN1HDzFV/5vVYDZC0D83kQTnKL6yTxaEH1y
         UFWmSA7+tg9MOKJp0gKWeI/AtN8J55D2DnBSNzxz+CNJz9oUprWjmlUOrjQg+MxeEXp+
         YTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784524439; x=1785129239;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wtIFGoSBRcKLFYscg1P2XhmanSfP8q5tPz3vP9DYLG8=;
        b=VmNQ/539kxrzEkC6OGysyKLil7QUrrRtHA0kPGAGQoJO5JXFZgSK0EGFXJgZQOHekX
         ULfUTGJScpGx/p0qGAgnVdqUGmDXL16jPGPkFep8XAzHYSZLysd7HmKGfU2en5OeMeKM
         EMXrRJES6k7X2aGHSmUJjnRjLL6SxKW7Ag9FYW1Wx6zWQxtzbo3JRaYyck+YwfGcikaw
         wNJqdu57rhqxaGwX2zkdBw/d/xgexqKCb0A8+OQ4lvdVbtOp3CGa5iMIIijXFt9AIQ4/
         JUKUJBE63tvCI/haD3n/w9fj35ekIgEV4UZ9z07yyBp7TIWeipf6Lmj6PKIjcODqwboI
         /36A==
X-Forwarded-Encrypted: i=1; AHgh+Rq2zU/mjMXp1NAxwBkfHDIbTS3qXmrgQt10UcDNVDfuoua50gP7Wqp7xTyjwmBdSVft62UkuJO8rrUsaioUpHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGUzGEmwVXSSksgdqcRqejPPGRIEf4Z2mc/XoIEIFP0kONgMDq
	AXEX1Wxe6hniefsK/dHKrOo3igniuk+7nLH9rmPpHbiClFdNp5FrMfdJFjCnazOMLgKp8C7g/bk
	s3fW9A0s7wXGHgyhKzcKOOFY1R++hLL4WsWJCG7DmHCZDNBje/UjE28aZwei29lDRnJYj5iuK+D
	pDC08=
X-Gm-Gg: AfdE7cm96+yQC0aAjzioswOgTZ8x2Y8S9YCl4G9oG2anq4BjoOewwSblG3iHBpuaecy
	XLiCsOduvHKgznp7vWcj/Yhe4JB+mss07ZfnhaAriHdoO4MlItEJBONOjAcnTGqBrDKpp7qbFmu
	t7PDxKBb3bKSqIhkYCjVNKT3nVoFW/JUB6nvqjwRFhYzOXiiUlBKGG0ZwyHbj3O3XAyt6x/B+E4
	PfjRIVKwv+nmETA9LP7HAW8YtXh0a4MleXW6jyMuR5u79UXRo3vLF2CQ6KQ3S7niyNjTpBHnRLx
	a9cQbo42hfArXgQVwfJYqEX+IMZ5veW4fGzpqYn9h81b4xDsUrO8FzOm8bW9Sw6YaaV3ncJMgQs
	6kOmNHD7RgzvzckZwDVozSqDFdWehe+NpGKhGRBZkpsDYFRY=
X-Received: by 2002:a17:902:f78c:b0:2c9:b96a:2855 with SMTP id d9443c01a7336-2cf34667e9fmr103411085ad.0.1784524439365;
        Sun, 19 Jul 2026 22:13:59 -0700 (PDT)
X-Received: by 2002:a17:902:f78c:b0:2c9:b96a:2855 with SMTP id d9443c01a7336-2cf34667e9fmr103410915ad.0.1784524438840;
        Sun, 19 Jul 2026 22:13:58 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9d439sm37620122eec.5.2026.07.19.22.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 22:13:58 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sun, 19 Jul 2026 22:13:57 -0700
Subject: [PATCH RFC] Bluetooth: Add generic support for vendor HCI frames
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJWuXWoC/yWMQQqDMBAAvyJ7bsBIsNVroQ/wKiImrro9JGFXR
 RD/3rQ9zsDMCYJMKFBnJzDuJBR8An3LwC2Dn1HRmBiKvCjzu66UbDEGXvsd/Ri4XxwpPVlrjKk
 G+0BIYWSc6PhNW2heT+j+Ujb7Rrd+d3BdHzp6n757AAAA
X-Change-ID: 20260719-support_vendor_hci-1fbb4449ab8e
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: fJfeEpMaV98dET3SBkEym3oWk46DejoY
X-Proofpoint-ORIG-GUID: fJfeEpMaV98dET3SBkEym3oWk46DejoY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA1NSBTYWx0ZWRfX0qcgroqe990m
 8gH3VeJzO/yaxL9ra5do2rnnNJbGOU2fTejk2OndLPWsejrLinTYb5IhPP3Ot/+gIRK2JhY31Zf
 KZYpClvqYbofQBRmAU0lUNzowzL6FCHEkFSR86HAAXeN1Yby+VMAV4dogjDvuZqOQsmCGiwVL1m
 qxtNgfmfFIgSTE6uTJncp6x5k3/bi4YIxicNQPCoBEBmAzxkYmRMn7nxtNBNxsbsesTgpk/zPJ5
 rG6VDPja8ca6YAtd0mdEaPrq+0RH/njG+r5q4txTLTea0Xf1cwGOgIe/RcKZpUNem5JMiLRKbps
 N1I5wOyaM9QFIGdeyDoKrNUkcdBgXsBPSmTkAAnBba5iLWxqUQsdHjVEthtvB2GX/Zv3ayCcEMN
 WjKZqFoI5fv9Tgn8SgpYyzAuie5JNfFTpz2o9y5BFOh4/OMjfgtE+gDgg7woNxapHPtjgy0iBaH
 dyQTEb0ik8qEVtgrzfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA1NSBTYWx0ZWRfX7/dJcxSYDWCi
 XgmpfV5H1ZJq/snPUElqAJGrYs4eRQ0USPHfUkvJFO8dQnHch29L+naAy/yXkSoHx1P6zzNn1u6
 ePl3rUp01VDzera5pTAgvcqKvVuVrs4=
X-Authority-Analysis: v=2.4 cv=YsQ/gYYX c=1 sm=1 tr=0 ts=6a5dae98 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Z8Lx9VBdTKfv_1qZMnEA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200055

For Qualcomm multi-subsystem BT chips, the transport wire carries both
BT-HCI and PERI-HCI frames. PERI is a subsystem on the chip. Take the
upcoming QCC2072 support as an example:

    Packet type                BT-HCI indicator   PERI-HCI indicator
    --------------------------------------------------------------
    CMD (Host -> Controller)   0x01                0x31
    ACL Data (bidirectional)   0x02                0x32
    EVENT (Controller -> Host) 0x04                0x34

To generically support vendor HCI frames:

- Show them in btmon logs as they appear on the wire.
- Allow userspace to send/receive them via HCI_CHANNEL_USER, with a
  socket option to control RX, defaulting off to eliminate regression
  risk for existing applications.
- Add hdev->recv_vendor() to handle vendor frames in hci_rx_work() like
  BT frame handlers.
- Add hci_send_vendor_frame() API similar to existing __hci_cmd_send().

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Hi Luiz
To address the below concerns you raised on previous
discussion, and inspired from your suggestion to add hdev callback:

- Not use safer skb helper like skb_pull_data()
- It will skip sending to the monitor, making debugging much harder

Looking forward to your further comments.

Why hdev->is_vendor() instead of multiplexing vendor frames under a
virtual HCI_VENDOR_PKT + vendor indicator byte ?

1) The virtual HCI_VENDOR_PKT isn't used by the core itself
   currently, and may be removed later.
2) It makes full use of the indicator (hci_skb_pkt_type(skb)) space,
   which is large enough to accommodate vendor frames without an
   extra layer of nesting inside HCI_VENDOR_PKT.
3) It lets userspace and btmon logs see the exact same frame as it
   appears on the wire.

Previous discussion link:
https://lore.kernel.org/all/CABBYNZJpdeoZ16bObLRPhng2dfyNeK9ix9_-z_hMZhJ0QxTxGg@mail.gmail.com
https://lore.kernel.org/all/CABBYNZJ0zoVVVxuM48L=Km==gnrQuskrbjB6q_aNV0KEEY3+5w@mail.gmail.com
---
 include/net/bluetooth/bluetooth.h |  2 +
 include/net/bluetooth/hci.h       |  1 +
 include/net/bluetooth/hci_core.h  | 13 +++++++
 include/net/bluetooth/hci_mon.h   |  2 +
 net/bluetooth/hci_core.c          | 22 +++++++++++
 net/bluetooth/hci_sock.c          | 78 ++++++++++++++++++++++++++++++++++-----
 6 files changed, 108 insertions(+), 10 deletions(-)

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
index e7133ff87fbf..20a455d90ef3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -645,6 +645,8 @@ struct hci_dev {
 	int (*setup)(struct hci_dev *hdev);
 	int (*shutdown)(struct hci_dev *hdev);
 	int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
+	bool (*is_vendor)(struct hci_dev *hdev, const struct sk_buff *skb);
+	void (*recv_vendor)(struct hci_dev *hdev, struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	void (*hw_error)(struct hci_dev *hdev, u8 code);
 	int (*post_init)(struct hci_dev *hdev);
@@ -660,6 +662,15 @@ struct hci_dev {
 	u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *skb);
 };
 
+static inline bool hci_is_vendor_frame(struct hci_dev *hdev,
+				       const struct sk_buff *skb)
+{
+	if (!hdev->is_vendor)
+		return false;
+
+	return hdev->is_vendor(hdev, skb);
+}
+
 #define hci_set_quirk(hdev, nr) set_bit((nr), (hdev)->quirk_flags)
 #define hci_clear_quirk(hdev, nr) clear_bit((nr), (hdev)->quirk_flags)
 #define hci_test_quirk(hdev, nr) test_bit((nr), (hdev)->quirk_flags)
@@ -2327,6 +2338,8 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
+int hci_send_vendor_frame(struct hci_dev *hdev, struct sk_buff *skb);
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
index 1e324c05af24..c12c180e8293 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2920,6 +2920,8 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	case HCI_DRV_PKT:
 		break;
 	default:
+		if (hci_is_vendor_frame(hdev, skb))
+			break;
 		kfree_skb(skb);
 		return -EINVAL;
 	}
@@ -3053,6 +3055,18 @@ static int hci_send_conn_frame(struct hci_dev *hdev, struct hci_conn *conn,
 	return hci_send_frame(hdev, skb);
 }
 
+int hci_send_vendor_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	if (hci_is_vendor_frame(hdev, skb))
+		return hci_send_frame(hdev, skb);
+
+	bt_dev_err(hdev, "invalid vendor frame with pkt_type 0x%2.2x",
+		   hci_skb_pkt_type(skb));
+	kfree_skb(skb);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hci_send_vendor_frame);
+
 /* Send HCI command */
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 		 const void *param)
@@ -4066,6 +4080,14 @@ static void hci_rx_work(struct work_struct *work)
 			break;
 
 		default:
+			if (hci_is_vendor_frame(hdev, skb)) {
+				BT_DBG("%s Vendor packet with type 0x%2.2x",
+				       hdev->name, hci_skb_pkt_type(skb));
+				if (hdev->recv_vendor) {
+					hdev->recv_vendor(hdev, skb);
+					break;
+				}
+			}
 			kfree_skb(skb);
 			break;
 		}
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 070ca388f9ac..903498e6db3d 100644
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
+			if (hci_is_vendor_frame(hdev, skb)) {
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
@@ -359,6 +363,7 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 	struct sk_buff *skb_copy = NULL;
 	struct hci_mon_hdr *hdr;
 	__le16 opcode;
+	bool is_vendor_frame = false;
 
 	if (!atomic_read(&monitor_promisc))
 		return;
@@ -400,7 +405,26 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 		opcode = cpu_to_le16(HCI_MON_VENDOR_DIAG);
 		break;
 	default:
-		return;
+		is_vendor_frame = hci_is_vendor_frame(hdev, skb);
+		if (!is_vendor_frame)
+			return;
+		if (bt_cb(skb)->incoming)
+			opcode = cpu_to_le16(HCI_MON_VENDOR_RX_PKT);
+		else
+			opcode = cpu_to_le16(HCI_MON_VENDOR_TX_PKT);
+		break;
+	}
+
+	if (is_vendor_frame) {
+		skb_copy = __pskb_copy_fclone(skb, HCI_MON_HDR_SIZE + 1,
+					      GFP_ATOMIC, true);
+		if (!skb_copy)
+			return;
+
+		*(u8 *)skb_push(skb_copy, 1) = hci_skb_pkt_type(skb);
+		hdr = skb_push(skb_copy, HCI_MON_HDR_SIZE);
+		hdr->len = cpu_to_le16(skb->len + 1);
+		goto out_comm;
 	}
 
 	/* Create a private copy with headroom */
@@ -408,14 +432,15 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!skb_copy)
 		return;
 
-	hci_sock_copy_creds(skb->sk, skb_copy);
-
 	/* Put header before the data */
 	hdr = skb_push(skb_copy, HCI_MON_HDR_SIZE);
+	hdr->len = cpu_to_le16(skb->len);
+
+out_comm:
 	hdr->opcode = opcode;
 	hdr->index = cpu_to_le16(hdev->id);
-	hdr->len = cpu_to_le16(skb->len);
 
+	hci_sock_copy_creds(skb->sk, skb_copy);
 	hci_send_to_channel(HCI_CHANNEL_MONITOR, skb_copy,
 			    HCI_SOCK_TRUSTED, NULL);
 	kfree_skb(skb_copy);
@@ -1868,7 +1893,8 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		    hci_skb_pkt_type(skb) != HCI_ACLDATA_PKT &&
 		    hci_skb_pkt_type(skb) != HCI_SCODATA_PKT &&
 		    hci_skb_pkt_type(skb) != HCI_ISODATA_PKT &&
-		    hci_skb_pkt_type(skb) != HCI_DRV_PKT) {
+		    hci_skb_pkt_type(skb) != HCI_DRV_PKT &&
+		    !hci_is_vendor_frame(hdev, skb)) {
 			err = -EINVAL;
 			goto drop;
 		}
@@ -2017,6 +2043,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
+	int opt_int;
 	u16 opt;
 
 	BT_DBG("sk %p, opt %d", sk, optname);
@@ -2050,6 +2077,23 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
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
@@ -2132,6 +2176,7 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
+	int opt_int;
 	u16 mtu;
 
 	BT_DBG("sk %p, opt %d", sk, optname);
@@ -2153,6 +2198,19 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
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

---
base-commit: 7f02cdbb4cf17df8aa1977eea0cf490c472a706d
change-id: 20260719-support_vendor_hci-1fbb4449ab8e

Best regards,
--  
Zijun Hu <zijun.hu@oss.qualcomm.com>


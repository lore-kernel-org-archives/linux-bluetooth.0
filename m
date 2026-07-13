Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C147400E0C
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944077; cv=none; b=Gr0ALmOTtioyAUaZDF0BAuqO4s90kDWco1lBe7ZYwI80hf54czGr1E3QOpZRHtiGszs74rD5LN5XzyR46xcObE+psc+7o3rPN+ZTsYq7PDBXxp/FjkLS6ylRD0nsYQkKKNeRTqrZCqCKcMQcgkk1SUQnkxL0I2cuwjyX/wwi+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944077; c=relaxed/simple;
	bh=53ICJc8qJnkq2uR6QNbHG4MizR5aQngiFWAplX8e7ZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsDsqgMGCN0xyjxrRnA458Y0Py+N3x4DCh8fOuqiDxdcczkAbbHnRBtSatYCKkSfJNCJpIlUZF8bSX4JZ8yfS7Woha9y6tAEM+4J7kt0CFe3OByZi+Edkcp/MhLFshEqG7wg2/8liQwKxN7BxWlfiXnsQEJ28+t1v6BOzbhXiCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iBr/2yOW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fVGWbQiz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iBr/2yOW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fVGWbQiz"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D7Ykr6794223
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G3bvnkiaRpsv8wjgu6CwsTey95Lq+Ru74ZSc4ZFHu60=; b=iBr/2yOWmtUKRsyQ
	CXnrufnFBDgBPaYx+EhbD6iUI6/qPZlalf6SluaSCioo+12Jp0ibfnEBIG3N0sdn
	0NNavxwM0xl4v2MRrT34XFo3EvcDN8NUEo+hxsiea/dP09OQX2+GHB7D/WdeFlC4
	C8OZOfawhXZwd1VQY1YstR9miR8mr3l68CktV7Kc0Xr6/FvZPoBSyRhy+1mYRhNg
	dFATIsVB/2YaaFjHjUdBn4qQ0+wmR6HIl12SnHirs46w6/FfengAWfhA+GR2YLhc
	aoIZ0GcdFqbg3ik4UwqSaCeqKRIRBHd5+ZXnOvinbP86LfyI28dZySih8FN07PWq
	FTzKNg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcurn0xt4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 12:01:14 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca6a6373ad4so304384a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783944074; x=1784548874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G3bvnkiaRpsv8wjgu6CwsTey95Lq+Ru74ZSc4ZFHu60=;
        b=fVGWbQizldaadDUgQY8aARYdRDsUELbzEZutDAiJnSccc6K+M/kewjBQSuyZFpdBeY
         cBeVL53tJwvniMgnBYgXQ0PBeMukR3izqIE6qWauJGlvHpPrMkjIZEOHYQXxaZAYFpPx
         tsG8Y5wbcd9mtN3PwFDewBV8wAVqE27NZRzeWximSP95dMu+i/SGl53tXuT5q8OfkGH9
         q0h7yFCrrI/YnEDRC8bdN6ZSyBy8nmTiDkaBvnvij/PekZY+21mr6dVt3wmLrPRoJ/Yh
         yLQPTnDlb1tfvxzK9nfpECfCkprpGHYRLZreFA27Hvwkydsh7KI7rfDUnDbikhRQmMjm
         85BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783944074; x=1784548874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G3bvnkiaRpsv8wjgu6CwsTey95Lq+Ru74ZSc4ZFHu60=;
        b=GsFg7JBA2c8C+OfEQ3sn/Geh6w5M6lL8bbc5++mJFF4M3foKCVOwc0zKZwL+Ov3MP3
         rePDUCz51Hgy/wkfsrcMDpJzxIG/mihPN0qZgupH34u93lSZJSYdIhJ7cpQXAlqMxrvx
         FPS8IyHEcW7s29HBA2JE2gb0IC0H/o+CbTWPwUr9HqScHJtcBzBDdb0FH15clSvq2r5u
         dqNtLKUmkcss6rFLf0sx1ZtRildIOTlyzM9z1wIjN5CIbY7kEVSwIgTlty4Ee5uy8VdQ
         AHiTzWpee1gA3Nosa8uSI81UuCUtgfwzul3NdPilpMCPDQgehyXZRS2HBGUkFzxYuodc
         yrHA==
X-Forwarded-Encrypted: i=1; AHgh+RqC0Z9q4GRf1dtfW55HN9IzdgqXWFUnJ4LtvtkCra8lakaO3eeFhO+suxWupe/hhISQQ/hMqpv5x8VoCruGlIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySwLJRnP+mEABvPtENBz/+Y5ZhFReOqNWiTQjh6vPJeGj/Zocx
	BqlGfma/xcVaBYTY247a2Izqou8AYEiCXUcFKxurxNlAM2/k+s9nzmemZlj2TAlRZn2Q1F9NKDb
	D2a/4BESaPmV3fjRfine7UA7w5APSOyR2ojjqmKI0cak14sUDZW1gURRRP8+Avp2YAtf8eFthJc
	5Xd8ajdXt2
X-Gm-Gg: AfdE7ckmXK5cS1YJQ8Ltz2bTAD6Q6ZZmnqyrut19mRs7IwHwUlYH30CxHHo/oFbQACO
	4srdmPOh6hSfxU6e7RJp5khExAml8yGCIy3oAGi3VcUY547zgTEJ8R6E9PWCJMaHrdNKZBd4lG8
	FNxcGFg0rv6aGIYbPrZbrpGc+96ZfTe7nMuoXUkzumwLXWUBX80tsWn/5aK/vBlKOwcPBkBnXm5
	lHCVbrZFBimYmm4MNvL0CeWwl1gXvsXw+ry/x5pvY6xHgBbcabWbVfBBCd+mm00MkjsnDF3iDvZ
	ObLhxuADeLW+RlWgM5+0bBcMoASAuRE3RqPolifE2xIRzLqiXY+NooVxt0pZOqy/lnijJ68k/+y
	LoRZJGuUzCBaJUMJhdxpM1eu9c/18H2wJnQcxzVvi/SK0eziBOyOte9HdtA==
X-Received: by 2002:a17:90b:5867:b0:381:cef1:11b2 with SMTP id 98e67ed59e1d1-38dc77c79b5mr6893211a91.7.1783944073678;
        Mon, 13 Jul 2026 05:01:13 -0700 (PDT)
X-Received: by 2002:a17:90b:5867:b0:381:cef1:11b2 with SMTP id 98e67ed59e1d1-38dc77c79b5mr6893183a91.7.1783944073214;
        Mon, 13 Jul 2026 05:01:13 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm74577772eec.31.2026.07.13.05.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:01:12 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 05:01:11 -0700
Subject: [PATCH v2 1/5] Bluetooth: coredump: Introduce and apply
 hci_devcd_state_name()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-btusb_prep_qcc2072-v2-1-bbcb651285f2@oss.qualcomm.com>
References: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
In-Reply-To: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: -R_y5LxK0_qA_Tk1u8833jAjUIQRzf3L
X-Authority-Analysis: v=2.4 cv=IcK3n2qa c=1 sm=1 tr=0 ts=6a54d38a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=-o8gAGCozA265rLodYYA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX/TtQAHHn910g
 fGCQaKStAWP/pbMrIIwJRtv2i1D7EhR2d5X8POlnM5p8AKDZJLc7ds3zPMBMX3qNpfL++1T0wwq
 9mXiWqWsC5cUfsekTPM3KAOXY+pNfJ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX+RH8jS05QYhj
 5q2WWgvawRW3Q7mEwc6/harVC3FypFCtXgtLGfKGzVIABtjQzbA80nwqlYmeivA9M8G7dEaajte
 +XoIzA0icOrnaJoXIuLQHdpHaGNS/CUZIx8BMxEMpPIs0WPdES9BsqEfDU5cJOekO3oHfY9cEzb
 qKiUUMxzr5umh0Ed1PzVY8Vbwmudq3RdQnzpLMfsYH38N8MVJjFfyUHGX/uaA7wn4l9w9YfpH5r
 hFFWZSRId0pqdEnGGbe9n8LSwD3Q/wtuXzlTnCzGpCLd2Vw68rIIyxVboo0M+YWreX2Jb7eWUqv
 3ryOAAOX+WnjCk+WbAvKj0iwjW7t8Ta2T7Y9RrEIzjk979z1Qb2qHmMRNnkksYFchuCdgC+LbVX
 3s56JL+0gGJxRm3IqCQKa1uh0RYz56jeg+0bLl/LvnGotz3zInyRNHBBfk7JlW4DmhPP6lNVN3V
 hSlRnhtLTrLte1W0X8g==
X-Proofpoint-GUID: -R_y5LxK0_qA_Tk1u8833jAjUIQRzf3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130125

Introduce hci_devcd_state_name() to make devcoredump state more
readable, and apply it in coredump.c. Also remove a trailing space
in two bt_dev_dbg() format strings while applying it.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 include/net/bluetooth/coredump.h |  7 +++++++
 net/bluetooth/coredump.c         | 45 +++++++++++++++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/coredump.h b/include/net/bluetooth/coredump.h
index 72f51b587a04..ab85a6adfffd 100644
--- a/include/net/bluetooth/coredump.h
+++ b/include/net/bluetooth/coredump.h
@@ -60,6 +60,8 @@ struct hci_devcoredump {
 
 #ifdef CONFIG_DEV_COREDUMP
 
+const char *hci_devcd_state_name(enum devcoredump_state state);
+
 void hci_devcd_reset(struct hci_dev *hdev);
 void hci_devcd_rx(struct work_struct *work);
 void hci_devcd_timeout(struct work_struct *work);
@@ -74,6 +76,11 @@ int hci_devcd_abort(struct hci_dev *hdev);
 
 #else
 
+static inline const char *hci_devcd_state_name(enum devcoredump_state state)
+{
+	return "";
+}
+
 static inline void hci_devcd_reset(struct hci_dev *hdev) {}
 static inline void hci_devcd_rx(struct work_struct *work) {}
 static inline void hci_devcd_timeout(struct work_struct *work) {}
diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index c0f027fab583..913bbba559f8 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -30,8 +30,9 @@ struct hci_devcoredump_skb_pattern {
 
 #define DBG_UNEXPECTED_STATE() \
 	bt_dev_dbg(hdev, \
-		   "Unexpected packet (%d) for state (%d). ", \
-		   hci_dmp_cb(skb)->pkt_type, hdev->dump.state)
+		   "Unexpected packet (%d) for state %s.", \
+		   hci_dmp_cb(skb)->pkt_type, \
+		   hci_devcd_state_name(hdev->dump.state))
 
 #define MAX_DEVCOREDUMP_HDR_SIZE	512	/* bytes */
 
@@ -50,8 +51,9 @@ static int hci_devcd_update_hdr_state(char *buf, size_t size, int state)
 /* Call with hci_dev_lock only. */
 static int hci_devcd_update_state(struct hci_dev *hdev, int state)
 {
-	bt_dev_dbg(hdev, "Updating devcoredump state from %d to %d.",
-		   hdev->dump.state, state);
+	bt_dev_dbg(hdev, "Updating devcoredump state from %s to %s.",
+		   hci_devcd_state_name(hdev->dump.state),
+		   hci_devcd_state_name(state));
 
 	hdev->dump.state = state;
 
@@ -245,7 +247,7 @@ static void hci_devcd_dump(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	u32 size;
 
-	bt_dev_dbg(hdev, "state %d", hdev->dump.state);
+	bt_dev_dbg(hdev, "state %s", hci_devcd_state_name(hdev->dump.state));
 
 	size = hdev->dump.tail - hdev->dump.head;
 
@@ -368,8 +370,9 @@ void hci_devcd_rx(struct work_struct *work)
 			break;
 
 		default:
-			bt_dev_dbg(hdev, "Unknown packet (%d) for state (%d). ",
-				   hci_dmp_cb(skb)->pkt_type, hdev->dump.state);
+			bt_dev_dbg(hdev, "Unknown packet (%d) for state %s.",
+				   hci_dmp_cb(skb)->pkt_type,
+				   hci_devcd_state_name(hdev->dump.state));
 			break;
 		}
 
@@ -549,3 +552,31 @@ int hci_devcd_abort(struct hci_dev *hdev)
 	return 0;
 }
 EXPORT_SYMBOL(hci_devcd_abort);
+
+const char *hci_devcd_state_name(enum devcoredump_state state)
+{
+	const char *state_name = "Unknown";
+
+	switch (state) {
+	case HCI_DEVCOREDUMP_IDLE:
+		state_name = "IDLE";
+		break;
+	case HCI_DEVCOREDUMP_ACTIVE:
+		state_name = "ACTIVE";
+		break;
+	case HCI_DEVCOREDUMP_DONE:
+		state_name = "DONE";
+		break;
+	case HCI_DEVCOREDUMP_ABORT:
+		state_name = "ABORT";
+		break;
+	case HCI_DEVCOREDUMP_TIMEOUT:
+		state_name = "TIMEOUT";
+		break;
+	default:
+		break;
+	}
+
+	return state_name;
+}
+EXPORT_SYMBOL(hci_devcd_state_name);

-- 
2.34.1


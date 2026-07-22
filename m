Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FD439F78
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737480; cv=none; b=sZtlAkEk4cugaD68+oRHgGRrBjWSK1w89vCdQFCc9SI70jWHJr/IHlQc8pbTzQ6PGiFEcn4oqNrTTFvwEKmcaftA/M7w9Zm3zTolL1ryJnPeHhdwJ8TwQXPma/mMSYW5nsCgcG481SSY/UaoZYZhFlkGgPsiL1JHjsv2R0mD3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737480; c=relaxed/simple;
	bh=jRpGREaM5NqJx3foXH/P4m0ScWZEgcGcIvLo39NcCrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qTSg4n0LaGaC3hmPUEn90mb4a4zua96/AidNP8TonDLYDuS3H1iX0KgXxpD1LLcpuzBtvTdU4zZA4fSfm/lodMeyEO9vgqiHOzff3fFZD8f0Nl3e0dhW0x6FJI5g/imFSA61Xa0L6yBBUdJ3MDQS16hX0Eov/HT9TKDJxBK3Px0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JVmCbbV+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gAtQMeLu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JVmCbbV+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gAtQMeLu"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFXnB7931069
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T1RqKOzM4TNeWlVebimqOJ/wcJPg7VwTnUROemELgw0=; b=JVmCbbV+xLKipX9H
	KF/prHvauxQwoeZIf/ugbLeVo7tSIDzDf7g18JK/5ouAexvrixwd1fh1vLG1GtL9
	G6I+1V8Q9sTa7S/jtNqVQy1rrncl3xwlR4Np/dtGkiIvd83gl34ITUc1KVA95MsY
	OzXdbNKVAz8ThvIEhglzEN6uKogcOlpkutjWaYT1uq9jH35iy6gOnxoNzHPX7nyV
	CC5MtdzknqsjjuX7XPtLIc8YcrQtsCk3pzOVQgLszqtnXoydoNMgH7CKPaokWhC0
	Mlcnb/AC/k8pFGeZ7DD/bCv7Jgk1I1oRRiSNJWMAWgpduNy7wvrnGGNCREvcNvEM
	CU/RKw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fju229ux7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:24:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3809cc5dcccso2026037a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784737476; x=1785342276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T1RqKOzM4TNeWlVebimqOJ/wcJPg7VwTnUROemELgw0=;
        b=gAtQMeLupvhpQavgzJsJZmj9ZBQZXRARTd/VXjHxQ99xseAmbY/1sHxFaWFh3ME02T
         836AZN34UKF8yba5Uu0NXKCFJUoH/ii5tTk2lSH/sDMAp5UAKbvwtg9u2hlHmlZBgDG8
         HpVMZGewINzvNu5ku+mFEbbeHmY72lX3HFjTnVWCByqxDDN7tJINBB3ELVfQnzxIO5WZ
         Adr0Etn9J7/lpGGQkGLl6s00bI0lMDL+BGIcyDZFPtgLErB5dsCHIhubuWSL0vWc63f1
         bPRbxTaBmanbahlhe9/WrJ2TC+gTnZx1vAVUmbHG1FOo5qu9mDDAnxkVpq98uS39w3HS
         LBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737476; x=1785342276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T1RqKOzM4TNeWlVebimqOJ/wcJPg7VwTnUROemELgw0=;
        b=oZCTtUH8Hu1hFtn07+QPHMGZiC1nc4nDAzRqcKvC25gY3l7xdLKeNL34dte85jvuU7
         g6yFtxqgHVV9WNk3cfkZrOps0Nq2EFXWiKYb+WIdW5jPHw3zAgw9xhBVx4aVk4opICfh
         GbBlG6Zn8BHjeuUFq0PpH4FHoVSqUp3z5CVZj6YJD7q8T6cfxKpjfuu5MhNSUIpYlsHV
         C1IXfVcEAiHOfNKjyR9HRG33vwVq/+61cEdVferXrHJ63Qr9OwacI2H70hKkMpjtsROd
         MnPqqD2m3SBsI4Yng2QWKhA76z5tMnoY0A5CfgziHPu+/AUzS9tD1jEg+QZoumEfysQE
         mjfA==
X-Forwarded-Encrypted: i=1; AHgh+RoAIz/opRnV+e94im48SeWJz3qWCxqJ4Tjrx5U3jccgIyKLXBz3kHaYppAFsB3FhBtkXHyYUZ2nTQF9yhBaByU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6g+Kb3xyNYK4fkFKGPUG2KhAAa03ww3x281TTK/x+vWd2u4FI
	1cYmL4imw5fCXrkkJWLaBdwK+0CK0ZiS4oABjRemNK1lhseiCHPHaDmV80mFRJfhZNYpQWnCzHR
	2N056erQdYvqIFIEZUjRcoHdxdXWxcs8Vw0+rL6On+CxUthgqlPUecweSHOe1Bp2qXxZInTM=
X-Gm-Gg: AR+sD11qE5OcyOrU4JKa4JSI50X4DnAGFET1jKLlhrNIW8MJizPwKWRQfsu9EfOcIIw
	xQIzEFs9Rj+vltCRdMPVJC7FEjDviBm0cuNYIl0Z5wkqw/wgpjQ0hm0xUcqyuG38yfuN+a1inhD
	cyvydME5O7ZJieWfAc2afwH57cAAmXeZkRAWh/Prkv//j7LTG581U9fwOZxGdHLM+PmyGZ2BLeQ
	jQJo6IpGlwY1zz7DLGowkwq92TbrBjrrFF9yur3WNdbJcZ+S8wPuyDcXBMQUUjT+ioyMpAVAYa1
	4qdmKCqae8uFuF/VMxduQfFcgyyKZ2dRXz0IjNztXQMQ3xHpjE4q4eH2yzWj+01ha0mURE/Cb39
	7rf3hYVBRtM8epKjlu+BZZXueAR+OQQ0VEDL72ILujIvyGOM=
X-Received: by 2002:a17:90b:3b42:b0:383:5a16:bd67 with SMTP id 98e67ed59e1d1-38ea4b4b6c5mr3439254a91.4.1784737476166;
        Wed, 22 Jul 2026 09:24:36 -0700 (PDT)
X-Received: by 2002:a17:90b:3b42:b0:383:5a16:bd67 with SMTP id 98e67ed59e1d1-38ea4b4b6c5mr3439222a91.4.1784737475668;
        Wed, 22 Jul 2026 09:24:35 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc9d932sm10569970eec.12.2026.07.22.09.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:24:34 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:24:22 -0700
Subject: [PATCH RFC v2 3/3] Bluetooth: Add hdev->recv_bt_vendor() to handle
 BT vendor frames
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-support_vendor_hci-v2-3-132b506460a4@oss.qualcomm.com>
References: <20260722-support_vendor_hci-v2-0-132b506460a4@oss.qualcomm.com>
In-Reply-To: <20260722-support_vendor_hci-v2-0-132b506460a4@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=X4Bi7mTe c=1 sm=1 tr=0 ts=6a60eec4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=W2HtuRoJ5q-BxxgZR4MA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: s1EPnC5mI2UfKkGfaSbtQ6GHOX9qzd1q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2MSBTYWx0ZWRfXxZlxOAqPYfJH
 Wje5MWCqJEcbl8ZmysuvZSy7EKHZFzoDvk2GOTeVxWg6xUeOE4M5Wl0mZ/HeQkURfubjd9sE73D
 0j1yayTgepV+F3LgT6ENcWypvSVUsHE=
X-Proofpoint-ORIG-GUID: s1EPnC5mI2UfKkGfaSbtQ6GHOX9qzd1q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2MSBTYWx0ZWRfX21T9zwAlezhw
 Hd/zoNFjbgBgvdcVafxu1iV6aXXoCBoWHIMXMpX7aQjZhU9BbJkRUKCLXAhIW5AcNFwbOy3/Sjj
 9nugUpSV5tZI8m58RmRQEJKO/MXOVpKhXa1vG2FzTZL9U0DNqeL9G17UWjwN6z8u/LcWeYemgEL
 POpHrBgHkyI0hGVOnX4SJs2OWyJnhnLSO05S0RBbr5Y5hh4vPcigGbhv5qqFnTM9u1ep2xazcCz
 3Xuy9podAdaoEQnEZy+txlegT6+wQ/7cHmx4wANZ7GTL10BC5XBLQ7N6u/FwbpYCC3GCd16zbGJ
 3QbVBUSjb+kSkRMPVsIQ36kINdgaAyYD8+NM7LbvW61+EtvVpkhJ+4fWxC0Vxn0DfJq6oqZAWkS
 tmSNfy09LD39pV9huQLDL1BaHmAzkdq1ILrLeV19RkFZN+EuQ9IVPKSydlyN03ulMRrQIGB6R8w
 Juxx0/21K1byG1EX6dQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220161

For unsolicited VSE and ACL frames with vendor reserved handles:
Many transport drivers pre-process them in the RX-path because the BT core
cannot recognize them, and cause:

- Impact performance since skb_clone() in IRQ-disabled context
- Difficult to debug as frames consumed without btmon logging

Fix by adding the hook to process them within stack's process
context, when they have been logged by btmon.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         | 33 +++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 428261591288..12f3720f6cc8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -646,6 +646,8 @@ struct hci_dev {
 	int (*setup)(struct hci_dev *hdev);
 	int (*shutdown)(struct hci_dev *hdev);
 	int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
+	/* Return true if @skb was consumed, false otherwise */
+	bool (*recv_bt_vendor)(struct hci_dev *hdev, struct sk_buff *skb);
 	void (*recv_vendor_pkt)(struct hci_dev *hdev, struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	void (*hw_error)(struct hci_dev *hdev, u8 code);
@@ -2329,6 +2331,7 @@ static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
+bool hci_recv_bt_vendor(struct hci_dev *hdev, struct sk_buff *skb);
 int hci_send_vendor_frame(struct hci_dev *hdev, struct iov_iter *iter);
 
 int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 90807562e8ed..21ef748e3528 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3830,6 +3830,12 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	__u16 handle, flags;
 	int err;
 
+	/* Header is valid when ACL frame arrives here */
+	if (hci_recv_bt_vendor(hdev, skb)) {
+		hdev->stat.acl_rx++;
+		return;
+	}
+
 	hdr = skb_pull_data(skb, sizeof(*hdr));
 	if (!hdr) {
 		bt_dev_err(hdev, "ACL packet too small");
@@ -3918,6 +3924,33 @@ static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 			   handle, err);
 }
 
+bool hci_recv_bt_vendor(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_event_hdr *evt_hdr;
+	u8 evt, pkt_type;
+
+	if (!hdev->recv_bt_vendor)
+		return false;
+
+	pkt_type = hci_skb_pkt_type(skb);
+
+	/* Save the event code before calling into the driver, since @skb
+	 * may be freed once consumed.
+	 */
+	if (pkt_type == HCI_EVENT_PKT) {
+		evt_hdr = hci_event_hdr(skb);
+		evt = evt_hdr->evt;
+	}
+
+	if (!hdev->recv_bt_vendor(hdev, skb))
+		return false;
+
+	if (pkt_type == HCI_EVENT_PKT && evt != HCI_EV_VENDOR)
+		bt_dev_warn(hdev, "consumed unexpected BT event 0x%2.2x", evt);
+
+	return true;
+}
+
 static bool hci_req_is_complete(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea858391c789..94c02b66bdfa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7801,6 +7801,11 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
+	if (hci_recv_bt_vendor(hdev, skb)) {
+		hdev->stat.evt_rx++;
+		return;
+	}
+
 	hci_dev_lock(hdev);
 	kfree_skb(hdev->recv_event);
 	hdev->recv_event = skb_clone(skb, GFP_KERNEL);

-- 
2.34.1


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F7B377A90
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969700; cv=none; b=UkjIt18WfSgUkLmio8/Qe9HCktqIjNsc9DtdIaDsFhL2mtIbUVu9XVVpeHjWiBXA+MJoTgESGpbS3OaXT9hyoG4DdTese3JSG/KVZGqufDnvJkJb2yEqMDOLDk7Nj4ltTypVaYrbri7U4st2YpFQVlKecgodYK6Xg48mUFxcFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969700; c=relaxed/simple;
	bh=AMwdyjB7hyw0NqYSHQaz6dmi2+1GNKiv7es6JqJIx+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eraQIqDE8YPHKNPTitJDiTr+K6AHIdNrDQDLjBo36MhWhToFa5slGxf7lnrY2uNalmPGR45Zdnfpn6g0+dnk8z7Sz3tmnEOknzInhBK511lzD7ygp9Oa9BSfErfuhEnND+LNbI04KDD48wfyDLb4CBaoVlWGV937a51xxiUCXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V6XNx2AK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f8R0RvU5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V6XNx2AK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f8R0RvU5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P4oNdB480788
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3m3sJGPETkhBWscQG8/Pj7ULi6VLrSuP3GvH0174IBg=; b=V6XNx2AKv0TSQbQE
	dYGGjJnl+KtEPBlj71sH2YHs7gdb6Io0XX2EwCH8PnUDdId2Dh7d3mHmENoxBLAb
	1GJm/c/p4pMp2yDXmOXfZ6JKS1ohRm7MF3iDOLaKj8QcDMTOSyCtw9ObuOJEL233
	syxWn6jgbkghYE4N30Qmjh82y5R3XXV8N3z8cFDZHagYTa6IBZ4kOvA1CrjY2O82
	8Me/5wGbTH9Oom8xtkev0apIIJFH7AKE8/kYk6/yLzwhJB7fj95t1FcQbq+mAl2t
	+r0OxQ7gl0JUFM0oUi/Wfcb/OO69kd4hQPe1CZcm3y9KkrvywcYZU824JnTuw5lI
	nsDJig==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpajgdun-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cae7a8b9easo2096965ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784969696; x=1785574496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3m3sJGPETkhBWscQG8/Pj7ULi6VLrSuP3GvH0174IBg=;
        b=f8R0RvU5kL0Th8ir0iZ9RQZ0eUc4SPtZap3hiqK0KPvnoFiqwAjR9YGWrFd4PNVpSH
         gVgjwzI6jKrA8ovhFKyYWTcumJYeeVwZy0+3L2d24eewvgVmCyAFfgmxTJD9zL2V584N
         L08YHQFmM2kJnOt/vAxd2mtgEwyDGuLA8R/LygUF4/ZO8kFP+He2qn2y0yW1XrEObITW
         zhg2zHjZHGqEqAoxXYR2aCOnwvece6pwEAIpid/yncO18c3SzNOg0kbvRLsyGptOeQAL
         IHJoeLRoTLTsxEFBEz9hbiBCsjhU9jrqvR7+CNh9Yr4m65wcW3iwY6cQ22OMZoo4D0At
         rKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969696; x=1785574496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3m3sJGPETkhBWscQG8/Pj7ULi6VLrSuP3GvH0174IBg=;
        b=lTsFoBMAVH4xytQ+7SwCrjWvJFMco7sK7YJv+7nTfburU0FwLYAigOd7EABaBYDZfN
         04+eV4mNTTlcoygai4dyexRJXL6VcM+iHstJQR4vA9PIx3jDa4E7PhOd7a7p6XxCm1/K
         zInnt8o6OvwTLDg9p78tYyKaDDQSXFxEhPE+KXjuPdMyICt1clcJNUUIwzM31dytpOvo
         fPunYvVs6z/ehoXjtq8w0pKUJb/OIPaWUo4UtQ66s4PS2oUMgLky8PcnqL1iaagBNFVZ
         90Dhe+6EaeJcvI2fyzs54L4JdPe8hNeOJOOGzCRJnJvQB/Z/qahbsob4zRFofffYG5bw
         j3Ig==
X-Forwarded-Encrypted: i=1; AHgh+Rqss4ImdKgkoWK7CYbRkyLffba2lS0TFG6GiCwQamM8cXY0wFqhePGXLDleEFAPyd7Qg4JXwdFe7fNI59tZd3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkHRVXZABxMqnrmkMAbTcKcc+8xWy12L2gIhPIp5GOSsSSVuR
	D4qNzC9jv9zHqOOE00G9+HxMPHEHHp3Dq0Yv52bmaMlx0tl05X8BdusICvxIgnrGFHHNucc8pVv
	wg7BDXSFPV6w8FdF/0BZp8hJic09NVdjt8YKr7uCoclzMYQywB/38vMYssq7mwJ+FAsKuPQY=
X-Gm-Gg: AR+sD100Ja1nPskCVcvuivdE+nL82Y7l/FYsn1DRA/TSCZsxd+f/wvt1a59cAaMq+UE
	rMGdAXs2B0Y4lhFmSYVLY0R0zQcsYnLbox01BTW9goH77KdPxXuN/SNxqbJ/YVlxgQuc5ktLTtN
	j9MM69U83G6ChLiWaTdOFS63fb0U3C3PAqbreydYgxhPwMEO+eufQ1Y2tZg1IJemovSrT3y4tgO
	XXVw7/x2kyihLtGFz1OndEMsKTb4OAaPbA7Lmf7VNkk55LApAatjxIx27TrARu5PENj9yeuo29Y
	VUt1k5R1LuXQvq6/pQlqfw5U+5jtTwScKFa6GPOfqsRxM7q4ysW8cOvpGohAl3pK4rqf2gI9ngm
	mlrG8Q9befGqDbMSdbmSGMAU96vXmMhNgxgxAdIzjwzJ7GHs=
X-Received: by 2002:a17:903:468e:b0:2cc:df15:91e2 with SMTP id d9443c01a7336-2cfde8c2f20mr12140205ad.7.1784969695611;
        Sat, 25 Jul 2026 01:54:55 -0700 (PDT)
X-Received: by 2002:a17:903:468e:b0:2cc:df15:91e2 with SMTP id d9443c01a7336-2cfde8c2f20mr12140135ad.7.1784969695213;
        Sat, 25 Jul 2026 01:54:55 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm7823000eec.10.2026.07.25.01.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:54:54 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 25 Jul 2026 01:54:41 -0700
Subject: [PATCH 03/11] Bluetooth: coredump: Introduce and apply
 hci_devcd_state_name()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-generic_fix-v1-3-305aec261a19@oss.qualcomm.com>
References: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
In-Reply-To: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Manish Mandlik <mmandlik@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: bInEp8rRNZEjdtGZJlyjVkS4HBnS-FFT
X-Authority-Analysis: v=2.4 cv=A8Bc+aWG c=1 sm=1 tr=0 ts=6a6479e0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=l6NYOpP1_F8NA1PUTOMA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: bInEp8rRNZEjdtGZJlyjVkS4HBnS-FFT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfXw7o1XjXVtueE
 Wtoron1EyybO3dMy8F7CZIcz8nqmyzAQEBvdQoGdCYOacQDMy0+faKDcBafvi9o3siKtmAv+q0Y
 vyCpR9c08BOkLfzkaj9quLszy9nDxpiPkUNxAZLTnwsWjj/6l1+wUcKRS874tILUTezTo40BEJk
 Vt6iRvf9uZ5Px++9TOVLHCXLb2B/dWpEvvlyI0HMkIPhcJ8m30oEPXQ8Yg9DL0DCDTU4oXSFNqA
 zeqbRfAzmx/biUttNo8fbXrTk5zrCf9kpemPj7p4hRjGfc3Wu4yqtkF4gFkCS87jupWL1OIqJ3J
 /RlzsZB7JqdCAt1KxtWsEB9/sPyS17j80NeyQED4IyQFLZr/uqxE2RftKifetGTchU6f54NWlxy
 FkJtmZFU91Lci+1BOANQ/QMo2XcIi9J/xHfala1tMJIVkdXLOdhj365xKvE3v2+1MaY/F/cUYwL
 GH0fG6tLmz+lZV/tq3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfXxFrhOmlYHp/D
 x7ZrwG0WpEbem1AqRNzIhrF4IMwhUbQisg/FALlRBU6Ubom7SBYZvtMO69xS9AMeA0CebO7Qyn7
 TXg493N6OUxOkGe7iU/3XzL/i0puV3M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250083

Introduce hci_devcd_state_name() to describe the devcoredump state by a
string name instead of a plain number, for several reasons:

1) Applying it in coredump.c makes the devcoredump state in log messages
   more readable than a plain number.
2) Transport drivers may need to show the devcoredump state name too.
3) In future, the universal state name could be notified to userspace
   via uevent, allowing a universal application (e.g. a daemon) to be
   developed to save the coredump, which is otherwise discarded by the
   device coredump core after 5 minutes (DEVCD_TIMEOUT); see
   nxp_coredump_notify().

Also drop a trailing space from two bt_dev_dbg() format strings while
applying it in coredump.c.

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Previous version:
https://lore.kernel.org/all/20260713-btusb_prep_qcc2072-v2-1-bbcb651285f2@oss.qualcomm.com

Changes since previous version:
- Improve commit title and message.
---
 include/net/bluetooth/coredump.h |  7 +++++++
 net/bluetooth/coredump.c         | 45 +++++++++++++++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/coredump.h b/include/net/bluetooth/coredump.h
index 72f51b587a04..ab85a6adfffd 100644
--- a/include/net/bluetooth/coredump.h
+++ b/include/net/bluetooth/coredump.h
@@ -55,30 +55,37 @@ struct hci_devcoredump {
 
 	coredump_t		coredump;
 	dmp_hdr_t		dmp_hdr;
 	notify_change_t		notify_change;
 };
 
 #ifdef CONFIG_DEV_COREDUMP
 
+const char *hci_devcd_state_name(enum devcoredump_state state);
+
 void hci_devcd_reset(struct hci_dev *hdev);
 void hci_devcd_rx(struct work_struct *work);
 void hci_devcd_timeout(struct work_struct *work);
 
 int hci_devcd_register(struct hci_dev *hdev, coredump_t coredump,
 		       dmp_hdr_t dmp_hdr, notify_change_t notify_change);
 int hci_devcd_init(struct hci_dev *hdev, u32 dump_size);
 int hci_devcd_append(struct hci_dev *hdev, struct sk_buff *skb);
 int hci_devcd_append_pattern(struct hci_dev *hdev, u8 pattern, u32 len);
 int hci_devcd_complete(struct hci_dev *hdev);
 int hci_devcd_abort(struct hci_dev *hdev);
 
 #else
 
+static inline const char *hci_devcd_state_name(enum devcoredump_state state)
+{
+	return "";
+}
+
 static inline void hci_devcd_reset(struct hci_dev *hdev) {}
 static inline void hci_devcd_rx(struct work_struct *work) {}
 static inline void hci_devcd_timeout(struct work_struct *work) {}
 
 static inline int hci_devcd_register(struct hci_dev *hdev, coredump_t coredump,
 				     dmp_hdr_t dmp_hdr,
 				     notify_change_t notify_change)
 {
diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index c0f027fab583..913bbba559f8 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -25,18 +25,19 @@ struct hci_devcoredump_skb_pattern {
 	u8 pattern;
 	u32 len;
 } __packed;
 
 #define hci_dmp_cb(skb)	((struct hci_devcoredump_skb_cb *)((skb)->cb))
 
 #define DBG_UNEXPECTED_STATE() \
 	bt_dev_dbg(hdev, \
-		   "Unexpected packet (%d) for state (%d). ", \
-		   hci_dmp_cb(skb)->pkt_type, hdev->dump.state)
+		   "Unexpected packet (%d) for state %s.", \
+		   hci_dmp_cb(skb)->pkt_type, \
+		   hci_devcd_state_name(hdev->dump.state))
 
 #define MAX_DEVCOREDUMP_HDR_SIZE	512	/* bytes */
 
 static int hci_devcd_update_hdr_state(char *buf, size_t size, int state)
 {
 	int len = 0;
 
 	if (!buf)
@@ -45,18 +46,19 @@ static int hci_devcd_update_hdr_state(char *buf, size_t size, int state)
 	len = scnprintf(buf, size, "Bluetooth devcoredump\nState: %d\n", state);
 
 	return len + 1; /* scnprintf adds \0 at the end upon state rewrite */
 }
 
 /* Call with hci_dev_lock only. */
 static int hci_devcd_update_state(struct hci_dev *hdev, int state)
 {
-	bt_dev_dbg(hdev, "Updating devcoredump state from %d to %d.",
-		   hdev->dump.state, state);
+	bt_dev_dbg(hdev, "Updating devcoredump state from %s to %s.",
+		   hci_devcd_state_name(hdev->dump.state),
+		   hci_devcd_state_name(state));
 
 	hdev->dump.state = state;
 
 	return hci_devcd_update_hdr_state(hdev->dump.head,
 					  hdev->dump.alloc_size, state);
 }
 
 static int hci_devcd_mkheader(struct hci_dev *hdev, struct sk_buff *skb)
@@ -240,17 +242,17 @@ static void hci_devcd_handle_pkt_pattern(struct hci_dev *hdev,
 		bt_dev_dbg(hdev, "Failed to set pattern");
 }
 
 static void hci_devcd_dump(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	u32 size;
 
-	bt_dev_dbg(hdev, "state %d", hdev->dump.state);
+	bt_dev_dbg(hdev, "state %s", hci_devcd_state_name(hdev->dump.state));
 
 	size = hdev->dump.tail - hdev->dump.head;
 
 	/* Send a copy to monitor as a diagnostic packet */
 	skb = bt_skb_alloc(size, GFP_ATOMIC);
 	if (skb) {
 		skb_put_data(skb, hdev->dump.head, size);
 		hci_recv_diag(hdev, skb);
@@ -363,18 +365,19 @@ void hci_devcd_rx(struct work_struct *work)
 			hci_devcd_handle_pkt_complete(hdev, skb);
 			break;
 
 		case HCI_DEVCOREDUMP_PKT_ABORT:
 			hci_devcd_handle_pkt_abort(hdev, skb);
 			break;
 
 		default:
-			bt_dev_dbg(hdev, "Unknown packet (%d) for state (%d). ",
-				   hci_dmp_cb(skb)->pkt_type, hdev->dump.state);
+			bt_dev_dbg(hdev, "Unknown packet (%d) for state %s.",
+				   hci_dmp_cb(skb)->pkt_type,
+				   hci_devcd_state_name(hdev->dump.state));
 			break;
 		}
 
 		hci_dev_unlock(hdev);
 		kfree_skb(skb);
 
 		/* Notify the driver about any state changes before resetting
 		 * the state machine
@@ -544,8 +547,36 @@ int hci_devcd_abort(struct hci_dev *hdev)
 	hci_dmp_cb(skb)->pkt_type = HCI_DEVCOREDUMP_PKT_ABORT;
 
 	skb_queue_tail(&hdev->dump.dump_q, skb);
 	queue_work(hdev->workqueue, &hdev->dump.dump_rx);
 
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


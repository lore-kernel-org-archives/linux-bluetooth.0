Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF89315D46
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139948; cv=none; b=YUOpf2b4WAIIP7u8kPRKRoT6PY4YSvISowgmoAj0M7ahdJBO+i6J0PdTymuuYoU5yFOxyjLAI6wW5SV0l/9e8JOp+Tf/0Nd+pTk/++2mzEtIbXTdyKiSDFYwDDY+rZ2zm80oXchmTbphIRFAgyl3yP2x2xBJntjrBUa2YjYRHmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139948; c=relaxed/simple;
	bh=p8F6QkLRVD5oUWLabKHDe/oJZxyvmx/Gd6VZzexn/jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=USNtcFTeH5KXE/OkUvH6Gg9NFy2isDatYFzGfOYP8x+t30PGrwMeG2VQ9cSlcGiK4yvyizqTR7byl+VldivNdGsEf8/PPSF4Jkj0FElFf0B7r4KHZGulqcjNHF9Adk5cGTVuYpTkrFih/jkEi3N/27kbTIy1P4JuEUejy47H3RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D9LEvdIY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HSW1BG6Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D9LEvdIY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HSW1BG6Q"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDSZia1120910
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	235gNcfFV3kkqtG19jSUUgPcN6QOmLAdx+z2l1LbSmQ=; b=D9LEvdIYxnmkt9ii
	ayvBSa4dw34JRptMP9+deN5McctdoeE2DkkcDMesWlM9EjmsmygX8UxNf2OxSpuu
	ylBysrUMB9kVuK9i0sJhCic8woanaKO6ZCbbRsU2w9QwJ3x6oL+t6jMwamjvWjIA
	zGSh0vvSO3JP7uN3PlMc/3Wv0wZ3HcfWyivlvSC+PP6wgQMCEgaf4SstQ+FMDxzj
	xID2J3+7Kgx0uDKPDRYxrZxAW00FjAAAprbZCnNOf4+SHQ/FY8oqLyDmsP5x9Oo0
	KTFogrYi4Atenx52TT111Lxf8kWTFu6oDJrropsWvmlMGm/fX/+mIbt+FFXzq6e0
	GAVudg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5ye8ab9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 14:52:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bfe1e3d45so537103eec.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782139941; x=1782744741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=235gNcfFV3kkqtG19jSUUgPcN6QOmLAdx+z2l1LbSmQ=;
        b=HSW1BG6QoEKpL69f8FH4OKY76hgFeFEB/hmwRocCrMTkyKyzAwU/PdaZmumdTFtP9j
         HfFxVh5qcSABVippZgv07RnviwichRf+S197pxqe3pZYhndR/4nNrv98Ae5hY1QNqsKV
         w/zqxdoCKyFQM2p7ndQamrWuvT8eGXm4OXW8Hsie7pYh79/tOBDYvB4nzqX5ctsnRaCN
         frYSFZR1oZDhnNJfh6zk4+9Jax9qtRrgU8EXygE84k7Gk3znn7gmG++JthnBf/kIjZaS
         Sp5lBwPFQ73bLpgjG55LtABpWfUnjnCSrMZwXrwct9r9cVf9NKlAaERs6gg0tp62yhY2
         3tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139941; x=1782744741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=235gNcfFV3kkqtG19jSUUgPcN6QOmLAdx+z2l1LbSmQ=;
        b=Dc6lVvlKStrGoSamzpJ/Pzm6S43jFDfUn0ZkdR1i/qac+BMGfct5XDYQ7HWoNfDaer
         eVk70InbOeztr0sZutpRQxnDA0VixadA/sAUii7H7qYdwNUL6FF7yheSlWjfGfwx1xR+
         +dB9VRziWKd9hN7eyHwy6STsDfx1jhmeiJvl//lEK3UhlRmKvqNuBlAkpUUx7rlk4xgw
         lgq5urjWtoEuXabdHOML/Zc676KComiUHBisJxzlwNgjNILPilwPf8rMNQbkzihDxLEj
         nOxx6TdoffbbdAiRfywNLErdGMwiU4GVUaM2NeRdHn1I3c+ckFTRPxEEGugJyoGTAjZo
         o96Q==
X-Forwarded-Encrypted: i=1; AHgh+RpkXCPQ4fmOsJaj83Td7d2gtTWqfYyhTRmbrofRW4l1jruVKQnazS5CrE9VeRemjWcKm6u+U4oXyPQGMb/KXOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyncTjVhSl3tD8SFma4R0NotFHqP0FTmiW+o/r5rWWSw0fCg/aF
	9qZ6hLZG9G/sAVkXrfoJwt7g2nnJhIQDMT7W5Imm5V3PKKRYxxGs9cqPYvi0NkCc02gWRcoWZoi
	CdE87Ras733rYZ3H7Vr8vjAORtENiYbmdrfnNsG6JLq5cU5SY6l0U/SE8YHrT//O9uSO/82M=
X-Gm-Gg: AfdE7ck8B1rGYgUhguQkg4g8ZOKbNhHfcmQsqrrWhv7NnMrofHvunTK+5HjrtlaS+W0
	xmDGcWFsMo8qy1yoX2sGYF3/CHKiHjiHm5NqUic0qfHAlUtgdgUvryNdiFXNYaB1BKC5RhcoEEy
	o5/S/iR0E9bEzStWzU38jdm25SNvco7cQzzXW7s5KG3ChaatDsXp22+NYC6sptFhQU4bxILzOlS
	lDmmhplATHiSSnFzjbPQcApA1E3tQyGgda2aMRjvdVXNelzYFRPBQpGB5C+Lz+4JX4lOepsY3mH
	k8yM5bqPDeXYWpYoL6HXDDdG5ALKCEEsnl9zg8WNdVMiP/9a45VPdkJdvdDiqRTdPJ0VUufFMug
	MnBelxrr640KMp0LeWZsf3dzxD2FCz9QM088Pgq/TpAF0C5OZXd/TwpC8mw==
X-Received: by 2002:a05:7301:10c1:b0:304:e327:aef8 with SMTP id 5a478bee46e88-30c17b68722mr3562186eec.2.1782139940803;
        Mon, 22 Jun 2026 07:52:20 -0700 (PDT)
X-Received: by 2002:a05:7301:10c1:b0:304:e327:aef8 with SMTP id 5a478bee46e88-30c17b68722mr3562168eec.2.1782139940087;
        Mon, 22 Jun 2026 07:52:20 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bddfe34sm12025561eec.20.2026.06.22.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:52:19 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 07:52:18 -0700
Subject: [PATCH 05/13] Bluetooth: btusb: QCA: move qca_dump out of struct
 btusb_data
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-bt_bugfix-v1-5-11f936d84e72@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: lBLz_uV2I4h_uquP3oZsrGWKKqqB6EW9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfXzlTFl4GLveIc
 yHuDaTqXHhF/kozNWnJZlF+7bQ+npslNEZkbKHwp9k7SgDTG49klFDXCPgVVAxtnSEb1YBmkjf2
 cVkp8cvgRYvTHaLEyu+y2PZBXwSLLEU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX+rqNJgODAdXR
 AuWfY5YZ0MOvPGCFZdy2gslSmMXZuwRbGEZRbEGzdvn5p3YZTZEtOXCD9m8PUBS4OUApN7kW71h
 kqX0QEZ0yc43UJL1xoj5lSkglaXX2+0awr1cvSiHVxdcgzD/JBgxyBmolj5o2sHvAXcip0pVKou
 1ii3vFriZ1R4bcAawjYk71TFma+8kxXh1npyImAZehkKhjOEeEO9wrm2mkP4NQLGIeLFBfkPRN9
 gqNds689ysjWHLvI8uIlcPofTpzj1YTMhrnKaf9YCU3Mh/EKrI6eKis7UMSiVGMOVE5y10NWXiG
 O7z8hHZeEgQKseOXVgXzrgsDSgo2Ki6qsPGeSqLXcChn3aeXT2O+tNbyKiLLU7hwmVjlGRZ6BWt
 8uMGg7K7lQqOVaQsrnzSsm23oQtm7mg+uF/f3rGEHM7VL4TF1AWYU6PtNYSaAKmjrsZH6l8EYhf
 yvn+uyBybJ7yCJN1DMA==
X-Proofpoint-GUID: lBLz_uV2I4h_uquP3oZsrGWKKqqB6EW9
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a394c26 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=0qFWW5pOsv3iMAJ541kA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

'struct btusb_data' ideally should not include vendor specific
fields, but it currently includes the QCA devcoredump member
'struct qca_dump_info qca_dump'.

Fix by moving it into hci_dev private area accessed by hci_get_priv().

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 56 ++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 184a87d1234c..6f965c313dff 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -939,6 +939,10 @@ struct qca_dump_info {
 	u16 ram_dump_seqno;
 };
 
+struct btqca_data {
+	struct qca_dump_info qca_dump;
+};
+
 #define BTUSB_MAX_ISOC_FRAMES	10
 
 #define BTUSB_INTR_RUNNING	0
@@ -1025,8 +1029,6 @@ struct btusb_data {
 	int (*disconnect)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
-
-	struct qca_dump_info qca_dump;
 };
 
 static void btusb_reset(struct hci_dev *hdev)
@@ -3116,14 +3118,15 @@ struct qca_dump_hdr {
 static void btusb_dump_hdr_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	char buf[128];
-	struct btusb_data *btdata = hci_get_drvdata(hdev);
+	struct btqca_data *btqca_data = hci_get_priv(hdev);
+	struct qca_dump_info *qca_dump_ptr = &btqca_data->qca_dump;
 
 	snprintf(buf, sizeof(buf), "Controller Name: 0x%x\n",
-			btdata->qca_dump.controller_id);
+			qca_dump_ptr->controller_id);
 	skb_put_data(skb, buf, strlen(buf));
 
 	snprintf(buf, sizeof(buf), "Firmware Version: 0x%x\n",
-			btdata->qca_dump.fw_version);
+			qca_dump_ptr->fw_version);
 	skb_put_data(skb, buf, strlen(buf));
 
 	snprintf(buf, sizeof(buf), "Driver: %s\nVendor: qca\n",
@@ -3131,7 +3134,7 @@ static void btusb_dump_hdr_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	skb_put_data(skb, buf, strlen(buf));
 
 	snprintf(buf, sizeof(buf), "VID: 0x%x\nPID:0x%x\n",
-			btdata->qca_dump.id_vendor, btdata->qca_dump.id_product);
+			qca_dump_ptr->id_vendor, qca_dump_ptr->id_product);
 	skb_put_data(skb, buf, strlen(buf));
 
 	snprintf(buf, sizeof(buf), "Lmp Subversion: 0x%x\n",
@@ -3160,6 +3163,8 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 
 	struct qca_dump_hdr *dump_hdr;
 	struct btusb_data *btdata = hci_get_drvdata(hdev);
+	struct btqca_data *btqca_data = hci_get_priv(hdev);
+	struct qca_dump_info *qca_dump_ptr = &btqca_data->qca_dump;
 	struct usb_device *udev = btdata->udev;
 
 	pkt_type = hci_skb_pkt_type(skb);
@@ -3187,8 +3192,8 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 			goto out;
 		}
 
-		btdata->qca_dump.ram_dump_size = dump_size;
-		btdata->qca_dump.ram_dump_seqno = 0;
+		qca_dump_ptr->ram_dump_size = dump_size;
+		qca_dump_ptr->ram_dump_seqno = 0;
 
 		skb_pull(skb, offsetof(struct qca_dump_hdr, data0));
 
@@ -3200,29 +3205,29 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 		skb_pull(skb, offsetof(struct qca_dump_hdr, data));
 	}
 
-	if (!btdata->qca_dump.ram_dump_size) {
+	if (!qca_dump_ptr->ram_dump_size) {
 		ret = -EINVAL;
 		bt_dev_err(hdev, "memdump is not active");
 		goto out;
 	}
 
-	if ((seqno > btdata->qca_dump.ram_dump_seqno + 1) && (seqno != QCA_LAST_SEQUENCE_NUM)) {
-		dump_size = QCA_MEMDUMP_PKT_SIZE * (seqno - btdata->qca_dump.ram_dump_seqno - 1);
+	if ((seqno > qca_dump_ptr->ram_dump_seqno + 1) && seqno != QCA_LAST_SEQUENCE_NUM) {
+		dump_size = QCA_MEMDUMP_PKT_SIZE * (seqno - qca_dump_ptr->ram_dump_seqno - 1);
 		hci_devcd_append_pattern(hdev, 0x0, dump_size);
 		bt_dev_err(hdev,
 			   "expected memdump seqno(%u) is not received(%u)\n",
-			   btdata->qca_dump.ram_dump_seqno, seqno);
-		btdata->qca_dump.ram_dump_seqno = seqno;
+			   qca_dump_ptr->ram_dump_seqno, seqno);
+		qca_dump_ptr->ram_dump_seqno = seqno;
 		kfree_skb(skb);
 		return ret;
 	}
 
 	hci_devcd_append(hdev, skb);
-	btdata->qca_dump.ram_dump_seqno++;
+	qca_dump_ptr->ram_dump_seqno++;
 	if (seqno == QCA_LAST_SEQUENCE_NUM) {
 		bt_dev_info(hdev,
 				"memdump done: pkts(%u), total(%u)\n",
-				btdata->qca_dump.ram_dump_seqno, btdata->qca_dump.ram_dump_size);
+				qca_dump_ptr->ram_dump_seqno, qca_dump_ptr->ram_dump_size);
 
 		hci_devcd_complete(hdev);
 		goto out;
@@ -3230,10 +3235,10 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	return ret;
 
 out:
-	if (btdata->qca_dump.ram_dump_size)
+	if (qca_dump_ptr->ram_dump_size)
 		usb_enable_autosuspend(udev);
-	btdata->qca_dump.ram_dump_size = 0;
-	btdata->qca_dump.ram_dump_seqno = 0;
+	qca_dump_ptr->ram_dump_size = 0;
+	qca_dump_ptr->ram_dump_seqno = 0;
 	clear_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
 
 	if (ret < 0)
@@ -3709,8 +3714,10 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 		return err;
 
 	if (btdata->match_id->driver_info & BTUSB_QCA_WCN6855) {
-		btdata->qca_dump.fw_version = le32_to_cpu(ver.patch_version);
-		btdata->qca_dump.controller_id = le32_to_cpu(ver.rom_version);
+		struct btqca_data *btqca_data = hci_get_priv(hdev);
+
+		btqca_data->qca_dump.fw_version = le32_to_cpu(ver.patch_version);
+		btqca_data->qca_dump.controller_id = le32_to_cpu(ver.rom_version);
 	}
 
 	if (!(status & QCA_SYSCFG_UPDATED)) {
@@ -4174,6 +4181,9 @@ static int btusb_probe(struct usb_interface *intf,
 	} else if (id->driver_info & BTUSB_MEDIATEK) {
 		/* Allocate extra space for Mediatek device */
 		priv_size += sizeof(struct btmtk_data);
+	} else if (id->driver_info & BTUSB_QCA_WCN6855) {
+		/* Allocate extra space for QCA WCN6855 device */
+		priv_size += sizeof(struct btqca_data);
 	}
 
 	data->recv_acl = hci_recv_frame;
@@ -4316,8 +4326,10 @@ static int btusb_probe(struct usb_interface *intf,
 	}
 
 	if (id->driver_info & BTUSB_QCA_WCN6855) {
-		data->qca_dump.id_vendor = id->idVendor;
-		data->qca_dump.id_product = id->idProduct;
+		struct btqca_data *btqca_data = hci_get_priv(hdev);
+
+		btqca_data->qca_dump.id_vendor = id->idVendor;
+		btqca_data->qca_dump.id_product = id->idProduct;
 		data->recv_event = btusb_recv_evt_qca;
 		data->recv_acl = btusb_recv_acl_qca;
 		hci_devcd_register(hdev, btusb_coredump_qca, btusb_dump_hdr_qca, NULL);

-- 
2.34.1


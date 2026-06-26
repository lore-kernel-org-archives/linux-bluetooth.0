Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F663A16AB
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451199; cv=none; b=oNDP+E+tea+Q8shErj7eTyPvdv1Gg8XS6ippNQHfCUwuO7nSsshnTUeoC7g04YRls7tC8qeDxoHJMIvlq3Iu94imxgqYfVPEAiPJ1dtKWtj5p6JWweipWk/5nMGCho1sbDL6F9C3XUDyFrEkLYWAkjJk/ZKJIV4BBypCUHUBNgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451199; c=relaxed/simple;
	bh=G57PRvnCTVv1g7AkoeoncnFch1CLOD6NcEmypvuIrwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0wgsHgSZPxsWHb1zM14WFysJCjA7TRbSGoSoxDQ4zgADtbaLF0WY5QXcOpU0xs4dwKYQ9b6s1Hz8Os1I1IJbT+W1boAXQoDf+2DxU8tQlEdcvjmwSvTGYRmIFEPVPsFOHmyGex1dOujuWqt7Y6bmRh2A1vUG54whWz4EuHTwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QFRNUpKe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h/rPEl8K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QFRNUpKe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h/rPEl8K"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q2iZj1076297
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2llfy6r0JTyF6TECv8bZCD+XrXgW/KnGKods9XqPCP0=; b=QFRNUpKenuaaWDo8
	3bdVWhwHCCyGUzW1QywuK30CeCkQUa1WlVauou+ItFMGDeJoWXPYZ4cVdcPbCOhD
	5Ly5CjBbNDCCpK0ZepL7KGGkBk7ALEtPhDvoOYZb1+QlzZ7HRedyLbaWWLSe0zfO
	96nTzR3jiAPyFiFPFOqJzyoiDWgl0V6sIfdH6C1Jpwdssgtc0YX0qUnxAhm+GwiQ
	LnO0pT81yulwrr6rS4DigD0cROaLCm9WO0fibKBTWjf9kIFpBlD1dyR0dDquM+qz
	eyUqVmSyP6ielnTdTfkFX/pfWWSJxInxf8yGWLBtQgbl+K3L42V1TirLCLB4U/q5
	5ur9Aw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1eew92u2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 05:19:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bd0d5f5a4so61877eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 22:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782451196; x=1783055996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2llfy6r0JTyF6TECv8bZCD+XrXgW/KnGKods9XqPCP0=;
        b=h/rPEl8KeWWafiTLm+TShT6flOkMggXz7asGKFyD7La6ACm4KDa6RQZdaIBLtEfDsS
         A/o3IsojSlBuWKdjaZLFUuNVvo6/w3Fq4JBferihhGe8ttazrclY+bDyvqoTw7rG7iMh
         KfgGhcSX2xUYZ4rTtrEnKq5bRWFhQqp75vIdKLTJ4HxU+/qoowUT9lFnhFM6Ws5c4J1N
         0apRVwTgbuRjvFwWGrYE0eZJY72F6du2KckD/CBO/9w7EaGgfE0AoQ+Hm5aJqXOEvNP+
         t9lMfo1glRk7WqRUKX3Yqib4KKtGAORE59D7YhIiSSkH+DIG8TMSwha7gH0uNPLK6GyQ
         +pEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451196; x=1783055996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2llfy6r0JTyF6TECv8bZCD+XrXgW/KnGKods9XqPCP0=;
        b=OB3s/qFGLvKUoA+WE3c6YJ6VjT+RDndqPqAhGS+azZ0ptKnIzzGpWNc9c6H9gOGaMm
         e6qa94t5GZPqXFQrYXRVSjo4mPDjwOzb1gXYJj8CrMcUdmhvn1rPqLIhv7UBxN8gdluP
         //uG3pDFWGxZDLi2C70tx6hYiGTniX0r53C4uHhZFoF84kok9YFDdS6h0p6OvhDm094H
         NLLQJN/Bjm0H4CftkwBLV1yvFVdIqf3espTx4JpkxdsEoQqITiU215LKLmMPt6/kyKqK
         jLYelhFr2whDcXO+skdKeXCAZ/DuWBa1CHS9s+34fi4qff6Ep+xfBPEBdUxBoFW9/beF
         9A2A==
X-Forwarded-Encrypted: i=1; AHgh+Rol1PibGTzbVyqH9xOOHpMCEoRfuYZQQtuptoPLQv4BWNFtmv+/Uqbqj1cGyP0wCqzgiQFRwoQZ1utZHWw0D9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4b/0YLWm/zNsmvBi7SmRsQs/r4RRTuvHONlMSHEgRUlmcXO90
	APjrObe8xvyKX95Vj8wpnTtXf4uV9pKzyJR49IeItamDOZfrJ8613YwFyJ8EwcKJ/DAOiRst2Ab
	IUP2FijLZNOVgZkodPTR814qoScodr1pLVbzo9s+d4NGatsfI3O1sn3tkBQwv/xABO/M+7+o=
X-Gm-Gg: AfdE7clc/TjPPrXQ0CRTawiqfE/24ZDDK5by0HmACvkUURD3nwGlo6/lRB1q0QMnb1D
	uRMhbwhXvK5RXI4KsjmbTez3N3kmY+w7vo4U9pFBy05REII8SeCnmNYQ/9trnQglaRpMD/lJ4rM
	EW+hX6HtYsZWGRC/KbVhgZKBixbYff7gN7W+8kaIJlAAdIzsVaHhRK8HaXdcfM8IZpd8I4VS+ca
	YwW6hub4QXRZOqtV0dCikiSUi0KU5lXqildWcUxtMFdKw09UJcHWwYWkHpeRIHIIyXzVyWfT38l
	nldiWr+SGT3cYlpZ/z4Go4M196Tqrdgx+k2sZJG0OWzzoeq9E1wFc9ZQpOk9U2SlK/YF1UE+MJO
	713XAPS4zYwq58tDuKJjSB+24aREg8dsZ01tgE6WFCgOh2tVNFqzToUFezw==
X-Received: by 2002:a05:7300:6144:b0:30b:c021:5045 with SMTP id 5a478bee46e88-30c84ce60f7mr2112496eec.5.1782451195550;
        Thu, 25 Jun 2026 22:19:55 -0700 (PDT)
X-Received: by 2002:a05:7300:6144:b0:30b:c021:5045 with SMTP id 5a478bee46e88-30c84ce60f7mr2112487eec.5.1782451194969;
        Thu, 25 Jun 2026 22:19:54 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14345291eec.4.2026.06.25.22.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:19:54 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 22:19:50 -0700
Subject: [PATCH v2 05/12] Bluetooth: btusb: QCA: move qca_dump out of
 struct btusb_data
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-bt_bugfix-v2-5-93396a6f7d5e@oss.qualcomm.com>
References: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
In-Reply-To: <20260625-bt_bugfix-v2-0-93396a6f7d5e@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Tim Jiang <quic_tjiang@quicinc.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-arm-msm@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX8l5kH66KP4xu
 CM2Lz4RWAu8TzsgOEEeyFhh/EgqrrlfhfT6D1vHG05w0GbacoTfII2vX77+t+4+pYxRsRCW4BAq
 agNheMKYAKbKn/z8awLIP1Z6VEc9xFY=
X-Proofpoint-GUID: S83eP8rGHqooHJUZd3Yp-YFjca-hF7er
X-Proofpoint-ORIG-GUID: S83eP8rGHqooHJUZd3Yp-YFjca-hF7er
X-Authority-Analysis: v=2.4 cv=P7UKQCAu c=1 sm=1 tr=0 ts=6a3e0bfc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0qFWW5pOsv3iMAJ541kA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX3qIWAgzUvDli
 I5gO10QAao1EHbmd15IE/OXPOXzsuUnhexiklD95YJ9RU0hPj5ngsLL3cJ2jL3MbaFJsnYHIMI1
 +X6GfUwnTa4ft2rKda0HTMYV1F5rxydGBwxcxk5PKuI+RM+8wAVq3tliQBfNglxYEl5LJHSGal4
 jWUOiXDmhjFDQOOnh/+qSzxY9eCMFifyf1AdAQJH05ILlhdTSMTtSLUga/awjSJ/cCDJBqe0lHM
 lcAp7Zt5wjNvKLAXm+l8SAWDGUwfSQA9O2AA45J+8UzMcobNbQBvOTL1YkTD+mwRNLoOBIkbMfr
 XUiOoLgVbLkxixTFQ2P2q2c23PBoCQ2nr9aT3FpPphFQq2gEdg8Hz2DcQg+YmgBYZmZTEWaUaPo
 4FS14vUGZT8vOLzUypebT0klHVUzFmaxE8iCuxS0725YaA3mvKNKlMr8x7vDn1MAKH3JnSk0hud
 eoqoiTm2iaLuvlbHuRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260040

'struct btusb_data' ideally should not include vendor specific
fields, but it currently includes the QCA devcoredump member
'struct qca_dump_info qca_dump'.

Fix by moving it into hci_dev private area accessed by hci_get_priv().

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btusb.c | 56 ++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0bc7d7b61b25..a5ff4af90675 100644
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
@@ -3117,14 +3119,15 @@ struct qca_dump_hdr {
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
@@ -3132,7 +3135,7 @@ static void btusb_dump_hdr_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	skb_put_data(skb, buf, strlen(buf));
 
 	snprintf(buf, sizeof(buf), "VID: 0x%x\nPID:0x%x\n",
-			btdata->qca_dump.id_vendor, btdata->qca_dump.id_product);
+			qca_dump_ptr->id_vendor, qca_dump_ptr->id_product);
 	skb_put_data(skb, buf, strlen(buf));
 
 	snprintf(buf, sizeof(buf), "Lmp Subversion: 0x%x\n",
@@ -3161,6 +3164,8 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 
 	struct qca_dump_hdr *dump_hdr;
 	struct btusb_data *btdata = hci_get_drvdata(hdev);
+	struct btqca_data *btqca_data = hci_get_priv(hdev);
+	struct qca_dump_info *qca_dump_ptr = &btqca_data->qca_dump;
 	struct usb_device *udev = btdata->udev;
 
 	pkt_type = hci_skb_pkt_type(skb);
@@ -3188,8 +3193,8 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 			goto out;
 		}
 
-		btdata->qca_dump.ram_dump_size = dump_size;
-		btdata->qca_dump.ram_dump_seqno = 0;
+		qca_dump_ptr->ram_dump_size = dump_size;
+		qca_dump_ptr->ram_dump_seqno = 0;
 
 		skb_pull(skb, offsetof(struct qca_dump_hdr, data0));
 
@@ -3201,29 +3206,29 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -3231,10 +3236,10 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -3710,8 +3715,10 @@ static int btusb_setup_qca(struct hci_dev *hdev)
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
@@ -4177,6 +4184,9 @@ static int btusb_probe(struct usb_interface *intf,
 	} else if (id->driver_info & BTUSB_MEDIATEK) {
 		/* Allocate extra space for Mediatek device */
 		priv_size += sizeof(struct btmtk_data);
+	} else if (id->driver_info & BTUSB_QCA_WCN6855) {
+		/* Allocate extra space for QCA WCN6855 device */
+		priv_size += sizeof(struct btqca_data);
 	}
 
 	data->recv_acl = hci_recv_frame;
@@ -4319,8 +4329,10 @@ static int btusb_probe(struct usb_interface *intf,
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


Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF55436344
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800639; cv=none; b=Tsv2HNd0mbYqFhYlvTqdBncEpE02UfRGxKJERzCEMoirEHO5LrCHm/ophvjrBcu1Qc65jutkeFHczlQL/0OVt/M0hXToP2xR6ZRN3OX0EPl0qbOE4sVRY6Pf3UPBsXhr0ovnm5xj9wh6CI8xGdj56qbhBmRiIBp3Vsyz1lDieNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800639; c=relaxed/simple;
	bh=W2CbQs96aNcvRwookk8Jcu/u0RGeb+cUthYTKV3XqDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KVs7JENqrlunxBJGUqwdZdnGmkeVpQMv29Qn2X4ttQnP2c8AtrxsRF3DtBKQ8PZcANGOU6d+IQ1t6p2wUi9F82Iv45XTEry+/srUqRGcUde67MzoD8WMWTCS6Pvx0+IFkSUdmOS6smbSpAkyOQLIsnyLMi55cb1di4dilkyvexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JW4TpvIo; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JW4TpvIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=DX
	iBhX5vEaccAd09jJeCSTJOLPErarrdo95Sdq3PXcQ=; b=JW4TpvIoxrnOPkymRq
	+1uIPBjgmpjtdj2M03/RzN3R2xyr9VCwAWeGBTXLB4MTFNRHEkHFvUwo4FpzxzTQ
	IpNa9Msoc0mgDFfCGdVItGTAipbFeECUOc2AWdvJdTCeg3DwrQF37DIhX+IcG6KX
	YUmHjhkZkL8BXM4qTmxTCAcec=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBnoGpF5WFqzjaPKg--.45854S2;
	Thu, 23 Jul 2026 17:56:22 +0800 (CST)
From: zhangchen200426@163.com
To: luiz.von.dentz@intel.com,
	yang.li@amlogic.com,
	tim.bird@sony.com,
	naga.akella@oss.qualcomm.com,
	gustavoars@kernel.org,
	pav@iki.fi
Cc: zhangchen01@kylinos.cn,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures
Date: Thu, 23 Jul 2026 17:56:16 +0800
Message-Id: <20260723095616.1543159-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnoGpF5WFqzjaPKg--.45854S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF43CFWfWw45XF47JrWrKrg_yoW5tw1kpa
	909a45ZrW8JrsxX3WfAa97Zrs5Xw1kurZrKrsFk34rZanYvrZ7tF1kCry2yry3ArWDJF17
	XF4Igr17KrWkJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWyIbUUUUU=
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbC6AZ9Gmph5UYvwgAA3M

From: Chen Zhang <zhangchen01@kylinos.cn>

Define HCI_Write_Link_Supervision_Timeout command, event structure, and
corresponding event handler function.

Signed-off-by: Chen Zhang <zhangchen01@kylinos.cn>
---
 include/net/bluetooth/hci.h      | 10 ++++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 40 ++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 50f0eef71fb1..18a5a17eb218 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1239,6 +1239,16 @@ struct hci_cp_host_buffer_size {
 	__le16   sco_max_pkt;
 } __packed;
 
+#define HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT	0x0c37
+struct hci_cp_write_link_supervision_timeout {
+	__le16	 handle;
+	__le16	 timeout;
+} __packed;
+struct hci_rp_write_link_supervision_timeout {
+	__u8	 status;
+	__le16	 handle;
+} __packed;
+
 #define HCI_OP_READ_NUM_SUPPORTED_IAC	0x0c38
 struct hci_rp_read_num_supported_iac {
 	__u8	status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e7133ff87fbf..866903a9b5c8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -702,6 +702,7 @@ struct hci_conn {
 	__u8		le_features[248];
 	__u16		pkt_type;
 	__u16		link_policy;
+	__u16		link_supervision_timeout;
 	__u8		key_type;
 	__u8		auth_type;
 	__u8		sec_level;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 741d658e9630..3b1f4cf922c3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -606,6 +606,44 @@ static u8 hci_cc_write_voice_setting(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+static u8 hci_cc_write_link_supervision_timeout(struct hci_dev *hdev, void *data,
+						struct sk_buff *skb)
+{
+	struct hci_ev_status *rp = data;
+	struct hci_cp_write_link_supervision_timeout *sent;
+	struct hci_conn *conn;
+	u16 handle;
+	u8 status = rp->status;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+
+	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT);
+	if (!sent)
+		return status;
+
+	handle = le16_to_cpu(sent->handle);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn) {
+		status = 0xFF;
+		goto done;
+	}
+
+	if (!status) {
+		conn->link_supervision_timeout = __le16_to_cpu(sent->timeout);
+		bt_dev_dbg(hdev, "handle 0x%4.4x timeout set to 0x%4.4x (%u ms)",
+			   handle, conn->link_supervision_timeout,
+			   conn->link_supervision_timeout * 5 / 8);
+	}
+
+done:
+	hci_dev_unlock(hdev);
+
+	return status;
+}
+
 static u8 hci_cc_read_num_supported_iac(struct hci_dev *hdev, void *data,
 					struct sk_buff *skb)
 {
@@ -4097,6 +4135,8 @@ static const struct hci_cc {
 	HCI_CC_STATUS(HCI_OP_WRITE_CLASS_OF_DEV, hci_cc_write_class_of_dev),
 	HCI_CC(HCI_OP_READ_VOICE_SETTING, hci_cc_read_voice_setting,
 	       sizeof(struct hci_rp_read_voice_setting)),
+	HCI_CC(HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT, hci_cc_write_link_supervision_timeout,
+	       sizeof(struct hci_rp_write_link_supervision_timeout)),
 	HCI_CC_STATUS(HCI_OP_WRITE_VOICE_SETTING, hci_cc_write_voice_setting),
 	HCI_CC(HCI_OP_READ_NUM_SUPPORTED_IAC, hci_cc_read_num_supported_iac,
 	       sizeof(struct hci_rp_read_num_supported_iac)),
-- 
2.25.1


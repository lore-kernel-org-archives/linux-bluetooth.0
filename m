Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245153DA5AE
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883309; cv=none; b=sAaf6yID8UGEm8L5Z923uoV+G3JeP1mROzfvyB8GF8HhZaOH9GeNR3SLiPW2efM0/n2vlVt05M3yC7VjKGFrRZdlDrvrmbtcFM7+utEj7e1tcBTa8v74eqNkRuIdkLBxlAgZh+0/VLzK86YEYvHtl8dNjv4VVL8RMKEfdSR1pZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883309; c=relaxed/simple;
	bh=J6pM6oPcQ9r2irSCaGHK1YyBk7b8RMUMKr6etxKzgHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U0pAhTcPVlFJ8qY3GpFmCJaDyGMHqrPXjm+ryPlakRUC37rZ8voNM2Bx1D3+xBieN6sAsyeus2zhQdvlUrQ64Eo6f2tEGBg0qyNMpyv/crTubkbDClqTFASHvcdxrRsjza5EFcwDdTba93f/kUka0+RqGiTmCf39oR28ifkn0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Db81ZUho; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Db81ZUho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+y
	Dqp5ZOSkgpPl2uq7k9kPwWZjw60JKBKgsOZv43Unw=; b=Db81ZUhoii9JOSVdK/
	wXhg+lgf3mImztRQCU5ejBtncspGLxy+lTYyOK2HcodTWuhVB9TN/r4HZevGmOHc
	Atyw9ZHtAj//UyIqva9yX2bk60i4WKf5wVKkUEvoBHDOX5DFkq7Rg1CaJLo+3MMH
	scqFQhqDfLm03GN/d9A9yDB4w=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCHj9AxKGNqnnybJQ--.37020S2;
	Fri, 24 Jul 2026 16:54:11 +0800 (CST)
From: zhangchen200426@163.com
To: luiz.von.dentz@intel.com,
	yang.li@amlogic.com,
	tim.bird@sony.com,
	naga.akella@oss.qualcomm.com,
	gustavoars@kernel.org,
	pav@iki.fi
Cc: zhangchen01@kylinos.cn,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures
Date: Fri, 24 Jul 2026 16:54:06 +0800
Message-Id: <20260724085406.1884991-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCHj9AxKGNqnnybJQ--.37020S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1UCrWxKFW5AFWfuFyUJrb_yoWrZF1kpa
	909a45ZrW8Jrs3X3WfAaykZrs5Xw1kurW7KrZ2k34FyanYvrZ7tF1kCa42yry3ArWDJ3W7
	XF42gry7KrykJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWyIbUUUUU=
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbC5xOJJmpjKDMiQAAA3r

From: Chen Zhang <zhangchen01@kylinos.cn>

Some speakers do not actively initiate disconnection when power off. As
a result, the center can only wait for a timeout to disconnect, with the
default timeout being 20s. In certain scenarios, this can significantly
impact user experience. For example, if a speaker is playing music and
is then turned off, it takes 20s before the music starts playing from
the center.

Define HCI_Write_Link_Supervision_Timeout command, event structure, and
corresponding event handler function, set the timeout to 5s after ACL
link is established.

Signed-off-by: Chen Zhang <zhangchen01@kylinos.cn>
---
 include/net/bluetooth/hci.h      | 10 +++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 50 ++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

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
index 741d658e9630..653184d0dfc7 100644
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
@@ -3240,6 +3278,16 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 			hci_send_cmd(hdev, HCI_OP_CHANGE_CONN_PTYPE, sizeof(cp),
 				     &cp);
 		}
+
+		if (conn->type == ACL_LINK && conn->role == HCI_ROLE_MASTER) {
+			struct hci_cp_write_link_supervision_timeout cp;
+
+			cp.handle = ev->handle;
+			cp.timeout = 0x1F40;	/* 8000 * 0.625ms = 5000ms */
+			hci_send_cmd(hdev, HCI_OP_WRITE_LINK_SUPERVISION_TIMEOUT,
+				     sizeof(cp), &cp);
+		}
+
 	}
 
 	if (conn->type == ACL_LINK)
@@ -4097,6 +4145,8 @@ static const struct hci_cc {
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


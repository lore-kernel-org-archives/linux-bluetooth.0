Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1B453A34
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696906; cv=pass; b=Xkb66DOJnxi5zxhIa55pHIKEiEUhfqPgYHQqj/PzRle0kd6SCNlrDnbHAqzQBDn1C7uOfuepnnlolGJ9MEyanU0rCzmFcyfh5VmwcQ3rgVrEyjRyy94qsEN0ewfsZMRWukhXx/uKspa6vEG+GvUcRQut9yWk+ooKdbPBzDxeINg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696906; c=relaxed/simple;
	bh=I6KpaMh3qiJgmfjFABN4uNolYwPYwhn+9V3eQ9TA3g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/7HcSuHl8NQEJoCLJvas+Yrz1LZVljpOn0VXYTr2WInrHlFh0+DLHB1O17pfaYB4WG/Fo/SLpVBKFN+1yOc5enOGpmMcuhCzhfVsWyqH0+8Lt1Q7yzWQTD4YhR1njmbR75NmKW8HGr8LMZtnLnK/gyf7KvS+Y+rxKhIda3uhag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=MqBOK9mn; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="MqBOK9mn"
ARC-Seal: i=1; a=rsa-sha256; t=1786696883; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=RHgnc6K09oZV8JoVygN5RrrjYlpYvR2qCJF256BaM9za4WNt9RJzisrvdT7/eQXORYbzAQocjasWQwQFV+SDqmRS5ecBe1M6rfWOkzy4Sufv15VlY9+PaCDS1gYzu9Nm+qfPj5eD04yI86ajDC/2F1CLtyEZSQgaQH9MN+5cCkQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786696883; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=F7oT5md6Zr92jsZEkNRblXbG/f3dZQSoNCqZS5xIqTI=; 
	b=d2WVQxVojfJqPYRrGwgK5sR8Ec9FIBpImOaYFk2mC3tdo7FErTcFSntBrfVs3xbsAtVNaNxT7YCKNTPVG29nrLGDGcFu0XG1hRUSlQjltLHk1OQhApnZo/SWlh+cJ3+Uo6py5rmNqduHcM+xCgu6GuqzjjDVS5z2mKX01UgAkNs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786696883;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=F7oT5md6Zr92jsZEkNRblXbG/f3dZQSoNCqZS5xIqTI=;
	b=MqBOK9mn3OyCiN5a5BW+aibgKtTXC1f3+i2HxVrQo567L6sy72R0jPgFCrcUDgks
	vLs37RJj2I/MxUpLEkxqWjo4EOWmK7wIzwfWOL/tkQz53tolPjDI/SgqeflEv48Xlbr
	vbhOMZEWuqJykBWF9jeCTf39u/JbId9zdIAMIBYA=
Received: by mx.zoho.eu with SMTPS id 1786696880253596.5822836158649;
	Fri, 14 Aug 2026 10:41:20 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: neeraj.sanjaykale@nxp.com,
	amitkumar.karwar@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: alex.zhou@nxp.com,
	song.xue_1@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btnxpuart: Validate the FW dump header length
Date: Fri, 14 Aug 2026 08:41:08 +0000
Message-ID: <20260814084110.920879-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814081221.913676-1-ali@iusegentoo.com>
References: <20260814081221.913676-1-ali@iusegentoo.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

nxp_process_fw_dump() pulls the ACL header off the frame and then reads
seq_num and buf_len from a struct nxp_fw_dump_hdr placed at skb->data,
without checking that the ACL payload is long enough to contain it.

h4_recv_buf() collects HCI_ACL_HDR_SIZE bytes of header followed by the
number of payload bytes named in that header, so skb->len is 4 + dlen
with dlen supplied by the controller and possibly smaller than the 8
byte dump header, or zero. A short frame with connection handle 0xfff
therefore reads both fields from beyond the received data.

Beyond the read itself, buf_len is what terminates a dump: a value of
zero makes the driver call hci_devcd_complete() and reset the
controller, so a truncated frame can end a dump early.

Reject frames whose payload is shorter than the dump header.

Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump feature")
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
v2: Warn on the early exit path instead of dropping the frame silently,
    as suggested by Neeraj. Dropped the trailing newline from the
    suggested message, since bt_dev_warn() already appends one.

v1: https://lore.kernel.org/all/20260814081221.913676-1-ali@iusegentoo.com/

 drivers/bluetooth/btnxpuart.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 6a1cffe08d5f..f439d287146e 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1370,10 +1370,19 @@ static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
 									  sizeof(*acl_hdr));
 	struct nxp_fw_dump_hdr *fw_dump_hdr = (struct nxp_fw_dump_hdr *)skb->data;
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
-	__u16 seq_num = __le16_to_cpu(fw_dump_hdr->seq_num);
-	__u16 buf_len = __le16_to_cpu(fw_dump_hdr->buf_len);
+	__u16 seq_num;
+	__u16 buf_len;
 	int err;
 
+	/* The ACL payload must be long enough to hold the FW dump header */
+	if (skb->len < sizeof(*fw_dump_hdr)) {
+		bt_dev_warn(hdev, "FW dump: invalid or corrupt fw dump chunk");
+		goto free_skb;
+	}
+
+	seq_num = __le16_to_cpu(fw_dump_hdr->seq_num);
+	buf_len = __le16_to_cpu(fw_dump_hdr->buf_len);
+
 	if (seq_num == 0x0001) {
 		if (test_and_set_bit(BTNXPUART_FW_DUMP_IN_PROGRESS, &nxpdev->tx_state)) {
 			bt_dev_err(hdev, "FW dump already in progress");
-- 
2.55.0


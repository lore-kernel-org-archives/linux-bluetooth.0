Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F60E49252E;
	Fri, 14 Aug 2026 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732152; cv=pass; b=n0Ho0hx5yLsXCv3IzzLuRsxg6u8nxdS6SMIsiSji30eWjj8SK5ZSQ3z7sJOyWBHV/O9Dq22iwcPqg3S/cEg4f2yJhuvo2Y8d03OOpPwhPCPQ7Htv1hlu9V6pxtCRu2GqM6N/GLq2595Hs5INsZCW/gb6cgFae2BrrTQGK3qy7Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732152; c=relaxed/simple;
	bh=f/J5TbdcHXZ3PTJLxvGCrdd4D/UAnGLsqYcs68vEADI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPMrIoGA0F6KsJXp+XlwI5akGQ0oZiUi61yg/v0OSCRThfPNUMDjkNaBbgqqpxZLYTRGXiefCoVJTUDQvHDlD8WV6pfqe3+RTjsTXtAUi9ODUL/CdAaGQxRStwxTp/4dm5LVgpf40nsN07tHedqpbAeFbIul3NuCd1PzvNNIifE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=kXNCMS1K; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="kXNCMS1K"
ARC-Seal: i=1; a=rsa-sha256; t=1786732143; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=i0pWXWWJFXmwArW82rrSkgOqpKzSPclaHavDTdfK4WxqDMnK4z20Zvf3UxEWJyXVdHxDyAEv2ds5uY8+S3S/VL7d5bN4+TtbJ2kB2nIwZnbqCLu/h0OLnQjiOlTVqF8PNq2WPa0YJC6bn/JNgRtRaFhS4mrqg/3n5851Re7o/AY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786732143; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WclBpSx112b+QyPbfG9yk3n7QWCF0qSA2wwxnaRAZQE=; 
	b=X6/0NC84JjuvHmRdovr3aIQHZm/ZddeQuCOtPN7NfTahweQUAb9s9KzufmkoXZj8rYX9FvBmVjh2lACJCd6saJjQcV0yfHVL4+K/UbrpjVbJ9NHiLJz/fgSe3JFo49Zw1wYFuhNTbLFrGnztxCJNMap5xeA5CCK2or0pQSkUGoA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786732143;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WclBpSx112b+QyPbfG9yk3n7QWCF0qSA2wwxnaRAZQE=;
	b=kXNCMS1K5k5oaVYDoOPYwQDyQ3jotmfPmEutoQ3wZht0+r/w925zUWXyLXrEK/0m
	Z+wDAtOJQeVHzOHMV/LRc8/fdkq9M77cbZd3/pUiSH5Li3GbbMr4xPx/PR3gDuJ4wfD
	fNv662XXUss1vq5MIUeQMWlqoNjWzUwIjwLuQkO0=
Received: by mx.zoho.eu with SMTPS id 1786732140288659.8875099886181;
	Fri, 14 Aug 2026 20:29:00 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	neeraj.sanjaykale@nxp.com,
	amitkumar.karwar@nxp.com,
	marcel@holtmann.org,
	alex.zhou@nxp.com,
	song.xue_1@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: btnxpuart: Validate the FW dump header length
Date: Fri, 14 Aug 2026 18:28:48 +0000
Message-ID: <20260814182849.940976-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CABBYNZKVQ0CxsviF92iP1Hj2rBiH_hmmEHirp8D=b-DvuaTNeA@mail.gmail.com>
References: <CABBYNZKVQ0CxsviF92iP1Hj2rBiH_hmmEHirp8D=b-DvuaTNeA@mail.gmail.com>
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

Use skb_pull_data() to validate and pull the FW dump header before
accessing its fields. Warn and reject the chunk if the header is
truncated.

Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump feature")
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
v3: Use skb_pull_data() to validate and pull the FW dump header, as
    suggested by Luiz.
v2: Warn on the early exit path instead of dropping the frame silently,
    as suggested by Neeraj. Dropped the trailing newline from the
    suggested message, since bt_dev_warn() already appends one.

v1: https://lore.kernel.org/all/20260814081221.913676-1-ali@iusegentoo.com/

 drivers/bluetooth/btnxpuart.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 6a1cffe08d5f..e6c15bc6a30b 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1368,12 +1368,21 @@ static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_acl_hdr *acl_hdr = (struct hci_acl_hdr *)skb_pull_data(skb,
 									  sizeof(*acl_hdr));
-	struct nxp_fw_dump_hdr *fw_dump_hdr = (struct nxp_fw_dump_hdr *)skb->data;
+	struct nxp_fw_dump_hdr *fw_dump_hdr;
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
-	__u16 seq_num = __le16_to_cpu(fw_dump_hdr->seq_num);
-	__u16 buf_len = __le16_to_cpu(fw_dump_hdr->buf_len);
+	__u16 seq_num;
+	__u16 buf_len;
 	int err;
 
+	fw_dump_hdr = skb_pull_data(skb, sizeof(*fw_dump_hdr));
+	if (!fw_dump_hdr) {
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


Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7B533C19E;
	Tue, 18 Aug 2026 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787084555; cv=pass; b=abPSYq2uwqwWQu+zU04+AhA9xx2H+IWGECQ06vkEQ2TNOL7yuh/vjqJA3vUdG9xwXjoQWVbw3CBcJLferkoeW3akL0zko+mGcJdTTtq6993VHjSg+HYaxAB9Z3bozxiDEnZHjQcZLohktw/TtWXjNqg1A5KsezwlOM8/wnhptFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787084555; c=relaxed/simple;
	bh=/UpSY5d6cvj4kaeRp0oCsujwI7JiU5rPb0xNZAOX8WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHmCDefDdAJFRWtJDx/gh3pV2dtvnh3L3Y+LlF2/rKdDlum1TceYDloWewprcpWTMJb3CCLXrRoY2TOCj+YUy3k+y007lTmft7Af5SlQzWH8hxa4YF+lvumXuS2W0gPrVdTIbdnNPZWG2nH4B+2PxsE2HnTwJRduvzGWorEvQag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=JHvTmaBU; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="JHvTmaBU"
ARC-Seal: i=1; a=rsa-sha256; t=1787084545; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZWG3bms7XlmOuaLGUfcii/bD+LOnmRcw594+iCXubKScI9KNF8u3dt4hNAXZymX2TIA+JxpJtY7wD6rrlcg8xMys5TW61vXb8em8sfV04K6cZNILnWWEtJVLKd3u469CgbuW8ZSVRlPurq5oz7LQZ1W07yX3K6BiwIvvcUBl30o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1787084545; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fMFVxEtuDjoAKyvYCuWWAmMet5fEpco4TNoSqqurPgk=; 
	b=RmfKOdV+0BjjP8uQXcEMHwUjtEbYz1klZi74u3uKNmG1hjsjqFNDKocKtlz2mHxgR3Txphj7MmB1EpMsrHDdQbTs/XQ6TzQ8H5vstW85AGGkFzB7U8KF+8BE/6vUChX77vwRmFnrNFdbSPSPKijA5F2/rMO5rShCGqY1iWThkRA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787084545;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fMFVxEtuDjoAKyvYCuWWAmMet5fEpco4TNoSqqurPgk=;
	b=JHvTmaBUNFf1+7XgqeNME3hztFzx3tOhUxb/xHM8Yu6xRsYyXU08qO/0PmaQznBI
	NQzTml2Gow5JanbnWdLhtNnzv4Rj7bP1yUjmhrnKMT64VAgKPhMLXH3hhDAWbpE/cUJ
	0BsqXGe7Viyur3S893d3YjCozweLGFNausgz8Q1Y=
Received: by mx.zoho.eu with SMTPS id 1787084542044832.9430274589988;
	Tue, 18 Aug 2026 22:22:22 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: luiz.dentz@gmail.com,
	neeraj.sanjaykale@nxp.com,
	amitkumar.karwar@nxp.com,
	marcel@holtmann.org
Cc: alex.zhou@nxp.com,
	song.xue_1@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] Bluetooth: btnxpuart: Validate the FW dump header length
Date: Tue, 18 Aug 2026 20:21:54 +0000
Message-ID: <20260818202211.617795-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

nxp_process_fw_dump() pulls the ACL header off the frame and then reads
seq_num and buf_len from a struct nxp_fw_dump_hdr placed at skb->data
without checking that the ACL payload is long enough to contain it.

h4_recv_buf() collects HCI_ACL_HDR_SIZE bytes of header followed by the
number of payload bytes named in that header, so skb->len is 4 + dlen
with dlen supplied by the controller and possibly smaller than the 8
byte dump header, or zero. A short frame with connection handle 0xfff
can therefore read both fields beyond the received data.

This is not only an out-of-bounds read. buf_len is also what terminates
a dump, so a value of zero makes the driver call hci_devcd_complete()
and reset the controller. A truncated frame can therefore end a dump
early.

Check that the payload is long enough before reading the header. The
header is not pulled from the skb because the skb is cloned for
hci_devcd_append() afterwards and the NXP FW dump analyzer expects
nxp_fw_dump_hdr at the beginning of each chunk in the dump.

Abort the dump when a chunk is too short to contain the header. The
firmware is not expected to generate such chunks, so receiving one
means something already went wrong and the rest of the dump can no
longer be trusted. Dropping it silently would leave userspace with a
dump that looks complete even though a chunk went missing from it.

hci_devcd_abort() still reports the data collected so far and records
HCI_DEVCOREDUMP_ABORT in the State line of the dump header, so userspace
can tell that the dump is truncated. The controller is reset as on the
completion path because BTNXPUART_FW_DUMP_IN_PROGRESS makes
nxp_enqueue() reject commands until the reset clears it.

Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump feature")
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/linux-bluetooth/AS4PR04MB9692EC13E3176B6D7525D097E7A72@AS4PR04MB9692.eurprd04.prod.outlook.com/
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
v4: Restore the v2 approach of checking the length without pulling the
    header. skb_pull_data() in v3 also advances skb->data, so the clone
    passed to hci_devcd_append() lost the nxp_fw_dump_hdr that the NXP
    dump analyzer expects, as Neeraj pointed out. On top of that, abort
    the dump when a chunk is too short, as suggested by Luiz.

    Sent as a new version rather than as an incremental fix on top of
    1fcf216462ec, since you mentioned folding it in. It applies to
    1fcf216462ec^. If you would rather keep 1fcf216462ec and take a
    delta on top, let me know and I will send that instead.

    Dropped Neeraj's Reviewed-by from v2 and from the follow-up patch,
    since the abort handling is new here.
    https://lore.kernel.org/linux-bluetooth/20260818080104.563675-1-ali@iusegentoo.com/

v3: Use skb_pull_data() to validate and pull the FW dump header, as
    suggested by Luiz.

v2: Warn on the early exit path instead of dropping the frame silently,
    as suggested by Neeraj. Dropped the trailing newline from the
    suggested message, since bt_dev_warn() already appends one.

v1: https://lore.kernel.org/all/20260814081221.913676-1-ali@iusegentoo.com/

 drivers/bluetooth/btnxpuart.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index e2b8f7997e4e..f6d08942a91e 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1361,10 +1361,23 @@ static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
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
+		if (fw_dump_in_progress(nxpdev)) {
+			hci_devcd_abort(hdev);
+			nxp_set_ind_reset(hdev, NULL);
+		}
+		goto free_skb;
+	}
+
+	seq_num = __le16_to_cpu(fw_dump_hdr->seq_num);
+	buf_len = __le16_to_cpu(fw_dump_hdr->buf_len);
+
 	if (seq_num == 0x0001) {
 		if (test_and_set_bit(BTNXPUART_FW_DUMP_IN_PROGRESS, &nxpdev->tx_state)) {
 			bt_dev_err(hdev, "FW dump already in progress");

base-commit: c519ffc1e2c669296b976d11f5e7a79d2f82debb
-- 
2.55.0


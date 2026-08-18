Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF93F3890EE;
	Tue, 18 Aug 2026 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040096; cv=pass; b=BEHFSy6/AP+7bKKzrAc0BEQLnccbhVe+EMVYRYkDybLDQ81fU7PheA6cFPPK0TjhZ1MElUlaYEqU8Tv7/J+7FmD1NPR6XoYFxEky5cFFYWA5MZCKML4xfF/bn9GsqE4brLOwvUXU7B/QdewtL8dYaoejskZ3Vzzsq/dR+OVQBgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040096; c=relaxed/simple;
	bh=c/3CYRgUoIDpUXGwBpQbNd6i5l7TDD1F+ykL7YXIobM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDhiWwBRuRNwsIg6aCoRAZXTobv++7HZiXEWKEEdwjcicQZl+NIMWKmCXU1aStG08fJHNOJuuWgyUBu9fkmxzOAGfEI6A6KlsuH9vqyAfDJ7I5YY11Ncz/okmmMAjOC9rCmf3SY8e0rTfGHQdknlslm6CqEzj3j87RXzwDpNmRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=bjRjLnLZ; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="bjRjLnLZ"
ARC-Seal: i=1; a=rsa-sha256; t=1787040079; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=F0SqCE7MJQHDvKPIUmxyF7K3ScuPXWegmLnnpSdD2TKLvEhVB188WOagUU8NNoIADxeupULd6RCu36wr+8DmIm8dfnNtFzVf/DHV+4FJyYsdHKbB0zCosw9OHM8WaSDksZfg/8Y0isP7WPAiG0/l4EHIdnyaSFiUIM5PpGosng0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1787040079; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HT6FP9h5iFpQTeLcUVRvrNI/4UHPkItYwVE3Lc5Ha/c=; 
	b=eIdXZbRVo3f3zOr58WCb5Pe2X9nYbNEIXuY3isgS65EARAtOuBMNCy5csgHcvMTmnpekTqpikXhrvt5u5ryPlyY+wmlqS/OgI3CqjmjdHfdtjGw3+JYR9ksYY0L5UU7HcGq5qFY6qAcd2W50OyIXExys+Rz2QERXQX6/oFq7t/g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787040079;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HT6FP9h5iFpQTeLcUVRvrNI/4UHPkItYwVE3Lc5Ha/c=;
	b=bjRjLnLZrRP2zL0QNM7BBxW1YIWPVSJkpfYiHCJScL/lPy+KhjyzM0+9EIl3e/Sq
	cLd5LK09fbaCBD/771bdQw5iYYt5ix+h8SdMrzc3DA6fzUNwm1JDStaaW80vLdt4ilA
	ei5vaGnDF7oZeWHTFpdLwz3CV7N576HWWCeem4mI=
Received: by mx.zoho.eu with SMTPS id 1787040076399533.7974277267994;
	Tue, 18 Aug 2026 10:01:16 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: neeraj.sanjaykale@nxp.com,
	amitkumar.karwar@nxp.com,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: alex.zhou@nxp.com,
	song.xue_1@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btnxpuart: Keep FW dump header in coredump chunks
Date: Tue, 18 Aug 2026 08:00:54 +0000
Message-ID: <20260818080104.563675-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <AS4PR04MB969206113CDC2F5C66994E6EE7A62@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <AS4PR04MB969206113CDC2F5C66994E6EE7A62@AS4PR04MB9692.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Commit 1fcf216462ec ("Bluetooth: btnxpuart: Validate the FW dump
header length") changed nxp_process_fw_dump() to use skb_pull_data()
when validating the FW dump header.

This also removes the header from skb->data. Since the skb is cloned
for hci_devcd_append() afterwards, the FW dump header is missing from
the coredump chunk.

The NXP FW dump analyzer expects nxp_fw_dump_hdr at the beginning of
each chunk, so this results in invalid coredumps.

Check the header length without pulling it from the skb instead. This
keeps skb->data pointing to the FW dump header when the skb is cloned.

Fixes: 1fcf216462ec ("Bluetooth: btnxpuart: Validate the FW dump header length")
Reported-by: Neeraj Kale <neeraj.sanjaykale@nxp.com>
Link: https://lore.kernel.org/linux-bluetooth/AS4PR04MB9692EC13E3176B6D7525D097E7A72@AS4PR04MB9692.eurprd04.prod.outlook.com/
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
Sorry for the late follow-up. I missed your reply on the v2 thread and
only noticed it after the change had landed. This patch restores the
approach from v2, as you suggested.

 drivers/bluetooth/btnxpuart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index f2bbe6e462aa..16d0f709d4b7 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1359,14 +1359,14 @@ static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_acl_hdr *acl_hdr = (struct hci_acl_hdr *)skb_pull_data(skb,
 									  sizeof(*acl_hdr));
-	struct nxp_fw_dump_hdr *fw_dump_hdr;
+	struct nxp_fw_dump_hdr *fw_dump_hdr = (struct nxp_fw_dump_hdr *)skb->data;
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	__u16 seq_num;
 	__u16 buf_len;
 	int err;
 
-	fw_dump_hdr = skb_pull_data(skb, sizeof(*fw_dump_hdr));
-	if (!fw_dump_hdr) {
+	/* The ACL payload must be long enough to hold the FW dump header */
+	if (skb->len < sizeof(*fw_dump_hdr)) {
 		bt_dev_warn(hdev, "FW dump: invalid or corrupt fw dump chunk");
 		goto free_skb;
 	}
-- 
2.55.0


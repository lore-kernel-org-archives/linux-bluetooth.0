Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E9204684
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733859397; cv=none; b=n1Su2yPG1a56sWDYTzV7XpDuZwXRV/3DOMpTV0A0KZ/6T0OsIF4zz12nq/YSqB1+eOcPTDGGP42nDTdkJjDiiVRuqp5IZyTTIUi49J96M0pL0BbSPTxmFApHV+8puWwKpjmvB2RQ+jykWtcJ/M26ktnqpMiYrSr9O/10YeHIfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733859397; c=relaxed/simple;
	bh=jnGwAb3sJyR6wPnPf/v4qoAr47tDfiy/QgY1p/ireRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition; b=a1uQcjJUCn89CxgL9rKbhyLR6jnIUE85pgNOAVC6jkHuIftHM0ZjxWoumsYctlwvVUmwtbMWUdDiulTyOdpabRg99CMKYiC3VT9WIqtaMeYEmPUbZ7V+ov49BVNC5PyA9rgWzlPNpZmYp1orNjdRKoInvldv1KHe8gk2Tmz4duE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=J/rkOfhE; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="J/rkOfhE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2uz5aXtGfG1B0VtJbxm1Nmhune6FGr6+yfn9GwRV5KU=; b=J/rkOfhEbIRX35i22/iayPnvJI
	NSZpXKJE6yowQ3DBTX3lPrKMM9TzqUuywYAXOs5wUPEs7pYz/dJ5EwS1DDSxSd43yhFEw30syW73w
	cjXh7M+8lrYJaqtWMfEyuW6u9ATMbzl/EUMAH6P9CBQqga2vmQy2CuFWtZdplVSPWCTh1S2PX9ExY
	uoe79UNN3RPbjXH3EZtq67LUwTMS5Qlvo3GeBeLv/+xwRGhgvkaD6bsmknb5OAydWsXa8Cvj4zQeI
	OcpvM/JBtrcVhg5Dn2CG8lTiNm4NJkmdBBIeRrpLn1y9wengD92Q2oxGK3fwkoYSzwNyXVq62DjQq
	Sep++5mw==;
Received: from 179-125-79-244-dinamico.pombonet.net.br ([179.125.79.244] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tL61o-001bpV-RK; Tue, 10 Dec 2024 20:36:17 +0100
Date: Tue, 10 Dec 2024 16:36:10 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jing Cai <jing.cai@mediatek.com>, Chris Lu <chris.lu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH Resend] Bluetooth: btmtk: avoid UAF in btmtk_process_coredump
Message-ID: <Z1iYKvmenw81i1UG@quatroqueijos.cascardo.eti.br>
References: <20240731190330.1619718-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.34.1

hci_devcd_append may lead to the release of the skb, so it cannot be
accessed once it is called.

==================================================================
BUG: KASAN: slab-use-after-free in btmtk_process_coredump+0x2a7/0x2d0 [btmtk]
Read of size 4 at addr ffff888033cfabb0 by task kworker/0:3/82

CPU: 0 PID: 82 Comm: kworker/0:3 Tainted: G     U             6.6.40-lockdep-03464-g1d8b4eb3060e #1 b0b3c1cc0c842735643fb411799d97921d1f688c
Hardware name: Google Yaviks_Ufs/Yaviks_Ufs, BIOS Google_Yaviks_Ufs.15217.552.0 05/07/2024
Workqueue: events btusb_rx_work [btusb]
Call Trace:
 <TASK>
 dump_stack_lvl+0xfd/0x150
 print_report+0x131/0x780
 kasan_report+0x177/0x1c0
 btmtk_process_coredump+0x2a7/0x2d0 [btmtk 03edd567dd71a65958807c95a65db31d433e1d01]
 btusb_recv_acl_mtk+0x11c/0x1a0 [btusb 675430d1e87c4f24d0c1f80efe600757a0f32bec]
 btusb_rx_work+0x9e/0xe0 [btusb 675430d1e87c4f24d0c1f80efe600757a0f32bec]
 worker_thread+0xe44/0x2cc0
 kthread+0x2ff/0x3a0
 ret_from_fork+0x51/0x80
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Allocated by task 82:
 stack_trace_save+0xdc/0x190
 kasan_set_track+0x4e/0x80
 __kasan_slab_alloc+0x4e/0x60
 kmem_cache_alloc+0x19f/0x360
 skb_clone+0x132/0xf70
 btusb_recv_acl_mtk+0x104/0x1a0 [btusb]
 btusb_rx_work+0x9e/0xe0 [btusb]
 worker_thread+0xe44/0x2cc0
 kthread+0x2ff/0x3a0
 ret_from_fork+0x51/0x80
 ret_from_fork_asm+0x1b/0x30

Freed by task 1733:
 stack_trace_save+0xdc/0x190
 kasan_set_track+0x4e/0x80
 kasan_save_free_info+0x28/0xb0
 ____kasan_slab_free+0xfd/0x170
 kmem_cache_free+0x183/0x3f0
 hci_devcd_rx+0x91a/0x2060 [bluetooth]
 worker_thread+0xe44/0x2cc0
 kthread+0x2ff/0x3a0
 ret_from_fork+0x51/0x80
 ret_from_fork_asm+0x1b/0x30

The buggy address belongs to the object at ffff888033cfab40
 which belongs to the cache skbuff_head_cache of size 232
The buggy address is located 112 bytes inside of
 freed 232-byte region [ffff888033cfab40, ffff888033cfac28)

The buggy address belongs to the physical page:
page:00000000a174ba93 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x33cfa
head:00000000a174ba93 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x4000000000000840(slab|head|zone=1)
page_type: 0xffffffff()
raw: 4000000000000840 ffff888100848a00 0000000000000000 0000000000000001
raw: 0000000000000000 0000000080190019 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888033cfaa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
 ffff888033cfab00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888033cfab80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888033cfac00: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
 ffff888033cfac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Check if we need to call hci_devcd_complete before calling
hci_devcd_append. That requires that we check data->cd_info.cnt >=
MTK_COREDUMP_NUM instead of data->cd_info.cnt > MTK_COREDUMP_NUM, as we
increment data->cd_info.cnt only once the call to hci_devcd_append
succeeds.

Fixes: 0b7015132878 ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---

Resending as this has not been applied yet.

This has been tested by Chris Lu.

Also, the tests GitLint and CheckPatch are complaining about long lines,
but those are from dmesg logs, so they are kept as is with no added
wrapping.

Thanks.
Cascardo.

---
 drivers/bluetooth/btmtk.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index b7c348687a77..46f605249df7 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -395,6 +395,7 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btmtk_data *data = hci_get_priv(hdev);
 	int err;
+	bool complete = false;
 
 	if (!IS_ENABLED(CONFIG_DEV_COREDUMP)) {
 		kfree_skb(skb);
@@ -416,19 +417,22 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
 		fallthrough;
 	case HCI_DEVCOREDUMP_ACTIVE:
 	default:
+		/* Mediatek coredump data would be more than MTK_COREDUMP_NUM */
+		if (data->cd_info.cnt >= MTK_COREDUMP_NUM &&
+		    skb->len > MTK_COREDUMP_END_LEN)
+			if (!memcmp((char *)&skb->data[skb->len - MTK_COREDUMP_END_LEN],
+				    MTK_COREDUMP_END, MTK_COREDUMP_END_LEN - 1))
+				complete = true;
+
 		err = hci_devcd_append(hdev, skb);
 		if (err < 0)
 			break;
 		data->cd_info.cnt++;
 
-		/* Mediatek coredump data would be more than MTK_COREDUMP_NUM */
-		if (data->cd_info.cnt > MTK_COREDUMP_NUM &&
-		    skb->len > MTK_COREDUMP_END_LEN)
-			if (!memcmp((char *)&skb->data[skb->len - MTK_COREDUMP_END_LEN],
-				    MTK_COREDUMP_END, MTK_COREDUMP_END_LEN - 1)) {
-				bt_dev_info(hdev, "Mediatek coredump end");
-				hci_devcd_complete(hdev);
-			}
+		if (complete) {
+			bt_dev_info(hdev, "Mediatek coredump end");
+			hci_devcd_complete(hdev);
+		}
 
 		break;
 	}
-- 
2.34.1


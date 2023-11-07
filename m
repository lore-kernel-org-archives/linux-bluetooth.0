Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED52EAFE
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IreGocXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85664C43391;
	Tue,  7 Nov 2023 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699359168;
	bh=P74SAIEBupBfjmRHO6udvwsy+6ed2VyOutKXqj+kflk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IreGocXaLbfHA2ZXpr8eqc71/CicK1utkMSQoYU6TVnKOwcGZft8mwYYhHPFOXOz6
	 XqGXoB84faHt4J1y5E+x+NagTIVQY1/B68fkroDX2Z1ZtjihwBj+CftNjIH8+cVrkL
	 dEkn7bZ8es5HePXxOzycPlc8oL5AXEYHM2X1T8qdNVsBiv0Wm0xPMtOPiPn9KhICGp
	 iBASXFlMs7VH5Y4OvSdaDiEv/3c2nAPZRmbzS6Fq3B5LEtjCHVHbNw45NtVUlPeRQn
	 tkan00toeTL+dKlhD3s65m9xhXcOi6cWcyx+EgUrf3+hqr/fT6Z9gmejOriNjrKNCM
	 X48OLu3VsCeXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: youwan Wang <wangyouwan@126.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 09/11] Bluetooth: btusb: Add date->evt_skb is NULL check
Date: Tue,  7 Nov 2023 07:12:24 -0500
Message-ID: <20231107121230.3758617-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121230.3758617-1-sashal@kernel.org>
References: <20231107121230.3758617-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit

From: youwan Wang <wangyouwan@126.com>

[ Upstream commit 624820f7c8826dd010e8b1963303c145f99816e9 ]

fix crash because of null pointers

[ 6104.969662] BUG: kernel NULL pointer dereference, address: 00000000000000c8
[ 6104.969667] #PF: supervisor read access in kernel mode
[ 6104.969668] #PF: error_code(0x0000) - not-present page
[ 6104.969670] PGD 0 P4D 0
[ 6104.969673] Oops: 0000 [#1] SMP NOPTI
[ 6104.969684] RIP: 0010:btusb_mtk_hci_wmt_sync+0x144/0x220 [btusb]
[ 6104.969688] RSP: 0018:ffffb8d681533d48 EFLAGS: 00010246
[ 6104.969689] RAX: 0000000000000000 RBX: ffff8ad560bb2000 RCX: 0000000000000006
[ 6104.969691] RDX: 0000000000000000 RSI: ffffb8d681533d08 RDI: 0000000000000000
[ 6104.969692] RBP: ffffb8d681533d70 R08: 0000000000000001 R09: 0000000000000001
[ 6104.969694] R10: 0000000000000001 R11: 00000000fa83b2da R12: ffff8ad461d1d7c0
[ 6104.969695] R13: 0000000000000000 R14: ffff8ad459618c18 R15: ffffb8d681533d90
[ 6104.969697] FS:  00007f5a1cab9d40(0000) GS:ffff8ad578200000(0000) knlGS:00000
[ 6104.969699] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6104.969700] CR2: 00000000000000c8 CR3: 000000018620c001 CR4: 0000000000760ef0
[ 6104.969701] PKRU: 55555554
[ 6104.969702] Call Trace:
[ 6104.969708]  btusb_mtk_shutdown+0x44/0x80 [btusb]
[ 6104.969732]  hci_dev_do_close+0x470/0x5c0 [bluetooth]
[ 6104.969748]  hci_rfkill_set_block+0x56/0xa0 [bluetooth]
[ 6104.969753]  rfkill_set_block+0x92/0x160
[ 6104.969755]  rfkill_fop_write+0x136/0x1e0
[ 6104.969759]  __vfs_write+0x18/0x40
[ 6104.969761]  vfs_write+0xdf/0x1c0
[ 6104.969763]  ksys_write+0xb1/0xe0
[ 6104.969765]  __x64_sys_write+0x1a/0x20
[ 6104.969769]  do_syscall_64+0x51/0x180
[ 6104.969771]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 6104.969773] RIP: 0033:0x7f5a21f18fef
[ 6104.9] RSP: 002b:00007ffeefe39010 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[ 6104.969780] RAX: ffffffffffffffda RBX: 000055c10a7560a0 RCX: 00007f5a21f18fef
[ 6104.969781] RDX: 0000000000000008 RSI: 00007ffeefe39060 RDI: 0000000000000012
[ 6104.969782] RBP: 00007ffeefe39060 R08: 0000000000000000 R09: 0000000000000017
[ 6104.969784] R10: 00007ffeefe38d97 R11: 0000000000000293 R12: 0000000000000002
[ 6104.969785] R13: 00007ffeefe39220 R14: 00007ffeefe391a0 R15: 000055c10a72acf0

Signed-off-by: youwan Wang <wangyouwan@126.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f99d190770204..cc210fb790d89 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3095,6 +3095,9 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 		goto err_free_wc;
 	}
 
+	if (data->evt_skb == NULL)
+		goto err_free_wc;
+
 	/* Parse and handle the return WMT event */
 	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
 	if (wmt_evt->whdr.op != hdr->op) {
-- 
2.42.0


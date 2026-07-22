Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534A43C05D;
	Wed, 22 Jul 2026 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712430; cv=none; b=etdKZmzSAbbHxlB54w1D81HQA5dJ+tzKDFFPaidNXwGSQCq+xXE/3sTDFojtWZAQs+ixRBlJz6Gh0BB+63sWSDty2eul20zDD2DSZeJpewyX344XGMkgS/AYyteatThIzsEm/Wvu394gxScRSyLvmtx3UQRDeWSZ2ZVkMfAByy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712430; c=relaxed/simple;
	bh=r6hZqZvpvUYS5mbg1BmYw39K+sG4E42X8q4DwmgWchI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tpiYYbb37KHcp/Ffx68lGlzDj84bqkD2YzzOJJFQB5yGEfZIfd9i0pAz0GtsrXNDmifXe/LNasdtIhSU+fVmbBhUV6i2SK8e6UNweBvfo4bbyuhzVGiZWEZ8hEB+7cpNqx4FP+c2I0t0kIcrWpHQgnIS1/Up+E89UNckXEIgnaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fAJ8yTgF; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fAJ8yTgF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=DO
	K243lRucDzSnRshYJY6o7qpdBcg7TewytBKhtukTg=; b=fAJ8yTgFpogwzXg8Ud
	dH9c3q0HqFm2vy0p/vtC264zbWFN+ztD9oVkgqQrDS7g0xofkLIXQLqsyUNvYWkn
	xwQB0SwaYrCMM2xjzIYwv8hI9YbBBPeDLO+3kj3HAtdsF511jgBKm3t6pAAJxrZe
	peN9g4pIFXcERt83mAAEGPwAg=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3oPi_jGBq7jX1Kw--.58159S2;
	Wed, 22 Jul 2026 17:26:24 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiale Yao <yaojiale02@163.com>,
	Bastien Nocera <hadess@hadess.net>,
	SeungJu Cheon <suunj1331@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Tim Bird <tim.bird@sony.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame
Date: Wed, 22 Jul 2026 17:26:14 +0800
Message-Id: <20260722092616.1122797-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3oPi_jGBq7jX1Kw--.58159S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4xur1DGF13Gr4DGryDZFb_yoW8XrWUpF
	ZrKFn5AF4DXrs7Ar12yF4xZryrCr1kWFy7K398C3yFkr1rC34FvF17KrWjqrWxCrWDAFyY
	kF10qF4UCwn8XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AAGQGpgjMDJSAAA3x

rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr and dereferences
hdr->addr and hdr->ctrl without validating skb->len first. A truncated
frame with skb->len less than the minimum header size causes an
out-of-bounds read of uninitialized memory. Additionally, a zero-length
frame causes skb->len-- to underflow to UINT_MAX, making
skb_tail_pointer() read far past the buffer.

Commit 23882b828c3c ("Bluetooth: RFCOMM: validate skb length in MCC
handlers") fixed the same class of missing-length-check bugs in the MCC
sub-handlers, but the top-level rfcomm_recv_frame() was left unfixed.
KMSAN reports:

  BUG: KMSAN: uninit-value in rfcomm_run
  ...
  Uninit was created at:
    __alloc_skb+0x474/0xb60
    vhci_write+0xe9/0x870

Fix this by rejecting frames smaller than sizeof(struct rfcomm_hdr) + 1
(the minimum frame must have a 3-byte header and a 1-byte FCS).

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 net/bluetooth/rfcomm/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ebeae17b71d1..37c23ef47baf 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1778,6 +1778,11 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
+	if (skb->len < sizeof(*hdr) + 1) {
+		kfree_skb(skb);
+		return s;
+	}
+
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
-- 
2.34.1


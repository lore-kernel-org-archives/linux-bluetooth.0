Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B3F1428F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746185; cv=none; b=IcyUolPdUFx/PyHuh+y2i6iYuBYX+w8DnT3riXmsEAGQQaioF6q7Rh5aINoVM+PqN+H63biia7kFI/FsgpIoXOweuO8OnNbjEys9g4KsFiIO7sNFDOKUycbMstE2nBNGoJU94jOo+tIs70c9bqCUK4DC21gkd9zZMTcnTQWSPUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746185; c=relaxed/simple;
	bh=R2f+ZWFeGkE7OCVq5vgG+66cveITxAf5+IIsW0L7OPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=steWuOadOwoMIkDn25dgejASMyPH/YYcwFZQNFJgoO1MwrzW8npuafmUXDpQ2d3P+dggHrTfqLiIACYFEFg85mqgg2xs3tnsM1TLtWhQeNatgOzIfqo2lt4tlP4X3GxUMp9SzgsA4+59YCLQF9wu3qvFdbCi9Bo1qQV/w7wL+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=WwyxbdlK; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="WwyxbdlK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PSd0U
	iTa8GxL439RyFT55es/lYaTAdadZ/QwVOOkSbw=; b=WwyxbdlKhRzHUHgHt5+Ez
	yQon9wV0x4agUC+JXQ/to7dpSPpOhTrhiMsG4Kd4VfRyQkFIyxR9Ad/Pb0qJoVCD
	CLclUjOaPCSkznpnDHmjJ96axWpDREZgy/K5qG6HxRYnljbUlWF5GWc+B1eFXa7q
	5Bivz1v1QDoPgi4U/S5LKQ=
Received: from localhost.localdomain (unknown [58.22.7.114])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wD3n2W5ic1msxN4BQ--.16578S2;
	Tue, 27 Aug 2024 16:09:30 +0800 (CST)
From: Felix Qin <xiaokeqinhealth@126.com>
To: linux-bluetooth@vger.kernel.org
Cc: Felix Qin <xiaoyao@rock-chips.com>
Subject: [PATCH BlueZ 1/1] att: Correctly handle negative return values in can_write_data
Date: Tue, 27 Aug 2024 16:09:25 +0800
Message-Id: <20240827080925.55684-1-xiaokeqinhealth@126.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n2W5ic1msxN4BQ--.16578S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrnYwUUUUU
X-CM-SenderInfo: 50ld0yhhtl0xhhdo3xa6rslhhfrp/1tbimgpI1WbNhjxGdQAAsv

From: Felix Qin <xiaoyao@rock-chips.com>

---
 src/shared/att.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index a45e9c268..4a406f4b9 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -551,7 +551,7 @@ static bool can_write_data(struct io *io, void *user_data)
 	if (!op)
 		return false;
 
-	if (!bt_att_chan_write(chan, op->opcode, op->pdu, op->len)) {
+	if (bt_att_chan_write(chan, op->opcode, op->pdu, op->len) < 0) {
 		if (op->callback)
 			op->callback(BT_ATT_OP_ERROR_RSP, NULL, 0,
 							op->user_data);
-- 
2.34.1


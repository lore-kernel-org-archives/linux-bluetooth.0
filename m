Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D64835200F;
	Mon, 19 Oct 2026 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401177; cv=none; b=NxcUMUBZak623D7L9i3nJl6JJPnwcYUXp2fs3BOAfNQJ3OEUHC8aRoZQV2kq9cTScVkToGnom4pqrPABhK5/H+Z5sGi+8MZO53rlLoed9uwCntj23YM+VtBnhcHauG1LvfzWEhZMgAb+Zb8k1MpKOdqND1sWR65qLNerENm7YTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401177; c=relaxed/simple;
	bh=uL2/yGEIJSp+Pcj0y8exu25lAl4mGrxzhwzvqxe8CmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=di3w/S/JZ9ik6Mb28vGIS9DFyoOOpBxoYVFWi4XMEqOFo+WiJZE64kioq03Cb6HwFuL6WRRAWa9pYMFU4+VDrsC4M20naHbc1V+5xLFRIZQhY3+wbYbVeN60/pzWWOGadMAspoXiAsBY2db26SeMa699w09KYlz08c6dGf6KSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DwG/EqPv; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DwG/EqPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hz
	oy/JuyOeqUSt5dp280ZfevZdMIILMp2cAQA5QZXSk=; b=DwG/EqPvBd54lekfUK
	getHV02quQfJ7HKaRYlTpIiBSRx0zjTkvgLDzKOJSVh8XAdONrqo78649CieBI6E
	1CMGkV3qr2uZvhL3Dzvd54vR4QQiAw+9XMunMW4pb24WBSAwR5Ak/q11nA+nkEBX
	DbfM7CjjcmCeZpKLGIN73vGDc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3NysM39VqKsG2BA--.42110S2;
	Mon, 19 Oct 2026 17:12:45 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] Bluetooth: MGMT: Free cancelled adv monitor command
Date: Mon, 19 Oct 2026 17:12:43 +0800
Message-Id: <20261019091243.1847048-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3NysM39VqKsG2BA--.42110S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrW7Kr43Kw4xGw4UXFW7CFg_yoWDKFgEgw
	s8u34fAr4UGr4jyF1UuFWrWrnxKwn8GF1I9a9avFW7X3y5Gws0yrWkur13Aa4fu3WDCFn3
	Ars8CayS9w4xtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtiSdUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzg0LRWrV3w3rXQAA3W

MGMT_OP_REMOVE_ADV_MONITOR uses mgmt_pending_new(), so its command is
not on hdev->mgmt_pending. When the command sync callback is cancelled,
mgmt_remove_adv_monitor_complete() returns without freeing the command.
This leaks the command, its parameter buffer, and its socket reference.

Free the command before returning from the cancelled completion path.

Fixes: e6ed54e86aae ("Bluetooth: MGMT: Fix UAF on mgmt_remove_adv_monitor_complete")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 net/bluetooth/mgmt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 251a896babd5..e54a838aeada 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5682,8 +5682,10 @@ static void mgmt_remove_adv_monitor_complete(struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_remove_adv_monitor *cp;
 
-	if (status == -ECANCELED)
+	if (status == -ECANCELED) {
+		mgmt_pending_free(cmd);
 		return;
+	}
 
 	hci_dev_lock(hdev);
 
-- 
2.34.1


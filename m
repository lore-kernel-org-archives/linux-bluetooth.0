Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C2439E17E;
	Sat, 17 Oct 2026 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206600; cv=none; b=gvhSKuHhTYnn+cNSOIQ1nt9rK36mLpqwjlQBiWa24XOSAtX3Z9ulgYo5lGgmUOF8Vep00luGMILM6ON3kCSx4QPAIgoi7gsOwol2antJn9gz8KEHkuYwn4jqtRrTwMS6IQDZXpKtm6xVtbTyE+VzL6aL1rEVjpziN45aFIz26k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206600; c=relaxed/simple;
	bh=RBmzk5eFImnz8QVhMBDJeVuGaDuuw8vbjC/yDh8EkC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ew83xJZJrnFTvx5ajGhzcdafr6u3qde68crn3KbliTs/VbE5aX60fXPlNBXiopWpJwWRw9fnPG8Ld1gv5iSqkrgqR52K8sXODJT4SmcmiIOIr/DOcHrJT2gCUSy1vAIM5Tyl4xMm2J7YIZcNLKGGQSQdSzTjjofVr6rV5xptrSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PT4rJ6XT; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PT4rJ6XT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TZ
	bQAYl73iXM1j+HknjAr1iw8iVQ1FkoYM8KWiyJ9Q0=; b=PT4rJ6XTU/A12BXk2T
	EuoISpAFv/QAin4HnG0EiOTaRlGilyE8iWMaxebs643RcSRp82cvR7hXpeNiJP2I
	EzgaT11tenRImTf8Ut7Mg4lV+t85fpw+qL6Wy0t1mKtNr/eaCGUWTFc3nrDc21xY
	4S7RSVEcGsz9D9ZJofFPNnG5Q=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3v7z25tJqac7FAg--.27446S2;
	Sat, 17 Oct 2026 11:09:43 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 1/2] Bluetooth: MGMT: free remove monitor command on cancel
Date: Sat, 17 Oct 2026 11:09:39 +0800
Message-Id: <20261017030939.3615701-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v7z25tJqac7FAg--.27446S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4UXF1ruryrJF4kZw4kXrb_yoWDGFbE9w
	1vv3yxXr4UJr1jyF1UuF4ruwn3K3Z8GF1xWanIvFW7J3s8Cws8Xr4kur13Z34fua1DCFn3
	Ar1DCFyFyw4xtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtcTm7UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhdGgGrS5ve4JwAA3p

remove_adv_monitor() allocates its queued command with
mgmt_pending_new(), so the command is not linked into
hdev->mgmt_pending. If the command-sync entry is cancelled, its
completion callback returns without freeing the command, leaking both
the allocation and its socket reference.

Free the pending command before returning from the cancellation path.

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


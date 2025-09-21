Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E9274FE0
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482100; cv=pass; b=ih5QHJ43WPYwQYkhpWGBovb6Td+4bhGWBLzRaf17uOXaEUB9ZkzJqml7XaajNYTd0UPt3k0z+7brj/TOxvKvY6hYLjTI1yQd4FtnSWaCFCwzkvrDQlSPMl3xWjrmekcGyg/9/JqIt7r2ziKo8wGtSKrthZe2k0OMQiYFsO0covc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482100; c=relaxed/simple;
	bh=Z3IJ6vkFshRZcdaEoAdwHWNck/VAL4bYHkEmudELHq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LixAsSIRYKOnN+TuoLEaL+TlLHqM3CLca8ykM1uWqyd6x1GP9UXpUZ9iDRpovtd7faaKZvRHt4MfziubptmxyyhVe3mIYH/smK+vWf91K3BKc5F80bO8d3UQy4/cfRfLULrmFlHqqvllTz7sA9axMQB/Le4YpKLovC0h3Kpgyjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=DFFYmVNm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="DFFYmVNm"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCF4S4Xz10HB;
	Sun, 21 Sep 2025 22:14:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXV4uUSMBhjpnq9DRzXGRc8JBL2iHGfrUsXYl8PD5Ms=;
	b=DFFYmVNmE8QLj6CdvW/YozfFAc5fM++lYqh7h5j8TPHESCrlSZbRWjDlPCV8hAi1wdd671
	YN9wLXKorectjWgP+MV1tKP6ywiIW55R7ItjSVL95QXRMzfyb3JT7k5sTyniWunrjAVb5o
	u6iX2UF9vfqZwAUG2nN8M0isCtrLvfs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXV4uUSMBhjpnq9DRzXGRc8JBL2iHGfrUsXYl8PD5Ms=;
	b=Rc2lygAazfpS7Ok+v68Tvf8HQqc/IblFKhv/KbMCVGa/j/3xsu+xTlQu1a07GDp9YlTa2h
	WHX06m10DI0ISJf9pRUF6lhuog+Z06raSEiFPA1amJrnQEqPopWdhhapHtIZyvvGb+LzmM
	XXGKtX4Ly2T5MtuedGu+u6PVASEDdsQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482089; a=rsa-sha256; cv=none;
	b=EnRpSQit33SvawxknFYZZbVpWl6NzWlGH7tL9RdlkEGqZadqTHkBjrF6XUi1hcTBuLONHB
	1aZa5j8hI37mkQn552hSfI+E5X43RiCCX5nbRg2EhTndH3pqKX58MyRwGrvpbC/YP0bi39
	NL2ZTvdSAnXIs+ob0Crjse/cgpCN1c0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 13/24] Bluetooth: hci_sync: fix hdev locking in hci_le_create_conn_sync
Date: Sun, 21 Sep 2025 22:14:28 +0300
Message-ID: <938d67ed412de1ad4d55a7dfaff869009b223f8f.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix call to hci_conn_del() to hold hdev->lock and check the conn was not
concurrently deleted.

Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    hci_le_create_conn_sync() probably would need to do more locking/checks
    etc.  to guard against the conn being deleted or modified while it is
    running. That likely is not UAF, but only misbehavior.
    
    Only the wrong delete locking bug is fixed in this patch.

 net/bluetooth/hci_sync.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 408fe5e08c30..8fe2f5b73040 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6584,7 +6584,10 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 		    hdev->le_scan_type == LE_SCAN_ACTIVE &&
 		    !hci_dev_test_flag(hdev, HCI_LE_SIMULTANEOUS_ROLES)) {
-			hci_conn_del(conn);
+			hci_dev_lock(hdev);
+			if (hci_conn_valid(hdev, conn))
+				hci_conn_del(conn);
+			hci_dev_unlock(hdev);
 			return -EBUSY;
 		}
 
-- 
2.51.0


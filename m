Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E4C239E79
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 May 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748705128; cv=pass; b=lHSGP0aL2i176uutFeH73VAOYFevFPgkRfxbMoI7KDVQNMNEsI9HohoLOnj/5L+9tF0O1VBYgchrexOGCjw3RsPHHT5Fu4mNJ5QFRaP7BdDgf4SqhOHu7uqm0k1uPHMISS3BiabT7x0UVxzNKRlK0nMPCFqlitu0885mRRHWZQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748705128; c=relaxed/simple;
	bh=Ohu28niYx+wAdnqxRBI18sjRku1SvWvvaB7fLxW4kMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aH0NQxejjbRFRNue4BwtfTz9cR4nB5EUPfF6ZXNvHZb1nm50SWNAw7XL8RamXF6IZBHvkT2fpRcoQHCV2Ewr8bppWXOCX2s+CD6hDQk7C3dweZRPz36pgtd4/qrVLR6EPTkqTQrFagx65YUFIF6sBkco2SX1zOHa56/VZt3BarM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=jMBem92V; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=xMvb5BHi; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="jMBem92V";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="xMvb5BHi"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4b8kSS4R1Gz49Q8b
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 May 2025 18:25:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1748705112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z4/eIfOoAApJB+M2CTh9B7BsP1KbCNroKII7b2jF6co=;
	b=jMBem92ViU82aQHY55tHIHr33AHYjnKNs8gIq4AdW9kbXTwhEFLTAGsG5rsC+7Iuw94YFL
	cwE7y8KZUkQwdqJWz/mQ9vB/hnc9V9wp1BKc1OUdJDRJ0bKq8UC6QV+BmTX96xdpacIU/v
	NOIcNd43IS+mGeLxoBNHYDEcTzMCd0TBty/y+YkwzILofM91t0GTBUI1VJebYGvt3IsX6J
	PQsw6PZfKfkU51Yueh4F4oo1E1N4dbqCOBRI8RV65aF7TuHXCPfbeBygIN3EhgAZspk+wu
	nr1Ci0kM/g/4zzklheBpGU6xjmai18MoCcd3rW9jWhYN7PEVbCqlMoEMvpS+vQ==
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4b8kSJ0Nd2zyVb;
	Sat, 31 May 2025 18:25:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1748705104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z4/eIfOoAApJB+M2CTh9B7BsP1KbCNroKII7b2jF6co=;
	b=xMvb5BHi737K48dyUV/8rRNLxgLTnridq2EYXiMEw+E307DJNNRGLo/X+FamM4R+qJD/8F
	buGrYmazTzCw+LeZX8UQP2ad7VCbwJNduFJEVO8mIDCO5Zj/MO2GWv6rrqLDwSB4RsAPRh
	m5uXp2kR504A1cZgXE8kBf1QM/5VM2o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1748705104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z4/eIfOoAApJB+M2CTh9B7BsP1KbCNroKII7b2jF6co=;
	b=VvE3GhQ0VIn4r1D4jgl0Q/of940lfk36WfMWUFTqqUQU+10uCvTK2/jcxjPekIKYmGyoWp
	84Dkz5k/RjBwlDI/GotoEvpsv2GKraewMeiUdJc94zax9uWYG+j2meWOoXFFl2tOsXto9J
	uwg0PLMrmzjtFR2unRnXOyfegwrFyB8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1748705104; a=rsa-sha256; cv=none;
	b=o1wjqoErzDD+KfRScu6pOXtA5k/PsbamG3ioOMUENti2QcKgK4/ruvaSjgm/3ftXFlWL7G
	eyBxGtPp3gYJtj7mIJLF1GSas7SVT4Y1y/YMXdBthwzRJcmdumzSD8AgFcDFERXYv+Xu6d
	7RXQc7MFWvbec59QJCH2QJaNe3L9NNU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: hci_core: fix list_for_each_entry_rcu usage
Date: Sat, 31 May 2025 18:24:58 +0300
Message-ID: <4bfedc6d6edfdbdc7f2bde88da75a8329e78abb4.1748704997.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Releasing + re-acquiring RCU lock inside list_for_each_entry_rcu() loop
body is not correct.

Fix by taking the update-side hdev->lock instead.

Fixes: c7eaf80bfb0c ("Bluetooth: Fix hci_link_tx_to RCU lock usage")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3b49828160b7..04845ff3ad57 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3417,23 +3417,18 @@ static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 
 	bt_dev_err(hdev, "link tx timeout");
 
-	rcu_read_lock();
+	hci_dev_lock(hdev);
 
 	/* Kill stalled connections */
-	list_for_each_entry_rcu(c, &h->list, list) {
+	list_for_each_entry(c, &h->list, list) {
 		if (c->type == type && c->sent) {
 			bt_dev_err(hdev, "killing stalled connection %pMR",
 				   &c->dst);
-			/* hci_disconnect might sleep, so, we have to release
-			 * the RCU read lock before calling it.
-			 */
-			rcu_read_unlock();
 			hci_disconnect(c, HCI_ERROR_REMOTE_USER_TERM);
-			rcu_read_lock();
 		}
 	}
 
-	rcu_read_unlock();
+	hci_dev_unlock(hdev);
 }
 
 static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
-- 
2.49.0


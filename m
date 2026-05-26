Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DDB1FE44A;
	Tue, 26 May 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803479; cv=none; b=MwGfNt3Pyx404rYGn6mAl0mMMp3erp9WhKal9j1Mw+tJs2ip4/ZqAWVB3GnHLo5RvYAvmlO59Q/fCSdehgIdyp8YFTU1oEuyWSsGgsR7UwyoCifbZjl5iU7c8Y9vh0fdlHkITvDSxoY5lTRnuCNsGvoh974zYPoOGjoYe9U/Z5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803479; c=relaxed/simple;
	bh=7xU5AHbuTJWg/v3VXXXgEAuoOGUJYGEqz87SG+GdURk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fG27o38NIRjJ9yf9hlbE5Ey2gXmleT5PGDTxOQNMWA6vjry0PGuJCYF2k3XerBvfmOYlyhPYGyK4dnGl5//4ggid5d49b8Ub1rWG6hU5HdpJ2qUlMLz7uBIDl5fdZ97zoMamWoFBqqLydKFHTvhqJBvlrS6U6UzRpJKMts9aaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=S+6wPiRY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="S+6wPiRY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H9O+UnZSoUGr8poiTa1psKAAL62vlHP66fwIYRcsJ6g=; b=S+6wPiRYg1phu6+4R5xGk3BEym
	N4qiuMiGmz4kGfgjROyRvuvDnbcZpqLnqwhmLWcuy06UkMJ8C0xNSrVz81OfzalXOyxJtd909opOT
	yp4DEpapw/ksPmKB7N4p+T5CHzaWNWgihfFGxAG03JJTZDcqBMc8CnCf9MBDYxPqjIFhPnEVhtmsm
	TuozWNbQyizPTUKIfZR52d4noBd7zgN2HjdUWKRk+45HIRqf/Mve9j3rPeUYruRDS6HJxtDiAT2ER
	BiZ1t2e9eoES16nq+lyVZYREgkEQKQu4+xlah2neQrrztnRPR228lSCx71Ix0xPI9yIs3+bEVbYG6
	ZZ4Jg6sg==;
Received: from 177-136-90-227.vmaxnet.com.br ([177.136.90.227] helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wRsBe-008SdX-NS; Tue, 26 May 2026 15:51:14 +0200
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Tue, 26 May 2026 10:50:57 -0300
Subject: [PATCH v2 1/3] Bluetooth: hci_core: Rework hci_dev_do_reset() to
 use hci_sync functions
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-hci_send-v2-1-596977a9a814@igalia.com>
References: <20260526-hci_send-v2-0-596977a9a814@igalia.com>
In-Reply-To: <20260526-hci_send-v2-0-596977a9a814@igalia.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Gustavo Padovan <padovan@profusion.mobi>, Schspa Shi <schspa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, Heitor Alves de Siqueira <halves@igalia.com>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
X-Mailer: b4 0.15.2

The current HCI reset function in hci_core.c duplicates most of the work
done by hci_dev_close_sync(), and doesn't handle LE, advertising or
discovery.

Instead of porting these to hci_dev_do_reset(), directly call the
close/open functions from hci_sync to reset the hdev. MGMT now notifies
when a user performs a reset.

Suggested-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 net/bluetooth/hci_core.c | 43 +++----------------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c46c1236ebfa..28d7929dc593 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -539,46 +539,9 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 
 	hci_req_sync_lock(hdev);
 
-	/* Drop queues */
-	skb_queue_purge(&hdev->rx_q);
-	skb_queue_purge(&hdev->cmd_q);
-
-	/* Cancel these to avoid queueing non-chained pending work */
-	hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
-	/* Wait for
-	 *
-	 *    if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
-	 *        queue_delayed_work(&hdev->{cmd,ncmd}_timer)
-	 *
-	 * inside RCU section to see the flag or complete scheduling.
-	 */
-	synchronize_rcu();
-	/* Explicitly cancel works in case scheduled after setting the flag. */
-	cancel_delayed_work(&hdev->cmd_timer);
-	cancel_delayed_work(&hdev->ncmd_timer);
-
-	/* Avoid potential lockdep warnings from the *_flush() calls by
-	 * ensuring the workqueue is empty up front.
-	 */
-	drain_workqueue(hdev->workqueue);
-
-	hci_dev_lock(hdev);
-	hci_inquiry_cache_flush(hdev);
-	hci_conn_hash_flush(hdev);
-	hci_dev_unlock(hdev);
-
-	if (hdev->flush)
-		hdev->flush(hdev);
-
-	hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
-
-	atomic_set(&hdev->cmd_cnt, 1);
-	hdev->acl_cnt = 0;
-	hdev->sco_cnt = 0;
-	hdev->le_cnt = 0;
-	hdev->iso_cnt = 0;
-
-	ret = hci_reset_sync(hdev);
+	ret = hci_dev_close_sync(hdev);
+	if (!ret)
+		ret = hci_dev_open_sync(hdev);
 
 	hci_req_sync_unlock(hdev);
 	return ret;

-- 
2.54.0


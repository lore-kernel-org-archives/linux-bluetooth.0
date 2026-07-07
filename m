Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4643EB0EE
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427824; cv=none; b=U6yACsAleUtCgLXNudIXNAtxsJDNqWMGFXS54GQeAZdsSH2TljwdSykuISjukGFm7E3YkxAQ6//E3wl3bb8vLeKGg2KdkHh6dRemW8jS/q6YoqcHja2Iq5gyiW7NGipz0ZQfCIlX9DI1ZILbNiulDiJWpD787/aHyUxi4BAmsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427824; c=relaxed/simple;
	bh=P6ouAMfGsBZmjfYsM9LaiZ2Jve74LqS2vqxHUIOdeYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2XLelo/4JteW4YXqavt0jWUZXRfKPEqOKSNITPkoGM9RZHy5qMIH2+4J5wmH2EFYir0gVL5vZjsJWC06vkPH/jIosBqzWKVuQEkicGKtZDn4GjK0ubJEg5x5IcYAN/bT7rdDXUKmXJJTNf2lyNge9FaeBG+B4h3pVhm6YLMhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mm/kk9SV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=E5pPty9t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mm/kk9SV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E5pPty9t"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9A61759C4;
	Tue,  7 Jul 2026 12:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783427820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G/DgjDgyff49V4ZufarXGwJ5kq+7wNz9Qpge4QCSEBk=;
	b=mm/kk9SVR7niSh8bhbUVKSA1Gfxdod5cDK3hXUia6Z8CpSdLTNW4lUUHU6L2L57t2L5rym
	o5XBXKti3/GvD+GVMqK276+pGfr2hK4iv0PsmWPjj2SiIBKfwIlnlfZcbSY4J68fu1ZOqe
	mWgX3hHAPsasH4JHnav/XRuusRRPEAA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783427819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G/DgjDgyff49V4ZufarXGwJ5kq+7wNz9Qpge4QCSEBk=;
	b=E5pPty9tHuhN3PPfHNiyTZF2V0zrS7lRPJMNswmRHEXVcQbG3ttltPu2u3CODjo15t0hUU
	m/Ky2N6Jgd+I1ybA8KIagCWexncG6VS2ydTmGE4TDEwubFZL31PBSIig80OpyIHpxrOeR0
	yzu54JsGbzNteybzPeXxH2STOFG4Vmg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C97B4779AE;
	Tue,  7 Jul 2026 12:36:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A/cSMOvyTGrceQAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 07 Jul 2026 12:36:59 +0000
From: Oliver Neukum <oneukum@suse.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] Bluetooth: L2CAP: avoid deadlock with process_pending_rx
Date: Tue,  7 Jul 2026 14:36:56 +0200
Message-ID: <20260707123656.76552-1-oneukum@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -1.30

The fix for the deadlock caused by cancelling works taking a lock
while holding the same lock in l2cap_conn_del()
shifted the cancellation of info_timer and id_addr_timer to a time
before taking the lock. However, it left cancelling
pending_rx_work() inside the scope of the lock. process_pending_rx(),
however, also takes the lock. It can deadlock.
Shift the cancellation to before the lock, too.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: ab4eedb790cae ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
---
 net/bluetooth/l2cap_core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 62133eef9d2f..4b144eefdd33 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1772,8 +1772,14 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	/*
+	 * these take conn->lock
+	 * Hence a synchronous cancellation
+	 * would deadlock if done with the lock held
+	 */
 	disable_delayed_work_sync(&conn->info_timer);
 	disable_delayed_work_sync(&conn->id_addr_timer);
+	disable_work_sync(&conn->pending_rx_work);
 
 	mutex_lock(&conn->lock);
 
@@ -1781,13 +1787,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	skb_queue_purge(&conn->pending_rx);
 
-	/* We can not call flush_work(&conn->pending_rx_work) here since we
-	 * might block if we are running on a worker from the same workqueue
-	 * pending_rx_work is waiting on.
-	 */
-	if (work_pending(&conn->pending_rx_work))
-		cancel_work_sync(&conn->pending_rx_work);
-
 	ida_destroy(&conn->tx_ida);
 
 	l2cap_unregister_all_users(conn);
-- 
2.54.0


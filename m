Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD210A23;
	Thu, 16 May 2024 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715835086; cv=none; b=MJjvhvnAezvpwKfUul9vv1tTnV6cZFVqMIgaiv7ot0DPw4jvbYnBh0swaBIPNoHDmtjYIZ4BcCDLL6NsH41h50VvdtylDSSPSi0SaDFFeGnMxApl5PJthCJg33l2Vjk9QKhZDiP/p5tol+oPNSCorLMSpvalYn+Coe8kT57GXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715835086; c=relaxed/simple;
	bh=QOYbLekM5Zrc4zhKXVC4BYi0CMmtznr3IyXJv1O/Imk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRarcgP3BFA5qB3A4t1+esnSNG4D53iFCW/kVnpBq5KE4jifC/jCEhVJwjdo41Kb92WfCBUUkUDDEP9scC8WaNew/ZTTzXAoY6CImAjWYPTEdr8qZlQ00ChWLh0hKz/zBrSkNC18dVlFp9GR9MMplrFU2Z5UihW0a8yYb94r4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HCg+PwTw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HCg+PwTw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HCg+PwTw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HCg+PwTw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 562E83442D;
	Thu, 16 May 2024 04:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715835082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RTMlqtQa49a+mfw38qG65gipfBimeGz2d1N6Q2vYIC0=;
	b=HCg+PwTwvn2eFl2vgvtO8l9IcsFCAyOJ8YkQdvcmhdpeAY1fq0ccZpDP+w7u6UyU7b/efc
	QM4hxxBsCJ9cyFK469kpWVeuibXQ5fMd/lnaIuG/9sxLIrpmnyzRX6LG5LQTp0dqNomyR9
	BOSFtmXcRfMYBFBtdLBEgwUuBuw266Y=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HCg+PwTw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715835082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RTMlqtQa49a+mfw38qG65gipfBimeGz2d1N6Q2vYIC0=;
	b=HCg+PwTwvn2eFl2vgvtO8l9IcsFCAyOJ8YkQdvcmhdpeAY1fq0ccZpDP+w7u6UyU7b/efc
	QM4hxxBsCJ9cyFK469kpWVeuibXQ5fMd/lnaIuG/9sxLIrpmnyzRX6LG5LQTp0dqNomyR9
	BOSFtmXcRfMYBFBtdLBEgwUuBuw266Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A8FC137C3;
	Thu, 16 May 2024 04:51:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5IeKAMqQRWakQwAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 16 May 2024 04:51:22 +0000
From: Oliver Neukum <oneukum@suse.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH] bluetooth: btintel_pcie: nonsense error recording in irq
Date: Thu, 16 May 2024 06:50:47 +0200
Message-ID: <20240516045118.18552-1-oneukum@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Result: default: False [1.48 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.01)[46.55%];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: 1.48
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 562E83442D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

Either you return an error or you ignore it.
Recording it but then overwriting it makes no sense.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/bluetooth/btintel_pcie.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 590c188a4bb3..c507422d6b1b 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -498,19 +498,15 @@ static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status
 	rfh_hdr = buf;
 
 	len = rfh_hdr->packet_len;
-	if (len <= 0) {
-		ret = -EINVAL;
+	if (len <= 0)
 		goto resubmit;
-	}
 
 	/* Remove RFH header */
 	buf += sizeof(*rfh_hdr);
 
 	skb = alloc_skb(len, GFP_ATOMIC);
-	if (!skb) {
-		ret = -ENOMEM;
+	if (!skb)
 		goto resubmit;
-	}
 
 	skb_put_data(skb, buf, len);
 	skb_queue_tail(&data->rx_skb_q, skb);
-- 
2.45.0


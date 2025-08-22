Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C34502F
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755823257; cv=none; b=kY7ouQCwTD0r7/BEa9F0oE4cdswd71vJQlMrXAcXnciuYSbAo5tWat9qfremvv1oqd5VFMp8YjWlwWiPEUqQkLLcs2CPSMQb4CeS9kkdPJ1KNn2CwYFD7WZSPbxaOiclHFrxA6aFdcJz4JH7ayt1mbCOzUM9LNxPfmRLm4qMUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755823257; c=relaxed/simple;
	bh=lnMZ0Fg1/5oZCOc3UI2+lY12/jAJB/8QMggC+0CJc3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DIk8vV5Y4msnDxyHa4BexpFaq5U2K9gT5A/rjTtzn1elemJpknvykTWfKMCIx4xXEK0H0HaSt75KMMy11Z5HpLNQn3cBq+oHkS+sSj6oflwv5A+FmQmaF+j3A0JFwAmO7xQAivovZxM9vLqDbsBarehk9MRiFVrqIqGvmhXXdoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=hH4XfRVx; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="hH4XfRVx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mgp2oXtmlIEgm3VhFQhAud1V7DVV3rLBaZVTH1PpXek=; t=1755823255; x=1756687255; 
	b=hH4XfRVxt+FY9Mx18DNa5JyXMkQdiOUG+r9tp9PHWhKvDKNUbagoYoW514nSvz00iNBUJeykLOu
	ooc64GobfUrVGmFzZtu6hyGfD0/muLIUHb8k6UqfJRtf7s+nB7rDhdHCnjTJ7b3EZGPpiTlYGMlI+
	XQYxUyqeeztAI+CLsSjhPYWZm0403yNKCeFdRqqll5zJ6p4b7AvDydxcfsIHGKC6RaU7VFkfqrasC
	ho/wb9BfFPJZShzXFI7D0OoxRVZHdCbchc40tC7UuaedrBEX0oqR6D/RSmn1Nky6T+i0o26nlG+5/
	A16FjEOJzFuD8GG5oRea2awZIxMrwNw2v3wg==;
Received: from 135-180-5-199.fiber.dynamic.sonic.net ([135.180.5.199]:57628 helo=macbookair.lan)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <jgnieto@cs.stanford.edu>)
	id 1upFpo-0003vb-T9; Thu, 21 Aug 2025 17:40:49 -0700
From: Javier Nieto <jgnieto@cs.stanford.edu>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javier Nieto <jgnieto@cs.stanford.edu>
Subject: [PATCH] Bluetooth: hci_h5: avoid sending two SYNC messages
Date: Thu, 21 Aug 2025 17:39:13 -0700
Message-Id: <20250822003912.41754-1-jgnieto@cs.stanford.edu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Scan-Signature: 3e263c829a24e9e508d860775f9d44fb

Previously, h5_open() called h5_link_control() to send a SYNC message.
But h5_link_control() only enqueues the packet and requires the caller
to call hci_uart_tx_wakeup(). Thus, after H5_SYNC_TIMEOUT ran out
(100ms), h5_timed_event() would be called and, realizing that the state
was still H5_UNINITIALIZED, it would re-enqueue the SYNC and call
hci_uart_tx_wakeup(). Consequently, two SYNC packets would be sent and
initialization would unnecessarily wait for 100ms.

The naive solution of calling hci_uart_tx_wakeup() in h5_open() does not
work because it will only schedule tx work if the HCI_PROTO_READY bit is
set and hci_serdev only sets it after h5_open() returns. This patch
removes the extraneous SYNC being enqueued and makes h5_timed_event()
wake up on the next jiffy.

Signed-off-by: Javier Nieto <jgnieto@cs.stanford.edu>
---
 drivers/bluetooth/hci_h5.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index d0d4420c1a0f..863ee93dd8a8 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -213,7 +213,6 @@ static void h5_peer_reset(struct hci_uart *hu)
 static int h5_open(struct hci_uart *hu)
 {
 	struct h5 *h5;
-	const unsigned char sync[] = { 0x01, 0x7e };
 
 	BT_DBG("hu %p", hu);
 
@@ -243,9 +242,11 @@ static int h5_open(struct hci_uart *hu)
 
 	set_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags);
 
-	/* Send initial sync request */
-	h5_link_control(hu, sync, sizeof(sync));
-	mod_timer(&h5->timer, jiffies + H5_SYNC_TIMEOUT);
+	/*
+	 * Wait one jiffy because the UART layer won't set HCI_UART_PROTO_READY,
+	 * which allows us to send link packets, until this function returns.
+	 */
+	mod_timer(&h5->timer, jiffies + 1);
 
 	return 0;
 }
-- 
2.43.0


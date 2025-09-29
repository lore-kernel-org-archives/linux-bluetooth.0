Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5C2AD0D
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Sep 2025 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185919; cv=none; b=m/TWV8gTaL9UmDn/2rihlQby4+nkeVkgTZMb5ARTb+wybp5nL9zmbQQ9jqY4S42oB5F2wYZaw8drqWfbMCLbt09p2UTZMgcskSkR4rfKCRt+MHOC+TPzGFhLtOBBbm+HIPwei+sgHc78sLpNK49a+3iD+sY9LG4L4ap7WFD2meY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185919; c=relaxed/simple;
	bh=Fe2D9k9kOzyfGP6+8pl0Hj1SebK8XPAD/ltG5zuMC1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TS/S918qmIguaSyn8ilwxXEN+sfSA1SCiasdQZqKU9EtUu4WYsf99SU/uN9IoiA5k4EYrwAD4diGHN01PJWlPbfxy8bEnq6WsuEXVXM4d5updYTV2bjE22aGxTKCeXkPOhEqffuCIaRoLXqUt2B6VQRXYeC6CB0Lbz8yj8EwxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Ny4jtyf0; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Ny4jtyf0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+zGZsmZnMwdbBNUWDDU213aek09YnR6ivzu6XTrNLaE=; t=1759185916; x=1760049916; 
	b=Ny4jtyf0To9RW6UxWSLtpH7viQaVDwv5aeaKs/uYrL7pykX2U2gnyXJOdkI/rgPT4ymw15yO2Vc
	kTnF/rve0ITzeBNSBoooqHhGXJj/NZOPjdW9h/qUfq/uMQbQVESp+aV2PwJzGg75PS4PsOJ0QXpd8
	gZ+bCYd56EjGa+t/5pmovmqtoFVgBBv88KzFxBw17tRSd0DMMmtVcoOwsOxUojJEBOpCbf9h/XgNG
	MpNMrFBaocszUKMo9SmHhGHsKUt6unqjXxz/UpPRhr1a8uFct2Yp52RFzrqZ82I7uDwkzPTXwavXm
	BYUhtaXufNMkfAsJDkKuG5Lk8P2+SPvLA0Rg==;
Received: from gnat-2.stanford.edu ([171.64.77.55]:58553 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <jgnieto@cs.stanford.edu>)
	id 1v3MAJ-0001fN-Oa; Mon, 29 Sep 2025 15:16:16 -0700
From: Javier Nieto <jgnieto@cs.stanford.edu>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javier Nieto <jgnieto@cs.stanford.edu>
Subject: [PATCH resubmit] Bluetooth: hci_h5: avoid sending two SYNC messages
Date: Mon, 29 Sep 2025 15:14:41 -0700
Message-ID: <20250929221553.84966-1-jgnieto@cs.stanford.edu>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: daeb03f1a6494d8fe08e106a714ef916

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

My test environment is a MangoPi MQ-Pro board
(with a Realtek RTL8723DS Bluetooth chip) running the tip of
bluetooth-next, although I also observed this issue on 6.8 kernel.
Originally, I spotted it using a logic analyzer on the UART PCB traces.
I added a temporary log message to h5_link_control(), which prints the
first byte and the length of the packet being sent. Here is the relevant
part before the patch:

[   67.328445] Bluetooth: h5_link_control sending 1 with len 2
[   67.432393] Bluetooth: h5_link_control sending 1 with len 2
[   67.436424] Bluetooth: h5_link_control sending 3 with len 3
[   67.436592] Bluetooth: h5_link_control sending 2 with len 2
[   67.436693] Bluetooth: h5_link_control sending 3 with len 3
[   67.439510] Bluetooth: h5_link_control sending 2 with len 2
[   67.440004] Bluetooth: h5_link_control sending 4 with len 2
[   67.440030] Bluetooth: h5_link_control sending 3 with len 3

And here after the patch:

[   67.498228] Bluetooth: h5_link_control sending 1 with len 2
[   67.501444] Bluetooth: h5_link_control sending 3 with len 3
[   67.501615] Bluetooth: h5_link_control sending 2 with len 2
[   67.504976] Bluetooth: h5_link_control sending 2 with len 2
[   67.505141] Bluetooth: h5_link_control sending 4 with len 2
[   67.505168] Bluetooth: h5_link_control sending 3 with len 3

Notice that in the first case, two SYNC packets (type 1) are sent, one 100ms
after the other, while in the second case only one is sent. In both
cases, using bluetoothctl to connect to a device later on works fine.

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


Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6102F33ADA4;
	Tue, 19 May 2026 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205543; cv=none; b=XSrnhsLsFbH+FLp8mxO1AZAwg+WKmNZO3hGw0oauLB2wWtEh5wpryi/p38oj8hj0oOHFx+0PmeHXRCDD22Q0PHBN0LKK84vg/dXcT1CvasG/r4Rqs5xnlWFsdIjDbsqAMQd7W5+VwH2pAre5FXvuo2pkWxu/rS3Co5DxIC1Mr2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205543; c=relaxed/simple;
	bh=sInWBGwhjqaU6eBj2K0h83uP8Wrfu/Pbzvb0UauzUdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+B13wX6HGpJ1dTULaQcBTK5Gy8wS4qIPc6aTSjVaTKQQ8GszTl9cPCIT9T4MW6a6moC5fWh4b06P6OSdKzYTDV/xJV4YcO6yxq5bCHNqkAweq6uUOVXnA53bhUplne5vFB/VsO0UfWnGjkGOkUPF4C6McOF5YdG+5MSogkWswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phwe.de; spf=pass smtp.mailfrom=phwe.de; dkim=pass (2048-bit key) header.d=phwe.de header.i=@phwe.de header.b=g83ZNFho; arc=none smtp.client-ip=188.68.63.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phwe.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phwe.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phwe.de header.i=@phwe.de header.b="g83ZNFho"
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4gKfC22F5kz8fdy;
	Tue, 19 May 2026 15:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phwe.de; s=key2;
	t=1779205534; bh=sInWBGwhjqaU6eBj2K0h83uP8Wrfu/Pbzvb0UauzUdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g83ZNFho1ARxuScl6yXvo0KF+yMQ/J2hfZbKaAWQRheTTHc+y9qyR/mIRE2P5FdCC
	 J+yh6BdC0mtXBxWA5Z7rIsWTOxv+9274756NhPt84a7kdOIYhshYWlZxBOEwlLcfGQ
	 3et9cQo71csbcQRwVTlGEGTxrpHcvtnMT5zm/IwX/afl0CZVD5r8aGZRBl9V8vmiQY
	 WPNskNDewLh3XDxFxL3RVhBkW4KCpGUww3L8bSi9mmN48PFSfM/rP/cIChlausmiIo
	 ThpX0JomDNP5wIjTqtCKj8RfjhCi6DBrdaog6km65mfpU0yzcplh55EtcaC+W/N6Wu
	 X6R4o658eu3LA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4gKfC21X8sz8fdn;
	Tue, 19 May 2026 15:45:34 +0000 (UTC)
Received: from mxe95c.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gKfC14GvQz8sZh;
	Tue, 19 May 2026 17:45:33 +0200 (CEST)
Received: from mandalore.fritz.box (p5dd24ed4.dip0.t-ipconnect.de [93.210.78.212])
	by mxe95c.netcup.net (Postfix) with ESMTPSA id 9D046800AF;
	Tue, 19 May 2026 17:45:32 +0200 (CEST)
Authentication-Results: mxe95c;
	spf=pass (sender IP is 93.210.78.212) smtp.mailfrom=kernel@phwe.de smtp.helo=mandalore.fritz.box
Received-SPF: pass (mxe95c: connection is authenticated)
From: Philipp Weber <kernel@phwe.de>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+d06554f43a8fb48030b0@syzkaller.appspotmail.com
Subject: [RFC PATCH] Bluetooth: btusb: wait for rx_work before freeing data on
 disconnect
Date: Tue, 19 May 2026 17:44:31 +0200
Message-ID: <20260519154431.13471-1-kernel@phwe.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <6a0c3fc4.a00a0220.2ee31e.0002.GAE@google.com>
References: <6a0c3fc4.a00a0220.2ee31e.0002.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <177920553324.3466434.15605598225501997578@mxe95c.netcup.net>
X-NC-CID: gN6ZpV/mydDfRZL/NdR0jzoj1YQy8qGKe2yj4V8t6g==

syzbot reports a slab-use-after-free in skb_dequeue() called from
btusb_rx_work(), with the freed object being the btusb_data struct
released by btusb_disconnect() via usb_unbind_interface() -> kfree().

The race:

  btusb_close() (via hci_unregister_dev -> hdev->close)
    cancel_delayed_work(&data->rx_work);   <-- non-sync
    ...
    btusb_stop_traffic(data);              <-- kills URBs

A URB completion callback fired between the non-sync cancel and
btusb_stop_traffic() can call data->recv_acl() -> hci_recv_frame(),
which enqueues to data->acl_q and schedules data->rx_work again.
The cancel above already returned, so the newly-scheduled rx_work
is left pending. btusb_disconnect() then proceeds to kfree(data)
while rx_work may still execute, dereferencing data->acl_q in
skb_dequeue().

Drain rx_work in btusb_disconnect() before kfree(data). At that
point hci_unregister_dev() has fully returned, btusb_close() has
already killed all URBs via btusb_stop_traffic(), so no new
scheduling can happen. Any rx_work item that was re-scheduled by a
late URB callback in the close path is guaranteed to be drained.

This runs without hci_req_sync_lock held (it was acquired by
hci_dev_do_close and released before btusb_disconnect resumes), so
the sync cancel has no deadlock interaction with the close path.

Fixes: 800fe5ec302e ("Bluetooth: btusb: Add support for queuing during polling interval")
Reported-by: syzbot+d06554f43a8fb48030b0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d06554f43a8fb48030b0
Signed-off-by: Philipp Weber <kernel@phwe.de>
---
 drivers/bluetooth/btusb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7f5fce93d984..5d4ea44cd3c9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4462,6 +4462,15 @@ static void btusb_disconnect(struct usb_interface *intf)
 		usb_driver_release_interface(&btusb_driver, data->intf);
 	}
 
+	/*
+	 * rx_work is scheduled from URB completion handlers; btusb_close()
+	 * (called via hci_unregister_dev) uses a non-sync cancel, so a work
+	 * item may still be queued or executing when we reach this point.
+	 * Wait for it before freeing data, otherwise the worker dereferences
+	 * freed memory through skb_dequeue(&data->acl_q).
+	 */
+	cancel_delayed_work_sync(&data->rx_work);
+
 	hci_free_dev(hdev);
 	kfree(data);
 }

base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
-- 
2.53.0


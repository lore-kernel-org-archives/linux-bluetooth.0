Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFA261588
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Oct 2025 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759739754; cv=none; b=sjAB0hJ+JynN8rOl/AT9DdTgqDM8nJtIF3im3E41yfRIL6tPft4KESRWooY/L3oKN/LqMN16j9m1L47LlrY1B4p2WZiRVPifj8SrwHBA9ppYKtTQE3KbdgY0s2nMRzmHcEAjVzmdjnLuknLPhmCiScVm46xOnWmBg35CdGUjoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759739754; c=relaxed/simple;
	bh=tDc0IXCsjbz+wZJxX4tHjcbS+PUGTn1yPQHSNPPeuo4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=Do0Znga+RmNo6Z1hNhBHg3IXqRxoH/+qdodwQKyRN1woNMrZHKJp5KjXsXD+hbTX5xXHavN4viKT2tbiRileOHPauil0MCvvDw6kGnvlFnC4nHys3luOs74dR1mk35HwNWW1vIxFD1xbKR+rMhdyF0s+egn3rPhyurSm5ML2bKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VbMTcLEx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VbMTcLEx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759739750;
	bh=tDc0IXCsjbz+wZJxX4tHjcbS+PUGTn1yPQHSNPPeuo4=;
	h=From:To:Subject:Date:From;
	b=VbMTcLEx22SnMuM3E8t0bMvHP/HvP/ekTWpEARixvT3EBl7qbK+hNb87f/efZKfEj
	 6O+sgC8z/fKOCGLhWryFjhSa02GYkElaUyOL/inxCdZXyfAFRKWUdG9rvjhFVEi7og
	 7UYP80YuYrsIktmu5RNxWb2tM+V1GEwZa6ShLvwAQEIJmStOAcXkM/e3fijx9CZZjY
	 PCo/53N/2st/YaZGJbmVRPA7yKnlHC8u+38aTDZOwq9z6thd4sA4jgV5tXSLBSxcbC
	 cdVpm0/n09wbwdfB4PjiavvcOagp9F4BbSxU/TMD6JciSF/0M2d/jozowEK0wjyfeV
	 F8Oa47WH24oAw==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-AF44-1001-5648-D00b-bBF7-38Db.rev.sfr.net [IPv6:2a02:8428:af44:1001:5648:d00b:bbf7:38db])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5DE3B17E11FD
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Oct 2025 10:35:50 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Revert "Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()"
Date: Mon,  6 Oct 2025 10:35:44 +0200
Message-ID: <20251006083544.22408-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This reverts commit c9d84da18d1e0d28a7e16ca6df8e6d47570501d4. It
replaces in L2CAP calls to msecs_to_jiffies() to secs_to_jiffies()
and updates the constants accordingly. But the constants are also
used in LCAP Configure Request and L2CAP Configure Response which
expect values in milliseconds.
This may prevent correct usage of L2CAP channel.

To fix it, keep those constants in milliseconds and so revert this
change.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
 include/net/bluetooth/l2cap.h | 4 ++--
 net/bluetooth/l2cap_core.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 4bb0eaedda18..00e182a22720 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -38,8 +38,8 @@
 #define L2CAP_DEFAULT_TX_WINDOW		63
 #define L2CAP_DEFAULT_EXT_WINDOW	0x3FFF
 #define L2CAP_DEFAULT_MAX_TX		3
-#define L2CAP_DEFAULT_RETRANS_TO	2    /* seconds */
-#define L2CAP_DEFAULT_MONITOR_TO	12   /* seconds */
+#define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
+#define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	1492    /* Sized for AMP packet */
 #define L2CAP_DEFAULT_ACK_TO		200
 #define L2CAP_DEFAULT_MAX_SDU_SIZE	0xFFFF
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 805c752ac0a9..d08320380ad6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -282,7 +282,7 @@ static void __set_retrans_timer(struct l2cap_chan *chan)
 	if (!delayed_work_pending(&chan->monitor_timer) &&
 	    chan->retrans_timeout) {
 		l2cap_set_timer(chan, &chan->retrans_timer,
-				secs_to_jiffies(chan->retrans_timeout));
+				msecs_to_jiffies(chan->retrans_timeout));
 	}
 }
 
@@ -291,7 +291,7 @@ static void __set_monitor_timer(struct l2cap_chan *chan)
 	__clear_retrans_timer(chan);
 	if (chan->monitor_timeout) {
 		l2cap_set_timer(chan, &chan->monitor_timer,
-				secs_to_jiffies(chan->monitor_timeout));
+				msecs_to_jiffies(chan->monitor_timeout));
 	}
 }
 
-- 
2.43.0


Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8966315D29
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954589; cv=none; b=aZPRatC7lkIwcxwj28iZFKfO+ZEVdPprau7pJLa2DJ+0sxT6PnV6IRJkFYJg/zAYk75hhQAFnZVcnxJ2zf7Ewh0OY/haqcHfEGkPoHHmHTMyFXv6Xje5CkBZn70Nw4js272nbKjhI8xpkzrSUq4eeIH8VG2tPd42AIw66G4kmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954589; c=relaxed/simple;
	bh=5naCmXFsXoVUpisedcAXLc979ja9KwXBhSUbkfew9/U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KTZUzFYmgvgzYgawx4PiTspeqU1jQtieBOrprCCCeXTtBAmSkZjCoJCIPxM8slh/34lMMcV85iIhaIZdHmIaBpLg9St8iyVsLMNAZ5XCNIBrLmAahcexq3KL4SdFYAxpYBGea5CEBcpd54FrPt3B+egfK7NAso1DIn9faahS4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OLp3w0XP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OLp3w0XP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779954585;
	bh=5naCmXFsXoVUpisedcAXLc979ja9KwXBhSUbkfew9/U=;
	h=From:To:Subject:Date:From;
	b=OLp3w0XPaFCBhhvYMUI7McSD0iGXPLqXhPlbTlJuKisf4lvXWaR88xHN+R5V/yZik
	 PbRUXJN8mVHNq/JacBws34P+e7PYQ980EBSkrslXCAfihyJcTpZGOeUW/sAhd4Fk77
	 iQH/T7WmVmK3KxnD72db4Dr2oN43d79iOIaShHQU+Yu8pma84KUXHqZm+yAgs6CJSG
	 byD0TPK/bRRoGsJNKDy7iS2PUpWoqv5CrNHwj1mcypqHqMsfhYQDXtzJT3DrxpZqsE
	 8ZFssPhiHn06K+vJidqEi5dsuQM36BslEAiQFM9R/O19MmBzR+mWAXQ9hHLdsJecK3
	 /WTiUXErzH5HQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9FE9E17E0177
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 09:49:45 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mgmt: Remove mgmt_ev[] strings of undefined MGMT events
Date: Thu, 28 May 2026 09:49:38 +0200
Message-ID: <20260528074938.385847-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Remove event strings introduced in mgmt_ev[] but for which the MGMT
events has not been defined.

Those events are already part of the events_le_table[] in
monitor/packet.c

Fixes: f9557931ad36 ("monitor: Add decoding support for Sync Receiver events")
---
 lib/bluetooth/mgmt.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bluetooth/mgmt.h b/lib/bluetooth/mgmt.h
index 1c741ed55..7fab3d7a0 100644
--- a/lib/bluetooth/mgmt.h
+++ b/lib/bluetooth/mgmt.h
@@ -1254,9 +1254,6 @@ static const char *mgmt_ev[] = {
 	"Advertisement Monitor Device Lost",
 	"Mesh Packet Found",
 	"Mesh Packet Complete",
-	"PA Sync Established",
-	"BIG Sync Established",
-	"BIG Sync Lost",
 };
 
 static const char *mgmt_status[] = {
-- 
2.43.0


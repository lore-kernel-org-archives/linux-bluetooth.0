Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC1332EDE
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363444; cv=none; b=IdvHGAbFTVS8CJY5OMbir1LJezXtPkuvBYzKY5cXZPQvOH083I1FIBa4PV1sgJAGnw3XbdlxWqGA3+cAZkcdqjUKn8yrrxiAAnLzdFpTL4Zl2rnEya7VTY/odwvNPt/J/CpimZ1/bcdn+qSQvSC8cc984DDdMDCp5xWfhAijgXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363444; c=relaxed/simple;
	bh=EIx/+NrJoP8oKhEUBW/SY8Ky1pzLqaKOsapWU3PG1xM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaakgUuWKZ2NbphaytlV3/GwbfrB3IsM+Xc0JMao9jcraofYvDT3+gUdHTtAPiVbyzlPdoUZq7wi/vjI0kq6ndYe0XATOZUAx+2d4MYWAavth6sdWMqHwrTwhD+kMDzQqBKPDpSBSzwi0o1pG6NyorZBwpUE1VfH+zE4K8BugNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BFFe9kv8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BFFe9kv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777363436;
	bh=EIx/+NrJoP8oKhEUBW/SY8Ky1pzLqaKOsapWU3PG1xM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BFFe9kv8osYFvhRbqnh0gcjiTVnNhN8AAQRk2ohzWluHtpNOp0gFaYIz1ms8H6ZI5
	 pIzSPYt0oEprdQik3p9CtplR56bf76WO8bd7menz5Bo2XZ0jfZePyFdpQiyet4qSmw
	 MX5ELPClN8jHCvzqr7RCdpjk+Wtw7pYfR9kRJYduYqeCmuwFIh0jxtmgoG8nml6RDb
	 4Qq8PW5CTd2htN3OIUaqCmxCZ1KmQt8POwEpIABvlk1GNYrRvbnzC0i/pBwgRs13fS
	 kvdyoZcOl15p//ww7VYq2H7QyBxeA+JU4kPv10xKEYHZRmQEZIzx8yjZjDsXPn+bzI
	 rXnSI9JzxRueQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 317A717E1352
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 10:03:56 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] doc: Add documentation for CIS transport Desynchronized property
Date: Tue, 28 Apr 2026 10:03:13 +0200
Message-ID: <20260428080314.180777-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428080314.180777-1-frederic.danis@collabora.com>
References: <20260428080314.180777-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This is only supported when bluetoothd is started in testing mode.

Assisted-by: GPT:GPT-5.3-Codex
---
 doc/org.bluez.MediaTransport.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 81cf9e4da..e50ec3f20 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -357,3 +357,17 @@ Possible values for both Unicast and Broadcast:
 :byte Retransmissions:
 
 	Indicates configured retransmissions.
+
+boolean Desynchronized [readwrite, optional, CIS only, testing, experimental]
+`````````````````````````````````````````````````````````````````````````````
+
+Available only when D-Bus testing interfaces are enabled and the transport has
+the **Links** property.
+
+Controls whether linked transports are acquired together.
+
+When set to False (default), acquiring one linked transport automatically
+acquires all links.
+
+When set to True, links are not acquired automatically and each link must be
+acquired separately.
-- 
2.43.0


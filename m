Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368BE3E51F3
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310465; cv=none; b=qTrH+OsUL+HHX0tWeMb+oHRhigB4WavdUzTnysuRJVg/wmPWYrva1bQlabiAkr9w4iB3ydXC3O2MCimdnHjFKAPuSWyJzRe71LhmhB0Qn/8k1/MkW3uaWPb/Y9K7zKxpNw/3FgipQO+bdlvioJ2ceRQ0Exoi2tqOYxiCZRUo8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310465; c=relaxed/simple;
	bh=EIx/+NrJoP8oKhEUBW/SY8Ky1pzLqaKOsapWU3PG1xM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1aBShbZQ9coEMASPJp6ScYdH22umoCxCK+AwpJizPUdrFfhfIbzJmhpdW+vpRU6Zf3oWdfNIJyBAA5ekGa4bqpboSfZjXMyx15MQFegM977uCXT27CajNKaw8xbNL9uj50JtRBNRYPhzdbKrYymZMWDnA6a1SSKpUB8imkeKX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LpUfhZtp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LpUfhZtp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777310462;
	bh=EIx/+NrJoP8oKhEUBW/SY8Ky1pzLqaKOsapWU3PG1xM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LpUfhZtpR8CadeAJ9iw9MtVP2/asNIiI5CVAbs4Ar9LR3LVftHHqYJQHLz/fgpaUc
	 lAgiU39pA3vTm7tc3SEXqVU9hVVdhlRm64gVPdODOBPpS62mRx8Bnj+VWj1fEpfzZa
	 RCLnMPhvZVSjmM1dTpyQAJU8k2onXobc6ZpoBMPV6rrQni8x59aZ7IMQ9STrl3X5Jm
	 B3rDLryNzysjBPbE3CIfaqjv7CSWHDt69OCSZdX3MwPGVUgLYpEX7wk9Prq4wcHkAG
	 YW1XF61pXEiMBX0Uu7Q8+sNmMbh794nnn4aSDndC1IqGQFVv+5fiGk+aS4sH/EPbxU
	 UbPPrtoFxYepw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 830C117E0F33
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 19:21:02 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] doc: Add documentation for CIS transport Desynchronized property
Date: Mon, 27 Apr 2026 19:20:55 +0200
Message-ID: <20260427172056.148115-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427172056.148115-1-frederic.danis@collabora.com>
References: <20260427172056.148115-1-frederic.danis@collabora.com>
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


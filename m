Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8B268698
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846371; cv=none; b=IlE74vyHn2ATAfDyChfCaYXgY9i/o8izKoOn0OQUxwR6KKel8S53WWYqHlZMtCf6lZvC16/FjJlXG/3SU3YqHWlgecf3wjeH3sobbk3gVtQ+JGSRBaUnJLvI9o8UtVPS5JcBB93pFLj/12ZwQNDmfQ7xhfV5WgKcIv0eTKc7Xac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846371; c=relaxed/simple;
	bh=/pORlkl6iy5CCHtXO4r13EYVKwWAZM7hO+8n2bM2/Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPU+8VhMZbA4dBgjrPr8rBhSoQxaeL6fRrxuseZnN9v0Yol5SshYHF4arK/0lr8emrMk8CVd6683ZeT17EG3I4AXrSzLmhSwW4qpXy/UU6sYnRA+SlUhiI5nM3OQriQ4LSZz5sMnORuD6aCj1gFhjoggAMNSNp0vD/0clCPPEIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 4.0.e.4.2.0.f.6.8.d.6.d.1.1.3.4.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:4311:d6d8:6f02:4e04] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u9OOM-0079pP-21;
	Mon, 28 Apr 2025 14:19:26 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v4 6/6] Revert "obexd: only run one instance at once"
Date: Mon, 28 Apr 2025 14:15:35 +0100
Message-ID: <20250428131842.488921-7-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428131842.488921-1-kernel.org@pileofstuff.org>
References: <20250428131842.488921-1-kernel.org@pileofstuff.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No longer needed now services can share resources.

This reverts commit 8d472b8758dcdd89bf13cf2fb06a8846e1f483a0.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 obexd/src/obex.service.in | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/obexd/src/obex.service.in b/obexd/src/obex.service.in
index f269bc513..cf4d8c985 100644
--- a/obexd/src/obex.service.in
+++ b/obexd/src/obex.service.in
@@ -1,19 +1,10 @@
 [Unit]
 Description=Bluetooth OBEX service
-# This is a user-specific service, but bluetooth is a device-specific protocol.
-# Only run one instance at a time, even if multiple users log in at once:
-ConditionPathExists=!/run/lock/bluez/obexd.lock
-ConditionUser=!@system
 
 [Service]
 Type=dbus
 BusName=org.bluez.obex
 ExecStart=@PKGLIBEXECDIR@/obexd
 
-# If the service fails on the following line, please ensure
-# the bluez tmpfile has been installed in /usr/lib/tmpfiles.d/
-ExecStartPre=touch /run/lock/bluez/obexd.lock
-ExecStopPost=rm -f /run/lock/bluez/obexd.lock
-
 [Install]
 Alias=dbus-org.bluez.obex.service
-- 
2.49.0


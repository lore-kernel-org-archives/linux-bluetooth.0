Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79B1D5CC4
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608743; cv=none; b=h4w5YyLNpUzWYSDZ8Zhkzld2LyliNZu6nKmTNVbPp2asZjMoNMwEEdpSRGs9pe7ha91I5M+skx4/paUk9sr8y2QD6xUqga4una2QM2wPO3slWIPzwpZalK7Fj8rDFRvL6gFbFsb+sc1M+PXCc0EkzuhMEHP5y7pP8dWMgMLCCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608743; c=relaxed/simple;
	bh=/pORlkl6iy5CCHtXO4r13EYVKwWAZM7hO+8n2bM2/Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1DTTNXeqjiRlrKduUCLsHaOS8dt+EsLxxcmmzhuDzCYesyg4LC6U1/BHK0Y8207H/CLeGqDMmCjBmCBuJDtkxjOkGCTH6jaPTPihNmNH/wkUkG/z5IG2rkDvAQ8n7NQq8ay4aPg0dSlOwEt4a8PTrn1Gxhr/ZXfrme21f6sOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from f.e.3.8.2.2.5.b.8.9.9.0.4.5.1.6.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:6154:998:b522:83ef] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u8OZd-000GhX-2J;
	Fri, 25 Apr 2025 20:18:57 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v3 5/5] Revert "obexd: only run one instance at once"
Date: Fri, 25 Apr 2025 20:17:54 +0100
Message-ID: <20250425191846.639039-6-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425191846.639039-1-kernel.org@pileofstuff.org>
References: <20250425191846.639039-1-kernel.org@pileofstuff.org>
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


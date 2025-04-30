Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A9F25B1E0
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 13:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019031; cv=none; b=XBTHUJJXUQw1Ow1N0tUAF6Lyz0pBdmLPee7gZKcKFPo+TyNAmqzrfsAxQRo0TzHwn+DRZdmKcHFQoT46rbcR2kEMGBKc6xSLju9zdWDJcN9k+aNGyppV2u88auAYzlB7txi8CcU6qCcbW4KAmvE8iHCnk+Id0Kubns2pPKubDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019031; c=relaxed/simple;
	bh=/pORlkl6iy5CCHtXO4r13EYVKwWAZM7hO+8n2bM2/Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dj46VdzQhlLySOdObKym71/mWrIXFobXLxmcjxuYhk/XkY6tSS+k1aCKE6h/ie1UE6OqcyFYXl7r3xXcZQAVfQfVWENJx00dFg/FaCm/xfF4Two7I7cjO1rPTnMLJ85VwVHv2a8qhXc8jqR55jGni6GU03VX7RAesPKLhm/9sz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from a.d.e.2.8.8.9.5.f.7.2.3.4.3.2.4.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:4234:327f:5988:2eda] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uA7JB-00B6cr-2J;
	Wed, 30 Apr 2025 14:17:06 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v6 3/3] Revert "obexd: only run one instance at once"
Date: Wed, 30 Apr 2025 14:14:02 +0100
Message-ID: <20250430131648.1291354-4-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430131648.1291354-1-kernel.org@pileofstuff.org>
References: <20250430131648.1291354-1-kernel.org@pileofstuff.org>
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


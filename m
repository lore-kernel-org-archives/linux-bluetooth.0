Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B728934D
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426075; cv=none; b=HY4IL+yrpQn+n22/tWeIlM9Suqqh7vZkjguiBts0VC/U4RFuSgfoEZ6xMNLHdzOFt5zhxIBAaKeKw2a03wxw/C86XPKiinb2dPmtGhLdevqiL4sqCB44LSxOJWg27JfXmHm5tcgT4Av84zI1qch8zefvMKW221zCCZ8EI5hjZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426075; c=relaxed/simple;
	bh=/pORlkl6iy5CCHtXO4r13EYVKwWAZM7hO+8n2bM2/Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVHEoVzQ4t+H7xBLpjuL+/pK6FHp6EUp7ttmP0oVRq4LusrBX7mxDYpUNOcY7VLzXtCMn010jXT1CRSevuoOBBm1zaZimbWi/2Dw0SL/agBx9fY/pKsezyDfhWH+H5EYldQFRsgrFSswVe6hIUbo/08RQjHQA/8WyCodbkc0hYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 2.d.9.3.3.f.4.8.6.f.f.b.b.0.3.7.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:730b:bff6:84f3:39d2] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u7d3O-00El0N-2b;
	Wed, 23 Apr 2025 17:34:31 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ 4/4] Revert "obexd: only run one instance at once"
Date: Wed, 23 Apr 2025 17:33:26 +0100
Message-ID: <20250423163343.4160595-5-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423163343.4160595-1-kernel.org@pileofstuff.org>
References: <20250423163343.4160595-1-kernel.org@pileofstuff.org>
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


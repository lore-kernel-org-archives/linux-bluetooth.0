Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB261F3BB2
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601340; cv=none; b=Rr3EJ29TT+oEUPElye2htrERAkBSFAlZp3cf7t1qIYQy1UlKE7rBLbIS+MhUKsp2iKWjG4GCbCIW86pWmc5hJC4F57ChUpqJjVqAnEA3Pcmv1s4kuAEWItYohvkQyu7UCQDMEYyGTVtIEs6057BckR3+4+D2Vk56lQ+RwsV9xho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601340; c=relaxed/simple;
	bh=/pORlkl6iy5CCHtXO4r13EYVKwWAZM7hO+8n2bM2/Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SL9Hcp6PWKo667lQ8suGMvMfubeYUoXKzotGoRsAFpRPxVsThAsWPGcvpvYqGnPIxTtHYm4FzWZnp+4fqjb4/rEG5S2OXXQMjkKWLxPmJeSWFqvI8D5Uf1Rg966PS6rd/Qv5hjjKMexmw8Iw43DvLxbsa/Q268Uu8mlTO/zs6Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from f.e.3.8.2.2.5.b.8.9.9.0.4.5.1.6.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:6154:998:b522:83ef] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u8MeF-0005GV-19;
	Fri, 25 Apr 2025 18:15:34 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v2 5/5] Revert "obexd: only run one instance at once"
Date: Fri, 25 Apr 2025 18:13:04 +0100
Message-ID: <20250425171505.573271-6-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425171505.573271-1-kernel.org@pileofstuff.org>
References: <20250425171505.573271-1-kernel.org@pileofstuff.org>
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


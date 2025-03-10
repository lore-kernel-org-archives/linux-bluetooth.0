Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7A21E088
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607273; cv=none; b=LamjusHUo+kSvUSW9lijvUt6LkTPTc95/prKNT31awOVvaOffP1nnoY8euudS1uVh4m7a4Izbj0185NZ1hbpp5ZHLteT2HwVq9+eacxj+IsI4pxoiDtiKu0zKwBuLri+2Hw8fu8CKzF9vph6191T+nSEybT1oSzYzcI+mnL/eJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607273; c=relaxed/simple;
	bh=S/zI7s5S7t9TkD8YKsntyB0Bckr1RtpVjhMhUBg3vpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fa/N0UIsieYjUqGwQzApTBxebDnv5T90SGNz4MzQQYLGcfK8nPvqyRvqDdKx2YGCc4lQP/g1wGqFS4xaVGZTrrlcRFZCKuLy3ovZiJKPRb6QaOmVYfqhhD76X+35EEOZURvdwZYWRoXg/0AY3LJiKo2jELxNQo//XSU0uY3Hu8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from b.2.5.5.5.8.8.9.d.7.e.2.4.c.3.8.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:83c4:2e7d:9885:552b] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1trbbo-00EIzM-0q;
	Mon, 10 Mar 2025 11:47:48 +0000
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ] Avoid spurious warnings when dbus.service stops
Date: Mon, 10 Mar 2025 11:47:19 +0000
Message-ID: <20250310114719.4141881-1-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The systemd services generates a warning when it loses
ownership of its D-Bus name, which happens routinely
when dbus.service exits (e.g. when the user logs out).
---
 tools/mpris-proxy.service.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
index 530749094..c49d255b3 100644
--- a/tools/mpris-proxy.service.in
+++ b/tools/mpris-proxy.service.in
@@ -3,7 +3,7 @@ Description=Bluetooth mpris proxy
 Documentation=man:mpris-proxy(1)
 
 Wants=dbus.socket
-After=dbus.socket
+After=dbus.socket dbus.service
 
 [Service]
 Type=simple
-- 
2.47.2


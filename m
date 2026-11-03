Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.54.226.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719071;
	b=3IepNdJBVHz4pHc5TEB3cq4ThPo7X9r4QCnMIcycsQNe+w3HLLwGNIb0t6NK6rHHpxEn
	 1dmQC7M4TBY4CD8wxw1NdOimztZK2X9KszDxoiaYtXyYC4rT0Jv0nfZ1KJFDK4hVX3wSV
	 Q9P+LFe1kvIkO5XpizN7Je8fvMfmZh715IgVFWCu8a5J72S2ZT3A6YZP1iVXDmII47xQK
	 8oA3KISugT3kjKVUVYBju6t2hMU0S1hiI8cqJCsAs9og1Ab2aQiuHLKiT0J/JVDJJDmWm
	 yAxZwKUEYiRHrgdUV5f6n3E4PfnIoQpRbO8oEYQ21FnnSI6ez1RKzKjmsQsKiMpSVfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719071;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5L+ml8/iia9nZGNt1ztEQS4idka4W4lDUtD1CW4S93Q=;
	b=d9fYF53Y+xuX5qJzJ8ps/nSF+kDh6JqAOjsoY2pa45xWu4Sh43Wek8Rx1gYTz/mjTiTG
	 W7sOo7FTEX63mVNWER/KHVPCuT1n61w9gDzSZnD2nar3Gl2evgvFgIYZmadzKiDFvfh8a
	 VOa/wcwKhIoCNHA0fWeujJSeEO3zpQKze+0RSuaRhnEaq7jHl0IXskYjEtd1I/o9CWiCa
	 BK0mzzteNaoPbiygtON6Ljbf7iDKQV2/ytLzk7JBcF4Pjw1I3iN11qZcDivO5KRPD0WeH
	 7OnkKlRVJIMSx1EtSmfUcjnlsnqxxONftM2nStmCZIcaQ0HfiXNCOFiig7iPZSi7Jcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tnode.com;
	spf=pass smtp.mailfrom=tnode.com;
	arc=none smtp.remote-ip=46.54.226.45
Received: from mail.tnode.com (mail.tnode.com [46.54.226.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36267606A331
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 15:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36267606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tnode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tnode.com
Received: from localhost (localhost [127.0.0.1])
	by mail.tnode.com (Postfix) with ESMTP id 6B3DB1260034;
	Tue,  3 Nov 2026 16:17:42 +0100 (CET)
Received: from mail.tnode.com ([127.0.0.1])
	by localhost (mail.tnode.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JTgaWoqttzqI; Tue,  3 Nov 2026 16:17:41 +0100 (CET)
Received: (nullmailer pid 598668 invoked by uid 1000);
	Tue, 03 Nov 2026 15:17:40 -0000
From: Mitar <mitar.git@tnode.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mitar <mitar.git@tnode.com>
Subject: [PATCH BlueZ] mpris-proxy: Stop and start together with dbus.service
Date: Tue,  3 Nov 2026 16:17:24 +0100
Message-ID: <20261103151724.598627-1-mitar.git@tnode.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GNOME stops dbus.service when a session ends, with
gnome-session-restart-dbus.service, and the bus is started again through
dbus.socket once a client connects to it. mpris-proxy is not stopped
with the bus: libdbus ends it with exit status 1 when the bus closes its
connection, so the unit fails, and nothing starts it again as long as
the user's service manager keeps running, for example when the user logs
in again within logind's UserStopDelaySec=. The media players of the
next session are then not registered with BlueZ.

Make the unit part of dbus.service, so that stopping the bus stops
mpris-proxy first, and have dbus.service want it, so that it is started
again together with the bus.
---
 tools/mpris-proxy.service.in | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/mpris-proxy.service.in b/tools/mpris-proxy.service.in
index 6ae56c6..2b8a4d5 100644
--- a/tools/mpris-proxy.service.in
+++ b/tools/mpris-proxy.service.in
@@ -4,6 +4,7 @@ Documentation=man:mpris-proxy(1)
 
 Wants=dbus.socket
 After=dbus.socket dbus.service
+PartOf=dbus.service
 ConditionUser=!@system
 
 [Service]
@@ -11,4 +12,4 @@ Type=simple
 ExecStart=@PKGBINDIR@/mpris-proxy
 
 [Install]
-WantedBy=default.target
+WantedBy=default.target dbus.service
-- 
2.53.0


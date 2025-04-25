Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060B21883C
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608742; cv=none; b=fk6qe46FxiB9hFCbZGjgFIlElxS2N/fToR/cnRXuLnqwqCTFdUNXIAiWmVulTjyesWw8jadHsf47G/jY1En6u57DzOA5ulsZPCnuqPUdZTtQN7V+A4j2D35RD3u0cuVCgqDSmWQRLaswDOx6ZznmQlpPj7Sjq2+XAKQYF97GXxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608742; c=relaxed/simple;
	bh=F5TkCiC1YYyLTJG7eKCGP5llitXqEUf0RLnCcSBXU4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1Y362ibq3AsLZvg2ccmmGAfQetHLh0K2wNXJW5doD86hnZjV7gXeEJGIhg+sZmMZUwBU3N08IZz3rjmIxKmhcPXFeUpBLpD5XVoavX1LUQSnSPIkfaCm5riYaUYvfGYo5584aYqMJw5YV12Gg004uIqcae2FAwqwINKEmr5DOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from f.e.3.8.2.2.5.b.8.9.9.0.4.5.1.6.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:6154:998:b522:83ef] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u8OZd-000GhX-0b;
	Fri, 25 Apr 2025 20:18:56 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v3 1/5] pbap: Support calling pbap_init() after pbap_exit()
Date: Fri, 25 Apr 2025 20:17:50 +0100
Message-ID: <20250425191846.639039-2-kernel.org@pileofstuff.org>
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

pbap_exit() didn't previously unregister itself thoroughly.  That
was fine if it was only called when the service was about to exit,
because everything was implicitly unregistered when the process ended.
But we need to be more scrupulous if this can be called throughout
the program's lifecycle.

Send the UnregisterProfile message directly from pbap_exit(),
then call unregister_profile().

The UnregisterProfile message can't be sent directly from
unregister_profile(), because that also needs to be called when
register_profile() fails halfway through.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
 obexd/client/pbap.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 2f234fadf..90f8bdc02 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -1485,8 +1485,20 @@ void pbap_exit(void)
 {
 	DBG("");
 
-	dbus_connection_unref(conn);
-	conn = NULL;
+	g_dbus_remove_watch(system_conn, listener_id);
+
+	unregister_profile();
+
+	if (system_conn) {
+		dbus_connection_close(system_conn);
+		dbus_connection_unref(system_conn);
+		system_conn = NULL;
+	}
+
+	if (conn) {
+		dbus_connection_unref(conn);
+		conn = NULL;
+	}
 
 	obc_driver_unregister(&pbap);
 }
-- 
2.49.0


Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3452144BF
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684234; cv=none; b=FOzjwuwf7KWv2wRNWTV4MbEQQ2ZkmdA5osJB+eoR58hYoUWLMMrMON8d6FXm9lnV2lo0N0EazpC7aVX5bRYkqa0sJgCN/zZtncZIU+xs3y7zuvzDTS8Lk4cb3Pe7jInjQIGRuoJxfFebmwjFPBphVv8x5zNb7SEGvmqG8H0UEbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684234; c=relaxed/simple;
	bh=VWh4SFv5ywAKN5hI4x5/+uCRQqQTrFCpP+2jWcV/cF0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KvrACiicw3gRP9caP+ShaokIeg6wPU9IgkzI7EoPF4yP7XIz3xw7rCJqb3OPxnJDvaFwRaUgnJTIG067ljgKA+1OE4eziYggdL3RpKxtjgHCX4pPH+8yqMIhiWdOTXLfeUquNt3qoqDVST5g1H5M/T9fvnzeWtB14NClnIqDMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fboL2oWP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fboL2oWP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1738684230;
	bh=VWh4SFv5ywAKN5hI4x5/+uCRQqQTrFCpP+2jWcV/cF0=;
	h=From:To:Subject:Date:From;
	b=fboL2oWPLNFzCOXIOoSHsnU6xYmZlSO8Sg3RbhXDIAxwuiBnaDy4BSU8LZx+TsRcW
	 ouZ7J+kS6KzrrNC+9nvSZI/Yu7+Q9yGFmNe+3ZE7L47xKhVTqViw7oBGPrINih2rzX
	 K+dEQ5jAcTo1QZAPP+T0qPtoIXnT5TyqNb3rtEiTX84iwzP7te/MZdbtAFWta4kLwG
	 Mo1bQeKAt32wRTR9Mmlm1N9LBxWRIOt3ORdy+LbD6JiAaCyp3ROxc3+WvcvAbAdIao
	 1pufCrbr1j4YQCGU0Vy9b6r+r/wLZxfpQff3nmg4ki3k5TkHYLx+x2U4ieL7RIQLqf
	 aGVmJBRgYngmQ==
Received: from fdanis-XPS-13-9370.. (2A02-8428-Af44-1001-aA7E-9220-7620-339e.rev.sfr.net [IPv6:2a02:8428:af44:1001:aa7e:9220:7620:339e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A8CDA17E151F
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 16:50:30 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mpris-proxy: Fix missing line returns
Date: Tue,  4 Feb 2025 16:50:25 +0100
Message-ID: <20250204155025.96612-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 tools/mpris-proxy.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index b08733314..2774bcc1a 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -2132,7 +2132,7 @@ static void register_player(GDBusProxy *proxy)
 	player->conn = g_dbus_setup_private(DBUS_BUS_SESSION, player->bus_name,
 									NULL);
 	if (!player->conn) {
-		fprintf(stderr, "Could not register bus name %s",
+		fprintf(stderr, "Could not register bus name %s\n",
 							player->bus_name);
 		goto fail;
 	}
@@ -2143,7 +2143,7 @@ static void register_player(GDBusProxy *proxy)
 						NULL,
 						mpris_properties,
 						player, NULL)) {
-		fprintf(stderr, "Could not register interface %s",
+		fprintf(stderr, "Could not register interface %s\n",
 						MPRIS_INTERFACE);
 		goto fail;
 	}
@@ -2154,7 +2154,7 @@ static void register_player(GDBusProxy *proxy)
 						player_signals,
 						player_properties,
 						player, player_free)) {
-		fprintf(stderr, "Could not register interface %s",
+		fprintf(stderr, "Could not register interface %s\n",
 						MPRIS_PLAYER_INTERFACE);
 		goto fail;
 	}
@@ -2165,7 +2165,7 @@ static void register_player(GDBusProxy *proxy)
 						tracklist_signals,
 						tracklist_properties,
 						player, NULL)) {
-		fprintf(stderr, "Could not register interface %s",
+		fprintf(stderr, "Could not register interface %s\n",
 						MPRIS_TRACKLIST_INTERFACE);
 		goto fail;
 	}
@@ -2176,7 +2176,7 @@ static void register_player(GDBusProxy *proxy)
 						NULL,
 						playlist_properties,
 						player, NULL)) {
-		fprintf(stderr, "Could not register interface %s",
+		fprintf(stderr, "Could not register interface %s\n",
 						MPRIS_PLAYLISTS_INTERFACE);
 		goto fail;
 	}
-- 
2.43.0


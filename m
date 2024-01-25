Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5A51353F5
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209700; cv=none; b=Nl6/ewGSaitJEibbNVFBGf9z5YP24oiOumWA83QymURbEY8GF7dYco0GrquzswAiq2R8T0PYWkdXDGa64vod2lvBYqth7fURBopeKp49sDy7Z5hw1L2/zUdrWaA0ZEfeDjmPks98XhhK+tcIgjz+ngyvL5u08j0nBvd8wWZ30q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209700; c=relaxed/simple;
	bh=TR9FeCKfGpogbwWXGekAInfxeqoCMmoY+xr575x32gE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXNoIoT8QECO0B4kz9bhI0R5pMefwrdTc7o8TVGlkbU6jgRpWr2SIHOek3o04rnEKlWPpvH20xSpvQCSGPuOr9/F0ixh1P3sCZTBPpXYk7nXZBQnr4Nbf0qtskSwMXMdzNOG/IkaQC2g6vaev+IlpLcwbtXVRF53CYNYU0KUA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=myg7jpfg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="myg7jpfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706209695;
	bh=TR9FeCKfGpogbwWXGekAInfxeqoCMmoY+xr575x32gE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=myg7jpfgsSeC8eWD9hb/H5AC73/jdYAAhaDkGGpnAJDTXnA/t4Nowad49kK4cX12f
	 dTYq3rgBFkfL7bPOR0y89rG57lzFLkLp+PEmKqrQcV/Qh/DlT4H+zzI5u2HvVyoCny
	 KIjdRWHS9IOy+FJSyhAMw96vgd4YpY7Koo8dFvMe1KP6sPuhCj8Ypx9/c6fSYeAjU9
	 b8+C7Ix+Ve3q5VseO7de7eCQjBJQsV+F+1HnyCI2R4CJoGhsWNjbsC/5yM/iQ5ncC6
	 AyDKJeog8Ld7A6dmenrqVIIAKBk0zbft8yR61BMLyQSD+rFcTlLUtYVZ6LOZMc2R2Z
	 r/sNxbN002ItA==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ABC003782053
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:08:15 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/5] btgatt-client: Add function to search all primary services
Date: Thu, 25 Jan 2024 20:08:05 +0100
Message-Id: <20240125190805.1244787-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125190805.1244787-1-frederic.danis@collabora.com>
References: <20240125190805.1244787-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This is requested to pass PTS GATT/CL/GAD/BV-01-C test.
---
 tools/btgatt-client.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 04fd3ce0f..b47914da3 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1354,13 +1354,6 @@ static void cmd_set_sign_key(struct client *cli, char *cmd_str)
 		set_sign_key_usage();
 }
 
-static void search_service_usage(void)
-{
-	printf("Usage: search-service <uuid>\n"
-		"e.g.:\n"
-		"\tsearch-service 1800\n");
-}
-
 static void search_service_cb(bool success, uint8_t att_ecode,
 					struct bt_gatt_result *result,
 					void *user_data)
@@ -1392,6 +1385,27 @@ static void search_service_cb(bool success, uint8_t att_ecode,
 	PRLOG("\n");
 }
 
+static void cmd_search_all_primary_services(struct client *cli, char *cmd_str)
+{
+	if (!bt_gatt_client_is_ready(cli->gatt)) {
+		printf("GATT client not initialized\n");
+		return;
+	}
+
+	bt_gatt_discover_all_primary_services(bt_gatt_client_get_att(cli->gatt),
+						NULL,
+						search_service_cb,
+						NULL,
+						NULL);
+}
+
+static void search_service_usage(void)
+{
+	printf("Usage: search-service <uuid>\n"
+		"e.g.:\n"
+		"\tsearch-service 1800\n");
+}
+
 static void cmd_search_service(struct client *cli, char *cmd_str)
 {
 	char *argv[2];
@@ -1536,6 +1550,8 @@ static struct {
 			"\tSet retry on security error by elevating security"},
 	{ "set-sign-key", cmd_set_sign_key,
 				"\tSet signing key for signed write command"},
+	{ "search-all-primary-services", cmd_search_all_primary_services,
+				"\tSearch all primary services"},
 	{ "search-service", cmd_search_service,
 				"\tSearch service"},
 	{ "search-characteristics", cmd_search_characteristics,
-- 
2.34.1


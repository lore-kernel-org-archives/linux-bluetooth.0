Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC312E5F
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020322; cv=none; b=d8EGWJNia+GOFyqiF3GH5XXftOIrG3v9iI4jPsRIRYNn+yHfVaweWOf3oWUUy9ojkKMBH+WJTHVo6eFEeFfnSxUcg6ENX07fQFZHMNDEKQeNzgCuR3mSn/+MAE3tRdTRwwr4cyR6Llj79TXFxjsMzngCzFDbCknL0pH0u+LH4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020322; c=relaxed/simple;
	bh=TR9FeCKfGpogbwWXGekAInfxeqoCMmoY+xr575x32gE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnt91yu9U7Fe7wTY9Kl/hdwHyivB82MTlzlRyMAUW9cKY/HqHlC/ZMfmVFpEyMGNkmwLPu6tAgmC2fsCum9xQWZkQt5y7Fm4r+VXB6P5zTVczyrcKJPtnTvRJwZdWwagAKbTwfrj7X5HW2gUn/7qgXPioJ4LfvJVJWQ11b8BTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=koqwzln5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="koqwzln5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706020319;
	bh=TR9FeCKfGpogbwWXGekAInfxeqoCMmoY+xr575x32gE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=koqwzln5hepv4eAgJSBHzg+1lovTfW90Inpc6JY0cA9L42Pgq7tjRtceVNNHGhrTK
	 GtdGyNg/cpnUvty3s4CQpVYTeMNopFa9lSZafjUF1CZ7+mIQKa7wNhxt0CWqjTuBLC
	 fT4INO9QiyZH/X7Oz8iSqBHwjIPmzIRS8qTxS+kcPQPt8fbteJtOcFdcfGC0J7kvW6
	 NdEwJyh4xk8sA2sRSRe0jWPvah97RAn1oF9m9iZTNGqeU5TpMAhUuF+THQWIGy+I+A
	 eTIM1AlgnF1NneuYho1GvhGwBtoOWUDmAxiTRCjy4bY/LFCRbqvsiV9qKBMstuHuf+
	 2iSfecGb/B4Jw==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 66B6137820B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 14:31:59 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] btgatt-client: Add function to search all primary services
Date: Tue, 23 Jan 2024 15:31:51 +0100
Message-Id: <20240123143151.541787-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123143151.541787-1-frederic.danis@collabora.com>
References: <20240123143151.541787-1-frederic.danis@collabora.com>
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


Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C205A78A
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942214; cv=none; b=FI/ZXyNBsCtWjp4iPVAOafKfYt8TMr71FZgg4GRNMAg24mjQR4NSwhrFOA/xB0A/260tHghTWIQNQdSRq3nSmz86bqV67A1H32bfr7EogANetwImPkacPFYA/rZBqDVa+uBrCMPf0CoxVxBsH3QcoJO3Ar9Lkal4BiwwpbTkylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942214; c=relaxed/simple;
	bh=JCKSKyIQmz8gOz1UT5T41yjPOm1tgWRNXppZHZ7xejk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTOzktBytj+Vn5V8bBLb1B4lJ6NTQukNlLA5dMVPVu3xWRmzMUIdm6oszXpdx9V/eB2HR/XFHLj3rEpVRu9dzLI17myyaOIscxrmn0t8Zo7dFkxfUJ2zRR7TiepRLOvIjJ+DKDKPv2luhcuFkbcHVKh0B0Jbc2K+V5pTWdZQ/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h4pqhnjC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h4pqhnjC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705942210;
	bh=JCKSKyIQmz8gOz1UT5T41yjPOm1tgWRNXppZHZ7xejk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h4pqhnjCnHqTtYhrMubY4RcgMz8PDEJYVI75jPuvA19eKZtnW2RsTWBnokHskJi7f
	 O+oIoU8AktQnED7Pi9R6MKKLypU0ONTc9XjMbdVc+4acnqxUqF/46xNCOmZwhVTN+v
	 VqxFwf/c9Qf8d9Omhr/4e6GOnlO4GNejqbIv6A7PzPPpZzW9Os3ke3tdygwwUSl6vY
	 JhKJw46y0/i9I7ri9JEO9qCWzyNPfgcXBpK2fUl9YPLNhRaVczLEVZyhSuo0naQsLc
	 IDeVmTpmvTUA2t9Trjozl7Y0gAx93yvzHGL0fHZjXytZrYedEG2rs+UmbB9DkuTWXT
	 To3RiO6OXMtMw==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 074CB3782021
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:50:09 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] btgatt-client: Add function to search all primary services
Date: Mon, 22 Jan 2024 17:50:00 +0100
Message-Id: <20240122165000.279381-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122165000.279381-1-frederic.danis@collabora.com>
References: <20240122165000.279381-1-frederic.danis@collabora.com>
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
index a7d5d76ba..d097727dc 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1332,13 +1332,6 @@ static void cmd_set_retry_on_sec_error(struct client *cli, char *cmd_str)
 		printf("Invalid argument: %s\n", argv[0]);
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
@@ -1370,6 +1363,27 @@ static void search_service_cb(bool success, uint8_t att_ecode,
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
@@ -1603,6 +1617,8 @@ static struct {
 				"\tSet signing key for signed write command"},
 	{ "set-retry-on-sec-error", cmd_set_retry_on_sec_error,
 			"\tSet retry on security error by elevating security"},
+	{ "search-all-primary-services", cmd_search_all_primary_services,
+				"\tSearch all primary services"},
 	{ "search-service", cmd_search_service,
 				"\tSearch service"},
 	{ "search-characteristics", cmd_search_characteristics,
-- 
2.34.1


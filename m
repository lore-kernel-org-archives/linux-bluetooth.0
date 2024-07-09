Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA7C19DF5C
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535755; cv=none; b=KNMkdi8nMbIZyU+UsAzhipD5CeEIqnEmPEQRzctQoVBQa4ZprPxBQIe1iuowYa5W89aFwh5ica2m5xUOFczBk3W1Hbv1TxKWtmUeZ4eKA2wgZnp3gcoKP2n3hlHnRx/shW9kOqBDkJOXinCt+9pc7qiUof3FilOuDasBxqkuF/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535755; c=relaxed/simple;
	bh=iHjx/Ti8+JdvlZ0N7evE/PBGi25M3IbtfF+guY2ZDpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjsDIE3/rJxQ2z1vrROkTCZmc7xB3Xdy1QpYTLIVtVpnjjE5qJ//5rLDvfrE5hqygfNb+ViyQOBMscqTKaR/mdXTQg0TF9s+B+mSKB17uJuacATYBa+CQSrFh7xaMv+lLwtbdN4lT8gNDwq/3KiWX8jkCkw1eisoQ2DaCmvoKzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 9 Jul
 2024 17:35:24 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v2 4/4] settings: limit string size in gatt_db_load()
Date: Tue, 9 Jul 2024 17:35:03 +0300
Message-ID: <20240709143503.12142-5-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709143503.12142-1-r.smirnov@omp.ru>
References: <20240709143503.12142-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/09/2024 14:15:02
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186394 [Jul 09 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;inp1wst083.omp.ru:7.1.1;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.22.207.138:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/09/2024 14:19:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/9/2024 11:26:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to prevent buffer overflow by limiting
the maximum string length.

Found with the SVACE static analysis tool.
---
 V1 -> V2: use "%36s[^:]" instead of calculating the string length
 src/settings.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/settings.c b/src/settings.c
index 643a083db..371649395 100644
--- a/src/settings.c
+++ b/src/settings.c
@@ -232,7 +232,7 @@ static int gatt_db_load(struct gatt_db *db, GKeyFile *key_file, char **keys)
 		value = g_key_file_get_string(key_file, "Attributes", *handle,
 									NULL);
 
-		if (!value || sscanf(value, "%[^:]:", type) != 1) {
+		if (!value || sscanf(value, "%36[^:]:", type) != 1) {
 			g_free(value);
 			return -EIO;
 		}
@@ -255,7 +255,7 @@ static int gatt_db_load(struct gatt_db *db, GKeyFile *key_file, char **keys)
 		value = g_key_file_get_string(key_file, "Attributes", *handle,
 									NULL);
 
-		if (!value || sscanf(value, "%[^:]:", type) != 1) {
+		if (!value || sscanf(value, "%36[^:]:", type) != 1) {
 			g_free(value);
 			return -EIO;
 		}
-- 
2.34.1


Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CE1A4F2B
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084110; cv=none; b=X7djPY3oJhVUoqVT+Ngmkz9QLpjZcFoMta6Nx1MhE69OUAxvDfzNGk6qnE4kyhVKbn/oGi+KZG/j7odP3CoBJUpBQ5xeVp0xjglD0zRKp4NIsOGT721X7dSRU1bvDBvdX/5o4GxS9WipPEMknwOtzgN7d9II9qMw7bsj0DJ1wUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084110; c=relaxed/simple;
	bh=xmE/3st/WNbHueSfgiZvWHYu5FfznyOA/5J+X25kIHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUH9JV1APp7MWrF6zNKSOHzi5K2QWcY/JVhwd9RppsAXG5uP9H9yJzbGMWCjJQzUOYF4XXReO9pq/CV/2TnU0hSULvxp5Kf1LYaL/OANyPgWLRUbGw1nPZxLKjL4r2P5s8OQEyQDTW0z44AOmP+6u+bZ7MIS46X4nV+Y9UwqvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.187.157) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 4 Jul
 2024 12:08:17 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v2 1/3] shared/vcp: prevent dereferencing of NULL pointers
Date: Thu, 4 Jul 2024 12:07:52 +0300
Message-ID: <20240704090756.31351-2-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704090756.31351-1-r.smirnov@omp.ru>
References: <20240704090756.31351-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/04/2024 08:52:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186322 [Jul 04 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 217.23.187.157 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;217.23.187.157:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 217.23.187.157
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/04/2024 08:56:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/4/2024 6:00:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Using util_memdup() will terminate the program if memory
allocation fails.

Found with the SVACE static analysis tool.
---
 V1 -> V2: util_memdup() is used instead of checking for NULL
 src/shared/vcp.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 06264a241..4597bebf6 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -2127,14 +2127,8 @@ static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	vocs_ao_dec_r = malloc(length+1);
-	memset(vocs_ao_dec_r, 0, length+1);
-	memcpy(vocs_ao_dec_r, value, length);
-
-	if (!vocs_ao_dec_r) {
-		DBG(vcp, "Unable to get VOCS Audio Descriptor");
-		return;
-	}
+	vocs_ao_dec_r = util_memdup(value, length + 1);
+	memset(vocs_ao_dec_r + length, 0, 1);
 
 	DBG(vcp, "VOCS Audio Descriptor: %s", vocs_ao_dec_r);
 	free(vocs_ao_dec_r);
@@ -2531,14 +2525,8 @@ static void read_aics_audio_ip_description(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	ip_descrptn = malloc(length+1);
-	memset(ip_descrptn, 0, length+1);
-	memcpy(ip_descrptn, value, length);
-
-	if (!ip_descrptn) {
-		DBG(vcp, "Unable to get Audio Input Description");
-		return;
-	}
+	ip_descrptn = util_memdup(value, length + 1);
+	memset(ip_descrptn + length, 0, 1);
 
 	DBG(vcp, "Audio Input Description: %s", ip_descrptn);
 	free(ip_descrptn);
-- 
2.43.0


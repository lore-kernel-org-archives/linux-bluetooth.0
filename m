Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86582193460
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621039; cv=none; b=fleFdd2JDaxFa7BIPu7VsZnPnFmBwpgF8tGSQ90GQ6ateu3xSDLS1MeIUTR4BupPvzgcj0ptOQY3cLWReLEr8QNtVuJVxUArZfVVvkDFmrRgL0GoC5HGAFIL2geDQLpjSAl8X/2c6cXsktnRT8kbt4egHSpu0jOK/oDa8zU3VCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621039; c=relaxed/simple;
	bh=mRAhK77PuVCNh72sBJ99exWKjo0VFA05LpQESKZy2JU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NP1kxBh5iD4s/N/pMJV4jx1k6ZCIJeo4zc0u+TLUZNgoYsxl1WCw24heHFRtxAUoUznRaA2Jw2uf+O9XctZ15g8gDsKMsISzKKZgteb65Wwta3ZzNlkWey7zPsiyKMyJTo1AuOAUKNJn9kWLhs1ms9CdgRPgwvhgxlv6+P6f560=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (178.205.55.202) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 10 Jul
 2024 17:16:38 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v3 resend 4/6] shared/vcp: prevent dereferencing of NULL pointers
Date: Wed, 10 Jul 2024 17:16:17 +0300
Message-ID: <20240710141621.64394-5-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710141621.64394-1-r.smirnov@omp.ru>
References: <20240710141621.64394-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/10/2024 13:54:49
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186438 [Jul 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.205.55.202
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/10/2024 14:00:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/10/2024 12:34:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

util_memdup() will terminate the program if memory
allocation fails.

Found with the SVACE static analysis tool.
---
 V1 -> V2: util_memdup() is used instead of checking for NULL
 src/shared/vcp.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 43ef1d186..cfc426624 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -2139,14 +2139,8 @@ static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
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
@@ -2543,14 +2537,8 @@ static void read_aics_audio_ip_description(struct bt_vcp *vcp, bool success,
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


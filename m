Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC076176255
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010340; cv=none; b=HhgQuV4N3tUkV01eWJ3ZWFAnuPrTH69H3FJyo9Y45Z4D9LK5n32ptcvIV2UZJRAn+wdA0Rh3K0dT+RGtfCqGHuSrCECn5vCVEoPVxX8iNju9wbcDRmkL2nZ1D2oGjyBq/VUikyBMP+aTBV+0qkVTLYACoxuVNRcJxnkqg0rIE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010340; c=relaxed/simple;
	bh=j9eFscgCDK6YZCcIZ4vMtWQZroZtNHHYRdZ7xE75ru0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiEOCu6C2xt5oiDCTr/a3TQO/LJoh6vUnggFapxmb0EeJ/CyDBW8zsnq5pxGioeCe/UbbTGmg0uIMO2NLfzBIA8gUFW3xzYsHMzfZkeSC6y3VU6zMRzU/cD5eL0fwrsYt4epU4Rgl4OGmn0HVVeniN+xETkSl4k1Kt8N8okxe6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.187.157) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 3 Jul
 2024 15:38:43 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1 1/3] shared/vcp: prevent dereferencing of NULL pointers
Date: Wed, 3 Jul 2024 15:37:41 +0300
Message-ID: <20240703123745.56443-2-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703123745.56443-1-r.smirnov@omp.ru>
References: <20240703123745.56443-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/03/2024 12:15:57
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186307 [Jul 03 2024]
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
X-KSE-AntiSpam-Info: {Found in DNSBL: 217.23.187.157 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	217.23.187.157:7.1.2;omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
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
X-KSE-Antiphishing-Bases: 07/03/2024 12:21:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/3/2024 10:36:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to check that malloc() was able to allocate memory.

Found with the SVACE static analysis tool.
---
 src/shared/vcp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index b7e17e448..2ffdb22a0 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -2128,14 +2128,15 @@ static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
 	}
 
 	vocs_ao_dec_r = malloc(length+1);
-	memset(vocs_ao_dec_r, 0, length+1);
-	memcpy(vocs_ao_dec_r, value, length);
 
 	if (!vocs_ao_dec_r) {
 		DBG(vcp, "Unable to get VOCS Audio Descriptor");
 		return;
 	}
 
+	memset(vocs_ao_dec_r, 0, length+1);
+	memcpy(vocs_ao_dec_r, value, length);
+
 	DBG(vcp, "VOCS Audio Descriptor: %s", vocs_ao_dec_r);
 	free(vocs_ao_dec_r);
 	vocs_ao_dec_r = NULL;
@@ -2532,14 +2533,15 @@ static void read_aics_audio_ip_description(struct bt_vcp *vcp, bool success,
 	}
 
 	ip_descrptn = malloc(length+1);
-	memset(ip_descrptn, 0, length+1);
-	memcpy(ip_descrptn, value, length);
 
 	if (!ip_descrptn) {
 		DBG(vcp, "Unable to get Audio Input Description");
 		return;
 	}
 
+	memset(ip_descrptn, 0, length+1);
+	memcpy(ip_descrptn, value, length);
+
 	DBG(vcp, "Audio Input Description: %s", ip_descrptn);
 	free(ip_descrptn);
 	ip_descrptn = NULL;
-- 
2.43.0


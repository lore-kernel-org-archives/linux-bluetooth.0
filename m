Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53019D89D
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535752; cv=none; b=g8dT2WmHVo20rxW4m6fuRV4k8xeL0hRIXyzjYqWLKBwGiAKcuC12ngVEQac+S1/v7UP8uMnkulX/trzMcJNk/Oa16uuNeaTs1GGA7rpI12aqmW+crqRufOXlRl8im66y0qtn6n/xfjIpZue0FeTePJj3ISadYPxVngcopx5NYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535752; c=relaxed/simple;
	bh=zbITHsIUUE0Ji1/YBq0mag53WJ4gNvYQz7iddUlO4lk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=md8BCbvlqWpK0vJkfohik8l4A+xjxIFVAUWa+fDrbVSsFI+RATe7aP2Ktt1dBvRy7hdUl4294IXN9IUzrfAlDo6XYHBdmDHAM8uwZEHfiYj4EPakHJi/pFYP6zIFbIsmzE2N34kBLy04WhNOPMkHH3IdV2adu7Qh8LfG6z/75pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 9 Jul
 2024 17:35:23 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v2 3/4] settings: limit string size in load_service()
Date: Tue, 9 Jul 2024 17:35:02 +0300
Message-ID: <20240709143503.12142-4-r.smirnov@omp.ru>
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
 src/settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/settings.c b/src/settings.c
index b61e694f1..643a083db 100644
--- a/src/settings.c
+++ b/src/settings.c
@@ -193,7 +193,7 @@ static int load_service(struct gatt_db *db, char *handle, char *value)
 		return -EIO;
 	}
 
-	if (sscanf(value, "%[^:]:%04hx:%36s", type, &end, uuid_str) != 3) {
+	if (sscanf(value, "%36[^:]:%04hx:%36s", type, &end, uuid_str) != 3) {
 		DBG("Failed to parse value: %s", value);
 		return -EIO;
 	}
-- 
2.34.1


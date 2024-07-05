Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199EB144D23
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166309; cv=none; b=MP6uCsMRADAoV1WeRxfKttD7OIUDgelBp0kkuUPT41oNIUe8fgAj2qLKry9e1yFT9n+C7lwO5iFNU+M72cFjm+TWxO0UlwDES7oSFF1U4Wc0c94IhhWjC9GmDCCNTAzMhiKyn3R+9ulH7vQoInK5NnXWcrX4r3ulP5PgxSv8T2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166309; c=relaxed/simple;
	bh=LzRbPu8K8HIKwD8TXFkDExufstzLFgvReiHkczJ8wYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sl1wJkVpC/gEaPJyvnYzCH+uE/zNzRJmXriP6kj/xFANeBYm8HIsl5LDIOZAzbTa756YpMpmuGuTvAxEYhlVUKkCWVnzexAgEvszZJMgt7Tk42YmFam1kI4Mrq2Ea8+J1mHwJfHSfZX4LF3kF23/ySNqXEw7AePInZDCgnxWOto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.187.157) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 5 Jul
 2024 10:58:03 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v2 1/5] obexd: add NULL checks to file_stat_line()
Date: Fri, 5 Jul 2024 10:57:03 +0300
Message-ID: <20240705075709.26809-2-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705075709.26809-1-r.smirnov@omp.ru>
References: <20240705075709.26809-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/05/2024 07:27:52
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186342 [Jul 05 2024]
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
	217.23.187.157:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 217.23.187.157
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/05/2024 07:32:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/5/2024 4:11:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

gmtime() may return NULL. It is necessary to prevent
dereferencing of a NULL pointer.

Found with the SVACE static analysis tool.
---
 obexd/plugins/filesystem.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
index 4887a0b8a..a57b25a83 100644
--- a/obexd/plugins/filesystem.c
+++ b/obexd/plugins/filesystem.c
@@ -113,6 +113,7 @@ static char *file_stat_line(char *filename, struct stat *fstat,
 {
 	char perm[51], atime[18], ctime[18], mtime[18];
 	char *escaped, *ret = NULL;
+	struct tm a_gmtime, c_gmtime, m_gmtime;
 
 	snprintf(perm, 50, "user-perm=\"%s%s%s\" group-perm=\"%s%s%s\" "
 			"other-perm=\"%s%s%s\"",
@@ -126,9 +127,16 @@ static char *file_stat_line(char *filename, struct stat *fstat,
 			(fstat->st_mode & 0002 ? "W" : ""),
 			(dstat->st_mode & 0002 ? "D" : ""));
 
-	strftime(atime, 17, "%Y%m%dT%H%M%SZ", gmtime(&fstat->st_atime));
-	strftime(ctime, 17, "%Y%m%dT%H%M%SZ", gmtime(&fstat->st_ctime));
-	strftime(mtime, 17, "%Y%m%dT%H%M%SZ", gmtime(&fstat->st_mtime));
+	if (!gmtime_r(&fstat->st_atime, &a_gmtime) ||
+			!gmtime_r(&fstat->st_ctime, &c_gmtime) ||
+			!gmtime_r(&fstat->st_mtime, &m_gmtime)) {
+		error("gmtime_r() returned NULL");
+		return ret;
+	}
+
+	strftime(atime, 17, "%Y%m%dT%H%M%SZ", &a_gmtime);
+	strftime(ctime, 17, "%Y%m%dT%H%M%SZ", &c_gmtime);
+	strftime(mtime, 17, "%Y%m%dT%H%M%SZ", &m_gmtime);
 
 	escaped = g_markup_escape_text(filename, -1);
 
-- 
2.43.0


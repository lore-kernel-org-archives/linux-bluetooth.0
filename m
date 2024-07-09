Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C51619D8B4
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535749; cv=none; b=FI9LCWMPSdRz6nRUF0cre9kJsZ+1/rwEpgUyGZUVgfgt7IM8yPJ92jbXM1VlI0hMPh42EC14oSs6Opatj6FyW2FTS1c/ljlFbUUJTqh5/d9OVlAly26yLvsaURakF4BvIPj6+f6LmSmc7Psh0h6Z5T1FxlS/FS0/537cFEE0xVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535749; c=relaxed/simple;
	bh=0ejBL7ZSc7gA/IcHRXJCCK5EfVVRFcFEnRVWsUP1gqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll5j2QWftyXcqRITcXV/q9nG9oqdWDsVGiFoX0FhiZKvUG5BdIaoA8Ihf+8pesuh9bbMCKwfs9n0G0M797p5GRynBMaeDXdpjTq3XJSwJYmKm1C6PqCnRhKH8ZqSJA+VjOuRYKW61E4NEcsBguvbMSikppaZmD3RhEIsjrAzyfs=
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
Subject: [PATCH BlueZ v2 2/4] shared: prevent dereferencing of NULL pointers
Date: Tue, 9 Jul 2024 17:35:01 +0300
Message-ID: <20240709143503.12142-3-r.smirnov@omp.ru>
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

It is necessary to add checks for NULL before dereferencing pointers.

Found with the SVACE static analysis tool.
---
 src/shared/micp.c |  4 ++++
 src/shared/vcp.c  | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/src/shared/micp.c b/src/shared/micp.c
index b82bd92de..1c34e9d00 100644
--- a/src/shared/micp.c
+++ b/src/shared/micp.c
@@ -398,6 +398,10 @@ static void mics_mute_write(struct gatt_db_attribute *attrib,
 	}
 
 	micp_op = iov_pull_mem(&iov, sizeof(*micp_op));
+	if (!micp_op) {
+		DBG(micp, "iov_pull_mem() returned NULL");
+		goto respond;
+	}
 
 	if ((*micp_op == MICS_DISABLED) || (*micp_op != MICS_NOT_MUTED
 		&& *micp_op != MICS_MUTED)) {
diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 06264a241..602d46dc1 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -925,6 +925,10 @@ static void vcs_cp_write(struct gatt_db_attribute *attrib,
 	}
 
 	vcp_op = iov_pull_mem(&iov, sizeof(*vcp_op));
+	if (!vcp_op) {
+		DBG(vcp, "iov_pull_mem() returned NULL");
+		goto respond;
+	}
 
 	for (handler = vcp_handlers; handler && handler->str; handler++) {
 		if (handler->op != *vcp_op)
@@ -985,6 +989,10 @@ static void vocs_cp_write(struct gatt_db_attribute *attrib,
 	}
 
 	vcp_op = iov_pull_mem(&iov, sizeof(*vcp_op));
+	if (!vcp_op) {
+		DBG(vcp, "iov_pull_mem() returned NULL");
+		goto respond;
+	}
 
 	for (handler = vocp_handlers; handler && handler->str; handler++) {
 		if (handler->op != *vcp_op)
@@ -1517,6 +1525,10 @@ static void aics_ip_cp_write(struct gatt_db_attribute *attrib,
 	}
 
 	aics_op = iov_pull_mem(&iov, sizeof(*aics_op));
+	if (!aics_op) {
+		DBG(vcp, "iov_pull_mem() returned NULL");
+		goto respond;
+	}
 
 	for (handler = aics_handlers; handler && handler->str; handler++) {
 		if (handler->op != *aics_op)
-- 
2.34.1


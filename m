Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131A13C9B9
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719997424; cv=none; b=CxrGoYwXtz2Hfi055vaf6Z/aPED4TWR6yIRegoLJy1vfXVInS7Cmb5OPB/iUh30FZXa4omxXRSRoty86U9ASCNp8U+3zae0OOfhafI6TomtVHi/kgWjw2y3Q6r+oTXf/7Ufmi9KI7tYxeq0hEc9mc60IExyvBFkXKkHqypE+7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719997424; c=relaxed/simple;
	bh=Drnn6EMWxDBjKKnm8DG3bW6pO3De1CWieu8Nh5zne+U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sROhL1VMxs+RKCzpyYeiamPB+r5q0EmxDIRZ6RDZKm2HzzNKEenWpzzlMQvX6k5wGSqd8sb19Ez8hxhzatoCA/0NSTrlCWOJxAvinpal8l6Psxvj4DLCCLb5tOvxtqKD8+wC+fHsgqYeqfXaoj05zjzVdrWrSl4cYt8CE4Rrw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.187.157) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 3 Jul
 2024 12:03:30 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] shared/bap: prevent dereferencing of NULL pointers in ascs_ase_read()
Date: Wed, 3 Jul 2024 12:03:05 +0300
Message-ID: <20240703090305.14542-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.43.0
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/03/2024 08:38:11
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186299 [Jul 03 2024]
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
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;217.23.187.157:7.1.2;127.0.0.199:7.1.2
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
X-KSE-Antiphishing-Bases: 07/03/2024 08:41:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/3/2024 6:47:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

If the user_data argument is NULL, a NULL pointer will
be dereferenced. It is necessary to prevent this case.

Found with the SVACE static analysis tool.
---
 src/shared/bap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index ec54da341..cb5ea9e84 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -805,12 +805,17 @@ static void ascs_ase_read(struct gatt_db_attribute *attrib,
 				void *user_data)
 {
 	struct bt_ase *ase = user_data;
-	struct bt_bap *bap = bap_get_session(att, ase->ascs->bdb->db);
-	struct bt_bap_endpoint *ep = bap_get_endpoint(bap->local_eps,
-							bap->ldb, attrib);
+	struct bt_bap *bap = NULL;
+	struct bt_bap_endpoint *ep = NULL;
 	struct bt_ascs_ase_status rsp;
 
-	if (!ase || !bap || !ep) {
+	if (ase)
+		bap = bap_get_session(att, ase->ascs->bdb->db);
+
+	if (bap)
+		ep = bap_get_endpoint(bap->local_eps, bap->ldb, attrib);
+
+	if (!ep) {
 		gatt_db_attribute_read_result(attrib, id, BT_ATT_ERROR_UNLIKELY,
 								NULL, 0);
 		return;
-- 
2.43.0


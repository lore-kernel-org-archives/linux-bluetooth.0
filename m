Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33761586C3
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526480; cv=none; b=iMWkoXBUYy45algy/g2ltpci5hzCmwBYQX4nP3s2RkjFCL8VyQ7CK8Xfu8dgvLdpWjZfOloVzyXF2YOV+WMvYMlPoT+k+7+BRnmaW8BJPrxizfdnlQCNctuSCsLU+DPE9I9xqqu3+eej+fhrz+41XGpTW8Hs+Mpz2h2puj8+izE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526480; c=relaxed/simple;
	bh=vhrdcBVQZoZrccPSJiEm7syXScooPKEPuKqw+PcZYsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wu/0446BqpLEDOVs+0eZxo04ZmdP/GhjIwnBPBeyGnWpccpu0FxlG8fE5Ug/fbGsTMhxPuIKxO6UIlFn6WBxHvHSbNKwd2tQkkRwREZzStRXgvJmpNwKK4rODd9rVAzfc3bm2Z/PuMxn6yxSGdmwCIHZBy2xf0CXZ93PtMUWfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 9 Jul
 2024 15:00:53 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1 1/4] health: mcap: add checks for NULL mcap_notify_error()
Date: Tue, 9 Jul 2024 15:00:28 +0300
Message-ID: <20240709120031.105038-2-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709120031.105038-1-r.smirnov@omp.ru>
References: <20240709120031.105038-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/09/2024 11:45:20
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186390 [Jul 09 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 23 0.3.23
 8881c50ebb08f9085352475be251cf18bb0fcfdd
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	81.22.207.138:7.1.2;inp1wst083.omp.ru:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/09/2024 11:49:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/9/2024 11:26:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to prevent dereferencing of NULL pointers.

Found with the SVACE static analysis tool.
---
 profiles/health/mcap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index 7eceaa88a..2e4214a69 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -336,6 +336,9 @@ static void mcap_notify_error(struct mcap_mcl *mcl, GError *err)
 	case MCAP_MD_CREATE_MDL_REQ:
 		st = MDL_WAITING;
 		l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
+		if (!l)
+			return;
+
 		mdl = l->data;
 		mcl->mdls = g_slist_remove(mcl->mdls, mdl);
 		mcap_mdl_unref(mdl);
@@ -345,6 +348,9 @@ static void mcap_notify_error(struct mcap_mcl *mcl, GError *err)
 	case MCAP_MD_ABORT_MDL_REQ:
 		st = MDL_WAITING;
 		l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
+		if (!l)
+			return;
+
 		shutdown_mdl(l->data);
 		update_mcl_state(mcl);
 		con->cb.notify(err, con->user_data);
@@ -362,6 +368,9 @@ static void mcap_notify_error(struct mcap_mcl *mcl, GError *err)
 	case MCAP_MD_RECONNECT_MDL_REQ:
 		st = MDL_WAITING;
 		l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
+		if (!l)
+			return;
+
 		shutdown_mdl(l->data);
 		update_mcl_state(mcl);
 		con->cb.op(NULL, err, con->user_data);
-- 
2.34.1


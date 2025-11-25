Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA762D7392
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063582; cv=none; b=lqBllMLR+x2PnYmCU9sunnGDJUu2Rb4GK51rwPa3G1qmHcslrhO7ktv8KbYJ0aQ1bboACG4/0pDuptFHtzaODQQvn9hBGagGHY5qb1hTpUYiZDjN4+Umr0yzKvVv+kX2vTg2QQstnQ2/uKjM03gK9AVwkBTMDjJnelRAB3Yd/EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063582; c=relaxed/simple;
	bh=8zuK+gHOB7ZO4xmgJyL6DtTyrsBlHaXrg8ZzF1DVSI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltXNCtZM8NY9U+5wzvXzzrbsbEd30Khm0dThBMzWG5GR7BCWsgfg85L4fpGFWm/eke44XcZUqZlHgMRfVD+ep0IkxKepskIiRKngkhvvKxs3refKQmwAq70dBQrmpJk1KqLd7NzRsahBibRzwRVKsytvnam+pz4ssvoLn424AIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst087.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 25 Nov
 2025 12:39:29 +0300
From: Kirill Samburskiy <k.samburskiy@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Kirill Samburskiy <k.samburskiy@omp.ru>
Subject: [PATCH BlueZ 1/1] obexd: Always flush tranfser status changes. Set status to queued before starting
Date: Tue, 25 Nov 2025 12:38:35 +0300
Message-ID: <20251125093835.17472-2-k.samburskiy@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251125093835.17472-1-k.samburskiy@omp.ru>
References: <20251125093835.17472-1-k.samburskiy@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/25/2025 09:20:16
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 198368 [Nov 25 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.20
X-KSE-AntiSpam-Info: Envelope from: k.samburskiy@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 80 0.3.80
 4173f23c7a80b2919ca29df3f9fec80718f6330e
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {Tracking_repetitive_subdir_in_url}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.22.207.138:7.1.2;127.0.0.199:7.1.2;inp1wst087.omp.ru:7.1.1;omp.ru:7.1.1;github.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/25/2025 09:22:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/25/2025 5:38:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

When transferring multiple files in the same session, obexd reuses the
same obex_transfer object to communicate transfer state to agents.
Because of that every transfer except the first one starts with its
status being "completed". If in addition to that, if the file size is
0 bytes, then the transfer status will change to "active" and then
immediately to "completed", but only change to "completed" will be
signaled through D-Bus. Such status change from "completed" to
"completed" is invalid and can cause issues with some agents. To
resolve the issue, always signal status changes, and set status to
"queued" before starting the transfer.

Fixes: https://github.com/bluez/bluez/issues/1683
---
 obexd/plugins/opp.c | 2 ++
 obexd/src/manager.c | 9 ++++++++-
 obexd/src/manager.h | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/obexd/plugins/opp.c b/obexd/plugins/opp.c
index 2220efd49..57bc0e7b9 100644
--- a/obexd/plugins/opp.c
+++ b/obexd/plugins/opp.c
@@ -58,6 +58,8 @@ static int opp_chkput(struct obex_session *os, void *user_data)
 	if (t != NULL && !is_filename(t))
 		return -EBADR;
 
+	manager_emit_transfer_queued(user_data);
+
 	if (obex_option_auto_accept()) {
 		folder = g_strdup(obex_option_root_folder());
 		name = g_strdup(obex_get_name(os));
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 683dd4ca0..89b3d04fd 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -528,7 +528,7 @@ void manager_emit_transfer_property(struct obex_transfer *transfer,
 	if (transfer->path == NULL)
 		return;
 
-	if (strcasecmp("Size", name) == 0)
+	if (strcasecmp("Size", name) == 0 || strcasecmp("Status", name) == 0)
 		g_dbus_emit_property_changed_full(connection, transfer->path,
 					TRANSFER_INTERFACE, name,
 					G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH);
@@ -537,6 +537,13 @@ void manager_emit_transfer_property(struct obex_transfer *transfer,
 						TRANSFER_INTERFACE, name);
 }
 
+void manager_emit_transfer_queued(struct obex_transfer *transfer)
+{
+	transfer->status = TRANSFER_STATUS_QUEUED;
+
+	manager_emit_transfer_property(transfer, "Status");
+}
+
 void manager_emit_transfer_started(struct obex_transfer *transfer)
 {
 	transfer->status = TRANSFER_STATUS_ACTIVE;
diff --git a/obexd/src/manager.h b/obexd/src/manager.h
index 8fa12d15d..76869e3c8 100644
--- a/obexd/src/manager.h
+++ b/obexd/src/manager.h
@@ -22,6 +22,7 @@ struct obex_transfer *manager_register_transfer(struct obex_session *os);
 void manager_unregister_transfer(struct obex_transfer *transfer);
 void manager_emit_transfer_property(struct obex_transfer *transfer,
 								char *name);
+void manager_emit_transfer_queued(struct obex_transfer *transfer);
 void manager_emit_transfer_started(struct obex_transfer *transfer);
 void manager_emit_transfer_progress(struct obex_transfer *transfer);
 void manager_emit_transfer_completed(struct obex_transfer *transfer);
-- 
2.34.1


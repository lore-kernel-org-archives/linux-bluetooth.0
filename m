Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148361420A8
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719560910; cv=none; b=h6cpHc30Q0QNt4Z7MH4ObnaoQ7GsXNDY5wEv3SI3gR7OzE1jRGWZekLKpB2X/34LAagkb+HJjj6RepyjOGaxzjbJOKOICQ20BmTMiXaXZV8n5uHxAJyokZr/4reH3TU51iobExwkmZNj/yUwIEq8N3B1A7xKrTbwi9pNDCwIlr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719560910; c=relaxed/simple;
	bh=+i3gqne2mi/6lu6jUTxae/9ibE3KYRLolVZdMO5A6CU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IkVNb9TGHIidxVkQz1KEO7DJykTGw+CrvP9BcXAJacFGkXLBIpfbTO5ujFEQCsErj9ZDeiDnCFmehBybpkpRI/yhyOVqdZ+fizIspYXR5pYHNgOFwgH47QN+oo7g8ltnw0QePWNycpl32gF4rkyHPHx5PqLVcD0MFgq/EuLs/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.99.27) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 28 Jun
 2024 10:48:02 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] core: add NULL check to adapter_service_remove()
Date: Fri, 28 Jun 2024 10:47:49 +0300
Message-ID: <20240628074750.35992-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/28/2024 07:32:36
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186203 [Jun 28 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 84.18.99.27
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/28/2024 07:36:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/28/2024 4:47:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Make adapter_service_remove() safe for passing NULL pointers.
---
 src/adapter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index bdc5bf920..57e4dcd54 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1349,6 +1349,10 @@ int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec)
 void adapter_service_remove(struct btd_adapter *adapter, uint32_t handle)
 {
 	sdp_record_t *rec;
+	
+	if (!adapter)
+		return;
+
 	/*
 	 * If the controller does not support BR/EDR operation,
 	 * there is no point in trying to remote SDP records.
-- 
2.43.0


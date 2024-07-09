Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74F12DDAE
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526471; cv=none; b=ObpfX2UcL5qZaw99AO4+c0iaXI2uuPcz+XdHpFyksytOKAgEF5A1aVIWXKAESZ0mtm+GqgZY2rhDF8euMLpmfI9swa14SUyFOrW2mmFMq9JZOBRlbtANfbSIbuglZG7LjDytyKVfjFCEu80cRHTpLOjeCyi0s8HsE1eOQUKbcj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526471; c=relaxed/simple;
	bh=BxTqc23dd9AxaGRRDjAg7mSLLYhEMPj5nK7humNnF4c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S8N8V/F7wYJSPzmGiWHMsmSMIiKlB3ieK6fTWWCkJs7t2DpHVDyU0Iy4ZYvMu2uNSpCnO4VXpkinDTjmCaWbdJnmSKPU5OTZXOIqlYXynOnAMmzPifxjuXDLWATxNuR1YcTzkSPpqDEu8I84F2bhvUpHiVIeZYBTNJrrmYh+lTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 9 Jul
 2024 15:00:47 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1 0/4] fix errors found by SVACE static analyzer #3 
Date: Tue, 9 Jul 2024 15:00:27 +0300
Message-ID: <20240709120031.105038-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
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
X-KSE-Antiphishing-Bases: 07/09/2024 11:49:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/9/2024 11:26:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Several bug fixes.

Roman Smirnov (4):
  health: mcap: add checks for NULL mcap_notify_error()
  shared: prevent dereferencing of NULL pointers
  settings: limit the string size in load_service()
  settings: limit the number of chars to be read in gatt_db_load()

 profiles/health/mcap.c |  9 +++++++
 src/settings.c         | 58 +++++++++++++++++++++++++++++++++++++++---
 src/shared/micp.c      |  4 +++
 src/shared/vcp.c       | 12 +++++++++
 4 files changed, 80 insertions(+), 3 deletions(-)

-- 
2.34.1


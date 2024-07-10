Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2294190063
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611146; cv=none; b=o928R3DXpqkyJKdqykpW3o4xH7DXlJ93XoCzYyPaQGdiS8naJn8lmh+iB25hJMFmC3626Ez5VOTNkYHpAazHd5rcnxkQpJqulfUTfamqLM9xE4J7Cv5yEDwEAn+EFPgoeenpSBgzsoCIjAEbt6em6mxsT0nm8XxfdiSxTZiztx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611146; c=relaxed/simple;
	bh=sUhQVvcXqSwK0YiwA3n/uUvDHhcI8tK6O/8/hTrFHgM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jIVR18Cf7D0+X5g6xz0/XM5o8IALYVcPPyPiXEXdXX0/kj244U+MTCFjUDrWrMQKymv8xTirzVX3KT7dWircyC57Zh1rvTAawJSA7V/IzBrgzPIJYXBfWQxE3PHXdFRdu4bDLdip3MNs5Su7EFApYjj0fGLqySlCeT/SAB+Lo5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (178.205.55.202) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 10 Jul
 2024 14:32:11 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v2 resend 0/6] fix errors found by SVACE static analyzer #1
Date: Wed, 10 Jul 2024 14:31:43 +0300
Message-ID: <20240710113151.49296-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/10/2024 11:06:53
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186423 [Jul 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.205.55.202 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.205.55.202
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/10/2024 11:10:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/10/2024 9:01:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Several bug fixes.

Previous emails:
https://lore.kernel.org/linux-bluetooth/20240702085508.30513-1-r.smirnov@omp.ru/
https://lore.kernel.org/linux-bluetooth/20240702134106.102024-1-r.smirnov@omp.ru/
https://lore.kernel.org/linux-bluetooth/20240704090756.31351-1-r.smirnov@omp.ru/
https://lore.kernel.org/linux-bluetooth/20240704104928.43336-1-r.smirnov@omp.ru/

Roman Smirnov (6):
  gatt: add return value check of io_get_fd() to sock_io_send()
  shared/vcp: add NULL checks to foreach_aics_service()
  client/player: add error code handling to transport_recv()
  shared/vcp: prevent dereferencing of NULL pointers
  client/player: fix the order of args in cmd_register_endpoint()
  shared/gatt-client: add NULL check to discover_secondary_cb()

 client/player.c          | 10 ++++++++--
 src/gatt-database.c      |  9 ++++++++-
 src/shared/gatt-client.c |  4 +++-
 src/shared/vcp.c         | 23 +++++++----------------
 4 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.43.0


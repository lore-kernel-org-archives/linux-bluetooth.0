Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812E19149A
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621017; cv=none; b=EzxD8tLfDCmrMk/kuXOsjW6rmXf4PZ18l3/u86vKKC4xR6tW+nJ5ndKE45LTcMaA0ooo4o3s/rv5gqiwUNKT1G/7/UvpQ1ZMhCA9iy5FRDah6rW+HsquLtt6qYScn8FVc4S3mm9m8UDNnAwmObgggMY7ALYvdhoDPhlDqP0MTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621017; c=relaxed/simple;
	bh=zxlw8uCu3CW7c36o4nAO05DfYZJ29Nh21cGHVD8LWSM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KStjLptRcV48snT4fOovlB6G0LWxkifxpo+7ijjgnYBcOY8HV3lueN4LxhRh3IapychaJBmGXiy86gvs0GmRgKRNPdbBsL+HkfFuob949jw2BrA10p4Iz7AyIhaop0eNnsJBxvkdUPDd0w+4NRsUupfZohvtmb+GUoqJH85c934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (178.205.55.202) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 10 Jul
 2024 17:16:35 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v3 resend 0/6] fix errors found by SVACE static analyzer #1
Date: Wed, 10 Jul 2024 17:16:13 +0300
Message-ID: <20240710141621.64394-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/10/2024 13:54:49
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186438 [Jul 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;lore.kernel.org:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.205.55.202
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/10/2024 14:00:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/10/2024 12:34:00 PM
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
  gatt: add a check to sock_io_send()
  shared/vcp: add NULL checks to foreach_aics_service()
  client/player: add error code handling to transport_recv()
  shared/vcp: prevent dereferencing of NULL pointers
  player: fix the order of args in cmd_register_endpoint()
  gatt-client: add NULL check to discover_secondary_cb()

 client/player.c          | 10 ++++++++--
 src/gatt-database.c      |  9 ++++++++-
 src/shared/gatt-client.c |  4 +++-
 src/shared/vcp.c         | 23 +++++++----------------
 4 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.43.0


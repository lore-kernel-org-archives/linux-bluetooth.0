Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE912D8768
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973068; cv=none; b=r/dMmROlYp2xd4Hmv1lPWlPcu4AptrRcdLl/Q/HTAVSchiqthaXFd2h38Kq0NndFaPKkTd3KAzC4oMHH7COnNEQO5L7Rf0kwAlS58NN5p09/UXdHeRvFy8EcUOSr8fFe0vQJ6tNp7vra1DiU/rE6ofTAVqchjCaJ3PDb+H/xQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973068; c=relaxed/simple;
	bh=NAYzXTdDF0p0UwoHvquyzBPrRz0DmF1LFqpcvorphPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S7o3j8QE5qFuED8kYgcdvs+ZHXkKufJK6PSp5T9YoAZ0k3WEuHqtPKC1xUWNJoaT3BGTFz8MlG6nqq9NSRtR2nXP0iDWs416EaxxXxljeM+elga2YkHg7UOi/SI1I+1otpnIP/MYKvH1PvvSkxlTeLi81l1PO5x7aMsomAJDX+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst013.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 8 Jul
 2025 14:10:52 +0300
From: Ismagil Iskakov <i.iskakov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Ismagil Iskakov <i.iskakov@omp.ru>
Subject: [PATCH BlueZ v2 00/11] Fix bugs found by static analysis
Date: Tue, 8 Jul 2025 14:08:58 +0300
Message-ID: <20250708110909.2626286-1-i.iskakov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/08/2025 10:58:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194611 [Jul 08 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: i.iskakov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 63 0.3.63
 9cc2b4b18bf16653fda093d2c494e542ac094a39
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;inp1wst013.omp.ru:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1;81.22.207.138:7.1.2
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
X-KSE-Antiphishing-Bases: 07/08/2025 10:59:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/8/2025 7:58:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

This patch corrects some of the bugs not connected
to the functionality but to memory management etc.
Two exceptions being about fixing the arguments
order, which also could've caused some trouble.

Ismagil Iskakov (11):
  btio: fix range validation of security level
  profiles/audio: add nullity checks
  src/shared: add nullity checks
  isotest: close fd after sending when nconn=1
  obexd/client: fix err condition causing memleak
  profiles/audio: fix memleak of bt_bap
  src/shared: fix memleak
  src/shared: move null checks before dereferencing
  isotest: remove repeating conditions
  profiles/audio: fix io_unlink args order
  src/plugin: fix args order

 btio/btio.c                |  2 +-
 obexd/client/transfer.c    |  2 +-
 profiles/audio/a2dp.c      | 45 +++++++++++++++++++++++++++++---------
 profiles/audio/avrcp.c     | 24 +++++++++++++++++---
 profiles/audio/bap.c       | 24 +++++++++++---------
 profiles/audio/bass.c      |  7 +++++-
 profiles/audio/transport.c |  2 +-
 src/plugin.c               |  2 +-
 src/shared/bap.c           | 40 ++++++++++++++++++++++++++++-----
 src/shared/gatt-db.c       |  5 ++++-
 src/shared/vcp.c           |  3 +++
 tools/isotest.c            |  8 ++++---
 12 files changed, 126 insertions(+), 38 deletions(-)

-- 
2.34.1


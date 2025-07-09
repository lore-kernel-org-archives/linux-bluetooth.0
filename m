Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE852DA76A
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752063654; cv=none; b=E5WG4/1/8INGacq9LeEiTANAhd25TF1y+Z0V0wTEyCDVWk82PDVwRE2/rSvD6UtZH3gAcXcCFSAuSw559rDwNe7AeDJj3vGXE6Ogj+Q52gnxGhH8qy8I2McP2y8ghrIAUtPVnYV5dLOfLX3y7A7WDLK8kACMwWO8Gx4kLUetCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752063654; c=relaxed/simple;
	bh=lSyqDSxwAxQrFBNhzNWGYYME90KU9v0bgcph5wgGPds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lQ/Z9wgZKc3HvNevNq4qCEYaEKZzJBZl72Lz6Sh/fbwAR17zRcmNTuJNLZPIcyfCvzX9OpuKADcOn7qFm5yeJnhJy9t/komni2vgdDcHTYQrWuLXGiOEbG44/j8l7WALjB21+pjqXca+1ebHuvB8yLdyGZ0LiTl9nIAuHl7nzD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst013.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 9 Jul
 2025 15:20:34 +0300
From: Ismagil Iskakov <i.iskakov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Ismagil Iskakov <i.iskakov@omp.ru>
Subject: [PATCH BlueZ v3 0/4] Fix bugs found by static analysis
Date: Wed, 9 Jul 2025 15:18:48 +0300
Message-ID: <20250709121852.2811885-1-i.iskakov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/09/2025 12:13:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194672 [Jul 09 2025]
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
X-KSE-AntiSpam-Info:
	inp1wst013.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.22.207.138:7.1.2;127.0.0.199:7.1.2;omp.ru:7.1.1
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
X-KSE-Antiphishing-Bases: 07/09/2025 12:15:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/9/2025 11:17:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

btio: fix range validation of security level
Expression is used as an index for accessing
an array's element in function 'l2cap_set_lm'.
This expression can have value 4, which is out
of range, as indicated by a preceding
conditional expression.

profiles/audio: add nullity checks
Return value of a function 'btd_device_get_service'
is dereferenced without checking for NULL, but it
is usually checked for this function (28/35).
Return value of a function 'queue_find' is
dereferenced without checking for NULL, but it
is usually checked for this function (182/183).

src/shared: add nullity checks
Return value of a function 'util_iov_pull_mem'
is dereferenced without checking for NULL, but it
is usually checked for this function (64/80).
Return value of a function 'vcp_get_vcs' is
dereferenced without checking for NULL, but it is
usually checked for this function (4/5).

obexd/client: fix err condition causing memleak
Dynamic memory, referenced by 'err', is allocated
by calling function 'obc_transfer_get' and lost
at bip.c:139.

Ismagil Iskakov (4):
  btio: fix range validation of security level
  profiles/audio: add nullity checks
  src/shared: add nullity checks
  obexd/client: fix err condition causing memleak

 btio/btio.c             |  6 ++++++
 obexd/client/transfer.c |  2 +-
 profiles/audio/a2dp.c   | 35 +++++++++++++++++++++++++----------
 profiles/audio/avrcp.c  | 24 +++++++++++++++++++++---
 profiles/audio/bass.c   |  3 +++
 src/shared/bap.c        | 23 +++++++++++++++++++++++
 src/shared/vcp.c        |  3 +++
 7 files changed, 82 insertions(+), 14 deletions(-)

-- 
2.34.1


Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99DC13D255
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166300; cv=none; b=uSvibrKveUPlmqfiMIcnh9/jZh+rZyH5R5ZyiQU2pQU6WFSSHheXFPZITKwE0fcVoUOgaJ37za6t6E8tat+/bgk5iC1mr2X1W0wVQjGOzcVLgPsbHxNIsfanOI3CjixdTpJbQrnyFkgEAaniHfCTaqoH5VQpMrKpVhnPo+EAr5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166300; c=relaxed/simple;
	bh=wVRI0gFVv4nu17bAi7JQiPkl5ngp/fkV/rWRAGRz4yg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gULRHxjjKKxfwJ5OwxEgpjrWlOvjvd+ixQK3HHodoZX0FZnIlB1UsdyWBJnK/g4nt0KhmSHabsSikkXKly+S6exCVPbZAby7M2aWEAAxaQsDot9fhfCN9Yer09MDbbbkajgex8dppRD9qDXFRd/LEsHVGQ9QGLQt7O4y/Na0SdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.187.157) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 5 Jul
 2024 10:57:57 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v2 0/5] fix error found by SVACE static analyzer #2
Date: Fri, 5 Jul 2024 10:57:02 +0300
Message-ID: <20240705075709.26809-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/05/2024 07:27:52
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186342 [Jul 05 2024]
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
	217.23.187.157:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
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
X-KSE-Antiphishing-Bases: 07/05/2024 07:32:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/5/2024 4:11:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Several bug fixes.

Roman Smirnov (5):
  obexd: add NULL checks to file_stat_line()
  shared/shell: prevent integer overflow in bt_shell_init()
  tools/isotest: limit the maximum possible data_size
  tools/rctest: limit the maximum possible data_size
  settings: add NULL checks to gatt_db_load()

 obexd/plugins/filesystem.c | 14 +++++++++++---
 src/settings.c             |  4 ++--
 src/shared/shell.c         |  2 +-
 tools/isotest.c            |  4 +++-
 tools/rctest.c             |  5 ++++-
 5 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.43.0


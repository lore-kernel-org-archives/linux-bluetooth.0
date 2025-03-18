Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E60020CCEB
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303713; cv=none; b=KefpjpOwvKzIZInlNXVX+k2TgaGy89rCxSX394s4Ev/JlqoI8+zyLuavPXNxotDuaiP80GqZJBpJ62OwDVZ0mFB+EgoYzoUrJzFU0kLbHNl6V+DjIPwcHyruHDI6T5+srVBmuL0DeXg5C9WfKuK8wfUWT3Yr/wJ+r+IKIhYKGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303713; c=relaxed/simple;
	bh=kS4Lqc+8Bz9vUdHBXg/NkfCFJCnEZfo9YXqJnrDsyJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CN5QNttopx94fjykxo90pmQMM1o9UXiwKiYvRtCby+VJEhixEThVPhYwia7ZuNrCnOh3IligIKjfxzEpwAwtUOPzQnLqDvHcvOBYP/4KVOt0+q8dHEit8RzS6uRk83s91R2QGTiDszCwEghHw9l/0eErAD1MOAHtvlhgKJMalvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 18 Mar
 2025 16:14:47 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ 0/3] Fix crash in dbus caused by Unicode characters
Date: Tue, 18 Mar 2025 16:14:28 +0300
Message-ID: <20250318131431.124750-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 03/18/2025 12:50:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 191886 [Mar 18 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;inp1wst083.omp.ru:7.1.1;81.22.207.138:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
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
X-KSE-Antiphishing-Bases: 03/18/2025 12:54:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/18/2025 10:14:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

A crash was found during fuzzing testing:

dbus[5324]: arguments to dbus_message_iter_append_basic() were
incorrect, assertion "_dbus_check_is_valid_utf8 (*string_p)"
failed in file .../dbus-message.c line 2765.

Fix it with additional checks.

Roman Smirnov (3):
  shared/util: implement argsisutf8()
  client: replace validate_input() with argsisutf8()
  shared/shell: add check to shell_exec()

 client/main.c      | 17 ++---------------
 src/shared/shell.c |  3 +++
 src/shared/util.c  | 12 ++++++++++++
 src/shared/util.h  |  1 +
 4 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.34.1


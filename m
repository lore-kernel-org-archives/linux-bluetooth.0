Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE136AB50
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044668; cv=none; b=MDE1rswUKON2h1H/4U0rUk+qW+NsvBTUrlUC+5MeZDnHoYEz9D4ZQVJxcG/Ixq8CiCBfi7BbD5axSa7EpefAUnMu6PNMd5VyUol2Bzlp3gsyckQqcb9Eq2n+bxI/k3WZY2xbkopDRFvh9+tfaNL34u6GY/YxxYP5/dlqoIUo5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044668; c=relaxed/simple;
	bh=SsxG5jOziG5zKk3uRtHOb9MQmv12CLo2hp3sro32D7E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yroafy7g7GS62Oe5ndvsff+YhDX5sPbFN2x01MwUIE0LGzt/NAWUKnIjnCWDd/aFtV3OKabOPcGQ/an1CFdugt0DAaSAQj/FKc8frMGGoLXy3WG+WRardnS241z4b9eh5fPskrD97T24r3iBjMqsAwQHTdGE248RJn8+PMIWeko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from sambura-Nitro-AN515-43.omp.ru (95.26.77.187) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 1 Apr
 2026 14:42:19 +0300
From: Kirill Samburskiy <k.samburskiy@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Kirill Samburskiy <k.samburskiy@omp.ru>
Subject: [PATCH BlueZ 0/1] Fix unsolicited AVRCP RegisterNotification response
Date: Wed, 1 Apr 2026 14:42:01 +0300
Message-ID: <20260401114202.625377-1-k.samburskiy@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 04/01/2026 10:09:51
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 201856 [Apr 01 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: k.samburskiy@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 96 0.3.96
 f0df504111d78c4fb91ce829559989c2d1ddd192
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {date_rfc_vio_soft_silent}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {Tracking_repetitive_subdir_in_url}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 95.26.77.187 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 95.26.77.187 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	github.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 95.26.77.187
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/01/2026 10:12:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/1/2026 9:10:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Issue details: https://github.com/bluez/bluez/issues/1997

This patch separates registered_events and transaction_events tracking for
target and controller AVRCP roles.

Notes:
Technically registered_events is never read for controller role, thus writing
to it could be removed. However transaction_events is still required for both
TG and CT roles.

I have included null check for session->target in 
avrcp_handle_register_notification function, however it technically should
never fail since supported_events is initialized to non-zero value only after
session->target is assigned in target_init function. So if supported_events
has the corresponding event bit that should automatically mean that
session->target is non-null.

Kirill Samburskiy (1):
  audio/avrcp: Track TG and CT events separately

 profiles/audio/avrcp.c | 48 ++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

-- 
2.34.1


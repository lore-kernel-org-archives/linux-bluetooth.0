Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D992840DFBE
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775217851; cv=none; b=KINhk1RjjlkUty4ony+BUkfkmZ+yye25E99uBifziZDh446ZZYYrv9TduaRaL3YC8GHWykW8tk4wq2dG1LE4Kn++DH5ICe4wEI2e+lj+Ae0lhYiwULKb20McDwbdplM1F62Vpb2V/6XZ+Je8QRMKVr3lYOKK4O80ZmXtmQv3+Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775217851; c=relaxed/simple;
	bh=rifaurehYUdICPJTK0fSNhnwGUeNSIsYZgmN2da2TwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=smIqMZhwxauA47HnPrOHAjVeATKO696TN5xOmawjRzzHwncEwq07o74TA95ajvziAOehHp8fdEZhJjFNqPoue+kIZrlozoMyyTjHw/F4694l1+BwPBIkg8yJxGiE+P83ZA9YnxmvwGbGWGWAjH0xFCgUsd/nLpbeu1O4TSYCYU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from sambura-Nitro-AN515-43.omp.ru (95.26.77.187) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 3 Apr
 2026 15:03:50 +0300
From: Kirill Samburskiy <k.samburskiy@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Kirill Samburskiy <k.samburskiy@omp.ru>
Subject: [PATCH BlueZ v2 0/1] Fix unsolicited AVRCP RegisterNotification response
Date: Fri, 3 Apr 2026 15:03:38 +0300
Message-ID: <20260403120339.873320-1-k.samburskiy@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 04/03/2026 11:52:10
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 201953 [Apr 03 2026]
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
X-KSE-AntiSpam-Info:
	github.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
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
X-KSE-Antiphishing-Bases: 04/03/2026 11:54:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/3/2026 10:45:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Issue details: https://github.com/bluez/bluez/issues/1997

This patch separates registered_events and transaction_events tracking for
target and controller AVRCP roles.

Changes:
  v2: fix coding style

Kirill Samburskiy (1):
  audio/avrcp: Track TG and CT events separately

 profiles/audio/avrcp.c | 51 +++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 18 deletions(-)

-- 
2.34.1


Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185DE197A68
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Aug 2024 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220600; cv=none; b=c9WlYvwtKv4W5WToZ2qgiYL4zWX7C3gBo3pbBhEyfIqyCYXdRxUXnN6RfFGavMqeo0ZaWRfV+FWkKpcVZ2Dke8shJmaXc1VNxscik+jqM454/CHOv0B+aH3TtVglbwhYWC2fPP9o3YV+iCOuj+KRb4tfJXltD2BKschOTTQIAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220600; c=relaxed/simple;
	bh=eeo9rWPh1B1JgbhLChe12IlOgwXRninNCC6Ag3uBhL4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Px1AlnhZvCuA6MPQOtiEFqqubwK45i1nmuBLI+2mtkSOvTWxdIxqlP55qlnL6lQSg9xOGWaNOBse0FXGkbuBZBFAHwd86LPnYzPfqDbinYYTueszEkioWtUG6urD0re96dl8TXfQjXAwJPjkI2AUw6V92xg9/xktyHgaZtF7A9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.186.16) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 9 Aug
 2024 19:23:06 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1 0/3] fix errors found by SVACE static analyzer #4
Date: Fri, 9 Aug 2024 19:22:26 +0300
Message-ID: <20240809162252.50098-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/09/2024 16:04:17
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186979 [Aug 09 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 217.23.186.16
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/09/2024 16:08:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/9/2024 2:06:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Several bug fixes.

Roman Smirnov (3):
  tools/rctest: add NULL checks to main()
  android/avctp: remove check in session_browsing_cb()
  android/avdtp: fix leak in avdtp_new()

 android/avctp.c |  6 ++----
 android/avdtp.c |  4 +++-
 tools/rctest.c  | 30 +++++++++++++++++++++++-------
 3 files changed, 28 insertions(+), 12 deletions(-)

-- 
2.43.0


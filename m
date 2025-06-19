Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE9230BFD
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347263; cv=none; b=N5obbd76r+WM10BhhHAzueD5J4q2y91huk/ehMHcYdCGXS2Ui8hf+9IMgtU9Vi9BH+ngw4W07H7m0V7YQMY05YOJTZyr5KvsKoBm38N05r7rSt2EcletThBsAlUiSwfZW+id711O4GkwVCVXmdyhgKmFzckr2tiGHr8puFhuxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347263; c=relaxed/simple;
	bh=+wB3mXazRwxh93cu2+h2Ug19A0RZPhgs12DSwXZTxG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRnRWLg2DFNE6uVmEVk87ezUUv0TbPaAtU3UqFECmn3i46y96NYjQdOgpyoSsmF/Fab2SZa5i6JrzsOeoP+MwGFoqL/tLJ6vKoJURvgfNG0Rg0hUctkvDXKfghAfdK+ho4ppi5CG1TVIfpjbb+qZmhY0q/4vzqbN0Yf+T90/wp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst087.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 19 Jun
 2025 18:34:11 +0300
From: Kirill Samburskiy <k.samburskiy@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Kirill Samburskiy <k.samburskiy@omp.ru>
Subject: [PATCH BlueZ 1/2] shared/tester: add ability to shutdown tester IO
Date: Thu, 19 Jun 2025 18:31:19 +0300
Message-ID: <20250619153120.126315-2-k.samburskiy@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619153120.126315-1-k.samburskiy@omp.ru>
References: <20250619153120.126315-1-k.samburskiy@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 06/19/2025 15:18:50
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194208 [Jun 19 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: k.samburskiy@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 62 0.3.62
 e2af3448995f5f8a7fe71abf21bb23519d0f38c3
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;81.22.207.138:7.1.2;inp1wst087.omp.ru:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
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
X-KSE-Antiphishing-Bases: 06/19/2025 15:21:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/19/2025 5:52:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Some tests may require the ability to shutdown IO for proper teardown.
Add function tester_shutdown_io to accomplish that.
---
 src/shared/tester.c | 6 ++++++
 src/shared/tester.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 371ccaced..230e9ef75 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -1047,6 +1047,12 @@ struct io *tester_setup_io(const struct iovec *iov, int iovcnt)
 	return ios[0];
 }
 
+void tester_shutdown_io(void)
+{
+	io_shutdown(ios[0]);
+	io_shutdown(ios[1]);
+}
+
 void tester_io_send(void)
 {
 	struct test_case *test = tester_get_test();
diff --git a/src/shared/tester.h b/src/shared/tester.h
index 1f8138434..dfc1ca3a8 100644
--- a/src/shared/tester.h
+++ b/src/shared/tester.h
@@ -81,5 +81,6 @@ void tester_wait(unsigned int seconds, tester_wait_func_t func,
 							void *user_data);
 
 struct io *tester_setup_io(const struct iovec *iov, int iovcnt);
+void tester_shutdown_io(void);
 void tester_io_send(void);
 void tester_io_set_complete_func(tester_data_func_t func);
-- 
2.34.1


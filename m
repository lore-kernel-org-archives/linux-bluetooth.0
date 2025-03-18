Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094220CCF3
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303726; cv=none; b=pqdGZdfEVH+Z9Z4agHFiBattgmvDXc83dPIyqYTrERGaT7RJvWPz3Dwe7vq0dXKA3mDECRquKGGopWi1G/maTEUwPWpa9OIUaAWcPcydCLHgrjEcATPlUmxNEzH4TcOLBJ+Nb5yZM5Nmdtm//1Jg6+gJHBApRPOJVnkftNmpnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303726; c=relaxed/simple;
	bh=zWaIUoc0LRxa3ZdDB55TsSxYML2e6xY6JJRU5l1XLAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQjC2RNhNKjbAUIYthz83GSIepd1AUtKWVX+K7LEENsBNSRmfsmk+B+HEfUGQjou6d8GUDVlIOWbSPQ5A7ExC7sh+3gbE3V9aQRyaQ7OOocy6NAwoPHAnCgjoEETb+QuZE5SiMAZq/rfUkYU9ZPkWh4dvi/DvAuwF0pXiLOKs7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 18 Mar
 2025 16:14:57 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ 1/3] shared/util: implement argsisutf8()
Date: Tue, 18 Mar 2025 16:14:29 +0300
Message-ID: <20250318131431.124750-2-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318131431.124750-1-r.smirnov@omp.ru>
References: <20250318131431.124750-1-r.smirnov@omp.ru>
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
	127.0.0.199:7.1.2;81.22.207.138:7.1.2;inp1wst083.omp.ru:7.1.1;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
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

This implements argsisutf8() which checks that all strings in the
argv array are written in utf8.
---
 src/shared/util.c | 12 ++++++++++++
 src/shared/util.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 6e7634ad1..5d3a14d96 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1947,3 +1947,15 @@ bool strisutf8(const char *str, size_t len)
 
 	return true;
 }
+
+bool argsisutf8(int argc, char *argv[])
+{
+	for (int i = 0; i < argc; i++) {
+		if (!strisutf8(argv[i], strlen(argv[i]))) {
+			printf("Invalid character in string: %s\n", argv[i]);
+			return false;
+		}
+	}
+
+	return true;
+}
diff --git a/src/shared/util.h b/src/shared/util.h
index f2ca4f29f..dd357fb93 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -91,6 +91,7 @@ char *strdelimit(char *str, char *del, char c);
 int strsuffix(const char *str, const char *suffix);
 char *strstrip(char *str);
 bool strisutf8(const char *str, size_t length);
+bool argsisutf8(int argc, char *argv[]);
 
 void *util_malloc(size_t size);
 void *util_memdup(const void *src, size_t size);
-- 
2.34.1


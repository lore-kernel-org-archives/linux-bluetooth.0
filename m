Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D82248BE
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960176; cv=none; b=rEDEHUksAhqLOGiKooZ3sfMa5Gi7/lisC6k0CtiRukX47JI78KiIpX36iQ2Ji8jHfEXYt526anKTqXm8wFT3+Xq05iHvVEIDncPk65LdaSYX15csw3CLa4VXhcTKRmI+vFX78ccy5KyHYukAxrkMRgcLUb9Sx2R95Z9Tf3YrPJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960176; c=relaxed/simple;
	bh=89EJNSYHJ4I0dqx3cOpLPxjtutfhO7Cu1A8nNGLOq80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLgqH6AV1N/lxbD7oZ2u2EWETFxgyKt7Up8ySKi4wf7xdhNA1Hnbyey4cXM6yBr6q5vr4G3u2NSZgKr+93iT1LytMFnpuRd/X3tGu6rg/f4kFUDTxd1HX80quupfRfD7loQ7lzjFa7mwrTO72GVN3lm+iPL4EyshsVxBVvLNmFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst013.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 8 Jul
 2025 10:36:04 +0300
From: Ismagil Iskakov <i.iskakov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Ismagil Iskakov <i.iskakov@omp.ru>
Subject: [PATCH BlueZ 09/11] isotest: remove repeating conditions
Date: Tue, 8 Jul 2025 10:33:32 +0300
Message-ID: <20250708073334.2393559-10-i.iskakov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708073334.2393559-1-i.iskakov@omp.ru>
References: <20250708073334.2393559-1-i.iskakov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/08/2025 07:11:13
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 194600 [Jul 08 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: i.iskakov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 63 0.3.63
 9cc2b4b18bf16653fda093d2c494e542ac094a39
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	inp1wst013.omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;81.22.207.138:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/08/2025 07:12:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/8/2025 5:27:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

---
 tools/isotest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index 0ced19a9e..924876d35 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -684,9 +684,9 @@ static void recv_mode(int fd, int sk, char *peer)
 
 			r = recv(sk, buf, data_size, 0);
 			if (r < 0) {
-				if (r < 0)
-					syslog(LOG_ERR, "Read failed: %s (%d)",
-							strerror(errno), errno);
+				syslog(LOG_ERR, "Read failed: %s (%d)",
+						strerror(errno), errno);
+
 				if (errno != ENOTCONN)
 					return;
 
-- 
2.34.1


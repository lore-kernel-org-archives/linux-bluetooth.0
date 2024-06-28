Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81793558B9
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561077; cv=none; b=CIpE2/RSCV+VEF8mIYjhaTXxMw8sxxc6LhUC51MdxCJU2VlaeSdqLQD/6cSdn0+KqrmpiAhiMtanKbulHVSZVTw0v5OIf+XSGlBtgyabmYuMiAfo9poRi7lq81TFVFeeFKWY/ElmqRBW+LIUtviGj/XcH8qtbKJ04ScHZv9DVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561077; c=relaxed/simple;
	bh=JlvjrKiEQ2VRX9WOHomYbPO+muZTeRMCkCZN/NXAk+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sYAyJoqjwJi+gfLUZVcU3biQVQc/0Q1//YzU9iDSh8ASjqjCksD4nYkXGM19Tv7VSqVmhamCbAi3W6dhhP+oEoGCA4kVCJO52GgGKg3p5S+S/q5zmThXhQ5E9i7CoQcnRmC0ggmRPhattGK+wTzx/Ql8Q97eIhB7B17P0CbRO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.99.27) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 28 Jun
 2024 10:35:57 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] bass: add NULL check to bass_bcast_src_free()
Date: Fri, 28 Jun 2024 10:35:41 +0300
Message-ID: <20240628073542.20896-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/28/2024 07:22:03
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186203 [Jun 28 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 84.18.99.27
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/28/2024 07:25:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/28/2024 4:47:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Make bass_bcast_src_free() safe for passing NULL pointers.
---
 src/shared/bass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index c30537dee..d82c043ac 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1272,6 +1272,9 @@ static void bass_bcast_src_free(void *data)
 {
 	struct bt_bcast_src *bcast_src = data;
 
+	if (!bcast_src)
+		return;
+
 	for (int i = 0; i < bcast_src->num_subgroups; i++)
 		free(bcast_src->subgroup_data[i].meta);
 
-- 
2.43.0


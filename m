Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E484D39
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910180; cv=none; b=GFizRuzeJe0WRGlyvN6BjsdAByHHSY7yD9hCt3sz+Ls2vqH+7y1ZgY1MgJ9dN3DT+92Q2MlQK22HL7plPDA8H6tGDXJVFduEIytIWWR5Mke2YuaKRNqVkg1ILUK8S3e1mF+vNwOob6MUIXaCCpvC1N+c2CRA8hkNuHYhK/a0FZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910180; c=relaxed/simple;
	bh=yxHJAxI1xcuUjnH3XbuP0imHf7olPqOYYY4oMSVlroQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pzC7LjhRcW30Gz2OlhM4WQrL2xlBmtfMCACLXQsh7i1xmWp9Eapdz8YI+eKIEcnB99TcaRoLZLmRZCtoPM7dZCLoJLOwuN/ZOMNvE2StvFa6NVNpKHpiMqz82WHYxcuKNq6yO5kZV+jf80lQsOEhfTmoKY9+XEJE4YV29A1Qn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 2 Jul
 2024 11:49:25 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] shared/vcp: add NULL checks to foreach_vocs_service()
Date: Tue, 2 Jul 2024 11:49:07 +0300
Message-ID: <20240702084907.26066-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/02/2024 08:30:59
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 186271 [Jul 02 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 21 0.3.21
 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;inp1wst083.omp.ru:7.1.1;omp.ru:7.1.1;81.22.207.138:7.1.2
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
X-KSE-Antiphishing-Bases: 07/02/2024 08:34:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/2/2024 7:20:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Make foreach_vocs_service() safe for passing NULL pointers.

Found with the SVACE static analysis tool.
---
 src/shared/vcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index b7e17e448..06264a241 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -2701,6 +2701,9 @@ static void foreach_vocs_service(struct gatt_db_attribute *attr,
 	struct bt_vcp *vcp = user_data;
 	struct bt_vocs *vocs = vcp_get_vocs(vcp);
 
+	if (!vocs || !attr)
+		return;
+
 	vocs->service = attr;
 
 	gatt_db_service_set_claimed(attr, true);
-- 
2.34.1


Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5E13D88C
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998628; cv=none; b=TQPJq8mvSMlc3gEaKiCQcUuQ5oUL+IbxTyatw7jGkRUNZ7WtS5A3zgR1/MQqZ8NxB1wNSxVBsuO1dsmAzyK849w7kAAmKfRxULcftyMymPEX1f5gnETCCkieD/keH1o4aUzR2QIOfg2Lrarz8AT3OljZYoE8YsaHpn1/zU3GDPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998628; c=relaxed/simple;
	bh=de1/xUbv0RTOuFbeW3qO2uPAtPqMRsKt3Ldqi5H2gUU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTQUhqAyCbO/cPiCYKIPasGMlHnVItLpmIsJ+gWCI8F2NYu+31laOiBEkWuR14HR+KSPXCv9Gp5NxLUbnf9KC8QL5/TQnDlDLvcWYcPzEoyeKRHOJ894luCP+uKbUki88ZcEqj5LsDn1sXpb9SkNO3wmfRsX0PwSV3xXAEj+FtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (217.23.187.157) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 3 Jul
 2024 12:23:35 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH BlueZ v1] shared/bap: move checks for NULL before dereferencing
Date: Wed, 3 Jul 2024 12:23:22 +0300
Message-ID: <20240703092322.16659-1-r.smirnov@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 07/03/2024 08:57:23
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 186300 [Jul 03 2024]
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
X-KSE-AntiSpam-Info: {Found in DNSBL: 217.23.187.157 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;217.23.187.157:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
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
X-KSE-Antiphishing-Bases: 07/03/2024 09:00:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/3/2024 6:47:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

It is necessary to prevent dereferencing of NULL pointers.

Found with the SVACE static analysis tool.
---
 src/shared/bap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index ec54da341..defeeb635 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1870,11 +1870,11 @@ static unsigned int bap_ucast_disable(struct bt_bap_stream *stream,
 
 static uint8_t stream_stop(struct bt_bap_stream *stream, struct iovec *rsp)
 {
-	DBG(stream->bap, "stream %p", stream);
-
 	if (!stream)
 		return 0;
 
+	DBG(stream->bap, "stream %p", stream);
+
 	ascs_ase_rsp_success(rsp, stream->ep->id);
 
 	stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
@@ -2751,12 +2751,12 @@ static uint8_t ascs_start(struct bt_ascs *ascs, struct bt_bap *bap,
 
 static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
 {
-	DBG(stream->bap, "stream %p", stream);
-
 	if (!stream || stream->ep->state == BT_BAP_STREAM_STATE_QOS ||
 			stream->ep->state == BT_BAP_STREAM_STATE_IDLE)
 		return 0;
 
+	DBG(stream->bap, "stream %p", stream);
+
 	ascs_ase_rsp_success(rsp, stream->ep->id);
 
 	/* Sink can autonomously transit to QOS while source needs to go to
@@ -5830,11 +5830,13 @@ int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id)
 int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 				struct bt_bap_stream *link)
 {
-	struct bt_bap *bap = stream->bap;
+	struct bt_bap *bap;
 
 	if (!stream || !link || stream == link)
 		return -EINVAL;
 
+	bap = stream->bap;
+
 	if (stream->link || link->link)
 		return -EALREADY;
 
-- 
2.43.0


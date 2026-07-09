Received: from spamfilter04.delta.nl (spamfilter04.delta.nl [217.102.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24BE4219E8
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.102.255.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600053; cv=none; b=oHG3UnppcD4ZNtNGOQoywCzKIpBhGHJcUnMvfWDBZF3AJihbbf7w6HtK5SiF7Qp66+YyLUZ4jGfu3MK1nmJaB8g/3VCHSM8bvycjBw+eAQmvcqpjOZpskKdB+dCyiQEuYud9B80FtiSXJAZVv/nKoH0pacnXdr+AAq1IIeIhJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600053; c=relaxed/simple;
	bh=intjPTGWlcZJUzAPW3d6YzPENubW3dCETeXSGUTL2YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHTPAcaauFeS9y4S0NYXZxQsk6xMd9TKnrLQE43siuioc0SIJEzz1vVIssgsNviR0VgqeZbMeFSngc9OaeM0tBM+GDp3cc0Y2xPjEbHaTYDLCFGKwMKKVsiriErOjO6pLgFZ31s3GSH4ydkzI1N+gPkiFMl/0kcTSBa8F37JyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeelandnet.nl; spf=pass smtp.mailfrom=zeelandnet.nl; dkim=pass (2048-bit key) header.d=zeelandnet.nl header.i=@zeelandnet.nl header.b=LJtFMy5P; arc=none smtp.client-ip=217.102.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeelandnet.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeelandnet.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeelandnet.nl header.i=@zeelandnet.nl header.b="LJtFMy5P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zeelandnet.nl; s=se2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:reply-to:sender:bcc:in-reply-to:references:
	content-type; bh=nrLSflP9Yi/ToxhOJsiwfAEvblN1jTJ5RuHlw7vdu4E=; b=LJtFMy5PayLA
	6iEsKw2Hb9TNBBm8Vc2M61M+FoWVRwmrte1z7I8MVOxdUTNLIjxIpvwS5ROKylyCOBPblOFGEGDsj
	fOLHYbYVhyCyncI0L5laiN2IULOL4dQAIDZJVxaZYNqJkdMUlOlyywOPDYavV2oxTk2lyzZZXTBA1
	iR5Pi1KHE1FFRcUpOVp5UTvbbdDj2jG9OfV1OC2W/7VUZDKkb11hTa1vG4gQxX5icgk8ShgoPmvQ/
	eglApIbC3UxkCCc+MMC4jaUuzynIlp30Exujr63uPxw6dxD7DP7mqDFpF9CoDRuU37BYfGt/B/Eh8
	k25AXFjqhdLlDRsYpaoLvA==;
Received: from [217.102.255.198] (helo=mail.zeelandnet.nl)
	by spamfilter04.delta.nl with esmtp (Exim 4.94.2)
	(envelope-from <tomcatshoek@zeelandnet.nl>)
	id 1whoEW-0012Oz-BU; Thu, 09 Jul 2026 14:27:35 +0200
X-Sender-IP: 83.84.65.18
Received: from tomarchryzen.lan (83-84-65-18.cable.dynamic.v4.ziggo.nl [83.84.65.18])
	(Authenticated sender: tomcatshoek@zeelandnet.nl)
	by mail.zeelandnet.nl (Postfix) with ESMTPA;
	Thu,  9 Jul 2026 14:27:22 +0200 (CEST)
From: Tom Catshoek <tomcatshoek@zeelandnet.nl>
To: linux-bluetooth@vger.kernel.org
Cc: Tom Catshoek <tomcatshoek@zeelandnet.nl>
Subject: [PATCH BlueZ] adapter: Fix crash on UUID discovery filter match
Date: Thu,  9 Jul 2026 14:27:04 +0200
Message-ID: <20260709122704.351232-1-tomcatshoek@zeelandnet.nl>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DELTA-Domain: zeelandnet.nl
X-DELTA-Username: 217.102.255.198
Authentication-Results: delta.nl; auth=pass smtp.auth=217.102.255.198@zeelandnet.nl
X-DELTA-Outgoing-Class: ham
X-DELTA-Outgoing-Evidence: SB/global_tokens (0.00835450675665)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuUfyIcnHf3a0WCtna8UjjA6ar/aZZnX9yUS
 oquBA/HlQSu2SmbhJN1U9FKs8X3+Nt1e9xGgHpSCmLkfl25qZSy4A5F2aRjVfBzlUyXBRvKR0w9h
 kRlGHAo3NQuCQ2GgWEt+oaZ2ZNKAGVAgNukt+g/OlDtR/qCXMVqSLVxeSwueS0r/pqDh7apldsyM
 rNwI+mb6BpeseSBELv+0jcKNeZXKtC8pyCYYciHB12Lu4CxajAlsWE7tOYTNT8lmDvRJlbmOpK/F
 6IU0v47iJjbX7I+9/fNoXjtFtCxlBW3DVyFe1uu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jthScFjNlc1
 ym1ZMTyrHit3ucCra4pX+1a4LelmaTlLLSPOTUW8VuQuUjH2AV/aKRMG5ZuHnC6Q1xaigh/Kg6Bv
 Sy809eu/jWYBEJqyf9bfNG0ApoE6XUb6dlFWUtzi+p1bkdDJUxnGxw0egtRuEOribsHPt90rvmGO
 s5SvixjKO+7m/wWr4WZH8qWfzhK4dwPX6r3C2Qgzc+xROZfGnoE361ocd16tuABey7l0hihU3cu2
 LEHMAWWzwetiJ2Lrb7jakC/ZGhjihaxNSPYchWMM7fFAMyKkuNSmGasIEySLeO3lEQv8duYCgra7
 +K3X1QBUqiydTl+lieKrIWjlBRM24qPqET5A/FgpN2HwDuYrXKRlALcqA0HF7VonKLQi4KzrOprq
 PcI6TzRLzj+7IBoZm2NDaD/lUQRdMdfd37rjVEDTPpuFqUUQz+mM8JAD4ECW0fihWUDVT8Tezf81
 XTp2u2pJFGei59CM69J3MPW8zcVrrevAXc5+2feqX19eY6mb8F7jYaSBzb3xA9DALHJzmcbZtNYm
 syA6q549GjYvpujrjuU3A3io6xJmD59iFVkbE/0HgvoO1HH3QikyPk+Z8skqL4vcCZdkoHbHsBzz
 8vCdNy+TLo0glVoz5ULuXhi/d7mKJ7eLk5+BUGRLQ+nWoGQKfdsYiMyl4UyMG/ykgqLimuazXgva
 v3T8Xx736OrsXnV5yUc6vrtweAuDPge+fQ==
X-Report-Abuse-To: spam@spamfilter03.delta.nl
X-Complaints-To: abuse@spamfilter01.delta.nl

is_filter_match() looks up each discovery-filter UUID in the queue of
services parsed from a device advertisement. When that services list was
migrated from a GSList to a struct queue, the queue_find() call kept
GLib's g_slist_find_custom() argument order, passing the UUID string
where queue_find() expects a match function and the comparison function
where it expects the match data.

As a result queue_find() calls the UUID string as if it were a function,
jumping into non-executable heap and crashing bluetoothd with SIGSEGV as
soon as an advertisement matches a UUID filter configured via
SetDiscoveryFilter.

Add a queue_match_func_t helper and pass the arguments in the correct
order.

Fixes: https://github.com/bluez/bluez/issues/2282
---
 src/adapter.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 210225243..4ffa32a52 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7184,6 +7184,14 @@ static void adapter_msd_notify(struct btd_adapter *adapter,
 	}
 }
 
+static bool match_uuid(const void *data, const void *match_data)
+{
+	const char *uuid = data;
+	const char *match = match_data;
+
+	return strcmp(uuid, match) == 0;
+}
+
 static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
 								int8_t rssi)
 {
@@ -7216,8 +7224,7 @@ static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
 				 * uuid.
 				 */
 				if (queue_find(eir_data->services,
-							m->data,
-							g_strcmp) != NULL)
+							match_uuid, m->data))
 					got_match = true;
 			}
 		}
-- 
2.55.0


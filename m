Received: from mailsh.amlogic.com (unknown [114.94.151.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7110356750
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.94.151.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791616316; cv=none; b=OJ3QP5bPBt2Zg2YUjIu8Z5533UJ64FG+HTadRYnfFuAoHiPBJQDDaLzvF+DmG4Z6/saMWpNwp89613EQJIQHVY1H+on9x+kACilMMcDGqmEdLV3OE9Jp95fHROA8BmnkXBJ1gWELZqXGHuL9xmuhBKAi9Zg5AUXDyWJScrZsMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791616316; c=relaxed/simple;
	bh=kDXxL5ocD5OXFOV4BUt3FnZqecxYh0766X+AcbiLizY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ouzd6q9tw6EarI+vIJuTcMebLVds0+rzokFsDhFLXim+WMk9+kDWDV+xiwwtPZKM9Kv8Tu3zwI3sXlWdKjHRKd80alFzx9DQF1Kxx8SNRqgRT7AT7+J7PM9Wc1yN0ro8BRTmvJRaov5fjT3RQa4Q6aU226KnS5PWJqhbx8DH3VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=114.94.151.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from [127.0.1.1] (10.98.11.201) by mailsh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Sat, 10 Oct
 2026 15:11:52 +0800
From: Ye He <ye.he@amlogic.com>
Date: Sat, 10 Oct 2026 15:11:51 +0800
Subject: [PATCH bluez] bearer: Cancel disconn_timer upon
 btd_bearer_disconnected
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261010-bearer-disconn-timer-v1-1-12461fee99f1@amlogic.com>
X-B4-Tracking: v=1; b=H4sIADblyWoC/x3MSwqDMBRG4a3IHTeQpPWBWykOEv3VCxrlRoso7
 r3B4Tc456IIYUSqs4sEP468hATzyqgdXRiguEsmq21htNHKwwlEdRzbJQS18Zyk37n/VDYvHQp
 K6Sro+Xi2X/LTjpOa+/4DypkRjm0AAAA=
X-Change-ID: 20261010-bearer-disconn-timer-035b48257ae6
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
CC: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791616312; l=1113;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=kDXxL5ocD5OXFOV4BUt3FnZqecxYh0766X+AcbiLizY=;
 b=UYwSQD+jfIA3j2QiIIlr2ylc2pYea52EdElCABEW/NGIXlBOMyoAnXTENcTG8s0jzcI1KOk2o
 0svQIlZWIPpCGfB07tZgcEo+N2KAO34UIOOzSjf3p5cqe+VNCCeLtRU
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=

If a fast reconnect occurs after a rapid disconnect,
the 2-seconds bearer->disconn_timer may still fire and
tear down the newly established link.

Fix this by cancelling the disconn_timer inside
btd_bearer_disconnected().

Signed-off-by: Ye He <ye.he@amlogic.com>
---
 src/bearer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/bearer.c b/src/bearer.c
index 25224dcc7f25d3c5e9adef2644d8f1ae1b5c18ef..5544c2f609d80e2916b98741152f83a134863045 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -464,6 +464,12 @@ void btd_bearer_disconnected(struct btd_bearer *bearer, uint8_t reason)
 	if (!bearer || !bearer->path)
 		return;
 
+	/* cancel disconnect timer if ACL link has already dropped */
+	if (bearer->disconn_timer) {
+		timeout_remove(bearer->disconn_timer);
+		bearer->disconn_timer = 0;
+	}
+
 	if (!btd_device_is_connected(bearer->device))
 		device_disconnect_watches_callback(bearer->device);
 

---
base-commit: 7428ca2df9356363079db0f48412c20cbdb9471f
change-id: 20261010-bearer-disconn-timer-035b48257ae6

Best regards,
-- 
Ye He <ye.he@amlogic.com>


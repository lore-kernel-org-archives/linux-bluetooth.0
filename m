Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587CA1635BF
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332704; cv=none; b=I2QXooSgAYqff5F0arjQNjsunRyw1LHOm8pLDwc3zjXKW3246wzNtYK3A3SFG/WVX05VO72tJDxuIa/z3kXPO1MSvsI/3tBp6aKe5GrLPxK3hhZhqlTWZhLdkkyBM9vQUpjErsAySUcm2Zs6y4bJf9BO/MaJO0b52TnSL9v6L+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332704; c=relaxed/simple;
	bh=Yh0PDSY9sQwh0O2/JTlu7MTW12Eg3DPcxr2592X6H/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwJ8lwwuHvweiH0uUO+B4DowHW19eW9V5B7HmzO7QsbrfEYRb71K3I/7cWTJIGpP2SarhEF4GM9t+x1hH2R5pi4ZjBHBMXlkv/vaptoGYssa0O7+sImtWIHQ/8xJwhxl3RW6rUZ0hgA7EA6W8EPLrXbL5+DQc1r2ONI9peSESwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88A4A1BF204
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:15 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 01/14] adapter: Use false instead of 0 for bool
Date: Fri, 10 May 2024 11:10:59 +0200
Message-ID: <20240510091814.3172988-2-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510091814.3172988-1-hadess@hadess.net>
References: <20240510091814.3172988-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5505edbb29c1..8b478e213cb5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2413,7 +2413,7 @@ static int update_discovery_filter(struct btd_adapter *adapter)
 	 * starting discovery.
 	 */
 	if (filters_equal(adapter->current_discovery_filter, sd_cp) &&
-	    adapter->discovering != 0) {
+	    adapter->discovering != false) {
 		DBG("filters were equal, deciding to not restart the scan.");
 		g_free(sd_cp);
 		return 0;
-- 
2.44.0


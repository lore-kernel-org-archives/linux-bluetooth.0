Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C4716F84A
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343252; cv=none; b=YKMxsJuMUHtKYgCbwNZo3rZ/d5hW6fJY6+PTSh+STVQv3UWvAiqe3QsXliby5uYE/rJlg71JOhaU8l/hMdaxfDMUBrbrVfdI3ul7/zhr6Ay363RfM7I9/KTxCacqu5lcaQJgzczbI1Q3i9UPDOMR4TS7e5V2tCNJcwlhaGYJIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343252; c=relaxed/simple;
	bh=Yh0PDSY9sQwh0O2/JTlu7MTW12Eg3DPcxr2592X6H/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBNB4IgkQzGPYd/zPkZ9wB1cWdxjDHI0ef439NDPuMX0oUyB4okt5lvp6FYi6HG5XYW5h//0LnIQebEKWMXOa0Qfo02jsNAoPzLmjOoSH192vVLYs60tWYqS8Y41Y58uPfoQgPWILn72Y2IFtk4ZA+SpqXbLlCLs1L3Lrz/HgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB75B6000A;
	Fri, 10 May 2024 12:13:55 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 01/20] adapter: Use false instead of 0 for bool
Date: Fri, 10 May 2024 14:10:11 +0200
Message-ID: <20240510121355.3241456-2-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510121355.3241456-1-hadess@hadess.net>
References: <20240510121355.3241456-1-hadess@hadess.net>
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


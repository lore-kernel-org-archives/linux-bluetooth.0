Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379971635CB
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332705; cv=none; b=G3gB05weCdk4gzvuhi1+vV7SRHaU7BjHaTMXWZkxQ1vQ+hpIogKTpWyjL9Kz2F/ub9gthRgRqPMCwwYgu4rKcHmGbdsSAyDQMkdos+aNkADGghAfQBHY/yaXxz1jC5SdO7HOZujmioR58l8MO3C/7/21optSQBilzmUGJfG+4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332705; c=relaxed/simple;
	bh=F9aBXHTyJ8yCD7egItUeFRNE5MgkR7fAK7lVYebRWgM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGcVRMh1FF4Poclo6bQEWiFtIoQtpUF3q5ZU51liwNwdSQ4XXQnHLgBq+duNMFjHksosGxipWLM372PPjevpmRDqeo2xZwbJJD+3PifNCm2n+LngAQaJRMl+hTUAkZ4QvBRZeAE2L6vy+xzyEV9F3fWefyrzWaA2W1jbIcnf2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 863B61BF207
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:16 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 06/14] client/main: Fix mismatched free
Date: Fri, 10 May 2024 11:11:04 +0200
Message-ID: <20240510091814.3172988-7-hadess@hadess.net>
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

Error: ALLOC_FREE_MISMATCH (CWE-762): [#def37]
bluez-5.75/client/main.c:2108:2: alloc: Allocation of memory which must be freed using "g_free".
bluez-5.75/client/main.c:2108:2: assign: Assigning: "desc" = "g_strdup_printf("\x1b[0;94m[%s]\x1b[0m# ", attr)".
bluez-5.75/client/main.c:2111:2: free: Calling "free" frees "desc" using "free" but it should have been freed using "g_free".
2109|
2110|		bt_shell_set_prompt(desc);
2111|->		free(desc);
2112|   }
2113|
---
 client/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index f703cc91b24a..f967c149e7bd 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2113,7 +2113,7 @@ static void set_default_local_attribute(char *attr)
 	desc = g_strdup_printf(COLOR_BLUE "[%s]" COLOR_OFF "# ", attr);
 
 	bt_shell_set_prompt(desc);
-	free(desc);
+	g_free(desc);
 }
 
 static void cmd_select_attribute(int argc, char *argv[])
-- 
2.44.0


Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650B716F267
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343257; cv=none; b=NeTxyJ6B+V9ZEZy5Htx31kbzc9Hg7GT/L3hDN9DfMaIPgbrNu+2HjfmJEBy9I86J2ScKg3sBT1JIoxcrWBTLXp9kyj0knvtHg6rN5d/iIwPTPK/AEa3B/7j4FDIoNyOhDDUQxLUe4QtZSFegk+OcvGpMxopKvdNKFs1/IckvGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343257; c=relaxed/simple;
	bh=F9aBXHTyJ8yCD7egItUeFRNE5MgkR7fAK7lVYebRWgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8I+AAGNAFcZGoffWyO64kUgN/EszFM4JOiR5tatHGo+D7wB+3bsBxoBayxsdgKbSICLeDTtfhjNGj4O6mvlx7N1AlM+M6INNQcFA8EEfQxivkYsB5RI4hNNaEXir0elf9wf8kUnvqyZBh1ywnYDTSBu2RcPywT7dMKIfWNxJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75ED46000F;
	Fri, 10 May 2024 12:13:57 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 06/20] client/main: Fix mismatched free
Date: Fri, 10 May 2024 14:10:16 +0200
Message-ID: <20240510121355.3241456-7-hadess@hadess.net>
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


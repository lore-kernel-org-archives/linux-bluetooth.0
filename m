Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234F170844
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343256; cv=none; b=ZRznqYQFzYQ4CP+FWV0UykwbR9QEKe+37mI+E5ZUZEU88X9wTgO77DJgiIWXckYRK4JkafruGS8F24yz9ghZUt5LZUN0iIiSBGdzeQr+y6j4ffuEVKj86UY/Y7me5ONR3tEVMCx6hhHsqRce0l0DI15DKfRXdHztUXvt1e2vsEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343256; c=relaxed/simple;
	bh=ZfaaZ7dEeQ9VjznH7vB7wWyIi9NLs2xFK5M4PvwRoK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6ex5dNdaRkQLKLtzCzOdBQbTWIq/GuOCzqyGm/bMgsgbQ03mXh+StzGUJ7Grz4vHlsiyJDs8HqdPBXAGYwTCzEtwr2lnCGRDCN5TL4oPTCJWYaS5gyn+hNRMoQCnkEDiCWjXPjFy7KdmA3967fdQe+FZUWgmWbJ7W3zq8HF2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04BAF60012;
	Fri, 10 May 2024 12:13:58 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 11/20] isotest: Consider "0" fd to be valid
Date: Fri, 10 May 2024 14:10:21 +0200
Message-ID: <20240510121355.3241456-12-hadess@hadess.net>
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

Error: RESOURCE_LEAK (CWE-772): [#def79] [important]
bluez-5.75/tools/isotest.c:923:4: open_fn: Returning handle opened by "open_file".
bluez-5.75/tools/isotest.c:923:4: var_assign: Assigning: "fd" = handle returned from "open_file(altername)".
bluez-5.75/tools/isotest.c:925:3: off_by_one: Testing whether handle "fd" is strictly greater than zero is suspicious.  "fd" leaks when it is zero.
bluez-5.75/tools/isotest.c:925:3: remediation: Did you intend to include equality with zero?
bluez-5.75/tools/isotest.c:926:4: overwrite_var: Overwriting handle "fd" in "fd = open_file(filename)" leaks the handle.
924|
925|		if (fd <= 0)
926|->			fd = open_file(filename);
927|	}
928|
---
 tools/isotest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index 7e875fa58b15..810d15d2df2a 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -922,7 +922,7 @@ static void send_mode(char *filename, char *peer, int i, bool repeat)
 		if (!err)
 			fd = open_file(altername);
 
-		if (fd <= 0)
+		if (fd < 0)
 			fd = open_file(filename);
 	}
 
-- 
2.44.0


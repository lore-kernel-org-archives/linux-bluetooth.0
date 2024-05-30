Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2D1E532
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081263; cv=none; b=bUqqR994JOQdPARwsrjiaxfA3MZHkyOaFFHxt26nU8Wg1veV6xxdmKMGHBjby3RE/ajV57wGbal9ShIi3Gtp/JVp9AcEZFC/mVXgsWIWkQA2UwettWG+Eg/xyvLR0Ok9aklXie0uheqQPfVTLiW3OaRSzLF2k2yRA7Q1IDjanoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081263; c=relaxed/simple;
	bh=vs7XiLagZa5ntsanP3R0MRDHQ8gAeVOhTp8wK47UJK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvy8MegikkYUBC1oXnvsuxer4dzyXQNYNp3PSbr6r0FJjWvlnxnawTf9zKndeEIhFs/AZ2tEU0oh1AVCov36DUv7CaFoFT9dZoyhmyz2rKUqQYh/h51uX0z5cJl297ieuqh6MmQJA7gxjDuji0Rs3qq6wddaKhfR2djaxu50iFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50B362000E;
	Thu, 30 May 2024 15:00:58 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 2/9] mgmt-tester: Fix buffer overrun
Date: Thu, 30 May 2024 16:57:56 +0200
Message-ID: <20240530150057.444585-3-hadess@hadess.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530150057.444585-1-hadess@hadess.net>
References: <20240530150057.444585-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: OVERRUN (CWE-119): [#def56] [important]
bluez-5.76/tools/mgmt-tester.c:12667:2: identity_transfer: Passing "512UL" as argument 3 to function "vhci_read_devcd", which returns that argument.
bluez-5.76/tools/mgmt-tester.c:12667:2: assignment: Assigning: "read" = "vhci_read_devcd(vhci, buf, 512UL)". The value of "read" is now 512.
bluez-5.76/tools/mgmt-tester.c:12674:2: overrun-local: Overrunning array "buf" of 513 bytes at byte offset 513 using index "read + 1" (which evaluates to 513).
12672|		}
12673|		/* Make sure buf is nul-terminated */
12674|->	buf[read + 1] = '\0';
12675|
12676|		/* Verify if all devcoredump header fields are present */

Fixes: 49d06560692f ("mgmt-tester: Fix non-nul-terminated string")
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 8076ec105ebb..1d5c82ae0745 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -12671,7 +12671,7 @@ static void verify_devcd(void *user_data)
 		return;
 	}
 	/* Make sure buf is nul-terminated */
-	buf[read + 1] = '\0';
+	buf[read] = '\0';
 
 	/* Verify if all devcoredump header fields are present */
 	line = strtok_r(buf, delim, &saveptr);
-- 
2.45.1


Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3296F142E96
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850230; cv=none; b=fnkgHbozWfbknAzGALYNzuctnxWKlYHDc1XQ7OllS+3j+naUfWTshJTSsxMr8aoYa2nezg77dtGSnjv72k8gFYYWXboOWU0VTpWvQZpJ7llaGmUZaLI0P//mC9sQJGVsEDlmGzYbAfGBt3oV9nkakLQ9oZnx28kNcus54dthfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850230; c=relaxed/simple;
	bh=qgt4Ntngs7YG4F+yMa9fB5zhvbuMNsssLDX4d2JLqrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miY7wlnTf1X/JV/wSP6OFkkyJ8Qvv1IZsasnqWIuoEf6Xhto7n05f3CCjJqmoo1uRbiPKU/kNmic/es5XY2frxTQEPnKQs1BU1stqsT0HERuDBvHQQfl7B7mrz2x0iL2apPgGUd/noisY4rjyE9Qk5vVuE7RoPVD4S2aDKLQi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D7F71C0017;
	Thu, 16 May 2024 09:03:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 07/15] test-runner: Fix uninitialised variable usage
Date: Thu, 16 May 2024 11:03:11 +0200
Message-ID: <20240516090340.61417-8-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
References: <20240516090340.61417-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: UNINIT (CWE-457): [#def64] [important]
bluez-5.75/tools/test-runner.c:701:2: var_decl: Declaring variable "envp" without initializer.
bluez-5.75/tools/test-runner.c:739:3: uninit_use_in_call: Using uninitialized value "*envp" when calling "execve".
737|
738|	if (pid == 0) {
739|->		execve(argv[0], argv, envp);
740|		exit(EXIT_SUCCESS);
741|	}
---
 tools/test-runner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index ff5e19825801..908327255ad7 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -698,7 +698,7 @@ static const char *btvirt_table[] = {
 static pid_t start_btvirt(const char *home)
 {
 	const char *btvirt = NULL;
-	char *argv[3], *envp[2];
+	char *argv[3];
 	pid_t pid;
 	int i;
 
@@ -736,7 +736,7 @@ static pid_t start_btvirt(const char *home)
 	}
 
 	if (pid == 0) {
-		execve(argv[0], argv, envp);
+		execv(argv[0], argv);
 		exit(EXIT_SUCCESS);
 	}
 
-- 
2.44.0


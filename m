Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328EE142E91
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850230; cv=none; b=CYrfVvJqU132dSRl0D0ZKeIEM6weNLRWNywx0AA/3QOhuobyMBpzbXA+2v3Em+RzPOdgoiGc5esE/YdwTik/oCKx6ZvtQ2p8Zl9XjmX7ElQ0OQvNST7Uq7jLj2lqLBY4My5h9BGIJdF9hcUbLj4YJ3ILoxrJEgb1pbk8dv3Zr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850230; c=relaxed/simple;
	bh=G0YIdC2Ro9VnFebL+xvd7S9Fy6i8yWt/cOQX3ft3yIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVNp0II0ksUomc99Bzl+bAYuH85aenwgOqDszJbTBn/OHB5rnvahoWXwit7WoRZ68VRLRSz0vGUmS4skMyVauz0RiUs9AZ05UDJXV6yypmV75Ah+A3iQaVU965r2Ctl1rc79rykJV6oadGHOpYTfPUTsdPpH8rdLOsvVK07T9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7262B1C0015;
	Thu, 16 May 2024 09:03:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 05/15] test-runner: Remove unused envp
Date: Thu, 16 May 2024 11:03:09 +0200
Message-ID: <20240516090340.61417-6-hadess@hadess.net>
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

Error: UNINIT (CWE-457): [#def70] [important]
bluez-5.75/tools/test-runner.c:644:2: var_decl: Declaring variable "envp" without initializer.
bluez-5.75/tools/test-runner.c:682:3: uninit_use_in_call: Using uninitialized value "*envp" when calling "execve".
680|
681|	if (pid == 0) {
682|->		execve(argv[0], argv, envp);
683|		exit(EXIT_SUCCESS);
684|	}

Error: UNINIT (CWE-457): [#def71] [important]
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
index 5bdcf42fcd7a..134e26f9c691 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -641,7 +641,7 @@ static const char *monitor_table[] = {
 static pid_t start_btmon(const char *home)
 {
 	const char *monitor = NULL;
-	char *argv[3], *envp[2];
+	char *argv[3];
 	pid_t pid;
 	int i;
 
@@ -679,7 +679,7 @@ static pid_t start_btmon(const char *home)
 	}
 
 	if (pid == 0) {
-		execve(argv[0], argv, envp);
+		execv(argv[0], argv);
 		exit(EXIT_SUCCESS);
 	}
 
-- 
2.44.0


Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329ED142E9A
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850230; cv=none; b=Dsawoq4XmXCsi8QIqyXMy5MinxB2dDJaKEIAVjlEBsD92KJnuZC2moWuAWYw8Dg9Ejs/SRzxE+MWTDQL4dGpBW37F2WR7qgL4vCjqRbfyGph1BxfAGKgiAf1pL4WE174D9/7Wt54JHewStbxdkSXEuSAbIeyf0RZoUdLh4AaO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850230; c=relaxed/simple;
	bh=NBJkrCOhf1LhOUZCleZrx2xtGxd/DhKz9plgXoUn2q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnO/3wvdp6uIYo3GRuGbAQjyPG2n+ouY0JLFdvpl1UY4q1rd8q++ob2E5NFse8QbwXJKi3dtu1WS+GhHx2SSiKjxZOkIBoBje+biF9kL5KRuTzbcNZl3dwEG/kAWrpI4cBmlRZzzG/745VmX5I4/Eq0QtCNWQCOQ/0xEaoYePqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id BBE441C0016;
	Thu, 16 May 2024 09:03:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 06/15] test-runner: Fix uninitialised variable usage
Date: Thu, 16 May 2024 11:03:10 +0200
Message-ID: <20240516090340.61417-7-hadess@hadess.net>
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

Error: UNINIT (CWE-457): [#def72] [important]
bluez-5.75/tools/test-runner.c:856:2: var_decl: Declaring variable "argv" without initializer.
bluez-5.75/tools/test-runner.c:945:2: uninit_use: Using uninitialized value "argv[0]".
943|   	envp[pos] = NULL;
944|
945|-> 	printf("Running command %s\n", cmdname ? cmdname : argv[0]);
946|
947|   	pid = fork();
---
 tools/test-runner.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 134e26f9c691..ff5e19825801 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -912,6 +912,11 @@ static void run_command(char *cmdname, char *home)
 		audio_pid[0] = audio_pid[1] = -1;
 
 start_next:
+	if (!run_auto && !cmdname) {
+		fprintf(stderr, "Missing command argument\n");
+		return;
+	}
+
 	if (run_auto) {
 		if (chdir(home + 5) < 0) {
 			perror("Failed to change home test directory");
-- 
2.44.0


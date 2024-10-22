Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F149919F485
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606283; cv=none; b=hHx5WZ0pBUykdnt259Rt8ES0jdUdu5M92Fd/GYw/djZZUdinmhCd8Rbl0DQDqYuFa1pIZ90pklQHOwa1RXRwNMKamp3tUXPYvhN0+jpWarEXuJQEqodq9996sKhiT1xDDCbrwpgJic4kvEY3msmh59Dj2uL/7bFL4QcWZkSRO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606283; c=relaxed/simple;
	bh=iV3Gom7Fgo8VpeTriOg1gLZKtpVVrhzfyJhFC7ltCA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQ0PlrFRwjsbZ5M3IDDoxD5qtEijKd4EtPbvNcNgKveU/Obq4YbXonGintLQ15y59X9FPkTuqBvm2OKvl/ojGBjaqHLfeklCwZ6knKU2P6qfaKJdRw2LiPKcQ2bH5DqIDtqbYbm4vck9bmGybWpTxwyFdPm83VZ/okX93+NeW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60B8A240013;
	Tue, 22 Oct 2024 14:11:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v3 6/7] shared/shell: Add function to handle early help calls
Date: Tue, 22 Oct 2024 16:10:37 +0200
Message-ID: <20241022141118.150143-7-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022141118.150143-1-hadess@hadess.net>
References: <20241022141118.150143-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Add a function that would allow tools to exit after handling --help, so
as to avoid the daemon waiting to communicate with a D-Bus service that
might not be running.
---
 src/shared/shell.c | 10 ++++++++++
 src/shared/shell.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 2f83717b2d39..88cc7df2d565 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1697,3 +1697,13 @@ int bt_shell_get_timeout(void)
 {
 	return data.timeout;
 }
+
+void bt_shell_handle_non_interactive_help(void)
+{
+	if (!data.mode)
+		return;
+	if (data.argv[0] != cmplt)
+		return;
+	print_cmds();
+	exit(EXIT_SUCCESS);
+}
diff --git a/src/shared/shell.h b/src/shared/shell.h
index e431db9f5821..eebbc71faffb 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -60,6 +60,8 @@ int bt_shell_exec(const char *input);
 void bt_shell_quit(int status);
 void bt_shell_noninteractive_quit(int status);
 
+void bt_shell_handle_non_interactive_help(void);
+
 bool bt_shell_set_menu(const struct bt_shell_menu *menu);
 
 bool bt_shell_add_submenu(const struct bt_shell_menu *menu);
-- 
2.47.0


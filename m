Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BA19CC33
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598463; cv=none; b=PntSX7IfXQsvrr057EfDdPpNx8jqy9gh8tUKR8X+RwVlW93IDe+pumZPo/+1fzC9vBZQjLevUSTnlNqdbaQanUnmaLCbtsnDlD0IIVXVKsAX3zt7wvA/YYXgK2or3T6qzwytovQ/LfJ8pk6Ni2Gp3q7CZxFJFeztybmKQOW9PC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598463; c=relaxed/simple;
	bh=Tw5voPPuH/WUlwtUebJj2x7JUskyqTEq+0bS5xxzoyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsYaHQlqniE13WeRYoCmZuu6k/gM+JX05J4gwpJ/FH0v541LDV2W37VrTyAm4DVx37/ZTNPrW5I61tETNgPUDnFxfD4jakHF6z8dGfcvYA30dAf6d4r9b7esKCTVMQf2MxyoZ0DdncCvitBtqauGb+GfR6VqfuhLcyCxgaMQHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A7E81C0028;
	Tue, 22 Oct 2024 12:00:53 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 6/7] shared/shell: Add function to handle early help calls
Date: Tue, 22 Oct 2024 13:58:36 +0200
Message-ID: <20241022120051.123888-7-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022120051.123888-1-hadess@hadess.net>
References: <20241022120051.123888-1-hadess@hadess.net>
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
index 9ff774fe43a2..7107fb4c7776 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1694,3 +1694,13 @@ int bt_shell_get_timeout(void)
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
index b03250cac80f..17277a601d3e 100644
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


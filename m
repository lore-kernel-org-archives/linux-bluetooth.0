Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9389230264
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129158; cv=none; b=CO3ahuaKBG1+Tw5tOgm0GzmC3gpe0PdoABy7P+/eid023osGSkg+HqfmFHWDZJ3sosky1Or041ES8SF3UOnB2gWAgPtwpeu2uYb19uaEIIUw++UjmNZ0Pv6sh59hpwR3OdamefMX2wG9faz7raCy6nBPtOec4bxNbEzH01WodrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129158; c=relaxed/simple;
	bh=OUngSD58PFhMf38hQbPwnyHfr75JF7xeUivQ8brPLMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRxscNcizARwMlR/AfGHU0m7pnLyFlyVyOS6Meeg25ihI5ZG4ExSGOJEYQBB6whTNXOkviYlO0y1kIzw4cZPi13IX7eVCZVeYxygVNY1BgDFBk9YcYlotCF3RHtnOI+i+S9UQtgKTghsx2qxtWL1IjAcTIlRF6V4qpucCPvBfnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39E9B439F0;
	Tue, 13 May 2025 09:39:15 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v4 3/9] shared/shell: Add function to handle early help calls
Date: Tue, 13 May 2025 11:38:13 +0200
Message-ID: <20250513093913.396876-4-hadess@hadess.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513093913.396876-1-hadess@hadess.net>
References: <20250513093913.396876-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepveethfelveejffetkeelheehueejlefhvdehteehgfeghfekgfdvfefhgeekieetnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtrddrpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgruggvshhssehhrgguvghsshdrnhgvth
X-GND-Sasl: hadess@hadess.net

Add a function that would allow tools to exit after handling --help, so
as to avoid the daemon waiting to communicate with a D-Bus service that
might not be running.
---
 src/shared/shell.c | 10 ++++++++++
 src/shared/shell.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 674992065744..4e42bd69b4d7 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1708,3 +1708,13 @@ int bt_shell_get_timeout(void)
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
2.49.0


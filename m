Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC63D5221
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926859; cv=none; b=TMBQ6Qtrz3X4yrNTS8fGAfF6ywzrjqte30DZiJxRCMkLRAsd73Yyxx86Eal/8guaAgYFox2bvZEZEXyjFdmHl26MIX8cLv110OA/6oikodZQg5t9O+bXk0Uy4y9ZU39fxpSrQJTqLC9AEcmh8kxpYqSKMzH3wBR5dItd3vRSzJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926859; c=relaxed/simple;
	bh=sorGXUIZgQsRUGVcCRuGRSfSwp7S/yZPIAkWDydNWoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfHzEAZRdAPnrD9TxJZHeSvmflnE9i1yoxT1m3YrqeeYp2/HLvrP7jI5zogKYP7rDwaVjlZpO4dY0B9MFU5u/lCcrvfKin8TtSlw/U1/uPPta7ivwOfpE/dv+e/RKXPZJjx3yaBOgfdde4B3Il34QH9ahgNH4eFfSkP0lAUOrD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52BA13EBFC;
	Thu, 19 Mar 2026 13:27:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Wouter <wouter@xesxen.nl>
Subject: [PATCH BlueZ 1/1] shared/shell: Fix crash on bluetoothctl command completion
Date: Thu, 19 Mar 2026 14:25:39 +0100
Message-ID: <20260319132720.1517783-2-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319132720.1517783-1-hadess@hadess.net>
References: <20260319132720.1517783-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepveethfelveejffetkeelheehueejlefhvdehteehgfeghfekgfdvfefhgeekieetnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugephedvueetudefgfeuhfevpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihouhhtvghrseigvghsgigvnhdrnhhl
X-GND-State: clean

Don't try to complete empty commands, leading to invalid reads and
crashes.

==1430873== Invalid read of size 1
==1430873==    at 0x484BC77: strcmp (vg_replace_strmem.c:941)
==1430873==    by 0x435063: menu_completion (shell.c:1126)
==1430873==    by 0x4352F0: shell_completion (shell.c:1177)
==1430873==    by 0x4A2542B: gen_completion_matches (complete.c:1282)
==1430873==    by 0x4A2E9CD: rl_complete_internal (complete.c:2104)
==1430873==    by 0x4A257C2: _rl_dispatch_subseq (readline.c:944)
==1430873==    by 0x4A26ADF: readline_internal_char (readline.c:693)
==1430873==    by 0x4A46CE4: rl_callback_read_char (callback.c:275)
==1430873==    by 0x435E54: bt_shell_input_line (shell.c:309)
==1430873==    by 0x436A34: watch_callback (io-glib.c:173)
==1430873==    by 0x490A322: g_main_dispatch (gmain.c:3565)
==1430873==    by 0x490A322: g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4425)
==1430873==    by 0x4913277: g_main_context_iterate_unlocked.isra.0 (gmain.c:4490)
==1430873==  Address 0x0 is not stack'd, malloc'd or (recently) free'd

==1516885==    at 0x484A126: rindex (vg_replace_strmem.c:216)
==1516885==    by 0x4353AA: submenu_completion (shell.c:1153)
==1516885==    by 0x4353AA: shell_completion (shell.c:1187)
==1516885==    by 0x4A2542B: gen_completion_matches (complete.c:1282)
==1516885==    by 0x4A2E9CD: rl_complete_internal (complete.c:2104)
==1516885==    by 0x4A257C2: _rl_dispatch_subseq (readline.c:944)
==1516885==    by 0x4A26ADF: readline_internal_char (readline.c:693)
==1516885==    by 0x4A46CE4: rl_callback_read_char (callback.c:275)
==1516885==    by 0x435E94: bt_shell_input_line (shell.c:309)
==1516885==    by 0x436A74: watch_callback (io-glib.c:173)
==1516885==    by 0x490A322: g_main_dispatch (gmain.c:3565)
==1516885==    by 0x490A322: g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4425)
==1516885==    by 0x4913277: g_main_context_iterate_unlocked.isra.0 (gmain.c:4490)
==1516885==    by 0x491351E: g_main_loop_run (gmain.c:4695)
==1516885==  Address 0x0 is not stack'd, malloc'd or (recently) free'd

Reported-by: Wouter <wouter@xesxen.nl>

---
 src/shared/shell.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index b061f8001414..805f4b77016b 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1122,6 +1122,9 @@ static char **menu_completion(const struct bt_shell_menu_entry *entry,
 {
 	char **matches = NULL;
 
+	if (argc == 0)
+		return NULL;
+
 	for (; entry->cmd; entry++) {
 		if (strcmp(entry->cmd, input_cmd))
 			continue;
@@ -1146,6 +1149,8 @@ static char **submenu_completion(const char *text, int argc, char *input_cmd)
 
 	if (data.main != data.menu)
 		return NULL;
+	if (!input_cmd)
+		return NULL;
 
 	cmd = strrchr(input_cmd, '.');
 	if (!cmd)
-- 
2.53.0


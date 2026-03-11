Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7923D890D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227755; cv=none; b=FiDsiXusCo0C4k9D2iBWCnbup5dOcJmxmLyPyeGDgPSK/G6TZGTyB11DhIpXmkawP7SaLsOZ+E2d2U/huJuZfJBfCKdu/9PpD8MnXumoVmOiyMLO+GN00qdDip7/iFbV67L9JEZ7oeDO8xghHh4z49kFoWww0AYsN+pyMjSicqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227755; c=relaxed/simple;
	bh=IhaSKyzIjfVQj2v8WXOre6t1OflLQmiKkCsZIf8Jqx8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OryBB4ZDuUul62agbvf01yI5jgVxlmmFat1dZ8JiNVA6oIOAHWHiU+CgjiYb1UEMfwYEilC4v+XCUyLzby4lxPHTKwNEXwAAFVQqa4Rt1qJCvSo93bu4QzftfJ0z4BmO19zY8jDjly7e/XYd5CJLRduc5YoLwjTPM3Zc3AL3hzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B564343285
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 11:15:49 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/1] tools/btmgmt: Fix btmgmt --help hanging
Date: Wed, 11 Mar 2026 12:14:13 +0100
Message-ID: <20260311111540.2170373-2-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311111540.2170373-1-hadess@hadess.net>
References: <20260311111540.2170373-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeuheeigeefgeefvdekhedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean

btmgmt when run interactively would wait for commands on its prompt, but
that prompt is never setup when the help output is requested.

Handle --help through bt_shell_handle_non_interactive_help() so that the
application exits as soon as the help content has been printed, like
other interactive apps in bluez.
---
 tools/btmgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 0f3de2880014..762a3a141c4a 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -47,6 +47,9 @@ int main(int argc, char *argv[])
 	bt_shell_init(argc, argv, &opt);
 
 	mgmt_add_submenu();
+
+	bt_shell_handle_non_interactive_help();
+
 	mgmt_set_index(index_option);
 	bt_shell_attach(fileno(stdin));
 	status = bt_shell_run();
-- 
2.53.0


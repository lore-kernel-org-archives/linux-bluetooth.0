Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4938332EB8
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951374; cv=none; b=Dyl75VWLIK4gcqHeKiLixG7FQpsMM8MSa9TDEmsybNQw6bXyT+qmrgze3a5c4EQzZXMSLhAeIQIDHM16my/pC+NOnKcOhZPdjYYIA7JUx5kRHAYLKiwgO2BYpkXsD2kmYt9u2GJAd/rKrO6KwU8vzPtyNTB+dDORFagvl7c9ZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951374; c=relaxed/simple;
	bh=dgkW6CDBXxaNn3HvsVGkYkLsSA1RsSNW9VzvYKngBGI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bw20w81/u//PN9XogzgTnLkaT1UslsBWxcUC/SED/yWQQTUnrSmDOicfXCmdDZXzXm/nvP7hLdP9ctttVAhujrCJjCgvHQel178W1KwF2q+Kv6s2bGX/naimSZF9n9FNtXBvRyPh4Bh4mlMEKlWohbc59GpFZvWSSDurt3t+/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 684804326A
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 09:36:11 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v1 1/3] unit: Speed up unit-avdtp test
Date: Fri,  9 Jan 2026 10:29:00 +0100
Message-ID: <20260109093602.1224918-2-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109093602.1224918-1-hadess@hadess.net>
References: <20260109093602.1224918-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekgeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeikeegkedtgeefvdeitedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Speed up /TP/SIG/SMG/BI-02-C by reducing the timeout length from 1
second to 100 milliseconds.

This reduces the runtime from 1.5 secs to 0.1 secs.
---
 unit/test-avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 460982b2c542..9833b03be408 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -148,7 +148,7 @@ static gboolean send_pdu(gpointer user_data)
 	g_assert_cmpint(len, ==, pdu->size);
 
 	if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BI-02-C"))
-		g_timeout_add_seconds(1, context_quit, context);
+		g_timeout_add(100, context_quit, context);
 
 	if (pdu->fragmented)
 		return send_pdu(user_data);
-- 
2.52.0


Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF03596FD
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951375; cv=none; b=EG9iZG+q0d75FfeidO4uvbWIUpVgtiuLRkwjSzZvu1AqYrf6PQMqqY3BraIhezC+aI81C9bYNuEXoAIbRkUsE3kIcSVGB3r3MsnDeGwYhFN0MbdS6miSS7ItMNFzje4qwYsh2p/HDOIbu/pI7PSPx1bPM+VQ21RClA5IWuSkmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951375; c=relaxed/simple;
	bh=9tsIBAzYSY8Gzumm17bHcgE8Mmj/s/qjBopHCMIkcP8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojkMdCY7/72DxdHBM8wDun8WgMaEsjg64UwpuTMW2op/UyvaRnhq8cLN6/0BVbsqJl24tOCqwFwDH/OHRcCKCtPsftBbNU+yzN94XlNXnUrplWbz3hUSCFrDW3cAF3wtFQdDZ/EJD4fzFp+7OJkaoYIlSH1fbjR6MT34yk6zijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D9E443273
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 09:36:11 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v1 2/3] unit: Speed up unit-gobex-transfer test
Date: Fri,  9 Jan 2026 10:29:01 +0100
Message-ID: <20260109093602.1224918-3-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekgeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeelffelgfeggeefvdejfedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Speed up /gobex/test_packet_put_req_suspend_resume by reducing the
timeout length from seconds to hundreds of milliseconds.

This reduces the runtime from 1.5 secs to 0.1 secs.
---
 unit/test-gobex-transfer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 4fc97f4541b8..d97e0ae430f7 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -1123,7 +1123,7 @@ static gssize provide_seq_delay(void *buf, gsize len, gpointer user_data)
 
 	if (d->provide_delay > 0) {
 		g_obex_suspend(d->obex);
-		g_timeout_add_seconds(d->provide_delay, resume_obex, d);
+		g_timeout_add(d->provide_delay * 100, resume_obex, d);
 		d->provide_delay = 0;
 	}
 
-- 
2.52.0


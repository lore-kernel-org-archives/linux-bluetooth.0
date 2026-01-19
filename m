Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B92359FBB
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831972; cv=none; b=JrlmgRaiGLOmsURGiKIWKk7hCWxbWzYKAoInB34e5fCQEPD+aUtKNz0JY4n4kVxaUdjVGE43O8AB2JDifVp2vvmCuO3yX7uh4YMkpxEWSBQsrIZwSk/Hg+YlavQKKvooLiB5n0ujMnYDoEqK9seQqeDCUQ7sLz+8ZLhDO1Ybh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831972; c=relaxed/simple;
	bh=KQEP/S8qCbXWxGJjEHeqIqgxtvohd75ty4LFYTFGDRs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5w6SoAENxApQdZnvieg7JfknSOu+cNTtJapl5/aG2upsty/FlDHvDC+o2Ig/YcnsvolvBNbtXIEJ+jmUM14LQB47OApsOpzXZ1VThzqZnfyE4GwzevDvY5nT2ajiu4HowN/LxJ2eDHOkYHMIJKvqxDJIpv24fdPMleVH+VoMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CCFE43A07
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:12:48 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 1/4] src: Turn available priority macros into an enum
Date: Mon, 19 Jan 2026 14:27:09 +0100
Message-ID: <20260119141239.2683954-2-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119141239.2683954-1-hadess@hadess.net>
References: <20260119141239.2683954-1-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeefveevhffggeeftedtjedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

This will allow generated bindings to know to use the same type
independent of individual values.
---
 src/plugin.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/plugin.h b/src/plugin.h
index b484ed37874e..e03b587faed6 100644
--- a/src/plugin.h
+++ b/src/plugin.h
@@ -7,9 +7,12 @@
  *
  *
  */
-#define BLUETOOTH_PLUGIN_PRIORITY_LOW      -100
-#define BLUETOOTH_PLUGIN_PRIORITY_DEFAULT     0
-#define BLUETOOTH_PLUGIN_PRIORITY_HIGH      100
+
+enum bluetooth_plugin_priority {
+	BLUETOOTH_PLUGIN_PRIORITY_LOW     = -100,
+	BLUETOOTH_PLUGIN_PRIORITY_DEFAULT = 0,
+	BLUETOOTH_PLUGIN_PRIORITY_HIGH    = 100
+};
 
 struct bluetooth_plugin_desc {
 	const char *name;
-- 
2.52.0


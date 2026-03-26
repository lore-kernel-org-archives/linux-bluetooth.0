Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670573BFE24
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542312; cv=none; b=HxyG0dR9dj0TTNLu6KjeyPTGpZ4QDd/fxaMG48jKqsQTJ300kfcK1iqDbBMIs6sQziOjb8eM8v41uRAu38HQ5u7lszqGXFcmNtQob5A2H2CxUc59CKF1TAfg+Y041afMNQfuNuG88xbBiyYBRyphjkDEh4JX0mOsBbgJ0xP0hl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542312; c=relaxed/simple;
	bh=vKLG0UlLcMfeqNwpbUVM9Zg6apCugcsthqFCK5E7sv0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=go2SM6qfJdTuXChAnY/Jc9Ey7jsRZOWGCMY4otOzhYyjQPBw1jiE/wFUsgCLQCcgZvfUXhaGE7LzFsOPMc67BVF0BgYlzid+JfC9sSZt22JD4HF87JV1luH3FRsSOnWK8KNEwxzputSn3433dNH63wABpK2XO3O/34Lc1fvcBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4AB06205F6
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 16:25:03 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [RESEND PATCH BlueZ] mesh-gatt: Fix JSON files missing from dist
Date: Thu, 26 Mar 2026 17:24:48 +0100
Message-ID: <20260326162454.1910916-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffleeuffejvdeufeffvdejjedvheekgfeltdejhfeitdettefgjedvuedvhfejueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeegteeutdeivddthefhiedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Moving EXTRA_DIST into a conditional means that if the dist isn't made
with the deprecated tools enabled, then files will be missing from the
distribution.

Fixes: 1f6553edd8a5 ("build: Deprecate meshctl tool")
---
 Makefile.tools | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index f6de2e68551c..4a51762c3273 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -386,9 +386,8 @@ tools_meshctl_SOURCES = tools/meshctl.c \
 tools_meshctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
 				lib/libbluetooth-internal.la \
 				$(GLIB_LIBS) $(DBUS_LIBS) -ljson-c -lreadline
-
-EXTRA_DIST += tools/mesh-gatt/local_node.json tools/mesh-gatt/prov_db.json
 endif
+EXTRA_DIST += tools/mesh-gatt/local_node.json tools/mesh-gatt/prov_db.json
 
 bin_PROGRAMS +=  tools/mesh-cfgclient
 
-- 
2.53.0


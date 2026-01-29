Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6838885E
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769691606; cv=none; b=ACRoCY3d9r3COGiWr1kiCsjDYscFTShObv+6jFm1bCyNIbzjcTM++UV/L5oXLsXyE6CXYSIu+rtnXjwfdvZWtvye8G1XN7sUkUoIVM+cEEus3od8Sta9+N0AvUylvQMMOoxLWDzBqj4Br4oYCs+R0srIhp0d3308vrefQz9ld6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769691606; c=relaxed/simple;
	bh=UnH38xtdfKL3J6kN8iLrynTiAuqZWwyuvoNxKPRTdLU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fa8ZYeuASYNL4ILxnfbpobv6Z97PcQ9G9WlRpW0DVTQ0M2UP0a/lJClo6/l+/cJ2FoeGRE5rUugodJm8jJpLkrG2LgQ5xbhZFzch7mULZ8bUqaN2/oNrTPfNDERyQKkTyItWCIBL8k7Oqqi4HiKb3343WFkRhmXRwlvpQPmckKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A9CF743A19
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 12:59:56 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/1] build: Don't install btmgmt man page as tool isn't
Date: Thu, 29 Jan 2026 13:57:02 +0100
Message-ID: <20260129125948.2724071-2-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129125948.2724071-1-hadess@hadess.net>
References: <20260129125948.2724071-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeivdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeetleevhfejgeefteduledpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean

The btmgmt tool isn't installed through the Makefiles, so the
man page shouldn't be installed either.
---
 Makefile.tools | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index b75e9782cd75..4f4ee88defa0 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -349,7 +349,7 @@ profiles_iap_iapd_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
 
 if MANPAGES
 man_MANS += doc/rctest.1 doc/l2ping.1 doc/btattach.1 doc/isotest.1 \
-		doc/btmgmt.1 doc/bluetoothctl.1 \
+		doc/bluetoothctl.1 \
 		doc/bluetoothctl-mgmt.1 \
 		doc/bluetoothctl-monitor.1 doc/bluetoothctl-admin.1 \
 		doc/bluetoothctl-advertise.1 doc/bluetoothctl-endpoint.1 \
-- 
2.52.0


Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462D275B06
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700509; cv=none; b=CsU6uubaUg2h/UfrB8iKFma5waYpy84fs1U4kNs+D63CPIS/xNSKlELs1PCX6OGTitZ8zMUtf2oewsXNoU+Zw0m4s/u7XmmmKGTjyh57Y5lln7GGL0j2rYPoLsyddCOO65yUShakiOQqWPJIHde1slQB2XgCU8GozDNN48lEu+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700509; c=relaxed/simple;
	bh=rHdYdHg4yRUkEaec3FvJxlyFED8bz4rPN6XmioYj4Is=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvpJ7+TwK6JcJrWM3+ip1eRjJ9O2x6mocWX6XLMb6/qCcXCenKoL8ABTiKMoPCBnrT42eM1gN2nrr3ccpFDuGVtenjoY+gSZoHww6qa1VG5/iUeqMrAHW6wB6VY3Yy+PTjEavZykUXO03h2wl5S7m2auI4SNH16VlpU0+k+EfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 4704E584B8E
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:16:00 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 65CC04442B
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:15:53 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] input: Fix incorrect destructors being used
Date: Wed, 20 Aug 2025 16:15:46 +0200
Message-ID: <20250820141552.800720-3-hadess@hadess.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820141552.800720-1-hadess@hadess.net>
References: <20250820141552.800720-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdrrhgvughhrghtrdgtohhmpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

g_key_file_get_string() expects its value to be freed with g_free(), not
free().

Fixes:
profiles/input/manager.c:118:2: leaked_storage: Variable "uhid_enabled" going out of scope leaks the storage it points to.
profiles/input/hog.c:267:1: leaked_storage: Variable "uhid_enabled" going out of scope leaks the storage it points to.
---
 profiles/input/hog.c     | 2 +-
 profiles/input/manager.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index f5d24aad67e2..1f5b82b77435 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -259,7 +259,7 @@ static void hog_read_config(void)
 	if (!err) {
 		DBG("input.conf: UserspaceHID=%s", uhid_enabled);
 		uhid_state_persist = strcasecmp(uhid_enabled, "persist") == 0;
-		free(uhid_enabled);
+		g_free(uhid_enabled);
 	} else
 		g_clear_error(&err);
 
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index d0db13f2d3e9..b0e415f6706c 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -101,7 +101,7 @@ static int input_init(void)
 		if (!err) {
 			DBG("input.conf: UserspaceHID=%s", uhid_enabled);
 			input_set_userspace_hid(uhid_enabled);
-			free(uhid_enabled);
+			g_free(uhid_enabled);
 		} else
 			g_clear_error(&err);
 
-- 
2.50.1


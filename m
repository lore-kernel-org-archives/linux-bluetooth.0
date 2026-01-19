Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA47B35CB7C
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831971; cv=none; b=GdPMi8ZC0olQltii0zavq5Xgz8HNy3dKCuvmNbomQvM9PmbVMH2NNYwq7g3cidPGugkQBTegPv8/0rQ7NoM6iPKIiHJaF5G1JVSc21B0psC1kIosN4VqrdYX+jFYY2p7fDb6+R3j5eD+Q57c6W75uvAtw7TmqBlBmXkUOwKj3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831971; c=relaxed/simple;
	bh=mXWEQVEiij9UPqbWZqcwfF1GTDHhZdHjU59rSPVOTh4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azMeC5Jc2ffgT0Nx7oyjZ3UdhZacNyopCGMJWi/BDIQCSF2b6JWapxdlZ/SPIkyepvr+/nOSnZhqiLM+3eQ38d5UXxvqnDWK6JaFoWfFDk+gnGFq9xeu8YZDJ63Qi2zSwCirJ7VY1hF3h/gsGy0gXOt82xo4FxeMkfPQog0UDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7186443A0A
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:12:48 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 2/4] src: Prefix plugin-accessible adapter_set_name() function
Date: Mon, 19 Jan 2026 14:27:10 +0100
Message-ID: <20260119141239.2683954-3-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeejudekieeggeeftedttedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Plugin-accessible functions are usually prefixed with btd_ to avoid
confusing them with internal private functions. Rename
adapter_set_name() to match the existing btd_adapter_set_class().
---
 plugins/hostname.c | 4 ++--
 src/adapter.c      | 2 +-
 src/adapter.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/hostname.c b/plugins/hostname.c
index 35420e5d587b..c827506275aa 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -82,7 +82,7 @@ static void update_name(struct btd_adapter *adapter, gpointer user_data)
 	if (btd_adapter_is_default(adapter)) {
 		DBG("name: %s", hostname);
 
-		adapter_set_name(adapter, hostname);
+		btd_adapter_set_name(adapter, hostname);
 	} else {
 		uint16_t index = btd_adapter_get_index(adapter);
 		char *str;
@@ -92,7 +92,7 @@ static void update_name(struct btd_adapter *adapter, gpointer user_data)
 
 		DBG("name: %s", str);
 
-		adapter_set_name(adapter, str);
+		btd_adapter_set_name(adapter, str);
 
 		g_free(str);
 	}
diff --git a/src/adapter.c b/src/adapter.c
index a5de7cee1552..3bbee2e36810 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -998,7 +998,7 @@ static int set_name(struct btd_adapter *adapter, const char *name)
 	return -EIO;
 }
 
-int adapter_set_name(struct btd_adapter *adapter, const char *name)
+int btd_adapter_set_name(struct btd_adapter *adapter, const char *name)
 {
 	if (g_strcmp0(adapter->system_name, name) == 0)
 		return 0;
diff --git a/src/adapter.h b/src/adapter.h
index dd0c90d9cb3a..e562b1bcd4da 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -100,7 +100,6 @@ const char *adapter_get_path(struct btd_adapter *adapter);
 const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter);
 uint8_t btd_adapter_get_address_type(struct btd_adapter *adapter);
 const char *btd_adapter_get_storage_dir(struct btd_adapter *adapter);
-int adapter_set_name(struct btd_adapter *adapter, const char *name);
 
 int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec);
 void adapter_service_remove(struct btd_adapter *adapter, uint32_t handle);
@@ -114,6 +113,7 @@ void btd_adapter_unref(struct btd_adapter *adapter);
 
 void btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 							uint8_t minor);
+int btd_adapter_set_name(struct btd_adapter *adapter, const char *name);
 
 struct btd_adapter_driver {
 	const char *name;
-- 
2.52.0


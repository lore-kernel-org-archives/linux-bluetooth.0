Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0336829F
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831971; cv=none; b=WOGm8I49TbzYdJY0Yke8oPMPY/fzFjKeLuSNTwkQLvETznXN29XevLEUDdmX5RLC8V33AsMYh9u+cuswc0rqVKQXyKt4pfYVBt37jF2dz9ns8yjciPf1Pj5o5R/ve2TJaSiWVTDCv/fVnwdcUFkW5Csgq9A7orCKinnxCnT4+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831971; c=relaxed/simple;
	bh=w8sIUElyEXNMG/7tAD83riUGOulMyUKNzE/2aJ4bIHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aabKG7y8dA9ViySMS+E/BUnqGt4/6np7PWPHRNbKcNhcq9tvb3YXdZWttr6/XD1ChwCq3PIMBHfa3ORONi2zJfGnI04ZW9l7idaNOTbcNofAJ5QfPme+Gxq3w1Ev0rpjLPZbwpXgbt7W1ZSxVWKn7GmNWg/ZN565/1GQw/6VBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE544439FD
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:12:48 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 4/4] src: Prefix plugin-accessible adapter_foreach() function
Date: Mon, 19 Jan 2026 14:27:12 +0100
Message-ID: <20260119141239.2683954-5-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeffgfehgeeggeeflefhffdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

---
 plugins/hostname.c  | 8 ++++----
 src/adapter.c       | 6 +++---
 src/adapter.h       | 3 ++-
 src/agent.c         | 4 ++--
 src/gatt-database.c | 2 +-
 src/profile.c       | 4 ++--
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/plugins/hostname.c b/plugins/hostname.c
index c827506275aa..5a04df80560f 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -140,7 +140,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 			g_free(pretty_hostname);
 			pretty_hostname = g_strdup(str);
 
-			adapter_foreach(update_name, NULL);
+			btd_adapter_foreach(update_name, NULL);
 		}
 	} else if (g_str_equal(name, "StaticHostname") == TRUE) {
 		if (iter == NULL) {
@@ -158,7 +158,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 			g_free(static_hostname);
 			static_hostname = g_strdup(str);
 
-			adapter_foreach(update_name, NULL);
+			btd_adapter_foreach(update_name, NULL);
 		}
 	} else if (g_str_equal(name, "Chassis") == TRUE) {
 		if (iter == NULL) {
@@ -181,7 +181,7 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 				major_class = chassis_table[i].major_class;
 				minor_class = chassis_table[i].minor_class;
 
-				adapter_foreach(update_class, NULL);
+				btd_adapter_foreach(update_class, NULL);
 				break;
 			}
 		}
@@ -210,7 +210,7 @@ static gboolean hostname_cb(GIOChannel *io, GIOCondition cond,
 {
 	DBG("transient hostname changed");
 	read_transient_hostname();
-	adapter_foreach(update_class, NULL);
+	btd_adapter_foreach(update_class, NULL);
 	return TRUE;
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index 1eaadc4f89bb..31d4ae917688 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7709,7 +7709,7 @@ int btd_register_adapter_driver(const struct btd_adapter_driver *driver)
 	if (driver->probe == NULL)
 		return 0;
 
-	adapter_foreach(probe_driver, (void *) driver);
+	btd_adapter_foreach(probe_driver, (void *) driver);
 
 	return 0;
 }
@@ -7728,7 +7728,7 @@ void btd_unregister_adapter_driver(const struct btd_adapter_driver *driver)
 {
 	adapter_drivers = g_slist_remove(adapter_drivers, (void *) driver);
 
-	adapter_foreach(unload_driver, (void *) driver);
+	btd_adapter_foreach(unload_driver, (void *) driver);
 }
 
 static void agent_auth_cb(struct agent *agent, DBusError *derr,
@@ -9332,7 +9332,7 @@ struct btd_adapter *adapter_find_by_id(int id)
 	return match->data;
 }
 
-void adapter_foreach(adapter_cb func, gpointer user_data)
+void btd_adapter_foreach(adapter_cb func, gpointer user_data)
 {
 	g_slist_foreach(adapters, (GFunc) func, user_data);
 }
diff --git a/src/adapter.h b/src/adapter.h
index 09d08f9d5b6f..cdcee69385cb 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -53,6 +53,8 @@ int adapter_init(void);
 void adapter_cleanup(void);
 void adapter_shutdown(void);
 
+void btd_adapter_foreach(adapter_cb func, gpointer user_data);
+
 typedef void (*btd_disconnect_cb) (struct btd_device *device, uint8_t reason);
 void btd_add_disconnect_cb(btd_disconnect_cb func);
 void btd_remove_disconnect_cb(btd_disconnect_cb func);
@@ -63,7 +65,6 @@ void btd_remove_conn_fail_cb(btd_conn_fail_cb func);
 
 struct btd_adapter *adapter_find(const bdaddr_t *sba);
 struct btd_adapter *adapter_find_by_id(int id);
-void adapter_foreach(adapter_cb func, gpointer user_data);
 
 bool btd_adapter_get_pairable(struct btd_adapter *adapter);
 bool btd_adapter_get_powered(struct btd_adapter *adapter);
diff --git a/src/agent.c b/src/agent.c
index c990dc368439..3696575b83e6 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -148,7 +148,7 @@ static bool add_default_agent(struct agent *agent)
 
 	DBG("Default agent set to %s %s", agent->owner, agent->path);
 
-	adapter_foreach(set_io_cap, agent);
+	btd_adapter_foreach(set_io_cap, agent);
 
 	return true;
 }
@@ -168,7 +168,7 @@ static void remove_default_agent(struct agent *agent)
 	else
 		DBG("Default agent cleared");
 
-	adapter_foreach(set_io_cap, agent);
+	btd_adapter_foreach(set_io_cap, agent);
 }
 
 static void agent_disconnect(DBusConnection *conn, void *user_data)
diff --git a/src/gatt-database.c b/src/gatt-database.c
index ff5fa3bcc8b2..5819c252900c 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -548,7 +548,7 @@ static void profile_remove(void *data)
 
 	DBG("Removed \"%s\"", p->name);
 
-	adapter_foreach(adapter_remove_profile, p);
+	btd_adapter_foreach(adapter_remove_profile, p);
 	btd_profile_unregister(p);
 
 	g_free((void *) p->name);
diff --git a/src/profile.c b/src/profile.c
index 46a3d3b45718..dfc5f7161db9 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -2452,14 +2452,14 @@ static struct ext_profile *create_ext(const char *owner, const char *path,
 
 	ext_profiles = g_slist_append(ext_profiles, ext);
 
-	adapter_foreach(adapter_add_profile, &ext->p);
+	btd_adapter_foreach(adapter_add_profile, &ext->p);
 
 	return ext;
 }
 
 static void remove_ext(struct ext_profile *ext)
 {
-	adapter_foreach(adapter_remove_profile, &ext->p);
+	btd_adapter_foreach(adapter_remove_profile, &ext->p);
 
 	ext_profiles = g_slist_remove(ext_profiles, ext);
 
-- 
2.52.0


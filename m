Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/profile: Fix possible crash when registering profiles
Date: Thu,  5 Nov 2015 15:35:12 +0200
Message-Id: <1446730512-4182-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Profiles under ext_profiles are local and should no be mixed with other
external profiles since its type is different which can may cause invalid
memory when accessing member of ext_profile struct.
---
 src/profile.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index 49445d7..5a4f09c 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -719,19 +719,13 @@ void btd_profile_foreach(void (*func)(struct btd_profile *p, void *data),
 
 int btd_profile_register(struct btd_profile *profile)
 {
-	if (profile->external)
-		ext_profiles = g_slist_append(ext_profiles, profile);
-	else
-		profiles = g_slist_append(profiles, profile);
+	profiles = g_slist_append(profiles, profile);
 	return 0;
 }
 
 void btd_profile_unregister(struct btd_profile *profile)
 {
-	if (profile->external)
-		ext_profiles = g_slist_remove(ext_profiles, profile);
-	else
-		profiles = g_slist_remove(profiles, profile);
+	profiles = g_slist_remove(profiles, profile);
 }
 
 static struct ext_profile *find_ext_profile(const char *owner,
@@ -742,10 +736,6 @@ static struct ext_profile *find_ext_profile(const char *owner,
 	for (l = ext_profiles; l != NULL; l = g_slist_next(l)) {
 		struct ext_profile *ext = l->data;
 
-		/*
-		 * Owner and path can be NULL if profile was registered by a
-		 * plugin using external flag.
-		 */
 		if (g_strcmp0(ext->owner, owner))
 			continue;
 
-- 
2.4.3


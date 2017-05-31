Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/gatt: Fix not registering .accept callback for external profiles
Date: Wed, 31 May 2017 13:56:40 +0300
Message-Id: <20170531105640.3132-2-luiz.dentz@gmail.com>
In-Reply-To: <20170531105640.3132-1-luiz.dentz@gmail.com>
References: <20170531105640.3132-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The .accept callback is mandatory since probe_service has been changed to
check for it in 89ca735e57417ec296a41d8c31d0d0d5c66ce2a9.
---
 src/gatt-database.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 5979e37..3b4bc7c 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2248,6 +2248,15 @@ static void profile_device_remove(struct btd_service *service)
 	DBG("%s removed", p->name);
 }
 
+static int profile_device_accept(struct btd_service *service)
+{
+	struct btd_profile *p = btd_service_get_profile(service);
+
+	DBG("%s accept", p->name);
+
+	return 0;
+}
+
 static int profile_add(struct external_profile *profile, const char *uuid)
 {
 	struct btd_profile *p;
@@ -2271,6 +2280,7 @@ static int profile_add(struct external_profile *profile, const char *uuid)
 
 	p->device_probe = profile_device_probe;
 	p->device_remove = profile_device_remove;
+	p->accept = profile_device_accept;
 	p->auto_connect = true;
 	p->external = true;
 
-- 
2.9.4


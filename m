Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 20/27] network: Add trivial helper function
Date: Fri, 26 Apr 2013 08:17:16 +0200
Message-Id: <1366957043-2383-21-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Simplify the code and make it more readable by adding a trivial helper
function.
---
 profiles/network/connection.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index cc7c5ce..16ee318 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -85,6 +85,11 @@ struct __service_16 {
 
 static GSList *peers = NULL;
 
+static uint16_t get_service_id(struct btd_service *service)
+{
+	return bnep_service_id(btd_service_get_profile(service)->remote_uuid);
+}
+
 static struct network_peer *find_peer(GSList *list, struct btd_device *device)
 {
 	for (; list; list = list->next) {
@@ -644,9 +649,8 @@ static const GDBusPropertyTable connection_properties[] = {
 void connection_unregister(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct btd_profile *p = btd_service_get_profile(service);
 	struct network_peer *peer;
-	uint16_t id = bnep_service_id(p->remote_uuid);
+	uint16_t id = get_service_id(service);
 
 	DBG("%s id %u", device_get_path(device), id);
 
@@ -692,10 +696,9 @@ static struct network_peer *create_peer(struct btd_device *device)
 int connection_register(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct btd_profile *p = btd_service_get_profile(service);
 	struct network_peer *peer;
 	struct network_conn *nc;
-	uint16_t id = bnep_service_id(p->remote_uuid);
+	uint16_t id = get_service_id(service);
 
 	DBG("%s id %u", device_get_path(device), id);
 
-- 
1.8.1.4


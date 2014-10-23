Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 07/14] shared/gatt: Remove not needed function parameter
Date: Thu, 23 Oct 2014 12:15:30 +0200
Message-Id: <1414059337-12040-8-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414059337-12040-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414059337-12040-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to SPEC 4.1 4.5.1 "Find Included Services" there is no need
to pass UUID to discover_included_services() function.
---
 src/shared/gatt-helpers.c | 1 -
 src/shared/gatt-helpers.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index f993243..d751d5a 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1067,7 +1067,6 @@ failed:
 
 bool bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index df003ac..07c145d 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -83,7 +83,6 @@ bool bt_gatt_discover_secondary_services(struct bt_att *att, bt_uuid_t *uuid,
 					bt_gatt_destroy_func_t destroy);
 bool bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-- 
1.9.3


Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 06/14] shared/gatt: Remove not needed function parameter
Date: Fri, 10 Oct 2014 11:15:40 +0200
Message-Id: <1412932548-28363-7-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1412932548-28363-1-git-send-email-marcin.kraglak@tieto.com>
References: <1412932548-28363-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to SPEC 4.1 4.5.1 "Find Included Services" there is no need
to pass UUID to discover_included_services() function.
---
 src/shared/gatt-helpers.c | 1 -
 src/shared/gatt-helpers.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index fd8d06c..48e7379 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1002,7 +1002,6 @@ done:
 
 bool bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 8c434c1..f2c7ec5 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -82,7 +82,6 @@ bool bt_gatt_discover_secondary_services(struct bt_att *att, bt_uuid_t *uuid,
 					bt_gatt_destroy_func_t destroy);
 bool bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-- 
1.9.3


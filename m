Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/6] shared/gatt: Remove not needed function parameter
Date: Mon,  6 Oct 2014 07:55:43 +0200
Message-Id: <1412574944-5304-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1412574944-5304-1-git-send-email-marcin.kraglak@tieto.com>
References: <1412574944-5304-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to SPEC 4.1 4.5.1 "Find Included Services" there is no need
to pass UUID to discover_included_services() function.
---
 src/shared/gatt-helpers.c | 1 -
 src/shared/gatt-helpers.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 6a2cc22..c23fd06 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -978,7 +978,6 @@ done:
 
 bool bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index da409fa..abd218c 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -77,7 +77,6 @@ bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
 					bt_gatt_destroy_func_t destroy);
 bool bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-- 
1.9.3


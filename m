Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 4/4] tools/gatt-service: Fix clang compile error
Date: Mon,  4 May 2015 16:28:14 -0700
Message-Id: <1430782094-18396-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1430782094-18396-1-git-send-email-armansito@chromium.org>
References: <1430782094-18396-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the following compile warning when bluez is compiled
using clang:

tools/gatt-service.c:77:19: error: duplicate 'const' declaration specifier [-Werror,-Wduplicate-decl-specifier]
static const char const *ias_alert_level_props[] = {
                  ^
---
 tools/gatt-service.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 33e0d6a..9baa9e1 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -74,9 +74,7 @@ struct descriptor {
  * properties are defined at doc/gatt-api.txt. See "Flags"
  * property of the GattCharacteristic1.
  */
-static const char const *ias_alert_level_props[] = {
-						"write-without-response",
-						NULL };
+static const char *ias_alert_level_props[] = { "write-without-response", NULL };
 
 static gboolean desc_get_uuid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
-- 
2.2.0.rc0.207.ga3a616c


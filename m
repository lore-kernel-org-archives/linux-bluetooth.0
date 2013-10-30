Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/hal: Fix using void pointer in math operations
Date: Wed, 30 Oct 2013 10:27:54 +0200
Message-Id: <1383121674-24244-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes following compiler warnings:
...
hal-bluetooth.c: In function 'handle_adapter_props_changed':
hal-bluetooth.c:57:9: warning: pointer of type 'void *' used in arithmetic [-Wpointer-arith]
hal-bluetooth.c:57:29: warning: pointer of type 'void *' used in arithmetic [-Wpointer-arith]
hal-bluetooth.c:57:51: warning: pointer of type 'void *' used in arithmetic [-Wpointer-arith]
hal-bluetooth.c:66:5: warning: pointer of type 'void *' used in arithmetic [-Wpointer-arith]
...
---
 android/hal-bluetooth.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index fc60d72..0c083de 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -44,17 +44,18 @@ static void handle_adapter_props_changed(void *buf, uint16_t len)
 	struct hal_ev_adapter_props_changed *ev = buf;
 	bt_property_t props[ev->num_props];
 	struct hal_property *hal_prop;
-	void *p;
+	uint8_t *p;
 	int i;
 
 	if (!bt_hal_cbacks->adapter_properties_cb)
 		return;
 
 	hal_prop = ev->props;
-	p = ev->props;
+	p = (uint8_t *) ev->props;
 
 	for (i = 0; i < ev->num_props; i++) {
-		if (p + sizeof(*hal_prop) + hal_prop->len > buf + len) {
+		if (p + sizeof(*hal_prop) + hal_prop->len >
+							(uint8_t *) buf + len) {
 			error("invalid adapter properties event, aborting");
 			exit(EXIT_FAILURE);
 		}
@@ -64,7 +65,7 @@ static void handle_adapter_props_changed(void *buf, uint16_t len)
 		props[i].val = hal_prop->val;
 
 		p += sizeof(*hal_prop) + hal_prop->len;
-		hal_prop = p;
+		hal_prop = (struct hal_property *) p;
 
 		DBG("prop[%d]: %s", i, btproperty2str(&props[i]));
 	}
-- 
1.7.10.4


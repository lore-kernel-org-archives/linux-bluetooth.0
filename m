Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 2/9] android: Avoid unneeded includes
Date: Mon, 11 Nov 2013 16:03:40 +0200
Message-Id: <1384178627-25991-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384178627-25991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384178627-25991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Declare struct mgmt in adapter.h. This avoids including mgmt.h in
every file using adapter functions like socket and hid.
---
 android/adapter.h |    2 ++
 android/hidhost.c |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/adapter.h b/android/adapter.h
index c62b859..3bda9d9 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -23,6 +23,8 @@
 
 typedef void (*bt_adapter_ready)(int err);
 
+struct mgmt;
+
 void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 							bt_adapter_ready cb);
 
diff --git a/android/hidhost.c b/android/hidhost.c
index 683938f..8c3e9f6 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -38,7 +38,6 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "lib/uuid.h"
-#include "src/shared/mgmt.h"
 #include "src/sdp-client.h"
 #include "src/glib-helper.h"
 #include "profiles/input/uhid_copy.h"
-- 
1.7.10.4


Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/7] proximity: Remove unused definitions
Date: Fri, 31 Aug 2012 14:48:28 +0200
Message-ID: <1346417314-25109-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/proximity/linkloss.c | 2 --
 profiles/proximity/reporter.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
index 14403cb..6ed568c 100644
--- a/profiles/proximity/linkloss.c
+++ b/profiles/proximity/linkloss.c
@@ -44,8 +44,6 @@
 #include "reporter.h"
 #include "linkloss.h"
 
-#define BLUEZ_SERVICE "org.bluez"
-
 struct link_loss_adapter {
 	struct btd_adapter *adapter;
 	uint16_t alert_lvl_value_handle;
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index a3a8c8a..de3770a 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -49,8 +49,6 @@
 #include "linkloss.h"
 #include "immalert.h"
 
-#define BLUEZ_SERVICE "org.bluez"
-
 struct reporter_adapter {
 	DBusConnection *conn;
 	struct btd_adapter *adapter;
-- 
1.7.11.3


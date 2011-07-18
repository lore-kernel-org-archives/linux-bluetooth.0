Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Fix compilation with --disable-sap and glib < 2.28
Date: Mon, 18 Jul 2011 13:01:14 +0200
Message-ID: <1310986874-30015-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony-maemo6.c |    3 +++
 audio/telephony-ofono.c  |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 14d1ead..4430cc1 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -36,6 +36,9 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
+#include <bluetooth/sdp.h>
+
+#include "glib-helper.h"
 #include "log.h"
 #include "telephony.h"
 #include "error.h"
diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index e72734c..26815cf 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -35,6 +35,9 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
+#include <bluetooth/sdp.h>
+
+#include "glib-helper.h"
 #include "log.h"
 #include "telephony.h"
 
-- 
on behalf of ST-Ericsson


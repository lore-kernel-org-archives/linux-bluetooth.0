Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/8] doc: Update valgrind.suppressions with some libdbus suppressions
Date: Fri, 30 Nov 2012 13:57:38 +0100
Message-ID: <1354280264-19036-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354280264-19036-1-git-send-email-szymon.janc@tieto.com>
References: <1354280264-19036-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Suppress some useless libdbus warnings.
---
 doc/valgrind.suppressions |   81 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/doc/valgrind.suppressions b/doc/valgrind.suppressions
index 5967a15..07f3238 100644
--- a/doc/valgrind.suppressions
+++ b/doc/valgrind.suppressions
@@ -233,4 +233,83 @@
    fun:dbus_connection_send_with_reply_and_block
    fun:dbus_bus_register
 }
-
+{
+   <insert_a_suppression_name_here>
+   Memcheck:Leak
+   fun:malloc
+   ...
+   obj:/lib/*/libdbus-*
+   ...
+   fun:g_dbus_setup_bus
+}
+{
+   <insert_a_suppression_name_here>
+   Memcheck:Leak
+   fun:calloc
+   ...
+   obj:/lib/*/libdbus-*
+   ...
+   fun:g_dbus_setup_bus
+   fun:connect_dbus
+   ...
+}
+{
+   <insert_a_suppression_name_here>
+   Memcheck:Leak
+   fun:realloc
+   ...
+   obj:/lib/*/libdbus-*
+   ...
+   fun:dbus_connection_send_with_reply_and_block
+   fun:dbus_bus_register
+   ...
+}
+{
+   <insert_a_suppression_name_here>
+   Memcheck:Leak
+   fun:calloc
+   ...
+   obj:/lib/*/libdbus-*
+   ...
+   fun:dbus_connection_send_with_reply_and_block
+   fun:dbus_bus_register
+   ...
+}
+{
+   <insert_a_suppression_name_here>
+   Memcheck:Leak
+   fun:malloc
+   ...
+   obj:/lib/*/libdbus-*
+   ...
+   fun:dbus_connection_send_with_reply_and_block
+   fun:dbus_bus_register
+   ...
+}
+{
+   <insert_a_suppression_name_here>
+   Memcheck:Leak
+   fun:calloc
+   ...
+   obj:/lib/*/libdbus-*
+   ...
+   fun:dbus_connection_send_with_reply_and_block
+   fun:dbus_bus_request_name
+}
+{
+   <insert_a_suppression_name_here>
+   Memcheck:Leak
+   fun:realloc
+   ...
+   obj:/lib/*/libdbus-*
+   ...
+   fun:dbus_connection_send_with_reply_and_block
+   fun:dbus_bus_request_name
+}
+{
+   <insert_a_suppression_name_here>
+   Memcheck:Leak
+   fun:realloc
+   ...
+   obj:/lib/*/libdbus-*
+}
-- 
1.7.9.5


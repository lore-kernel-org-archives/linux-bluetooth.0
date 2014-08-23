Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 01/13] TODO: Add items for tasks involving the new shared ATT/GATT stack
Date: Fri, 22 Aug 2014 17:47:35 -0700
Message-Id: <1408754867-13313-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1408754867-13313-1-git-send-email-armansito@chromium.org>
References: <1408754867-13313-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 TODO | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/TODO b/TODO
index 50678d3..39a1773 100644
--- a/TODO
+++ b/TODO
@@ -136,8 +136,110 @@ Low Energy
   Priority: Low
   Complexity: C2
 
-ATT/GATT
-========
+ATT/GATT (new shared stack)
+===========================
+
+- shared/att currently doesn't handle signed writes. It should be extended to
+  support signing outgoing and verify incoming ATT PDUs.
+
+  Priority: Medium
+  Complexity: C1
+
+- Introduce shared/gatt-client as a standalone client implementation that can
+  operate on a single instance of bt_att as the ATT protocol transport. The
+  basic API should include functions for reference counting, setting a handler
+  for util_debug, and a high-level abstraction for GATT services,
+  characteristics, and descriptors.
+
+  Priority: Medium
+  Complexity: C1
+
+- Implement attribute discovery for shared/gatt-client. All services,
+  characteristics, and descriptors should be discovered and cached during the
+  set up process, which should also involve the initial MTU exchange.
+
+  Priority: Medium
+  Complexity: C1
+
+- Merge functions from shared/gatt-helpers involving value reads and writes into
+  shared/gatt-client. These functions should accept an instance of
+  bt_gatt_client instead of taking a bt_att directly.
+
+  Priority: Medium
+  Complexity: C1
+
+- Properly handle indications from the "Service Changed" characteristic.
+  shared/gatt-client should automatically rediscover all changed GATT services
+  and notify the upper layer using a specially assigned handler.
+
+  Priority: Medium
+  Complexity: C1
+
+- Define API functions in shared/gatt-client for enabling/disabling
+  characteristic handle-value notifications/indications on a reference counted
+  basis. Code that is no longer interested in notifications from a
+  characteristic should be able to unregister any callbacks without writing to
+  the "Client Characteristic Configuration" descriptor if there are others who
+  are still interested.
+
+  Priority: Medium
+  Complexity: C2
+
+- Introduce a handler interface to shared/gatt-client which can be used by the
+  upper layer to determine when the link has been disconnected or an ATT
+  protocol request times out.
+
+  Priority: Medium
+  Complexity: C2
+
+- Introduce long-term caching of attributes to shared/gatt-client, such that the
+  services, characteristics, and descriptors obtained from a peripheral are
+  remembered in the case of bonding. This may involve storing data about GATT
+  services to disk.
+
+  Priority: Low
+  Complexity: C4
+
+- Introduce a new GATT client command-line tool to test and use a single
+  instance of bt_gatt_client.
+
+  Priority: Low
+  Complexity: C1
+
+- Move all daemon plugins and profiles that are GATT based to use
+  shared/gatt-client instead of attrib/*. This is a complicated task that
+  potentially needs a new plugin/profile probing interface and a lot of
+  rewriting that can cause regressions in existing functionality. The biggest
+  challenge here is that an instance of bt_att (shared/att) and GAttrib
+  (attrib/gattrib) cannot coexist on the same file descriptor, since they will
+  cause ATT protocol violations by breaking the sequential request-response
+  structure. A special shared/gatt-client-gattrib implementation may be
+  necessary to move each profile/plugin to the new API before actually switching
+  to the shared/att based implementation.
+
+  Priority: Medium
+  Complexity: C4
+
+- Implement the client portion of doc/gatt-api.txt using shared/gatt-client once
+  plugin/profile code uses it.
+
+  Priority: Medium
+  Complexity: C2
+
+- Introduce shared/gatt-server, which combined with shared/gatt-db, can be used
+  as a GATT server implementation.
+
+  Priority: Medium
+  Complexity: C2
+
+- Implement the server portion of doc/gatt-api.txt using shared/gatt-server once
+  it exists.
+
+  Priority: Medium
+  Complexity: C4
+
+ATT/GATT (old/outdated)
+=======================
 
 - At the moment authentication and authorization is not supported at the
   same time, read/write requirements in the attribute server needs to
-- 
2.1.0.rc2.206.gedb03e5


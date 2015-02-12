Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 14/14] TODO: Update GATT items.
Date: Wed, 11 Feb 2015 19:17:44 -0800
Message-Id: <1423711064-7390-15-git-send-email-armansito@chromium.org>
In-Reply-To: <1423711064-7390-1-git-send-email-armansito@chromium.org>
References: <1423711064-7390-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Updated the GATT/ATT related TODO items:

  - Removed item about disconnect handling as this is already done via
    bt_att.
  - Long-term client caching is currently done in memory. Updated this
    to mean peristent.
  - GAttrib has already been turned into a shim around bt_att. Updated
    the related item to involve updating profiles only.
  - GATT client D-Bus API has been implemented.
  - Added item for missing portion of Service Changed support.
  - Added item for GATT related refactors discussed over IRC.
  - Added item for supporting the Includes property in GATT client.
---
 TODO | 54 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/TODO b/TODO
index e489221..db80b95 100644
--- a/TODO
+++ b/TODO
@@ -136,41 +136,19 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C1
 
-- Introduce a handler interface to shared/gatt-client which can be used by the
-  upper layer to determine when the link has been disconnected or an ATT
-  protocol request times out.
+- Persist client attribute cache across reboots.
 
   Priority: Medium
-  Complexity: C2
-
-- Introduce long-term caching of attributes to shared/gatt-client, such that the
-  services, characteristics, and descriptors obtained from a peripheral are
-  remembered in the case of bonding. This may involve storing data about GATT
-  services to disk.
-
-  Priority: Low
   Complexity: C4
 
 - Move all daemon plugins and profiles that are GATT based to use
   shared/gatt-client instead of attrib/*. This is a complicated task that
   potentially needs a new plugin/profile probing interface and a lot of
-  rewriting that can cause regressions in existing functionality. The biggest
-  challenge here is that an instance of bt_att (shared/att) and GAttrib
-  (attrib/gattrib) cannot coexist on the same file descriptor, since they will
-  cause ATT protocol violations by breaking the sequential request-response
-  structure. A special shared/gatt-client-gattrib implementation may be
-  necessary to move each profile/plugin to the new API before actually switching
-  to the shared/att based implementation.
+  rewriting that can cause regressions in existing functionality.
 
   Priority: Medium
   Complexity: C4
 
-- Implement the client portion of doc/gatt-api.txt using shared/gatt-client once
-  plugin/profile code uses it.
-
-  Priority: Medium
-  Complexity: C2
-
 - Introduce a way for shared/gatt-server to check security permissions on the
   current connection through bt_att.
 
@@ -190,6 +168,34 @@ ATT/GATT (new shared stack)
   Priority: Medium
   Complexity: C4
 
+- Send out indications from the "Service Changed" characteristic upon
+  reconnection if a bonded device is not connected when the local database is
+  modified.
+
+  Priority: High
+  Complexity: C2
+
+- Unify the GATT server and client D-Bus implementations into a single module.
+  While these don't share a lot of code, keeping them all in src/gatt-dbus seems
+  to make more sense from an organizational perspective.
+
+  Priority: Low
+  Complexity: C1
+
+- Isolate all GATT code inside the daemon into its own module and perform
+  interaction with other modules (e.g. src/device.c) via callbacks. This
+  includes client/server management, tracking incoming/outgoing connections for
+  ATT, and callbacks to perform profile probing.
+
+  Priority: Low
+  Complexity: C4
+
+- Support included services in the GATT D-Bus client API.
+
+  Priority: Medium
+  Complexity: C1
+
+
 ATT/GATT (old/outdated)
 =======================
 
-- 
2.2.0.rc0.207.ga3a616c


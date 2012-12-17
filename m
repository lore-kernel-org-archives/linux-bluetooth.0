Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] TODO: Mark Convert obexd & obex-client to ObjectManager/Properties as done
Date: Mon, 17 Dec 2012 13:50:07 +0200
Message-Id: <1355745007-1493-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355745007-1493-1-git-send-email-luiz.dentz@gmail.com>
References: <1355745007-1493-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 TODO | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/TODO b/TODO
index d9a708b..5a70e40 100644
--- a/TODO
+++ b/TODO
@@ -60,8 +60,6 @@ BlueZ 5
 Priority/Complexity omitted as all items are required before 5.0 is
 released.
 
-- Convert obexd & obex-client to ObjectManager/Properties
-
 - [pending] Convert storage to user per-remote device directories and
   ini-file format
 
@@ -87,6 +85,8 @@ Completed items:
 
 - Convert obexd to use org.bluez.Profile
 
+- Convert obexd & obex-client to ObjectManager/Properties
+
 - Remove org.bluez.Service interface (it has become unnecessary thanks
   to org.bluez.Profile). obexd needs to be converted to use the new
   interface first.
-- 
1.7.11.7


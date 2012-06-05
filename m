Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 03/23] core: Change D-Bus service file to use org.bluez.obex
Date: Tue,  5 Jun 2012 13:57:01 +0300
Message-Id: <1338893841-14234-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/obexd.service.in |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/obexd.service.in b/src/obexd.service.in
index e857f09..4645f70 100644
--- a/src/obexd.service.in
+++ b/src/obexd.service.in
@@ -1,3 +1,3 @@
 [D-BUS Service]
-Name=org.openobex
+Name=org.bluez.obex
 Exec=@libexecdir@/obexd --nodaemon
-- 
1.7.10.2


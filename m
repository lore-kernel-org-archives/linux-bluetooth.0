Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 09/23 v2] client: Change D-Bus service file to use org.bluez.obex.client
Date: Tue,  5 Jun 2012 16:02:57 +0300
Message-Id: <1338901391-17138-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
References: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/obex-client.service.in |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/obex-client.service.in b/client/obex-client.service.in
index 79339d1..6ca7c5d 100644
--- a/client/obex-client.service.in
+++ b/client/obex-client.service.in
@@ -1,3 +1,3 @@
 [D-BUS Service]
-Name=org.openobex.client
+Name=org.bluez.obex.client
 Exec=@libexecdir@/obex-client
-- 
1.7.10.2


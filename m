Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/6 v2] bluetooth: make use of secure flag for authorization
Date: Sun, 27 Nov 2011 23:12:06 +0200
Message-Id: <1322428331-28204-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Using secure flag is probably safer here as other services beside OPP
may not require security/authorization.
---

 plugins/bluetooth.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index c73beb6..613b2a5 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -479,7 +479,7 @@ static void confirm_event(GIOChannel *io, void *user_data)
 		goto drop;
 	}
 
-	if (driver->service != OBEX_OPP) {
+	if (driver->secure) {
 		if (request_service_authorization(service, io, address) < 0)
 			goto drop;
 
-- 
1.7.7.3


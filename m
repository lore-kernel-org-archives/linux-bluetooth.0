Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Don Zickus <dzickus@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, mkasik@redhat.com,
	Don Zickus <dzickus@redhat.com>
Subject: [PATCH 3/3] obexd: Add a detailed failure message for exchanging business cards
Date: Thu, 30 Jun 2016 17:01:29 -0400
Message-Id: <1467320489-127890-4-git-send-email-dzickus@redhat.com>
In-Reply-To: <1467320489-127890-1-git-send-email-dzickus@redhat.com>
References: <1467320489-127890-1-git-send-email-dzickus@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When sending the ExchangeBusinessCards() command, the command returns
a failure.  It isn't clear what that failure is.  Upon looking through
the code, it is obvious the funciton is not implemented.

This patch just adds an extra detail message 'Not Implemented' to make
the failure a little more clear about what the problem is.
---
 obexd/client/opp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/client/opp.c b/obexd/client/opp.c
index 3c2801a..0e063dd 100644
--- a/obexd/client/opp.c
+++ b/obexd/client/opp.c
@@ -117,7 +117,7 @@ fail:
 static DBusMessage *opp_exchange_business_cards(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	return g_dbus_create_error(message, ERROR_INTERFACE ".Failed", NULL);
+	return g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "Not Implemented");
 }
 
 static const GDBusMethodTable opp_methods[] = {
-- 
1.8.3.1


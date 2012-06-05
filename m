Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 17/23] test: Use org.bluez.obex namespace in exchange-business-cards script
Date: Tue,  5 Jun 2012 13:57:15 +0300
Message-Id: <1338893841-14234-18-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/exchange-business-cards |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/test/exchange-business-cards b/test/exchange-business-cards
index 4abe426..aace07b 100755
--- a/test/exchange-business-cards
+++ b/test/exchange-business-cards
@@ -4,17 +4,16 @@ import sys
 import dbus
 
 bus = dbus.SessionBus()
-client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-							"org.openobex.Client")
+client = dbus.Interface(bus.get_object("org.bluez.obex.client", "/"),
+					"org.bluez.obex.Client")
 
 if (len(sys.argv) < 4):
 	print "Usage: %s <device> <clientfile> <file>" % (sys.argv[0])
 	sys.exit(1)
 
 print "Creating Session"
-session_path = client.CreateSession(sys.argv[1], { "Target": "OPP" })
-opp = dbus.Interface(bus.get_object("org.openobex.client",
-					session_path),
-					"org.openobex.ObjectPush")
+path = client.CreateSession(sys.argv[1], { "Target": "OPP" })
+opp = dbus.Interface(bus.get_object("org.bluez.obex.client", path),
+					"org.bluez.obex.ObjectPush")
 
 opp.ExchangeBusinessCards(sys.argv[2], sys.argv[3])
-- 
1.7.10.2


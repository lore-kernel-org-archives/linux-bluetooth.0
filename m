Return-Path: <cyrus@holtmann.org>
Message-Id: <200908120918.n7C9Ihvn025042@home.pavel.comp>
From: Paul Fertser <fercerpav@gmail.com>
Date: Tue, 11 Aug 2009 10:19:13 +0400
Subject: [PATCH] network-api: improve documentation
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1250028267.30166.28.camel@localhost.localdomain>
References: <1250028267.30166.28.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Information about ways of specifying UUIDs and about disconnect conditions.

---
 doc/network-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 7271193..ae2be4f 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -17,6 +17,14 @@ Methods		string Connect(string uuid)
 			device name. Examples of the device name are bnep0,
 			bnep1 etc.
 
+			uuid can be either one of "gn", "panu" or "nap" (case
+			insensitive) or a traditional string representation of
+			UUID or a hexadecimal number.
+
+			The connection will be closed and network device
+			released either upon calling Disconnect() or when
+			the client disappears from the message bus.
+
 			Possible errors: org.bluez.Error.AlreadyConnected
 					 org.bluez.Error.ConnectionAttemptFailed
 
-- 
1.6.0.6

Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 1/2] Add RequestSecurePinCode to agent API
Date: Wed, 8 Jun 2011 16:05:19 +0200
Message-ID: <1307541920-3776-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The method is called if min. 16 bytes pincode is mendatory
to authenticate connection.

In practice this will be called only with mgmtops switched on. Hciops
don't support secure pin code so far.
---
 doc/agent-api.txt |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 9ab2063..b1cb354 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -31,6 +31,17 @@ Methods		void Release()
 			Possible errors: org.bluez.Error.Rejected
 			                 org.bluez.Error.Canceled
 
+		string RequestSecurePinCode(object device)
+
+			This method gets called when the service daemon
+			needs to get the secure passkey for an authentication.
+
+			The return value should be a string of 16 characters
+			length. The string can be alphanumeric.
+
+			Possible errors: org.bluez.Error.Rejected
+			                 org.bluez.Error.Canceled
+
 		uint32 RequestPasskey(object device)
 
 			This method gets called when the service daemon
-- 
1.7.4.1


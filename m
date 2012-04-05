Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, marcel@hotmann.org, hadess@hadess.net,
	Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv3 7/8] doc: document DisplayPinCode
Date: Thu,  5 Apr 2012 15:29:39 -0700
Message-Id: <1333664980-29165-8-git-send-email-scott@netsplit.com>
In-Reply-To: <1333664980-29165-1-git-send-email-scott@netsplit.com>
References: <1333664980-29165-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/agent-api.txt |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 9ab2063..5c8d4d2 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -61,6 +61,30 @@ Methods		void Release()
 			so the display should be zero-padded at the start if
 			the value contains less than 6 digits.
 
+		void DisplayPinCode(object device, string pincode)
+
+			This method gets called when the service daemon
+			needs to display a pincode for an authentication.
+
+			An empty reply should be returned. When the pincode
+			needs no longer to be displayed, the Cancel method
+			of the agent will be called.
+
+			If this method is not implemented the RequestPinCode
+			method will be used instead.
+
+			This is used during the pairing process of keyboards
+			that don't support Bluetooth 2.1 Secure Simple Pairing,
+			in contrast to DisplayPasskey which is used for those
+			that do.
+
+			This method will only ever be called once since
+			older keyboards do not support typing notification.
+
+			Note that the PIN will always be a 6-digit number,
+			zero-padded to 6 digits. This is for harmony with
+			the later specification.
+
 		void RequestConfirmation(object device, uint32 passkey)
 
 			This method gets called when the service daemon
-- 
1.7.7.3


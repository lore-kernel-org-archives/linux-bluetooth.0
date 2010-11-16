Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCHv3 6/7] Update DBus OOB API with RequestApproval method.
Date: Tue, 16 Nov 2010 16:44:06 +0100
Message-ID: <1289922247-20712-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1289922247-20712-1-git-send-email-szymon.janc@tieto.com>
References: <1289922247-20712-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/oob-api.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/doc/oob-api.txt b/doc/oob-api.txt
index 051b868..3a89f59 100644
--- a/doc/oob-api.txt
+++ b/doc/oob-api.txt
@@ -62,3 +62,17 @@ Methods		void RegisterProvider(object provider)
 			Possible errors: org.bluez.Error.ReadFailed
 					 org.bluez.Error.NoProvider
 					 org.bluez.Error.InProgress
+
+--------------------------------------------------------------------------------
+
+Service		unique name
+Interface	org.bluez.Agent
+Object path	freely definable
+
+Methods		void RequestApproval(object device)
+
+			This method gets called when the service daemon
+			needs to confirm incoming OOB pairing request.
+
+			Possible errors: org.bluez.Error.Rejected
+					 org.bluez.Error.Canceled
-- 
1.7.1


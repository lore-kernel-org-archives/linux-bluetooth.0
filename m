Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv4 6/7] Update D-Bus OOB API with RequestPairing method
Date: Tue, 23 Nov 2010 12:05:19 +0100
References: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com> <1290509592-9262-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1290509592-9262-7-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201011231205.19325.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed version (.orig removed)

---
 doc/oob-api.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/doc/oob-api.txt b/doc/oob-api.txt
index 4796e4c..e08f6f8 100644
--- a/doc/oob-api.txt
+++ b/doc/oob-api.txt
@@ -60,3 +60,17 @@ Methods		void RegisterProvider(object provider)
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
+Methods		void RequestPairing(object device)
+
+			This method gets called when the service daemon
+			needs to confirm incoming pairing request.
+
+			Possible errors: org.bluez.Error.Rejected
+					 org.bluez.Error.Canceled
-- 
1.7.1

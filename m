Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/5] TODO: Remove characteristic discovery for non connectable devices
Date: Mon,  3 Jan 2011 18:45:51 -0300
Message-Id: <1294091154-7367-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1294091154-7367-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1294091154-7367-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CreateDevice and CreatePairedDevice methods already check the event
type and AD Flags before to connect to discover all primary services.
Characteristic discovery will not be available since D-Bus method
is not exposed to Broadcaster devices.
---
 TODO |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/TODO b/TODO
index 6c5c58d..8d34035 100644
--- a/TODO
+++ b/TODO
@@ -17,15 +17,6 @@ Background
 Low Energy
 ==========
 
-- Avoid Characteristic discovery for non connectable devices. Proper parsing
-  of LE Advertising Report Event is missing. Event_Type field needs to be
-  extracted and its value shall be considered before to start the LE
-  connection on the channel 4. Characteristic discovery should not be
-  started for non connectable devices.
-
-  Priority: Medium
-  Complexity: C2
-
 - Advertising management. Adapter interface needs to be changed to manage
   connection modes, adapter type and advertising policy. See Volume 3,
   Part C, section 9.3. If Attribute Server is enabled the LE capable
-- 
1.7.3.4


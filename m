Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] build: Remove leftover from .gitignore
Date: Tue, 19 Feb 2013 17:00:04 -0400
Message-Id: <1361307604-4764-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1361307604-4764-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1361307604-4764-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

profiles/sap/sap.c used to be a symlink to a SAP driver. This symlink is
not created anymore (only the dummy driver is linked to bluetoothd at
the moment.)
---
 .gitignore |    1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 9483b92..e306f68 100644
--- a/.gitignore
+++ b/.gitignore
@@ -32,7 +32,6 @@ src/builtin.h
 src/bluetoothd
 tools/97-hid2hci.rules
 
-profiles/sap/sap.c
 profiles/cups/bluetooth
 profiles/iap/iapd
 
-- 
1.7.9.5


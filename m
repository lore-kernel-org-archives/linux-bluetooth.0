Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 3/3] doc: Add InvalidArguments to UnregisterService() errors
Date: Thu,  3 Apr 2014 16:46:52 -0300
Message-Id: <1396554412-2057-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396554412-2057-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396463426-7268-1-git-send-email-claudio.takahasi@openbossa.org>
 <1396554412-2057-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds "org.bluez.Error.InvalidArguments" as possible error
returned by GattManager1.UnregisterService().
---
 doc/gatt-api.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index deb519b..8c7975c 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -145,4 +145,5 @@ Methods		RegisterService(object service, dict options)
 			must match the same value that has been used
 			on registration.
 
-			Possible errors: org.bluez.Error.DoesNotExist
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.DoesNotExist
-- 
1.8.3.1


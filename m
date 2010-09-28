Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 4/4] Fix object path in the register watcher method
Date: Tue, 28 Sep 2010 14:49:15 -0300
Message-Id: <1285696155-32766-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1285696155-32766-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1285696155-32766-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The path argument in RegisterCharacteristicsWatcher method shall be
the agent's path. An agent will monitor changes in all characteristics.
---
 doc/attribute-api.txt |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index d0ce6f8..f66e9bc 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -69,18 +69,15 @@ Methods 	dict GetProperties()
 			Returns all properties for the interface. See the
 			Properties section for the available properties.
 
-		RegisterCharacteristicsWatcher(object path)
+		RegisterCharacteristicsWatcher(object agent)
 
-			Register a watcher for changes in specific characteristics
-			to monitor changes.
+			Register a watcher to monitor characteristic changes.
 
 			A watcher will be registered for this service and will
-			notifier about any changed characteristics in the service.
+			notify about any changed characteristics in the service.
 			This also notifies about any included characteristics.
 
-			Method for the watch objects still need to be defined.
-
-		UnregisterCharacteristicsWatcher(object path)
+		UnregisterCharacteristicsWatcher(object agent)
 
 			Unregister a watcher.
 
-- 
1.7.3


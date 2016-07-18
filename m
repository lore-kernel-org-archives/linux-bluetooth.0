Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] doc/adapter-api: Fix SetDiscoveryFilter documentation
Date: Mon, 18 Jul 2016 14:49:07 +0300
Message-Id: <1468842547-7088-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1468842547-7088-1-git-send-email-luiz.dentz@gmail.com>
References: <1468842547-7088-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The method is not set as experimental for while.
---
 doc/adapter-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 97462a3..08de6cd 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -45,7 +45,7 @@ Methods		void StartDiscovery()
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.Failed
 
-		void SetDiscoveryFilter(dict filter) [Experimental]
+		void SetDiscoveryFilter(dict filter)
 
 			This method sets the device discovery filter for the
 			caller. When this method is called with no filter
-- 
2.7.4


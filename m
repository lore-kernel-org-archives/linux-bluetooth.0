Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 4/5] Add DiscoverCharacteristics method to the Attribute API
Date: Mon, 14 Mar 2011 18:19:43 -0300
Message-Id: <1300137584-24437-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1300137584-24437-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1300137584-24437-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/attribute-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 23808e6..f2778f3 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -50,6 +50,14 @@ Methods 	dict GetProperties()
 			Returns all properties for the interface. See the
 			Properties section for the available properties.
 
+		array{object} DiscoverCharacteristics()
+
+			Discover all characteristics that belongs in this service.
+			When it returns all the characteristics paths will be
+			already registered. It will return the characteristics paths
+			as soon as they are discovered. After that it will try to
+			read all values.
+
 		RegisterCharacteristicsWatcher(object agent)
 
 			Register a watcher to monitor characteristic changes.
-- 
1.7.4.1


Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/4] Add Discover method to the Attribute API
Date: Fri, 11 Mar 2011 14:53:01 -0300
Message-Id: <1299865982-13601-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1299865982-13601-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1299865982-13601-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/attribute-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 23808e6..10a9a66 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -50,6 +50,14 @@ Methods 	dict GetProperties()
 			Returns all properties for the interface. See the
 			Properties section for the available properties.
 
+		Discover()
+
+			Discover all characteristics that belongs in this service.
+			When it returns all the characteristics paths will be
+			already registered. It will return as soon as all the
+			characteristics are discovered. After that it will try to
+			read all values.
+
 		RegisterCharacteristicsWatcher(object agent)
 
 			Register a watcher to monitor characteristic changes.
-- 
1.7.4.1


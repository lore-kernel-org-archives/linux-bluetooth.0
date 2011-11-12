Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 1/4] Add a way to manually configure the CCC attribute of a Characteristic
Date: Fri, 11 Nov 2011 21:20:06 -0300
Message-Id: <1321057209-24931-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1321057209-24931-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1321057209-24931-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/attribute-api.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 98d7f30..9f2273f 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -151,6 +151,13 @@ Properties 	string UUID [readonly]
 			Friendly representation of the Characteristic Value
 			based on the format attribute.
 
+		string Config [readwrite]
+
+		       Configuration of the characteristic, valid values:
+		       "notify", "indicate" or "none". This property is only
+		       present if the CCC Descriptor could be found during
+		       the discovery of characteristics.
+
 
 Characteristic Watcher hierarchy
 ===============================
-- 
1.7.7


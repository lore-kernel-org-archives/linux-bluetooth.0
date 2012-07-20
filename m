Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 1/4] client-doc: Fix typo
Date: Fri, 20 Jul 2012 13:02:25 +0200
Message-Id: <1342782148-10684-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
 doc/client-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 1938a38..11b79be 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -288,7 +288,7 @@ Methods		void Select(string location, string phonebook)
 		array{string} ListFilterFields()
 
 			Return All Available fields that can be used in
-			SefFilter method.
+			SetFilter method.
 
 		array{string} GetFilter()
 
-- 
1.7.7.6


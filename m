Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 2/4] client-doc: Minor style fix
Date: Fri, 20 Jul 2012 13:02:26 +0200
Message-Id: <1342782148-10684-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1342782148-10684-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1342782148-10684-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Fix lines that are over 80 columns.
---
 doc/client-api.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 11b79be..8202f39 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -361,7 +361,8 @@ Methods		void SetFolder(string name)
 
 				string Name : Folder name
 
-		array{object, dict} GetMessageListing(string folder, dict filter)
+		array{object, dict} GetMessageListing(string folder,
+								dict filter)
 
 			Returns an array containing the messages found in the
 			given folder.
-- 
1.7.7.6


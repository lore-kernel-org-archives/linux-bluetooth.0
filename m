Return-Path: <cyrus@holtmann.org>
From: DoHyun Pyun <dh79.pyun@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: DoHyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH] Fix incorrect spelling
Date: Mon, 26 Dec 2011 10:00:25 +0900
Message-id: <1324861225-3977-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes incorrect spelling.
---
 doc/adapter-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 3a29295..20cef03 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -257,7 +257,7 @@ Properties	string Address [readonly]
 			Note that this property only affects incoming pairing
 			requests.
 
-		uint32 PaireableTimeout [readwrite]
+		uint32 PairableTimeout [readwrite]
 
 			The pairable timeout in seconds. A value of zero
 			means that the timeout is disabled and it will stay in
-- 
1.7.4.1


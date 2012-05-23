Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 13/16] client-doc: Add signal to report new transfers
Date: Wed, 23 May 2012 17:00:15 +0200
Message-Id: <1337785218-8661-14-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337785218-8661-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337785218-8661-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This signal makes it possible to support transfer-monitoring
applications.
---
 doc/client-api.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 656c492..e6647ff 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -56,6 +56,10 @@ Properties	string Source [readonly]
 
 		byte Channel [readonly]
 
+Signals		void TransferAdded(object path, dict properties)
+
+			Informs that a new transfer has been created (queued).
+
 Object Push hierarchy
 =====================
 
-- 
1.7.7.6


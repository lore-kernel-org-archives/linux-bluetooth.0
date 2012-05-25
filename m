Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 02/16] client-doc: Add progress property to transfer
Date: Fri, 25 May 2012 12:11:19 +0200
Message-Id: <1337940693-3417-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This property exposes the number of bytes transferred so far in a given
transfer.
---
 doc/client-api.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index cfb4ec9..cc25543 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -312,6 +312,16 @@ Properties	string Name [readonly]
 
 			Complete name of the file being received or sent.
 
+		uint64 Progress [readonly, optional]
+
+			Number of bytes transferred. For queued transfers, this
+			value will not be present.
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
 Agent hierarchy
 ===============
 
-- 
1.7.7.6


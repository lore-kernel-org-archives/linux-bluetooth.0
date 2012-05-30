Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 04/14] client-doc: Add transfer event-reporting signals
Date: Wed, 30 May 2012 17:50:13 +0200
Message-Id: <1338393023-29941-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

These signals replace the old agent-based notification mechanism.
---
 doc/client-api.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index cc25543..223ef9a 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -322,6 +322,15 @@ Signals		PropertyChanged(string name, variant value)
 			This signal indicates a changed value of the given
 			property.
 
+		void Complete()
+
+			Informs that the transfer has completed successfully.
+
+		void Error(string code, string message)
+
+			Informs that the transfer has been terminated because
+			of some error.
+
 Agent hierarchy
 ===============
 
-- 
1.7.7.6


Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 4/4] client-doc: Describe session properties
Date: Fri, 20 Jul 2012 13:02:28 +0200
Message-Id: <1342782148-10684-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1342782148-10684-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1342782148-10684-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add a short description of the session properties to be consistent with
the rest of the documentation.
---
 doc/client-api.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 8621df8..c0cca2d 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -53,10 +53,16 @@ Methods		dict GetProperties()
 
 Properties	string Source [readonly]
 
+			Bluetooth address of the local adapter.
+
 		string Destination [readonly]
 
+			Bluetooth address of remote device.
+
 		byte Channel [readonly]
 
+			RFCOMM channel number being used.
+
 Object Push hierarchy
 =====================
 
-- 
1.7.7.6


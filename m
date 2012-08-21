Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0] client-doc: Guarantee prefix in transfer paths
Date: Tue, 21 Aug 2012 09:23:35 +0200
Message-Id: <1345533815-5611-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The client D-Bus documentation should mention that all transfer paths
contain a prefix consisting of the path of the session they belong to.

This can be conveniently used by clients to install D-Bus signal matches
that concentrate on the relevant signals.
---
 doc/client-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/client-api.txt b/doc/client-api.txt
index 839a78c..7ca65cc 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -466,7 +466,7 @@ Transfer hierarchy
 
 Service		org.bluez.obex.client
 Interface	org.bluez.obex.Transfer
-Object path	[variable prefix]/{transfer0,transfer1,...}
+Object path	[variable prefix]/{session0,session1,...}/{transfer0,...}
 
 Methods		dict GetProperties()
 
-- 
1.7.7.6


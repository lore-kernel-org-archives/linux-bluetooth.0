Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 2/7] attrib-api: Update introduction text
Date: Mon, 23 Jul 2012 11:55:15 -0400
Message-Id: <1343058920-18608-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We do not have service objects anymore.
---
 doc/attribute-api.txt |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 5f4209d..6560b53 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -6,22 +6,10 @@ Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
 Service details
 ---------------
 
-One service object path for every remote SDP record or service in the
-attribute database. One service object path for every local SDP record
-or service from attribute database.
-
-Local services are children of the adapter object path. Remote services
-are children of the remote device object path. This doesn't solve the
-problem where local attributes can have different instances based on
-the remote device.
-
-In general the idea is to also represent SDP records as services so that
-new style application can just use the service interfaces to retrieve the
-needed information. That way the usage of SDP and GATT would be mostly
-fully transparent and a differentiation becomes unimportant in the future.
-
-A service consists of some generic service information and a set of
-characteristics. All characteristic are presented as object path as well.
+All characteristics are presented as object paths in a single, flat list. Each
+object has a "ServiceUUID" property which contains the 128-bit UUID of the
+service that contains it, so clients can identify the correct characteristic if
+multiple services contain the same characteristic.
 
 
 Device Service hierarchy
-- 
1.7.9.5


Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] doc: Add GATT to the supported features
Date: Mon, 16 Jul 2012 18:26:38 -0300
Message-Id: <1342473998-22998-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/supported-features.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/supported-features.txt b/doc/supported-features.txt
index 0510860..91ddd42 100644
--- a/doc/supported-features.txt
+++ b/doc/supported-features.txt
@@ -10,6 +10,7 @@ Profile/protocol	Version		Role(s)
 GAP			4.0		(LE) Central, Observer, Broadcaster
 L2CAP			4.0		Server, Client
 SDP			4.0		Server, Client
+GATT			4.0		Server, Client
 SDAP			1.1		Server, Client
 RFCOMM			1.1		Server, Client
 SPP			1.1		Server, Client
-- 
1.7.10.4


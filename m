Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/5] gitignore: Add missing tools
Date: Fri, 21 Jun 2013 11:17:32 -0300
Message-Id: <1371824255-3071-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1371824255-3071-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index c6e0ae2..550b350 100644
--- a/.gitignore
+++ b/.gitignore
@@ -59,6 +59,8 @@ tools/avtest
 tools/bdaddr
 tools/btiotest
 tools/mpris-player
+tools/bluetooth-player
+tools/l2cap-tester
 test/sap_client.pyc
 test/bluezutils.pyc
 unit/test-eir
-- 
1.8.3.1


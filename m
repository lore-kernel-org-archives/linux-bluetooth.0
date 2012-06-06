Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 16/17] test: Fix test-sap-server import issue
Date: Wed, 6 Jun 2012 15:19:26 +0200
Message-ID: <1338988767-19467-16-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sap-client is a helper library and needs to be suffixed with .py for
test-sap-server to be able to import it.

$ ./test-sap-server
Traceback (most recent call last):
  File "./test-sap-server", line 3, in <module>
    from sap import *
ImportError: No module named sap
---
 .gitignore                         |    1 +
 test/{sap-client => sap_client.py} |    0
 test/test-sap-server               |    2 +-
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename test/{sap-client => sap_client.py} (100%)

diff --git a/.gitignore b/.gitignore
index 137d2e5..be64771 100644
--- a/.gitignore
+++ b/.gitignore
@@ -80,6 +80,7 @@ test/btiotest
 test/test-textfile
 test/uuidtest
 test/mpris-player
+test/sap_client.pyc
 compat/dund
 compat/hidd
 compat/pand
diff --git a/test/sap-client b/test/sap_client.py
similarity index 100%
rename from test/sap-client
rename to test/sap_client.py
diff --git a/test/test-sap-server b/test/test-sap-server
index bea6ca9..f5ad1c8 100755
--- a/test/test-sap-server
+++ b/test/test-sap-server
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 
-from sap import *
+from sap_client import *
 import time
 
 def connect_disconnect_by_client(sap):
-- 
on behalf of ST-Ericsson


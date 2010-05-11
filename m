Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 5/9] Adds a HDP XML record parsing script
Date: Tue, 11 May 2010 12:38:19 -0300
Message-Id: <1273592303-18234-5-git-send-email-epx@signove.com>
In-Reply-To: <1273592303-18234-1-git-send-email-epx@signove.com>
References: <1273592303-18234-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a very simple script which interprets an HDP
record in XML format and outputs a dictionary. The script accepts
either files or standard input as XML sources.
---
 test/hdp/hdp_record_parse.py |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)
 create mode 100755 test/hdp/hdp_record_parse.py

diff --git a/test/hdp/hdp_record_parse.py b/test/hdp/hdp_record_parse.py
new file mode 100755
index 0000000..27d0f35
--- /dev/null
+++ b/test/hdp/hdp_record_parse.py
@@ -0,0 +1,11 @@
+#!/usr/bin/env python
+
+import hdp_record
+import sys
+
+if len(sys.argv) > 1:
+	xml = open(sys.argv[1]).read()
+else:
+	xml = sys.stdin.read()
+
+print hdp_record.parse_xml(xml)
-- 
1.7.0.4


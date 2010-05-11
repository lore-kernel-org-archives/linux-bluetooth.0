Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 4/9] Adds sample HDP record generation script
Date: Tue, 11 May 2010 12:38:18 -0300
Message-Id: <1273592303-18234-4-git-send-email-epx@signove.com>
In-Reply-To: <1273592303-18234-1-git-send-email-epx@signove.com>
References: <1273592303-18234-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a very simple HDP record generation script,
which makes the XML-formatted record from a simple dict with
HDP info.
---
 test/hdp/hdp_record_gen.py |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100755 test/hdp/hdp_record_gen.py

diff --git a/test/hdp/hdp_record_gen.py b/test/hdp/hdp_record_gen.py
new file mode 100755
index 0000000..4d9ce03
--- /dev/null
+++ b/test/hdp/hdp_record_gen.py
@@ -0,0 +1,20 @@
+#!/usr/bin/env python
+
+import hdp_record
+
+feature1 = {'mdep_id': 0x01, 'role': 'source',
+		'data_type': 0x1004, 'description': "Fake oximeter"}
+feature2 = {'mdep_id': 0x01, 'role': 'source', 'data_type': 0x4005}
+feature3 = {'mdep_id': 0x02, 'role': 'sink', 'data_type': 0x4006}
+feature4 = {'mdep_id': 0x04, 'role': 'sink', 'data_type': 0x4007}
+# features = [feature1, feature2, feature3, feature4]
+features = [feature1]
+hdp = {'features': features}
+hdp['mcap_control_psm'] = 0x1001
+hdp['mcap_data_psm'] = 0x1003
+hdp['name'] = "Fake oximeter"
+hdp['description'] = "A fake HDP record"
+hdp['provider'] = "Epx Inc."
+hdp['mcap_procedures'] = ('csp', 'csp_master', 'reconnect_init', \
+				'reconnect_accept')
+print hdp_record.gen_xml(hdp)
-- 
1.7.0.4


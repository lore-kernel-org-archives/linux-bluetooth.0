Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>
Subject: [PATCH v2 1/2] Add test-midi to ignore list
Date: Tue, 24 Jan 2017 10:29:38 -0800
Message-Id: <1485282579-9172-2-git-send-email-brian.gix@intel.com>
In-Reply-To: <1485282579-9172-1-git-send-email-brian.gix@intel.com>
References: <1485282579-9172-1-git-send-email-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 6257505..c0745b4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -138,6 +138,7 @@ unit/test-avdtp
 unit/test-avctp
 unit/test-avrcp
 unit/test-gatt
+unit/test-midi
 unit/test-gattrib
 unit/test-*.log
 unit/test-*.trs
-- 
1.9.1


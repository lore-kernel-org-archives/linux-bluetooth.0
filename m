Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/2] gitignore: Add unit/test-avdtp
Date: Thu, 28 Nov 2013 12:33:29 +0100
Message-Id: <1385638409-1955-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385637056-561-2-git-send-email-szymon.janc@tieto.com>
References: <1385637056-561-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
v2: fixed commit message
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index d567d26..2d3435a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -100,6 +100,7 @@ unit/test-gobex-apparam
 unit/test-gobex-header
 unit/test-gobex-packet
 unit/test-gobex-transfer
+unit/test-avdtp
 unit/test-*.log
 unit/test-*.trs
 
-- 
1.8.3.2


Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 11/13] .gitignore: Ignore soletta generated files
Date: Thu,  2 Jul 2015 11:33:52 -0300
Message-Id: <1435847634-22831-12-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
References: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index 7c1b7e0..6958ce9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -154,6 +154,10 @@ android/test-ipc
 android/test-*.log
 android/test-*.trs
 
+soletta/heartrate-gen.c
+soletta/heartrate-gen.h
+soletta/heartrate.json
+
 cscope.in.out
 cscope.out
 cscope.po.out
-- 
2.4.5


Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ v1 11/15] .gitignore: Ignore soletta generated files
Date: Tue, 21 Jul 2015 20:16:44 -0300
Message-Id: <1437520608-22444-12-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
References: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitignore b/.gitignore
index 7c1b7e0..ac705f5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -154,6 +154,11 @@ android/test-ipc
 android/test-*.log
 android/test-*.trs
 
+peripheral/soletta/heartrate-gen.c
+peripheral/soletta/heartrate-gen.h
+peripheral/soletta/heartrate.json
+peripheral/soletta/main.c
+
 cscope.in.out
 cscope.out
 cscope.po.out
-- 
2.4.6


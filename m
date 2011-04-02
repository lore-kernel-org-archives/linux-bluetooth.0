Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] Add uuidtest binary to gitignore list
Date: Sat,  2 Apr 2011 19:52:40 +0200
Message-Id: <1301766760-12063-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3e36a59..2ef7cb5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -79,6 +79,7 @@ test/lmptest
 test/ipctest
 test/btiotest
 test/test-textfile
+test/uuidtest
 compat/dund
 compat/hidd
 compat/pand
-- 
1.7.4.2


Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH] Add udev scripts to gitignore.
Date: Tue, 29 Jun 2010 22:08:51 -0300
Message-Id: <1277860131-3285-1-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 30bff3b..a6efe98 100644
--- a/.gitignore
+++ b/.gitignore
@@ -81,6 +81,9 @@ compat/dund
 compat/hidd
 compat/pand
 
+scripts/97-bluetooth.rules
+scripts/97-bluetooth-hid2hci.rules
+
 doc/*.bak
 doc/*.stamp
 doc/bluez.*
-- 
1.6.3.3


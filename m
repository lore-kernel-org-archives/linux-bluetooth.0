Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH] Fix bootstrap-configure command line parsing
Date: Tue, 30 Mar 2010 15:07:21 -0300
Message-Id: <1269972441-24242-1-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 bootstrap-configure |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bootstrap-configure b/bootstrap-configure
index 44e7ee8..5b7b88f 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -8,4 +8,4 @@ fi
     ./configure --enable-maintainer-mode \
 		--enable-debug \
 		--prefix=/usr \
-		--mandir=/usr/share/man
+		--mandir=/usr/share/man $*
-- 
1.6.3.3


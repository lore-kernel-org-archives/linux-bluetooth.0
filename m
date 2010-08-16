Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Fix using wrong argument in test-serial
Date: Mon, 16 Aug 2010 14:13:10 +0300
Message-Id: <1281957191-6964-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 test/test-serial |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/test-serial b/test/test-serial
index ed151dc..cc496df 100755
--- a/test/test-serial
+++ b/test/test-serial
@@ -29,7 +29,7 @@ if (len(args) < 1):
 	print "Usage: %s <address> [service]" % (sys.argv[0])
 	sys.exit(1)
 
-address = sys.argv[0]
+address = args[0]
 
 if (len(args) < 2):
 	service = "spp"
-- 
1.7.0.4


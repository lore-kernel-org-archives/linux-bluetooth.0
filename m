Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] test-serial: fix position  of the address argument
Date: Mon, 26 Jul 2010 15:20:59 -0300
Message-Id: <1280168460-18374-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-serial |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/test-serial b/test/test-serial
index ed151dc..1c7078c 100755
--- a/test/test-serial
+++ b/test/test-serial
@@ -29,7 +29,7 @@ if (len(args) < 1):
 	print "Usage: %s <address> [service]" % (sys.argv[0])
 	sys.exit(1)
 
-address = sys.argv[0]
+address = sys.argv[1]
 
 if (len(args) < 2):
 	service = "spp"
-- 
1.7.1.1


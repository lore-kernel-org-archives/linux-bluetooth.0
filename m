Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] test-serial: fix service value attribution
Date: Mon, 26 Jul 2010 15:21:00 -0300
Message-Id: <1280168460-18374-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1280168460-18374-1-git-send-email-gustavo@padovan.org>
References: <1280168460-18374-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-serial |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/test-serial b/test/test-serial
index 1c7078c..fd55b81 100755
--- a/test/test-serial
+++ b/test/test-serial
@@ -34,7 +34,7 @@ address = sys.argv[1]
 if (len(args) < 2):
 	service = "spp"
 else:
-	service = args[1]
+	service = sys.argv[2]
 
 path = adapter.FindDevice(address)
 
-- 
1.7.1.1


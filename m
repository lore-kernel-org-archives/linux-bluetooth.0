Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Fix test-proximity usage info
Date: Fri, 23 Sep 2011 11:05:15 -0300
Message-Id: <1316786715-21546-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-proximity |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/test/test-proximity b/test/test-proximity
index 04faf4e..289908e 100755
--- a/test/test-proximity
+++ b/test/test-proximity
@@ -46,7 +46,8 @@ if __name__ == "__main__":
 	if (len(args) < 1):
 		print "Usage: %s <command>" % (sys.argv[0])
 		print ""
-		print "  LinkLossAlertLevel <none|mild|high>"
+		print "  -b MAC LinkLossAlertLevel <none|mild|high>"
+		print "  -b MAC ImmediateAlertLevel <none|mild|high>"
 		sys.exit(1)
 
 	device_path = adapter.FindDevice(options.address)
-- 
1.7.6.1


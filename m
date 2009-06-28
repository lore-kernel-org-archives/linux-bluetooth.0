Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] test/agent.c: honour commandline --device
Date: Sun, 28 Jun 2009 20:27:36 +0200
Message-Id: <1246213659-24559-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/agent.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index b256f52..7cd4b6e 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -283,7 +283,7 @@ static char *get_device(const char *device)
 {
 	char *path;
 
-	path = strdup("/org/bluez/hci0");
+	path = strdup(device);
 
 	return path;
 }
-- 
1.6.3.1


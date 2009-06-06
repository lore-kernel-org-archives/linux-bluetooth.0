Return-Path: <cyrus@holtmann.org>
Date: Sat, 6 Jun 2009 22:56:35 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: "linux-bluetooth@vger.kernel..." <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] honour commandline --device in test/agent.c
Message-ID: <20090606205635.GA27558@esaurito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
as per subject, make --device in test/agent.c actually work

thanks,
filippo
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

Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH 3/3] mgmtops: Use DBG not error for printing name in read_info_complete
Date: Mon,  5 Mar 2012 20:05:25 +0100
Message-Id: <1330974325-4071-3-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1330974325-4071-1-git-send-email-szymon@janc.net.pl>
References: <1330974325-4071-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is debug not an error message.
---
 plugins/mgmtops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 4970b7c..4aa38fe 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1083,7 +1083,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 
 	name = btd_adapter_get_name(adapter);
 
-	error("mgmtops setting name %s", name);
+	DBG("mgmtops setting name %s", name);
 
 	if (name)
 		mgmt_set_name(index, name);
-- 
1.7.9.1



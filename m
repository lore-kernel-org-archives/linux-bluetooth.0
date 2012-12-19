Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/3] core: Remove bogus DBG()
Date: Tue, 18 Dec 2012 21:16:14 -0400
Message-Id: <1355879775-5809-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1355879775-5809-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1355879775-5809-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

mgmt_set_name() already prints the same information, and message still
refers to mgmtops.
---
 src/mgmt.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/src/mgmt.c b/src/mgmt.c
index ce1ff2f..17518cb 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1163,8 +1163,6 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 
 	name = btd_adapter_get_name(adapter);
 
-	DBG("mgmtops setting name %s", name);
-
 	if (name)
 		mgmt_set_name(index, name);
 	else
-- 
1.7.9.5


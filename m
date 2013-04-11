Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Bluetooth: Use GFP_KERNEL in sco_conn_add
Date: Thu, 11 Apr 2013 11:35:45 -0300
Message-Id: <1365690946-28050-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1365690946-28050-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes the memory allocation flags in the sco_conn_add
function, replacing the type to GFP_KERNEL. This function is executed
in process context and it is not called inside an atomic section.

Signed-off-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
---
 net/bluetooth/sco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d919d11..ca393b4 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -83,7 +83,7 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 	if (conn)
 		return conn;
 
-	conn = kzalloc(sizeof(struct sco_conn), GFP_ATOMIC);
+	conn = kzalloc(sizeof(struct sco_conn), GFP_KERNEL);
 	if (!conn)
 		return NULL;
 
-- 
1.7.11.7


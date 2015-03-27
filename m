Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] profiles/network: Add remove connection if iface couldn't bring up
Date: Fri, 27 Mar 2015 14:46:21 +0100
Message-Id: <1427463981-19365-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Connection should be deleted if bnep interface couldn't bring up.
---
 profiles/network/bnep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index e325b72..ab72021 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -631,8 +631,10 @@ int bnep_server_add(int sk, char *bridge, char *iface, const bdaddr_t *addr,
 	}
 
 	err = bnep_if_up(iface);
-	if (err < 0)
+	if (err < 0) {
+		bnep_conndel(addr);
 		rsp = BNEP_CONN_NOT_ALLOWED;
+	}
 
 reply:
 	if (bnep_send_ctrl_rsp(sk, BNEP_SETUP_CONN_RSP, rsp) < 0) {
-- 
2.1.0


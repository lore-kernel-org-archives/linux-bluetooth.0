Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/4] gobex: remove unused delay on test_put_req_random
Date: Mon,  5 Dec 2011 14:35:18 +0200
Message-Id: <1323088519-18235-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1323088519-18235-1-git-send-email-luiz.dentz@gmail.com>
References: <1323088519-18235-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gobex-transfer.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 518fd94..5bdd71b 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -465,7 +465,6 @@ static void test_put_req_random(void)
 
 	create_endpoints(&obex, &io, SOCK_STREAM);
 	d.obex = obex;
-	d.provide_delay = 200;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
 	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
-- 
1.7.7.3


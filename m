Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 1/3] tools/l2cap-tester: Remove not necessary  bthost_set_server_psm
Date: Fri, 20 Dec 2013 11:53:45 +0100
Message-Id: <1387536827-1590-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function can be replaced with bthost_add_l2cap_server().
---
 tools/l2cap-tester.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index a5028a3..d4a5041 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -731,7 +731,8 @@ static void test_connect(const void *test_data)
 		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 
 		if (!l2data->data_len)
-			bthost_set_server_psm(bthost, l2data->server_psm);
+			bthost_add_l2cap_server(bthost, l2data->server_psm,
+						NULL, NULL);
 		else
 			bthost_add_l2cap_server(bthost, l2data->server_psm,
 						client_l2cap_connect_cb, data);
-- 
1.8.3.1


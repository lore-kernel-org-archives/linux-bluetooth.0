Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/3] android/android-tester: Remove not necessary bthost_set_server_psm
Date: Fri, 20 Dec 2013 11:53:46 +0100
Message-Id: <1387536827-1590-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1387536827-1590-1-git-send-email-marcin.kraglak@tieto.com>
References: <1387536827-1590-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace this function with bthost_add_l2cap_server().
---
 android/android-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index aa0c155..5e60397 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1404,7 +1404,7 @@ static void test_socket_real_connect(const void *test_data)
 
 	bdaddr2android((bdaddr_t *) client_bdaddr, &emu_bdaddr);
 
-	bthost_set_server_psm(bthost, 0x0003);
+	bthost_add_l2cap_server(bthost, 0x0003, NULL, NULL);
 
 	status = data->if_sock->connect(&emu_bdaddr, test->sock_type,
 					test->service_uuid, test->channel,
-- 
1.8.3.1


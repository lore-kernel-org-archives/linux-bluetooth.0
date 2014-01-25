Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] tools/l2cap-tester: Test setsockopt(BT_SECURITY) on LE client
Date: Fri, 24 Jan 2014 21:54:01 -0400
Message-Id: <1390614842-28379-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1390614842-28379-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390614842-28379-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Although setting a security level using setsockopt(BT_SECURITY) is
optional for LE sockets (it will default to doing
unencrypted/unauthenticated connection), it is a common operation and it
is done by BlueZ daemon and some tools.
---
 tools/l2cap-tester.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 05202bd..d541f1b 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -461,6 +461,7 @@ static const struct l2cap_data le_server_success_test = {
 
 static const struct l2cap_data le_att_client_connect_success_test_1 = {
 	.cid = 0x0004,
+	.sec_level = BT_SECURITY_LOW,
 };
 
 static const struct l2cap_data le_att_server_success_test_1 = {
-- 
1.8.3.2


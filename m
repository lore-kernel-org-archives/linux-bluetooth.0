Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 09/10] tools/mgmt-tester: Remove not used condition
Date: Mon, 10 Mar 2014 00:06:02 +0100
Message-ID: <1394406363-6751-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394406363-6751-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394406363-6751-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 17d2bd2..a711d0d 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2868,9 +2868,6 @@ static void setup_start_discovery(const void *test_data)
 				setup_command_hci_callback,
 				NULL);
 
-		if (test->send_func)
-			send_param = test->send_func(&send_len);
-
 		mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
 				send_len, send_param, NULL, NULL, NULL);
 	} else {
-- 
1.8.4


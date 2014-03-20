Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] tools/mgmt-tester: Remove dead code
Date: Thu, 20 Mar 2014 14:25:09 +0100
Message-ID: <1395321909-27960-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395321909-27960-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395321909-27960-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 24febf6..b60d7d8 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2842,12 +2842,6 @@ static void setup_start_discovery(const void *test_data)
 	const struct generic_data *test = data->test_data;
 	const void *send_param = test->setup_send_param;
 	uint16_t send_len = test->setup_send_len;
-	unsigned char disc_param[] = { 0x07 };
-
-	if (!send_param) {
-		send_param = disc_param;
-		send_len = 1;
-	}
 
 	mgmt_send(data->mgmt, test->setup_send_opcode, data->mgmt_index,
 				send_len, send_param, setup_discovery_callback,
-- 
1.8.4


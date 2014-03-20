Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] tools/mgmt-tester: Minor fix in Stop discovery Success 1 test
Date: Thu, 20 Mar 2014 14:25:08 +0100
Message-ID: <1395321909-27960-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set directly setup_send params for start discovery. It will be easier to
follow the test.
---
 tools/mgmt-tester.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 82952c7..24febf6 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1722,6 +1722,8 @@ static const char stop_discovery_inq_param[] = { 0x33, 0x8b, 0x9e, 0x08, 0x00 };
 static const struct generic_data stop_discovery_success_test_1 = {
 	.setup_settings = settings_powered_le,
 	.setup_send_opcode = MGMT_OP_START_DISCOVERY,
+	.setup_send_param = start_discovery_bredrle_param,
+	.setup_send_len = sizeof(start_discovery_bredrle_param),
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
 	.send_param = stop_discovery_bredrle_param,
 	.send_len = sizeof(stop_discovery_bredrle_param),
-- 
1.8.4


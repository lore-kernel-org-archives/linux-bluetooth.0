Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 07/10] tools/mgmt-tester: Update Stop Discovery-BR/EDR (Inquiry) Success 1
Date: Thu, 20 Mar 2014 12:25:10 +0100
Message-ID: <1395314713-13104-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395314713-13104-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395314713-13104-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With new way of handling inquiry in btdev there is no need to register
inquiry event hook
---
 tools/mgmt-tester.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 9f71743..17d2bd2 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1734,9 +1734,6 @@ static const struct generic_data stop_discovery_success_test_1 = {
 
 static const struct generic_data stop_discovery_bredr_success_test_1 = {
 	.setup_settings = settings_powered,
-	.setup_expect_hci_command = BT_HCI_CMD_INQUIRY,
-	.setup_expect_hci_param = stop_discovery_inq_param,
-	.setup_expect_hci_len = sizeof(stop_discovery_inq_param),
 	.send_opcode = MGMT_OP_STOP_DISCOVERY,
 	.send_param = stop_discovery_bredr_param,
 	.send_len = sizeof(stop_discovery_bredr_param),
-- 
1.8.4


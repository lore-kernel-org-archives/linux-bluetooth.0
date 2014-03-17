Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 06/10] tools/mgmt-tester: Fix for Stop discovery test
Date: Mon, 17 Mar 2014 10:37:39 +0100
Message-ID: <1395049064-9751-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395049064-9751-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395049064-9751-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test "Stop Discovery - BR/EDR (Inquiry) Success 1" uses hciemu_type
BREDR but uses power settings to enable LE and tries to set LE:

  mgmt: [0x0002] command 0x000d
  mgmt: < 0d 00 02 00 01 00 01                             .......
  mgmt: > 02 00 02 00 03 00 0d 00 0c                       .........
  mgmt: [0x0002] command 0x0d status: 0x0c

This patch fixes this minor issue
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a3c1c72..9f71743 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1733,7 +1733,7 @@ static const struct generic_data stop_discovery_success_test_1 = {
 };
 
 static const struct generic_data stop_discovery_bredr_success_test_1 = {
-	.setup_settings = settings_powered_le,
+	.setup_settings = settings_powered,
 	.setup_expect_hci_command = BT_HCI_CMD_INQUIRY,
 	.setup_expect_hci_param = stop_discovery_inq_param,
 	.setup_expect_hci_len = sizeof(stop_discovery_inq_param),
-- 
1.8.4


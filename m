Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] mgmt-tester: Fix clang warning
Date: Tue, 20 Jan 2015 14:41:33 +0200
Message-Id: <1421757693-17233-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes clang warning below:
...
tools/mgmt-tester.c:3805:2: warning: Value stored to 'id' is never read
        id = mgmt_register(data->mgmt, MGMT_EV_DISCOVERING,
data->mgmt_index,
        ^
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.
...
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 92351e4..295fef5 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3802,7 +3802,7 @@ static void setup_start_discovery(const void *test_data)
 	uint16_t send_len = test->setup_send_len;
 	unsigned int id = 0;
 
-	id = mgmt_register(data->mgmt, MGMT_EV_DISCOVERING, data->mgmt_index,
+	mgmt_register(data->mgmt, MGMT_EV_DISCOVERING, data->mgmt_index,
 			   discovering_event, UINT_TO_PTR(id), NULL);
 
 	mgmt_send(data->mgmt, test->setup_send_opcode, data->mgmt_index,
-- 
2.1.0


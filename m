Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] tools/mgmt-tester: Fix "Pair Device - SSP Confirm Reject 1"
Date: Mon, 19 May 2014 12:53:42 +0200
Message-ID: <1400496822-28557-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400496822-28557-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400496822-28557-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With changes introduced in kernel by 6fd6b915 we no longer require MITM
when being pairing initiator (i.e. we indicate it to remote but do not
force it when remote does not require it) thus kernel will auto-accept
pairing when remote also does not require MITM. As a result it's not
possible for tester to reject user confirmation since there's no
request from kernel.

This patch sets acceptor authentication requirements to include MITM
so we'll have user confirmation request and tester can reject it.
---
 tools/mgmt-tester.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a8b14e4..4cc7ba4 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -392,6 +392,7 @@ struct generic_data {
 	bool client_enable_ssp;
 	uint8_t io_cap;
 	uint8_t client_io_cap;
+	uint8_t client_auth_req;
 	bool reject_ssp;
 	bool client_reject_ssp;
 };
@@ -2423,6 +2424,7 @@ static const struct generic_data pair_device_ssp_reject_1 = {
 	.expect_hci_func = client_bdaddr_param_func,
 	.io_cap = 0x01, /* DisplayYesNo */
 	.client_io_cap = 0x01, /* DisplayYesNo */
+	.client_auth_req = 0x01, /* No Bonding - MITM */
 	.reject_ssp = true,
 };
 
@@ -3128,6 +3130,9 @@ static void test_setup(const void *test_data)
 	if (test->client_io_cap)
 		bthost_set_io_capability(bthost, test->client_io_cap);
 
+	if (test->client_auth_req)
+		bthost_set_auth_req(bthost, test->client_auth_req);
+
 	if (test->client_reject_ssp)
 		bthost_set_reject_user_confirm(bthost, true);
 
-- 
1.9.3


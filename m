Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: trivial: Remove sparse warnings
Date: Mon, 12 Mar 2012 15:59:34 +0200
Message-Id: <1331560774-10748-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331560774-10748-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/mgmt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 06b5df3..5efca93 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -287,7 +287,7 @@ static int read_commands(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_rp_read_commands *rp;
 	u16 num_commands = ARRAY_SIZE(mgmt_commands);
 	u16 num_events = ARRAY_SIZE(mgmt_events);
-	u16 *opcode;
+	__le16 *opcode;
 	size_t rp_size;
 	int i, err;
 
@@ -2601,7 +2601,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return 0;
 }
 
-struct mgmt_handler {
+static struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
 	bool var_len;
-- 
1.7.9.1


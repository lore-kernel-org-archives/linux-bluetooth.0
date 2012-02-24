Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Trivial code style fix
Date: Fri, 24 Feb 2012 11:41:05 -0300
Message-Id: <1330094465-4625-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1330094465-4625-1-git-send-email-andre.guedes@openbossa.org>
References: <1330094465-4625-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove unneeded line break.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8a36e68..f71dfc5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2556,8 +2556,7 @@ int mgmt_interleaved_discovery(struct hci_dev *hdev)
 	return err;
 }
 
-static int start_discovery(struct sock *sk, u16 index,
-						void *data, u16 len)
+static int start_discovery(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct mgmt_cp_start_discovery *cp = data;
 	struct pending_cmd *cmd;
-- 
1.7.9.2


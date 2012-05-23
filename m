Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH trivial 4/4] Bluetooth: trivial: Remove empty line
Date: Wed, 23 May 2012 11:31:23 +0300
Message-Id: <1337761883-3190-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1337761883-3190-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337761883-3190-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_conn.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 971601e..da9f827 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -425,7 +425,6 @@ int hci_conn_del(struct hci_conn *conn)
 		}
 	}
 
-
 	hci_chan_list_flush(conn);
 
 	hci_conn_hash_del(hdev, conn);
-- 
1.7.9.5


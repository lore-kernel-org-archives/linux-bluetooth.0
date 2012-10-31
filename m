Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 01/12] Bluetooth: trivial: Fix braces style and remove empty line
Date: Wed, 31 Oct 2012 15:46:26 +0200
Message-Id: <1351691197-8394-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d1728af..c2fbaf9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6252,9 +6252,9 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 		conn = l2cap_conn_add(hcon, status);
 		if (conn)
 			l2cap_conn_ready(conn);
-	} else
+	} else {
 		l2cap_conn_del(hcon, bt_to_errno(status));
-
+	}
 }
 
 int l2cap_disconn_ind(struct hci_conn *hcon)
-- 
1.7.9.5


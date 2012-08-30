Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ v4 14/15] mgmt: Add address type to bonding debug message
Date: Thu, 30 Aug 2012 19:15:59 -0300
Message-Id: <1346364960-7699-15-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1346364960-7699-1-git-send-email-jprvita@openbossa.org>
References: <1346364960-7699-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mgmt.c b/src/mgmt.c
index 662d70b..f52cc67a 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -2333,7 +2333,8 @@ int mgmt_create_bonding(int index, bdaddr_t *bdaddr, uint8_t addr_type, uint8_t
 	char addr[18];
 
 	ba2str(bdaddr, addr);
-	DBG("hci%d bdaddr %s io_cap 0x%02x", index, addr, io_cap);
+	DBG("hci%d bdaddr %s type %d io_cap 0x%02x",
+					index, addr, addr_type, io_cap);
 
 	memset(buf, 0, sizeof(buf));
 	hdr->opcode = htobs(MGMT_OP_PAIR_DEVICE);
-- 
1.7.11.4


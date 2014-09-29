Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] shared/hci: Make use of io_send
Date: Mon, 29 Sep 2014 17:57:42 +0300
Message-Id: <1412002664-28253-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412002664-28253-1-git-send-email-luiz.dentz@gmail.com>
References: <1412002664-28253-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/hci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index 6ce62eb..9ab8c6e 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -113,7 +113,7 @@ static void send_command(struct bt_hci *hci, uint16_t opcode,
 	uint8_t type = BT_H4_CMD_PKT;
 	struct bt_hci_cmd_hdr hdr;
 	struct iovec iov[3];
-	int fd, iovcnt;
+	int iovcnt;
 
 	if (hci->num_cmds < 1)
 		return;
@@ -133,11 +133,7 @@ static void send_command(struct bt_hci *hci, uint16_t opcode,
 	} else
 		iovcnt = 2;
 
-	fd = io_get_fd(hci->io);
-	if (fd < 0)
-		return;
-
-	if (writev(fd, iov, iovcnt) < 0)
+	if (io_send(hci->io, iov, iovcnt) < 0)
 		return;
 
 	hci->num_cmds--;
-- 
1.9.3


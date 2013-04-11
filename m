Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 2/3] shared: Remove static address assignment in hciemu
Date: Thu, 11 Apr 2013 11:24:43 -0400
Message-Id: <1365693884-15423-3-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1365693884-15423-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1365693884-15423-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we need multiple virtual devices, addresses should not be the same.
Inside the function btdev_create, a specific address is generated.
---
 src/shared/hciemu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 60a4f47..8cd6548 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -192,20 +192,12 @@ static guint create_source_btdev(int fd, struct btdev *btdev)
 static bool create_vhci(struct hciemu *hciemu)
 {
 	struct btdev *btdev;
-	uint8_t bdaddr[6];
-	const char *str;
-	int fd, i;
+	int fd;
 
 	btdev = btdev_create(hciemu->btdev_type, 0x00);
 	if (!btdev)
 		return false;
 
-	str = hciemu_get_address(hciemu);
-
-	for (i = 5; i >= 0; i--, str += 3)
-		bdaddr[i] = strtol(str, NULL, 16);
-
-	btdev_set_bdaddr(btdev, bdaddr);
 	btdev_set_command_handler(btdev, master_command_callback, hciemu);
 
 	fd = open("/dev/vhci", O_RDWR | O_NONBLOCK | O_CLOEXEC);
-- 
1.8.2


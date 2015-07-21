Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH BlueZ v1 08/15] peripheral/gap: Set the discoverable flag in the advertising
Date: Tue, 21 Jul 2015 20:16:41 -0300
Message-Id: <1437520608-22444-9-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
References: <1437520608-22444-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 peripheral/gap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/peripheral/gap.c b/peripheral/gap.c
index 9c45057..e95394c 100644
--- a/peripheral/gap.c
+++ b/peripheral/gap.c
@@ -98,7 +98,7 @@ static void add_advertising(uint16_t index)
 	memset(buf, 0, sizeof(*cp) + sizeof(ad));
 	cp = buf;
 	cp->instance = 0x01;
-	cp->flags = cpu_to_le32((1 << 0) | (1 << 1) | (1 << 4));
+	cp->flags = cpu_to_le32((1 << 0) | (1 << 1) | (1 << 3) | (1 << 4));
 	cp->duration = cpu_to_le16(0);
 	cp->timeout = cpu_to_le16(0);
 	cp->adv_data_len = sizeof(ad);
-- 
2.4.6


Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 08/13] peripheral/gap: Set the discoverable flag in the advertising
Date: Thu,  2 Jul 2015 11:33:49 -0300
Message-Id: <1435847634-22831-9-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
References: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
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
2.4.5


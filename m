Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] unit/test-ringbuf: Fix indentation
Date: Sat, 25 Jan 2014 21:34:20 -0400
Message-Id: <1390700061-18666-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-ringbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/unit/test-ringbuf.c b/unit/test-ringbuf.c
index a19216f..e63321c 100644
--- a/unit/test-ringbuf.c
+++ b/unit/test-ringbuf.c
@@ -41,7 +41,8 @@ static unsigned int nlpo2(unsigned int x)
 	x |= (x >> 4);
 	x |= (x >> 8);
 	x |= (x >> 16);
-        return x + 1;
+
+	return x + 1;
 }
 
 static unsigned int align_power2(unsigned int u)
-- 
1.8.3.2


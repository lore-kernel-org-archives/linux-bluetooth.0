Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH] mesh: Correct length test in agent.c:request_ascii
Date: Sat, 18 Nov 2017 05:48:45 -0500
Message-Id: <20171118104845.23635-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

---
 mesh/agent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index c789b0c1a..efb8937d9 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -137,7 +137,7 @@ static bool request_decimal(uint16_t len)
 
 static bool request_ascii(uint16_t len)
 {
-	if (len != MAX_ASCII_OOB_LEN)
+	if (len > MAX_ASCII_OOB_LEN)
 		return false;
 
 	rl_printf("Request ASCII key (max characters %d)\n", len);
-- 
2.14.1


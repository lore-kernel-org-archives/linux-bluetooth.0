Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ] client: Fix memory leak due to the option to register
 an agent
Message-ID: <e75606ee-1e0f-5225-21d7-d6129202d9ac@jp.fujitsu.com>
Date: Wed, 21 Jun 2017 19:07:19 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When bluetoothctl runs with the command line option "-a <capability>", it
does not free the variable auto_register_agent registering the initial
agent and allocates new memory for it.

This frees the allocated memory before allocating new memory.
(The related commit id is 6db3470c2ea161b4b808ad1fc80dfd7e014fd359.)

---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 2f269af..9b01dfb 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2358,6 +2358,7 @@ static gboolean parse_agent(const char *key, const char *value,
 	if (!value)
 		return FALSE;
 
+	g_free(auto_register_agent);
 	auto_register_agent = g_strdup(value);
 
 	return TRUE;
-- 
2.7.4


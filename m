Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] plugins/policy: Set list separator
Date: Thu, 28 Jul 2016 17:27:47 +0300
Message-Id: <1469716070-16506-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
References: <1469716070-16506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Set list separator to ',' as it is used in main.conf.
---
 plugins/policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/policy.c b/plugins/policy.c
index bbb6961..3058824 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -775,6 +775,8 @@ static int policy_init(void)
 		goto done;
 	}
 
+	g_key_file_set_list_separator(conf, ',');
+
 	reconnect_uuids = g_key_file_get_string_list(conf, "Policy",
 							"ReconnectUUIDs",
 							NULL, &gerr);
-- 
2.7.4


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH] mesh: meshctl: Make composition-get argument optional
Date: Tue, 19 Dec 2017 16:27:59 -0500
Message-Id: <20171219212759.19918-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

It can't be both optional and required.

[config: Target = 0100]# composition-get 0
Unable to parse optional command arguments
---
 mesh/config-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index fc6b3dc5d..f280441cc 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -997,7 +997,7 @@ static const struct bt_shell_menu cfg_menu = {
 	.entries = {
 	{"target",		"<unicast>",		cmd_set_node,
 						"Set target node to configure"},
-	{"composition-get",	"[<page_num>]",		cmd_get_composition,
+	{"composition-get",	"[page_num]",		cmd_get_composition,
 						"Get Composition Data"},
 	{"netkey-add",		"<net_idx>",		cmd_add_net_key,
 						"Add network key"},
-- 
2.14.1


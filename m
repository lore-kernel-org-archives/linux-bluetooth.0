Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
        <frederic.dalleau@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
        <frederic.dalleau@collabora.com>
Subject: [PATCH 2/2] monitor: Format URI hash using 8 hex digits
Date: Wed, 26 Jul 2017 07:40:40 +0200
Message-Id: <20170726054040.17970-3-frederic.dalleau@collabora.com>
In-Reply-To: <20170726054040.17970-1-frederic.dalleau@collabora.com>
References: <20170726054040.17970-1-frederic.dalleau@collabora.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

URI hash is a 32 bits value.
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index f72fcab6a..994f5b259 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3551,7 +3551,7 @@ static void print_mesh_beacon(const uint8_t *data, uint8_t len)
 			break;
 		}
 
-		print_field("  URI Hash: 0x%4.4x", get_be32(data + 19));
+		print_field("  URI Hash: 0x%08x", get_be32(data + 19));
 		packet_hexdump(data + 23, len - 23);
 		break;
 	case 0x01:
-- 
2.11.0


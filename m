Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] audio/avrcp: Don't print an error if folder length is 0
Date: Fri, 22 Jan 2016 17:14:28 +0200
Message-Id: <1453475668-4609-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1453475668-4609-1-git-send-email-luiz.dentz@gmail.com>
References: <1453475668-4609-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some stacks, for instance iOS, does actually send 0 as folder length
so just ignore if that happens since that means only means the folder
doesn't have a name.
---
 profiles/audio/avrcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 076766d..787643c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2655,8 +2655,10 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 		uint8_t len;
 
 		len = pdu->params[i++];
+		if (!len)
+			continue;
 
-		if (i + len > operand_count || len == 0) {
+		if (i + len > operand_count) {
 			error("Invalid folder length");
 			break;
 		}
-- 
2.5.0


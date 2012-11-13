Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] avrcp: Fix dead assignments in ct_set_setting
Date: Tue, 13 Nov 2012 15:21:08 +0200
Message-Id: <1352812880-7306-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
References: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

Value stored in val is never read before writing it again. After
fixing val same applies to attr variable.
---
 audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index e3ce2fb..2517df8 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1944,8 +1944,8 @@ static bool ct_set_setting(struct media_player *mp, const char *key,
 					const char *value, void *user_data)
 {
 	struct avrcp_player *player = user_data;
-	int attr = attr_to_val(key);
-	int val = attrval_to_val(attr, value);
+	int attr;
+	int val;
 	struct avrcp *session;
 
 	session = player->sessions->data;
-- 
1.7.11.7


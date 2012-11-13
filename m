Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] avrcp: Fix dead assignments in ct_set_setting
Date: Tue, 13 Nov 2012 13:52:39 +0100
Message-ID: <1352811160-12722-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1352811160-12722-1-git-send-email-szymon.janc@tieto.com>
References: <1352811160-12722-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Value stored in val is never read before writing it again. After
fixing val same applies to attr variable.

---
 audio/avrcp.c |    4 ++--
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
1.7.9.5


Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 2/4] Code clean-up: Remove unnecessary character in comment
Date: Thu, 22 Sep 2011 09:52:46 +0200
Message-Id: <1316677968-3494-2-git-send-email-michalski.raf@gmail.com>
In-Reply-To: <1316677968-3494-1-git-send-email-michalski.raf@gmail.com>
References: <1316677968-3494-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes unnecessary comment's character.
---
 plugins/vcard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index e5e1de1..ca3a052 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -681,7 +681,7 @@ static void vcard_printf_address(GString *vcards, uint8_t format,
 		g_strlcat(fields, field_esc, len);
 
 		if (l->next)
-			/* not addding ';' after last addr field */
+			/* not adding ';' after last addr field */
 			g_strlcat(fields, ";", len);
 	}
 
-- 
1.6.3.3


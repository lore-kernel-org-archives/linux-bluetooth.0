Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/2] shared/btp: Allow to call btp_send without valid btp
Date: Fri, 23 Feb 2018 14:40:10 +0100
Message-Id: <20180223134010.20312-2-szymon.janc@codecoup.pl>
In-Reply-To: <20180223134010.20312-1-szymon.janc@codecoup.pl>
References: <20180223134010.20312-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to unconditionally call btp_send from code that generates
events eg when mapping those from D-Bus events.
---
 src/shared/btp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/btp.c b/src/shared/btp.c
index 555dabc39..7eea241a2 100644
--- a/src/shared/btp.c
+++ b/src/shared/btp.c
@@ -294,6 +294,9 @@ bool btp_send(struct btp *btp, uint8_t service, uint8_t opcode, uint8_t index,
 	struct pending_message *msg;
 	size_t len;
 
+	if (!btp)
+		return false;
+
 	len = sizeof(*hdr) + length;
 	hdr = l_malloc(len);
 	if (!hdr)
-- 
2.14.3


Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/2] gobex: remove extra define of G_OBEX_RSP_SUCCESS
Date: Mon,  7 Nov 2011 14:29:17 +0200
Message-Id: <1320668958-11238-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 gobex/gobex-packet.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex-packet.h b/gobex/gobex-packet.h
index 24c9dcc..e4cea0b 100644
--- a/gobex/gobex-packet.h
+++ b/gobex/gobex-packet.h
@@ -41,7 +41,6 @@
 /* Response codes */
 #define G_OBEX_RSP_CONTINUE			0x10
 #define G_OBEX_RSP_SUCCESS			0x20
-#define G_OBEX_RSP_SUCCESS			0x20
 #define G_OBEX_RSP_CREATED			0x21
 #define G_OBEX_RSP_ACCEPTED			0x22
 #define G_OBEX_RSP_NON_AUTHORITATIVE		0x23
-- 
1.7.6.4


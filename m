Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/11] obexd: Enable support for MAS profile
Date: Wed, 12 Dec 2012 13:52:09 +0200
Message-Id: <1355313136-7891-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
References: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 obexd/plugins/bluetooth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index fc88a1e..65bcad1 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -312,6 +312,8 @@ static const char *service2uuid(uint16_t service)
 		return OBEX_FTP_UUID;
 	case OBEX_PBAP:
 		return OBEX_PSE_UUID;
+	case OBEX_MAS:
+		return OBEX_MAS_UUID;
 	}
 
 	return NULL;
-- 
1.7.11.7


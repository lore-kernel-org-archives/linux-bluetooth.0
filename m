Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] obexd: Enable MNS server
Date: Tue,  9 Apr 2013 13:51:36 +0200
Message-Id: <1365508297-13032-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 obexd/plugins/bluetooth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index f80faa4..b9e9c91 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -336,6 +336,8 @@ static const char *service2uuid(uint16_t service)
 		return "00000002-0000-1000-8000-0002ee000002";
 	case OBEX_MAS:
 		return OBEX_MAS_UUID;
+	case OBEX_MNS:
+		return OBEX_MNS_UUID;
 	}
 
 	return NULL;
-- 
1.8.2.1


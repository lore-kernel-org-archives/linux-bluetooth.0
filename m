Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 07/19] hci: Retrieve the bluetooth name correctly
Date: Thu, 12 Apr 2012 20:32:58 +0530
Message-id: <1334243001-17016-8-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we set the bluetooth name length as maximum 248 bytes,
then while retrieving back we were getting only 247 bytes.
This problem can be verified using hciconfig tool.
---
 lib/hci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 269c021..9f829c9 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -1417,8 +1417,9 @@ int hci_read_local_name(int dd, int len, char *name, int to)
 		return -1;
 	}
 
-	rp.name[247] = '\0';
-	strncpy(name, (char *) rp.name, len);
+	strncpy(name, (char *) rp.name, len - 1);
+	name[len - 1] = '\0';
+
 	return 0;
 }
 
-- 
1.7.4.1


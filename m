Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Ido Yariv <ido@wizery.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>
Subject: [PATCH] Storage: Fix a buffer overflow in write_link_key
Date: Mon,  5 Mar 2012 20:12:31 +0200
Message-Id: <1330971151-11075-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The temporary string allocated on the stack is not large enough in worst
case. To be on the safe side, increase it to 64 bytes.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 src/storage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/storage.c b/src/storage.c
index a65cee4..7e7f081 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -533,7 +533,7 @@ int write_lastused_info(bdaddr_t *local, bdaddr_t *peer, struct tm *tm)
 
 int write_link_key(bdaddr_t *local, bdaddr_t *peer, unsigned char *key, uint8_t type, int length)
 {
-	char filename[PATH_MAX + 1], addr[18], str[38];
+	char filename[PATH_MAX + 1], addr[18], str[64];
 	int i;
 
 	memset(str, 0, sizeof(str));
-- 
1.7.7.6


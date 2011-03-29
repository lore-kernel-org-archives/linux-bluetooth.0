Return-Path: <cyrus@holtmann.org>
From: luiz.dentz@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3 v2] Fix uninitialized variables warnings
Date: Tue, 29 Mar 2011 16:47:44 +0300
Message-Id: <1301406464-3404-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1301406464-3404-1-git-send-email-luiz.dentz@gmail.com>
References: <1301406464-3404-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

src/attrib-server.c: In function ‘channel_handler’:
src/attrib-server.c:297:21: error: ‘cur’ may be used uninitialized in this function
src/attrib-server.c:502:10: error: ‘format’ may be used uninitialized in this function
src/attrib-server.c:503:11: error: ‘length’ may be used uninitialized in this function
make[1]: *** [src/attrib-server.o] Error 1
---
 src/attrib-server.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index dc05d7e..98bd6b1 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -315,7 +315,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 					ATT_ECODE_UNSUPP_GRP_TYPE, pdu, len);
 
 	last_handle = end;
-	for (l = database, groups = NULL; l; l = l->next) {
+	for (l = database, groups = NULL, cur = NULL; l; l = l->next) {
 		struct attribute *client_attr;
 
 		a = l->data;
@@ -538,6 +538,9 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 	} else if (last_type == BT_UUID128) {
 		length = 16;
 		format = 0x02;
+	} else {
+		g_slist_free(info);
+		return 0;
 	}
 
 	adl = att_data_list_alloc(num, length + 2);
-- 
1.7.4.1


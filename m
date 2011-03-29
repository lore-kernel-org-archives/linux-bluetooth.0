Return-Path: <cyrus@holtmann.org>
From: luiz.dentz@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Fix uninitialized variables warnings
Date: Tue, 29 Mar 2011 14:36:55 +0300
Message-Id: <1301398615-16283-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1301398615-16283-1-git-send-email-luiz.dentz@gmail.com>
References: <1301398615-16283-1-git-send-email-luiz.dentz@gmail.com>
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
 src/attrib-server.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index dc05d7e..fb89ea5 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -294,7 +294,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 {
 	struct att_data_list *adl;
 	struct attribute *a;
-	struct group_elem *cur, *old = NULL;
+	struct group_elem *cur = NULL, *old = NULL;
 	GSList *l, *groups;
 	uint16_t length, last_handle, last_size = 0;
 	uint8_t status;
@@ -499,8 +499,8 @@ static int find_info(uint16_t start, uint16_t end, uint8_t *pdu, int len)
 	struct attribute *a;
 	struct att_data_list *adl;
 	GSList *l, *info;
-	uint8_t format, last_type = BT_UUID_UNSPEC;
-	uint16_t length, num;
+	uint8_t format = 0, last_type = BT_UUID_UNSPEC;
+	uint16_t length = 0, num;
 	int i;
 
 	if (start > end || start == 0x0000)
-- 
1.7.4.1


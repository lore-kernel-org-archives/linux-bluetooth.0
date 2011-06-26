Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH obexd 2/3] Fix white space related coding style issues for gwobex
Date: Mon, 27 Jun 2011 03:26:05 +0530
Message-Id: <1309125366-29016-2-git-send-email-syamsidhardh@gmail.com>
In-Reply-To: <1309125366-29016-1-git-send-email-syamsidhardh@gmail.com>
References: <1309125366-29016-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

- Corrected the space between the arguments
- Corrected no space after 'sizeof'
---
 gwobex/obex-priv.h |    2 +-
 gwobex/utils.c     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gwobex/obex-priv.h b/gwobex/obex-priv.h
index f4e3e5b..c7e4997 100644
--- a/gwobex/obex-priv.h
+++ b/gwobex/obex-priv.h
@@ -37,7 +37,7 @@
 #include "gw-obex.h"
 #include "obex-xfer.h"
 
-#define CHECK_DISCONNECT(ret,err,ctx) do { \
+#define CHECK_DISCONNECT(ret, err, ctx) do { \
                                           if ((ctx)->conn_fd < 0) { \
                                               if (err) \
                                                   *(err) = GW_OBEX_ERROR_DISCONNECT; \
diff --git a/gwobex/utils.c b/gwobex/utils.c
index 02afa2e..f47b68a 100644
--- a/gwobex/utils.c
+++ b/gwobex/utils.c
@@ -50,7 +50,7 @@ char *bytestr(const uint8_t *uuid, int len) {
 gboolean fd_raw_mode(int fd) {
     struct termios mode;
 
-    memset(&mode, 0, sizeof (mode));
+    memset(&mode, 0, sizeof(mode));
     if (tcgetattr(fd, &mode) < 0) {
         debug("tcgetattr(%d, &mode): %s", fd, strerror(errno));
         return FALSE;
@@ -134,7 +134,7 @@ time_t parse_iso8601(const gchar *str, int len) {
     time_t    time;
     time_t    tz_offset = 0;
 
-    memset (&tm, 0, sizeof (struct tm));
+    memset (&tm, 0, sizeof(struct tm));
 
     /* According to spec the time doesn't have to be null terminated */
     if (str[len - 1] != '\0') {
-- 
1.7.4.1


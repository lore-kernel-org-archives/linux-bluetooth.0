Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] fix display of time_t values
Date: Mon, 29 May 2017 12:29:38 -0400
Message-Id: <20170529162938.5046-1-vapier@gentoo.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mike Frysinger <vapier@chromium.org>

There is no requirement that sizeof(time_t) == sizeof(long), so cast
all the displays of time related variables to intmax_t.  This comes
up now on x32 systems, but will probably start showing up more when
systems migrate to 64-bit time_t values.
---
 monitor/packet.c | 10 ++++++----
 tools/l2test.c   |  4 ++--
 tools/rctest.c   |  4 ++--
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 7d1c5e86d7f1..5633e9bf51bf 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -351,8 +351,9 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 		}
 
 		if (filter_mask & PACKET_FILTER_SHOW_TIME) {
-			n = sprintf(ts_str + ts_pos, " %02d:%02d:%02d.%06lu",
-				tm.tm_hour, tm.tm_min, tm.tm_sec, tv->tv_usec);
+			n = sprintf(ts_str + ts_pos, " %02d:%02d:%02jd.%06jd",
+				tm.tm_hour, tm.tm_min, (intmax_t) tm.tm_sec,
+				(intmax_t) tv->tv_usec);
 			if (n > 0) {
 				ts_pos += n;
 				ts_len += n;
@@ -360,8 +361,9 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 		}
 
 		if (filter_mask & PACKET_FILTER_SHOW_TIME_OFFSET) {
-			n = sprintf(ts_str + ts_pos, " %lu.%06lu",
-					tv->tv_sec - time_offset, tv->tv_usec);
+			n = sprintf(ts_str + ts_pos, " %jd.%06jd",
+					(intmax_t) tv->tv_sec - time_offset,
+					(intmax_t) tv->tv_usec);
 			if (n > 0) {
 				ts_pos += n;
 				ts_len += n;
diff --git a/tools/l2test.c b/tools/l2test.c
index 18194236b523..68401c4e2d6e 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -910,8 +910,8 @@ static void recv_mode(int sk)
 					timestamp = 0;
 					memset(ts, 0, sizeof(ts));
 				} else {
-					sprintf(ts, "[%ld.%ld] ",
-							tv.tv_sec, tv.tv_usec);
+					sprintf(ts, "[%jd.%jd] ",
+							(intmax_t) tv.tv_sec, (intmax_t) tv.tv_usec);
 				}
 			}
 
diff --git a/tools/rctest.c b/tools/rctest.c
index 6d84e075b206..e15311362d5c 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -508,8 +508,8 @@ static void recv_mode(int sk)
 					timestamp = 0;
 					memset(ts, 0, sizeof(ts));
 				} else {
-					sprintf(ts, "[%ld.%ld] ",
-							tv.tv_sec, tv.tv_usec);
+					sprintf(ts, "[%jd.%jd] ",
+							(intmax_t) tv.tv_sec, (intmax_t) tv.tv_usec);
 				}
 			}
 
-- 
2.12.0


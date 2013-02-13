Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] obexd: Handle absolute paths in obc_session_setpath
Date: Wed, 13 Feb 2013 15:02:29 +0100
Message-Id: <1360764149-26447-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1360764149-26447-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1360764149-26447-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

For absolute paths (that begin with '/'), obc_session_setpath gets called
twice to reset to the root folder.
This is caused by an empty first element in the folder list created by g_strsplit.

This solution sets the index to the folder array correctly and ignores
empty folder names. This fixes as well paths with double slashes.

Trace for 'SetFolder /telecom':

< ACL data: handle 21 flags 0x00 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 32 pf 0 ilen 13 fcs 0xd8
        OBEX: SetPath cmd(f): len 13 flags 2 constants 0
        Connection ID (0xcb) = 17
        Name (0x01) = Unicode length 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 21 packets 1
> ACL data: handle 21 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 32 pf 0 ilen 3 fcs 0x2
        OBEX: SetPath rsp(f): status 200 len 3
< ACL data: handle 21 flags 0x00 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 32 pf 0 ilen 13 fcs 0xd8
        OBEX: SetPath cmd(f): len 13 flags 2 constants 0
        Connection ID (0xcb) = 17
        Name (0x01) = Unicode length 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 21 packets 1
> ACL data: handle 21 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 32 pf 0 ilen 3 fcs 0x2
        OBEX: SetPath rsp(f): status 200 len 3
< ACL data: handle 21 flags 0x00 dlen 37
    L2CAP(d): cid 0x0040 len 33 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 32 pf 0 ilen 29 fcs 0xd8
        OBEX: SetPath cmd(f): len 29 flags 2 constants 0
        Connection ID (0xcb) = 17
        Name (0x01) = Unicode length 16
        0000: 00 74 00 65 00 6c 00 65  00 63 00 6f 00 6d 00 00  .t.e.l.e.c.o.m..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 21 packets 1
> ACL data: handle 21 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 32 pf 0 ilen 3 fcs 0x2
        OBEX: SetPath rsp(f): status 200 len 3
---
 obexd/client/session.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index f8aae5d..ca4a587 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -891,7 +891,10 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 		return;
 	}
 
-	next = data->remaining[data->index];
+	/* Ignore empty folder names to avoid resetting the current path */
+	while ((next = data->remaining[data->index]) && strlen(next) == 0) {
+		data->index++;
+	}
 	if (next == NULL) {
 		setpath_complete(p->session, NULL, NULL, user_data);
 		return;
@@ -929,15 +932,15 @@ guint obc_session_setpath(struct obc_session *session, const char *path,
 	data = g_new0(struct setpath_data, 1);
 	data->func = func;
 	data->user_data = user_data;
-	data->remaining = g_strsplit(path, "/", 0);
+	data->remaining = g_strsplit(strlen(path) ? path : "/", "/", 0);
 
 	p = pending_request_new(session, NULL, setpath_complete, data);
 
 	/* Relative path */
-	if (path[0] != '/' && path[0] != 0) {
+	if (path[0] != '/')
 		first = data->remaining[data->index];
-		data->index++;
-	}
+
+	data->index++;
 
 	p->req_id = g_obex_setpath(session->obex, first, setpath_cb, p, err);
 	if (*err != NULL)
-- 
1.8.1.3


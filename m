Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] SDP
From: Santiago Carot Nemesio <scarot@libresoft.es>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1272375265.2157.17.camel@mosquito>
References: <1272375265.2157.17.camel@mosquito>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 15:37:05 +0200
Message-ID: <1272375425.2157.20.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set to NULL return value on functions returning 0.

>>From 60e2094bfdb8fcc791b8ef8a64be3e9c0c2274cc Mon Sep 17 00:00:00 2001
From: Santiago Carot Nemesio <sancane@gmail.com>
Date: Tue, 27 Apr 2010 14:09:43 +0200
Subject: [PATCH 2/3] Set to NULL return value on functions returning 0


Signed-off-by: Santiago Carot Nemesio <sancane@gmail.com>
---
 lib/sdp.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index ca16118..667d412 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1214,7 +1214,7 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
 	default:
 		SDPERR("Sizeof text string > UINT16_MAX\n");
 		free(d);
-		return 0;
+		return NULL;
 	}
 
 	if (bufsize < n) {
@@ -1771,7 +1771,7 @@ sdp_list_t *sdp_list_append(sdp_list_t *p, void *d)
 	sdp_list_t *q, *n = malloc(sizeof(sdp_list_t));
 
 	if (!n)
-		return 0;
+		return NULL;
 
 	n->data = d;
 	n->next = 0;
@@ -1809,7 +1809,7 @@ sdp_list_t *sdp_list_insert_sorted(sdp_list_t *list, void *d,
 
 	n = malloc(sizeof(sdp_list_t));
 	if (!n)
-		return 0;
+		return NULL;
 	n->data = d;
 	for (q = 0, p = list; p; q = p, p = p->next)
 		if (f(p->data, d) >= 0)
@@ -3466,7 +3466,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 
 	if (reqtype != SDP_ATTR_REQ_INDIVIDUAL && reqtype != SDP_ATTR_REQ_RANGE) {
 		errno = EINVAL;
-		return 0;
+		return NULL;
 	}
 
 	memset(&rsp_concat_buf, 0, sizeof(sdp_buf_t));
-- 
1.6.3.3


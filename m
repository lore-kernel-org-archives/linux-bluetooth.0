Return-Path: <cyrus@holtmann.org>
From: Simon Fels <simon.fels@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH v2] obexd: pbap: add headers correctly for size query
Date: Mon, 19 Oct 2015 22:12:17 +0200
Message-Id: <1445285537-5694-1-git-send-email-simon.fels@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When client queries for the size of a phonebook we fall into a
indefinite loop as g_obex_apparam_encode always returns the same
number of items added to the buffer regardless how often it is
called. In former times where this code wasn't using GObexApparams
a array was reduced each time the headers where added and so we could
easily find out when we've added all headers. However today we need
to solve this a bit differently by also setting the firstpacket flag
when we receive the phonebook size result from the phonebook
implementation which then lets us correctly go through without
falling into a indefinite loop.
---
 obexd/plugins/pbap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index f2f9166..bab691c 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -193,6 +193,8 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 	pbap->obj->apparam = g_obex_apparam_set_uint16(NULL, PHONEBOOKSIZE_TAG,
 								phonebooksize);
 
+	pbap->obj->firstpacket = TRUE;
+
 	if (missed > 0)	{
 		DBG("missed %d", missed);
 
@@ -826,14 +828,13 @@ static ssize_t vobject_pull_get_next_header(void *object, void *buf, size_t mtu,
 								uint8_t *hi)
 {
 	struct pbap_object *obj = object;
-	struct pbap_session *pbap = obj->session;
 
 	if (!obj->buffer && !obj->apparam)
 		return -EAGAIN;
 
 	*hi = G_OBEX_HDR_APPARAM;
 
-	if (pbap->params->maxlistcount == 0 || obj->firstpacket) {
+	if (obj->firstpacket) {
 		obj->firstpacket = FALSE;
 
 		return g_obex_apparam_encode(obj->apparam, buf, mtu);
-- 
2.5.0


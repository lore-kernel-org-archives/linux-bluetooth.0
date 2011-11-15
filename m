Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 03/16] Introduce obex_get_non_header_data
Date: Tue, 15 Nov 2011 15:27:54 +0200
Message-Id: <1321363687-32490-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
References: <1321363687-32490-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function remove the need of calling OBEX_ObjectGetNonHdrData in the
plugins.
---
 plugins/ftp.c   |    4 ++--
 plugins/mas.c   |    4 ++--
 plugins/pbap.c  |    4 ++--
 src/obex-priv.h |    2 ++
 src/obex.c      |   10 ++++++++++
 src/obex.h      |    2 ++
 6 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 0586326..7a736ae 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -255,13 +255,13 @@ int ftp_setpath(struct obex_session *os, obex_object_t *obj, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 	const char *root_folder, *name;
-	uint8_t *nonhdr;
+	const uint8_t *nonhdr;
 	char *fullname;
 	struct stat dstat;
 	gboolean root;
 	int err;
 
-	if (OBEX_ObjectGetNonHdrData(obj, &nonhdr) != 2) {
+	if (obex_get_non_header_data(os, &nonhdr) != 2) {
 		error("Set path failed: flag and constants not found!");
 		return -EBADMSG;
 	}
diff --git a/plugins/mas.c b/plugins/mas.c
index 7d3d553..7d47212 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -410,10 +410,10 @@ static int mas_setpath(struct obex_session *os, obex_object_t *obj,
 							void *user_data)
 {
 	const char *name;
-	uint8_t *nonhdr;
+	const uint8_t *nonhdr;
 	struct mas_session *mas = user_data;
 
-	if (OBEX_ObjectGetNonHdrData(obj, &nonhdr) != 2) {
+	if (obex_get_non_header_data(os, &nonhdr) != 2) {
 		error("Set path failed: flag and constants not found!");
 		return -EBADR;
 	}
diff --git a/plugins/pbap.c b/plugins/pbap.c
index fb82766..2e607b3 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -698,11 +698,11 @@ static int pbap_setpath(struct obex_session *os, obex_object_t *obj,
 {
 	struct pbap_session *pbap = user_data;
 	const char *name;
-	uint8_t *nonhdr;
+	const uint8_t *nonhdr;
 	char *fullname;
 	int err;
 
-	if (OBEX_ObjectGetNonHdrData(obj, &nonhdr) != 2) {
+	if (obex_get_non_header_data(os, &nonhdr) != 2) {
 		error("Set path failed: flag and constants not found!");
 		return -EBADMSG;
 	}
diff --git a/src/obex-priv.h b/src/obex-priv.h
index a834511..6a439b4 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -36,6 +36,8 @@ struct obex_session {
 	time_t time;
 	uint8_t *apparam;
 	size_t apparam_len;
+	uint8_t *nonhdr;
+	size_t nonhdr_len;
 	uint8_t *buf;
 	int64_t pending;
 	int64_t offset;
diff --git a/src/obex.c b/src/obex.c
index a1621b9..3a06775 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -931,6 +931,8 @@ static void cmd_setpath(struct obex_session *os,
 		break;
 	}
 
+	os->nonhdr_len = OBEX_ObjectGetNonHdrData(obj, &os->nonhdr);
+
 	err = os->service->setpath(os, obj, os->service_data);
 	os_set_response(obj, err);
 }
@@ -1546,6 +1548,14 @@ ssize_t obex_get_apparam(struct obex_session *os, const uint8_t **buffer)
 	return os->apparam_len;
 }
 
+ssize_t obex_get_non_header_data(struct obex_session *os,
+							const uint8_t **data)
+{
+	*data = os->nonhdr;
+
+	return os->nonhdr_len;
+}
+
 int memncmp0(const void *a, size_t na, const void *b, size_t nb)
 {
 	if (na != nb)
diff --git a/src/obex.h b/src/obex.h
index 6ede0a4..3e8ce00 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -48,6 +48,8 @@ int obex_move(struct obex_session *os, const char *source,
 uint8_t obex_get_action_id(struct obex_session *os);
 char *obex_get_id(struct obex_session *os);
 ssize_t obex_get_apparam(struct obex_session *os, const uint8_t **buffer);
+ssize_t obex_get_non_header_data(struct obex_session *os,
+							const uint8_t **data);
 
 /* Just a thin wrapper around memcmp to deal with NULL values */
 int memncmp0(const void *a, size_t na, const void *b, size_t nb);
-- 
1.7.7.1


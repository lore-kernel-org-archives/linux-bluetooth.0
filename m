Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo
	<anderson.lizardo-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
Subject: [PATCH BlueZ 11/13] lib: Validate DTDs when parsing VersionNumberList
Date: Fri, 15 Feb 2013 10:56:25 -0400
Message-Id: <1360940187-5202-12-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360940187-5202-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
 <1360940187-5202-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Lizardo <anderson.lizardo-430g2QfJUUCGglJvpFV4uA@public.gmane.org>

---
 lib/sdp.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 61598bb..6c73818 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2155,9 +2155,24 @@ int sdp_get_server_ver(const sdp_record_t *rec, sdp_list_t **u16)
 		errno = ENODATA;
 		return -1;
 	}
-	for (curr = d->val.dataseq; curr; curr = curr->next)
+
+	if (!SDP_IS_SEQ(d->dtd) || d->val.dataseq == NULL)
+		goto invalid;
+
+	for (curr = d->val.dataseq; curr; curr = curr->next) {
+		if (curr->dtd != SDP_UINT16)
+			goto invalid;
 		*u16 = sdp_list_append(*u16, &curr->val.uint16);
+	}
+
 	return 0;
+
+invalid:
+	sdp_list_free(*u16, NULL);
+	*u16 = NULL;
+	errno = EINVAL;
+
+	return -1;
 }
 
 /* flexible extraction of basic attributes - Jean II */
-- 
1.7.9.5


Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd] Fix pulling single vCard for parameters header missing
Date: Thu, 20 Oct 2011 10:34:48 +0200
Message-Id: <1319099688-4427-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to PBAP specification (ANNEX A), all application-parameters
are optional in case of pulling single vCard entry, so header for
application-parameters can be omitted, and it would be valid as well.
Previously pulling single vCard was always failing with "Bad Request"
status in such a circumstance.
This patch fixes that issue and pulling single vCard is done successfully
with "OK" status. Output vCard would contain all fields under 2.1 format
(as for default settings).
---
 plugins/pbap.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index a03f07c..066e37e 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -643,8 +643,12 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 		return -EBADR;
 
 	rsize = obex_aparam_read(os, obj, &buffer);
-	if (rsize < 0)
-		return -EBADR;
+	if (rsize < 0) {
+		if (g_ascii_strcasecmp(type, VCARDENTRY_TYPE) != 0)
+			return -EBADR;
+
+		rsize = 0;
+	}
 
 	params = parse_aparam(buffer, rsize);
 	if (params == NULL)
-- 
1.6.3.3


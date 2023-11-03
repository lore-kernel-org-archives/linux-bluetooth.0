Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3A9C0018C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Nov 2023 18:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjKCSWL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 14:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjKCSWK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 14:22:10 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48583D42
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 11:22:08 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4SMTbv6w9Kz9sqJ;
        Fri,  3 Nov 2023 19:22:03 +0100 (CET)
From:   =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To:     linux-bluetooth@vger.kernel.org
Cc:     zbrown@gnome.org, =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ 4/4] lib/sdp: Pass size_t to sdp_get_string_attr()
Date:   Fri,  3 Nov 2023 19:21:50 +0100
Message-ID: <20231103182150.60088-5-verdre@v0yd.nl>
In-Reply-To: <20231103182150.60088-1-verdre@v0yd.nl>
References: <20231103182150.60088-1-verdre@v0yd.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4SMTbv6w9Kz9sqJ
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We're currently type-casting the output of strlen(sdpdata->val.str) into
an int, which is somewhat problematic given that strlen() can return
values larger than sizeof(int).

We can do better here and use size_t instead, so let's do that.

While at it, also add a comment explaining why the check here is "smaller
than" instead of "smaller than or equal".

Co-developed-by: Zander Brown <zbrown@gnome.org>
---
 lib/sdp.c     |  5 +++--
 lib/sdp_lib.h | 14 +++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 4b10d8f67..cff7e09fb 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2180,13 +2180,14 @@ int sdp_get_int_attr(const sdp_record_t *rec, uint16_t attrid, int *value)
 }
 
 int sdp_get_string_attr(const sdp_record_t *rec, uint16_t attrid, char *value,
-								int valuelen)
+								size_t valuelen)
 {
 	sdp_data_t *sdpdata = sdp_data_get(rec, attrid);
 	if (sdpdata)
 		/* Verify that it is what the caller expects */
 		if (SDP_IS_TEXT_STR(sdpdata->dtd))
-			if ((int) strlen(sdpdata->val.str) < valuelen) {
+			/* Have to copy the NULL terminator too, so check len < valuelen */
+			if (strlen(sdpdata->val.str) < valuelen) {
 				strcpy(value, sdpdata->val.str);
 				return 0;
 			}
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index 22776b678..91d46f59d 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -141,7 +141,7 @@ int sdp_general_inquiry(inquiry_info *ii, int dev_num, int duration, uint8_t *fo
 
 /* flexible extraction of basic attributes - Jean II */
 int sdp_get_int_attr(const sdp_record_t *rec, uint16_t attr, int *value);
-int sdp_get_string_attr(const sdp_record_t *rec, uint16_t attr, char *value, int valuelen);
+int sdp_get_string_attr(const sdp_record_t *rec, uint16_t attr, char *value, size_t valuelen);
 
 /*
  * Basic sdp data functions
@@ -543,32 +543,32 @@ int sdp_get_service_avail(const sdp_record_t *rec, uint8_t *svcAvail);
 int sdp_get_service_ttl(const sdp_record_t *rec, uint32_t *svcTTLInfo);
 int sdp_get_database_state(const sdp_record_t *rec, uint32_t *svcDBState);
 
-static inline int sdp_get_service_name(const sdp_record_t *rec, char *str, int len)
+static inline int sdp_get_service_name(const sdp_record_t *rec, char *str, size_t len)
 {
 	return sdp_get_string_attr(rec, SDP_ATTR_SVCNAME_PRIMARY, str, len);
 }
 
-static inline int sdp_get_service_desc(const sdp_record_t *rec, char *str, int len)
+static inline int sdp_get_service_desc(const sdp_record_t *rec, char *str, size_t len)
 {
 	return sdp_get_string_attr(rec, SDP_ATTR_SVCDESC_PRIMARY, str, len);
 }
 
-static inline int sdp_get_provider_name(const sdp_record_t *rec, char *str, int len)
+static inline int sdp_get_provider_name(const sdp_record_t *rec, char *str, size_t len)
 {
 	return sdp_get_string_attr(rec, SDP_ATTR_PROVNAME_PRIMARY, str, len);
 }
 
-static inline int sdp_get_doc_url(const sdp_record_t *rec, char *str, int len)
+static inline int sdp_get_doc_url(const sdp_record_t *rec, char *str, size_t len)
 {
 	return sdp_get_string_attr(rec, SDP_ATTR_DOC_URL, str, len);
 }
 
-static inline int sdp_get_clnt_exec_url(const sdp_record_t *rec, char *str, int len)
+static inline int sdp_get_clnt_exec_url(const sdp_record_t *rec, char *str, size_t len)
 {
 	return sdp_get_string_attr(rec, SDP_ATTR_CLNT_EXEC_URL, str, len);
 }
 
-static inline int sdp_get_icon_url(const sdp_record_t *rec, char *str, int len)
+static inline int sdp_get_icon_url(const sdp_record_t *rec, char *str, size_t len)
 {
 	return sdp_get_string_attr(rec, SDP_ATTR_ICON_URL, str, len);
 }
-- 
2.41.0


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7FBC433ED
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 00:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759D561420
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 00:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhEAAiK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Apr 2021 20:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEAAiK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Apr 2021 20:38:10 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5BC06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 17:37:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l10-20020a17090a850ab0290155b06f6267so2597807pjn.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 17:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZMRd3/ogoBW+jG1K4p7C9xcO9rAez6bw8p9FyOWw/Qo=;
        b=asaqDaQYPJYGZLhzlBiaYPc7Gibd6GnPolMFDMgxp/t/SwcM0NAxtF3bUu3oZ3/EyH
         /tuLKApaS9x/k0VFsP6CNPXZkLrhUCpqeaC3KAojdbVINu04sVS+5aSCIJ1kZQ30ViGQ
         lYaXKK4r89ehMVZRmO1S9Cl2yOvjnvZd0XZi7xi56aQ4nxaLIwGlZTBuxdE0QY9UT0ms
         zL3Cd5h7goXnOqlgu/bOCJD3vI7Zdth/lsfCUGzujCQuk955+CZPjMa5Hlzl+S9PzQ4Z
         M2lV5jyLpEY0nRXfeQPq+BpcJF0e6dy3aKdpPTCBJS92SOjwo00xRG4KIfqvbwqCXclD
         1PMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZMRd3/ogoBW+jG1K4p7C9xcO9rAez6bw8p9FyOWw/Qo=;
        b=iGGZ6TGOXRguOhLHKoEnWkX6kLgHfFSxzj+7m9ldm3WGWveGUfA7TQ8Npb8QvF80ph
         ObPWpGNSxT0NpvRHgpXNxQcFsIJenKlZDqqR/fRkaICsxIs6qp53sRbiYwSQpQ0wONBw
         cPh/FjG2Ebs3+IGgqt3W1m2IMYuMDh5OReoawG9X7B6z8bql9hgQgBLWcKGDuwN1O03J
         G64mLsmHNyDhr9GpNiXfB8q6/hUjAb+F2rlnUQ1CToDRrJqwzQBko9TISzocojhKdGmC
         lrFkkXk4U8bH6BxBLnsH908scpvJahOTf6wmaQdzdv8nwyw7U8Tz0D6rCalifQFA0lp9
         tpzA==
X-Gm-Message-State: AOAM533QivHYd5EFF94xfwUfUd2eey6r0cnJmQ0FWmM/lvps8Fw3qcwo
        mQLryCAnJ7XqmDIAH1PmFNjT5iV4uRzKrA==
X-Google-Smtp-Source: ABdhPJzmgncKsE/22FYyZJDPbalQ0ITD2n/5Z6mOxYQrkP5h/1et8lpczo5HBrGDAwF7HAVePYlhgA==
X-Received: by 2002:a17:903:248e:b029:ec:9c4f:765e with SMTP id p14-20020a170903248eb02900ec9c4f765emr8063245plw.17.1619829440495;
        Fri, 30 Apr 2021 17:37:20 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h76sm2198410pfe.161.2021.04.30.17.37.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 17:37:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] avdtp: Fix accepting invalid/malformed capabilities
Date:   Fri, 30 Apr 2021 17:37:15 -0700
Message-Id: <20210501003717.7553-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Check if capabilities are valid before attempting to copy them.
---
 profiles/audio/avdtp.c | 56 +++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 623fe30d3..c7bf99f42 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1305,43 +1305,53 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 	return NULL;
 }
 
-static GSList *caps_to_list(uint8_t *data, int size,
+static GSList *caps_to_list(uint8_t *data, size_t size,
 				struct avdtp_service_capability **codec,
 				gboolean *delay_reporting)
 {
+	struct avdtp_service_capability *cap;
 	GSList *caps;
-	int processed;
 
 	if (delay_reporting)
 		*delay_reporting = FALSE;
 
-	for (processed = 0, caps = NULL; processed + 2 <= size;) {
-		struct avdtp_service_capability *cap;
-		uint8_t length, category;
+	if (size < sizeof(*cap))
+		return NULL;
+
+	for (caps = NULL; size >= sizeof(*cap);) {
+		struct avdtp_service_capability *cpy;
 
-		category = data[0];
-		length = data[1];
+		cap = (struct avdtp_service_capability *)data;
 
-		if (processed + 2 + length > size) {
+		if (sizeof(*cap) + cap->length >= size) {
 			error("Invalid capability data in getcap resp");
 			break;
 		}
 
-		cap = g_malloc(sizeof(struct avdtp_service_capability) +
-					length);
-		memcpy(cap, data, 2 + length);
+		if (cap->category == AVDTP_MEDIA_CODEC &&
+					cap->length < sizeof(**codec)) {
+			error("Invalid codec data in getcap resp");
+			break;
+		}
+
+		cpy = btd_malloc(sizeof(*cpy) + cap->length);
+		memcpy(cpy, cap, sizeof(*cap) + cap->length);
 
-		processed += 2 + length;
-		data += 2 + length;
+		size -= sizeof(*cap) + cap->length;
+		data += sizeof(*cap) + cap->length;
 
-		caps = g_slist_append(caps, cap);
+		caps = g_slist_append(caps, cpy);
 
-		if (category == AVDTP_MEDIA_CODEC &&
-				length >=
-				sizeof(struct avdtp_media_codec_capability))
-			*codec = cap;
-		else if (category == AVDTP_DELAY_REPORTING && delay_reporting)
-			*delay_reporting = TRUE;
+		switch (cap->category) {
+		case AVDTP_MEDIA_CODEC:
+			if (codec)
+				*codec = cap;
+			break;
+		case AVDTP_DELAY_REPORTING:
+			if (delay_reporting)
+				*delay_reporting = TRUE;
+			break;
+		}
 	}
 
 	return caps;
@@ -1538,6 +1548,12 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 					&stream->codec,
 					&stream->delay_reporting);
 
+	if (!stream->caps || !stream->codec) {
+		err = AVDTP_UNSUPPORTED_CONFIGURATION;
+		category = 0x00;
+		goto failed_stream;
+	}
+
 	/* Verify that the Media Transport capability's length = 0. Reject otherwise */
 	for (l = stream->caps; l != NULL; l = g_slist_next(l)) {
 		struct avdtp_service_capability *cap = l->data;
-- 
2.30.2


Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4480C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 17:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE70207F7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 17:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joTTnWDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgFER7p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgFER7p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 13:59:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FDDC08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 10:59:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ne5so525416pjb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtFqxY3AA3W15/GVoqzSBfn9To65Z71ECZe2VU4A4Ng=;
        b=joTTnWDccWIX9Wn/qAEHL8YKX3fo0WKSAzBQPxHJY8MjHrbEDmkNOWse0Xxk1UQUgw
         Jo69hXK8ezoD7s3mxJq0nq1NeSoH3ZjritKi84TKVSZF1D8SP8NQYGk7RS7kPvZS9Rfd
         nBk1XEAFyyp7YB2ezAU1lPxsLeqJI1whB6vkkAGNXyHYNgGSu93Ir4GzJZOKAJetop5i
         bE7oev24eHLya6kjWrsmkNAKP6dvFbP9DZPVcpwFW5hzZxieuS4HRJN1GJ3bxEMvHeIl
         EuolnAhrfGlW5C4z84UJUaUa3aymHkkMwgXNnbRXaW/DO7BGe/5HEt+8CblSn7RRAzfd
         uTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KtFqxY3AA3W15/GVoqzSBfn9To65Z71ECZe2VU4A4Ng=;
        b=F0+pzm7d3g0TzGtRqrCvdgct6ZJICRdwJlyT+VujKleAPAOKiaFL7K6VCcbqevDH0l
         WgsNnN+odLMXSlj7IEQdgmKhmR1oNQIAL5lG0qSIk40inXUVEzZXBABaTz8fYZDjMbsI
         U2QzpYA5AjTrt6r+l/byuSDaLZnVTSaeM0LnNY/eP6WRJcyurBCVGZPh/FItNwkJQE1A
         utV+NjiyZa+afixHbLgApt5x7WA0sxdTr8tOPWHqNZoB+/SOHSqkBYGw5zu5t6Idhoq4
         FOONEpV4PD+fJF41NM1BxNoOxDwdG9PXqnQ5WIfFTF86t9noVPD9dex5jKOdQUl8EqaB
         VrHQ==
X-Gm-Message-State: AOAM530ULjcEUX6AyOhLHi2zRg0Bv/pZm48e56F4Ct1cErM1XoPcHoni
        HnXYvbMswirjHMKIolz1sPRtJbUp
X-Google-Smtp-Source: ABdhPJwsYmmmL9vDyV75wmdXazt/UpE+e6eL1T6anIBlnZu9+D/iWKLaXSqZSb7RDwAa3RAxfswkmg==
X-Received: by 2002:a17:90a:d487:: with SMTP id s7mr4261891pju.37.1591379984216;
        Fri, 05 Jun 2020 10:59:44 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p11sm245452pfq.10.2020.06.05.10.59.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 10:59:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btio: Fix not translation mode to L2CAP mode
Date:   Fri,  5 Jun 2020 10:59:42 -0700
Message-Id: <20200605175942.719436-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When using L2CAP_OPTIONS legacy modes need to be used since they are
not compatible with BT_MODE.
---
 btio/btio.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 13c731062..844d6007f 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -597,6 +597,20 @@ static gboolean get_key_size(int sock, int *size, GError **err)
 	return FALSE;
 }
 
+static uint8_t mode_l2mode(uint8_t mode)
+{
+	switch (mode) {
+	case BT_IO_MODE_BASIC:
+		return L2CAP_MODE_BASIC;
+	case BT_IO_MODE_ERTM:
+		return L2CAP_MODE_ERTM;
+	case BT_IO_MODE_STREAMING:
+		return L2CAP_MODE_STREAMING;
+	default:
+		return UINT8_MAX;
+	}
+}
+
 static gboolean set_l2opts(int sock, uint16_t imtu, uint16_t omtu,
 						uint8_t mode, GError **err)
 {
@@ -614,8 +628,14 @@ static gboolean set_l2opts(int sock, uint16_t imtu, uint16_t omtu,
 		l2o.imtu = imtu;
 	if (omtu)
 		l2o.omtu = omtu;
-	if (mode)
-		l2o.mode = mode;
+
+	if (mode) {
+		l2o.mode = mode_l2mode(mode);
+		if (l2o.mode == UINT8_MAX) {
+			ERROR_FAILED(err, "Unsupported mode", errno);
+			return FALSE;
+		}
+	}
 
 	if (setsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, &l2o, sizeof(l2o)) < 0) {
 		ERROR_FAILED(err, "setsockopt(L2CAP_OPTIONS)", errno);
-- 
2.25.3


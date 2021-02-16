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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5459BC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 23:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B92E64E10
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 23:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhBPXeV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Feb 2021 18:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhBPXeU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Feb 2021 18:34:20 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCCEC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Feb 2021 15:33:40 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t29so7177480pfg.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Feb 2021 15:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=McBDHmfkfwbeBj/qAUK5UpWvbsYXc1zDEYxrt+U7x6s=;
        b=MP1MX2KvM5iRmDte6BSi5gnm8lPjuoj2qkkynbp17ijG+kE1PFqly7JgLUyqQhe5ZQ
         8JWwXB/lFCvh6Cc6TWS2ewyxpx0m/8E+Ib+LiSYlhGQ4dfdHq5uz1wUYsdaEh6g5p+JN
         +wlSXLhP+AmE3LppfeQuvHZ3zXBmdnMkGaId+7qyaELho9Qm1e0QKLjfU/YBvhTOgBC1
         gzIvbuwmkUwT7nmiHtNzM/o/VeOnWmmthubmSdDp01GCIDPszR62w0wN78yG+5IhgZT0
         GiS0R/PLlxQxSboh4sl+N5w7a7wD5CdZmf8DohjfAdNqVKXbEMg6FnKITjbAYmo4U+in
         tG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=McBDHmfkfwbeBj/qAUK5UpWvbsYXc1zDEYxrt+U7x6s=;
        b=i8S9IB+cFnbk8l0/AaS/L7eQ/udx7nSvSL6nVpPdEXWRCoeejDaw/8PJdp+wzjnT+r
         RWBHRr1uNC0d8n4KqQRW7fy9kFynN8ap3acAd50/LwodYKk8cP7rtoR+vUm0hEvSHkPm
         zas1gkbLD5bztpoRZqPrJALhr+ppGT0w6C3Z3J9MqVGukE3934SldiwcHTGQH6JquRLk
         zVG7lHlf/XL+XDxa5wc0kAQxzymnS/OnDYLgchduhyTTnlai+PBn/4U/QqmzEEdAy9g0
         e2ktTM8OT3eTzDPUloFF2SmTBToKHMbwwSc3F2P5ZxWLbjWCr7bCm5lbyI4PfZaVrXtJ
         arcg==
X-Gm-Message-State: AOAM530BFO5/na5Q3KRSpddiRAle4Q0J+GX3feMzOWCvNh4uKUqDaaBs
        m6uh7/omlxDyQc5LDZBRT5bX11EQ8LtbGA==
X-Google-Smtp-Source: ABdhPJyJVu/4IHoWrndIixjJmYUzCvXnu7oLLLdxUQZf45XhXdtc9m4vQmtHcsT5WRnkPbrgE5BaLQ==
X-Received: by 2002:a63:1826:: with SMTP id y38mr21258223pgl.252.1613518418917;
        Tue, 16 Feb 2021 15:33:38 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h5sm99956pgv.87.2021.02.16.15.33.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 15:33:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] avdtp: Fix setting disconnect timer when there is no local endpoints
Date:   Tue, 16 Feb 2021 15:33:35 -0800
Message-Id: <20210216233337.859955-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there are not local endpoints left there is no point in starting
the disconnect timer as without any endpoint it is not possible to
configure streams anymore so the code should proceed to disconnect
immediately.
---
 profiles/audio/avdtp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index fa72ef66a..9ddcd6464 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1226,7 +1226,13 @@ void avdtp_unref(struct avdtp *session)
 
 	switch (session->state) {
 	case AVDTP_SESSION_STATE_CONNECTED:
-		set_disconnect_timer(session);
+		/* Only set disconnect timer if there are local endpoints
+		 * otherwise disconnect immediately.
+		 */
+		if (queue_isempty(session->lseps))
+			connection_lost(session, ECONNRESET);
+		else
+			set_disconnect_timer(session);
 		break;
 	case AVDTP_SESSION_STATE_CONNECTING:
 		connection_lost(session, ECONNABORTED);
-- 
2.29.2


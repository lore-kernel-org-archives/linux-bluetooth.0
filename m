Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE328C433E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 15:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7260964FB8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 15:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhCKPku (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbhCKPkj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Mar 2021 10:40:39 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23716C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 07:40:39 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t18so3637679pjs.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 07:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyGTkWfo3IWxGEwV6T4JfWKWDdvAYlYQKC/r15+LxWY=;
        b=ehaCu4+SfWDN3oz0QOuP6lDwa2LtkmtyXL07IOJ6qbslxss2Jh7ZZg61FD9mNck3ce
         VQqdZFmACS+bTTAliUIMzWSmvYSWRRbdrEvb3YBTDrLX8EjKKMak1NENqtQZ216oKA6N
         KBZMVr2GBgK9OrIDnPzZzFBqFhSjgooMp8vp2JFv2OlzBcragr0jILBcrrL04tgR4CDK
         OLejgltBgbrm+15RLZPlxLR0fJnLO9GwLFHJXgbA+10eSF2On+IrCV8lb/b2hucZrQD7
         QeF9ojRbmo7vfpFpN+W/rW/wE/sU9Hkh3QRr5YdTx5j/XxJXI6gTnIFw4bredP96bfpv
         v9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyGTkWfo3IWxGEwV6T4JfWKWDdvAYlYQKC/r15+LxWY=;
        b=DkZ+evn2WJIBSW6Ld2JOddXjG/DlUczmXEuDKkl7G0UAQ36x/0mFDxoJDC0rmqYwu/
         loeCT/1BMNJjQODf8EBDDS/tuEHLRu5slETtdp/WVuy4jsN3aWkUciqZ19EdiGyd+mi6
         FprR41yh1fs610py/xhyGFw/k1gN62g72x99mjCMb67U1YNArfGZozlNAZXetf3y//ea
         zdq1WVYO/D7a9dm44HhLejc7381Q90uBGFKJ4YrpTxhu1El3+01Rlm2LY+GITRvvdY3A
         9vV9tRKcAhwC6KEyCm4pdfZBF0jezzkkG206nBPOF5X3ybiQy0eYSRxfPbW5SVzIh+J4
         3TnA==
X-Gm-Message-State: AOAM5318u66E2mnGyJ+Tuwl8jFFhxnWgcOH7aZ3XWerN7BClMu8nksF3
        LqAGtSnQviu+TxUSbvrSl3nD+qO81hn4aw==
X-Google-Smtp-Source: ABdhPJzimh/YYqgsPdUkq4vlSKhgVOA6l+y7i00XZ2lSyOK9SIOqKOwU7CPN5uBcR3VpcJmn1BN8/A==
X-Received: by 2002:a17:902:8501:b029:e2:d953:212c with SMTP id bj1-20020a1709028501b02900e2d953212cmr8569046plb.49.1615477238181;
        Thu, 11 Mar 2021 07:40:38 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f14sm2995892pfk.92.2021.03.11.07.40.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:40:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] avdtp: Fix removing all remote SEPs when loading from cache
Date:   Thu, 11 Mar 2021 07:40:36 -0800
Message-Id: <20210311154036.1008199-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If avdtp_discover is called after cache has been loaded it end up
removing all remote SEPs as they have not been discovered yet.

Fixes: https://github.com/bluez/bluez/issues/102
---
 profiles/audio/avdtp.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 088ca58b3..1d5871c62 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3381,10 +3381,18 @@ int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
 	session->discover = g_new0(struct discover_callback, 1);
 
 	if (session->seps) {
-		session->discover->cb = cb;
-		session->discover->user_data = user_data;
-		session->discover->id = g_idle_add(process_discover, session);
-		return 0;
+		struct avdtp_remote_sep *sep = session->seps->data;
+
+		/* Check that SEP have been discovered as it may be loaded from
+		 * cache.
+		 */
+		if (sep->discovered) {
+			session->discover->cb = cb;
+			session->discover->user_data = user_data;
+			session->discover->id = g_idle_add(process_discover,
+								session);
+			return 0;
+		}
 	}
 
 	err = send_request(session, FALSE, NULL, AVDTP_DISCOVER, NULL, 0);
-- 
2.29.2


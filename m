Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2019CC05027
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 20:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjAZUMy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 15:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjAZUMw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 15:12:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6663B65AF
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 12:12:50 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9so2870327pll.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91fk8UQcmph4sRXVIFsVDlzR6bO+9TiL/3utzzRGgmo=;
        b=dSskUUDdwmfXa92tg3KKpHKTPaXplpfuuDO0OeWso7+Q8TynV2Gp9qSqVW+FaNsIhL
         JPjDkXY5Qe59sJmTmfM0OCLF4oMARDQozWsNSvKmIb0kQKatT2WmGrwZxLpKj5Ah6igb
         B0UbPAOeRJoqb8GFf9P78TbBSWutupN9moH7IneYs4eN4DQKASwyr+NPbDlxhM5e/qJ7
         M6yus1Qdf91HHevunf5kzEzVHCz+EFoi93v3UvZfeSLHJwvL2G+IAI+2Asq4H7g6AjYQ
         cr7yYfm9pBgq/Gl6Cv5YC2Yqjw+yMI86+vxIoWjJjtiWHv95HUcZJMVvyGBPDGvDKPL5
         mwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91fk8UQcmph4sRXVIFsVDlzR6bO+9TiL/3utzzRGgmo=;
        b=ft8YM/3D4VZpr9Tqnjp+vfmMgqBburIlXshEYaWexsA96zIp42CHDuYKS1ZYh8Hjw6
         VgSGdtJ7mQscof3+jMyZgzgSmyOWB7kuBPibEOFGGJujTiRlM1/My1wVY7K+79hWdQIa
         gOSTIAcC5xfcg7qRGHKsonsUflA3mSdZ+UjIo8wcCvRRdGZI++HndK5xo14krviYpN2a
         6YXsMGH162nmtNz2YKCkAUR2mAeTxvmyLUc/u4+WiUovg/daIzTAxzxZL82deXa1RcJJ
         W+v09tNUgF9Abu6swAzNAqozv20mv8TDG5buRjfCeoQ/wHeu7DcVBDYPxWb5jOVQtHGs
         X+GQ==
X-Gm-Message-State: AO0yUKWcxUFowxRK/Xm2/mpusIBylMqTQ40MaFEZtwV99wH7Kskl2DIh
        3+gS9PwqRCeKQsb7rEXflwBK/TfFQx4=
X-Google-Smtp-Source: AK7set9sdqp4k58aF7dIEwWg94V5R8Aq3RZ0GoqqBVTv9sOo1fmoHk/JOB4k3A8q/bU7Vo1lSxhFRw==
X-Received: by 2002:a17:902:ec88:b0:196:1d60:b1b8 with SMTP id x8-20020a170902ec8800b001961d60b1b8mr11106580plg.34.1674763969340;
        Thu, 26 Jan 2023 12:12:49 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902c78100b00194955b7898sm1341045pla.237.2023.01.26.12.12.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 12:12:48 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/5] bap: Fix registering multiple endpoint for the same PAC set
Date:   Thu, 26 Jan 2023 12:12:42 -0800
Message-Id: <20230126201242.4110305-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230126201242.4110305-1-luiz.dentz@gmail.com>
References: <20230126201242.4110305-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure there is only one endpoint representing a local and
remote PAC set.
---
 profiles/audio/bap.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 5a50a2cc6105..e5ffb7230580 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -510,6 +510,22 @@ static void ep_free(void *data)
 	free(ep);
 }
 
+struct match_ep {
+	struct bt_bap_pac *lpac;
+	struct bt_bap_pac *rpac;
+};
+
+static bool match_ep(const void *data, const void *user_data)
+{
+	const struct bap_ep *ep = data;
+	const struct match_ep *match = user_data;
+
+	if (ep->lpac != match->lpac)
+		return false;
+
+	return ep->rpac == match->rpac;
+}
+
 static struct bap_ep *ep_register(struct btd_service *service,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac)
@@ -520,6 +536,7 @@ static struct bap_ep *ep_register(struct btd_service *service,
 	struct queue *queue;
 	int i, err;
 	const char *suffix;
+	struct match_ep match = { lpac, rpac };
 
 	switch (bt_bap_pac_get_type(rpac)) {
 	case BT_BAP_SINK:
@@ -536,6 +553,10 @@ static struct bap_ep *ep_register(struct btd_service *service,
 		return NULL;
 	}
 
+	ep = queue_find(queue, match_ep, &match);
+	if (ep)
+		return ep;
+
 	ep = new0(struct bap_ep, 1);
 	ep->data = data;
 	ep->lpac = lpac;
-- 
2.37.3


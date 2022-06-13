Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99A3C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 23:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244438AbiFMXep (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 19:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbiFMXek (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 19:34:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2356332EE6
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 16:34:27 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s135so6943085pgs.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 16:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7P1wyykzAjdsa0oVX7nZF9urJa3Nda2ECOVn9sOUVOo=;
        b=EeEx0koed4qmNyRvxTbfNmBEQy6BEj3HnXVlB9Ko/g3MQGiJsn0UbbYbU4Mk176vZd
         Wpyah9BLRU8ghQ5M9W7vwDqD0befM6BcINZpdToMJ7ItdQpr6FM6A5VM44bBTrJro3hY
         rn9nA+aMsSAJcl0jUe0sGQP9XPE+0xziQUIBbWCQcWXd60vo3v2FN+Gv5s5WPjwqhB/c
         T7FbGtBkxZkTu7YUGAWNEnEwHgj1HsfInClOUw2qWeBIZMubmDS/cvjHHxSH8psSv7KO
         m5aKscX9DKciarhpQTTsl/NtPvup9YhkivpqK173wKXMWio2AGJ3sQjCiyFe8NLfkkrc
         u4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7P1wyykzAjdsa0oVX7nZF9urJa3Nda2ECOVn9sOUVOo=;
        b=SJPYmikGt5CTy1qOsncxx4FFVOhfRizDbWxb0zxJ+HnrVAacIWXN33JMeU9CAsSFob
         Qn/aAFoKzG3K6WHW2VwQCUS11X2rtefr+pfqjQUVhj4PlXue55SsctoSg+VDazqzCiZQ
         FEyBFyTiM8T7kJ23qf9Qj8XMHdY5tQvY2bpFu/xVIz8Qh4e6nq2wIpYbRC68K5FhSXFu
         IWvl45grqHGUCoCv1XTDuqrGH4HuGoVMi/MGuzp3u4OcNgsQsqxAGB3V4mhzt/kVQ7TA
         932AP5dKFGddGuSt8RodqC1lO30jBNy9ltNE3iOB0lPr3h9OHCqIedCsvRsNFvhI5OlU
         sKXw==
X-Gm-Message-State: AOAM531hNOvSSYqjwByEngqKClOVXUxmR1P3ek/m4EboIubaRwVmn6Ij
        64j3Cfh1Wt627sO2SGMnnDMUPKDjrtg=
X-Google-Smtp-Source: AGRyM1vmO4wxbtIVAQBbwcLyNBBbiMctr4xBUy5sdAdoYkpGMwlUMnuROcQoXa2mWVJGtbGDVC+Cqg==
X-Received: by 2002:a05:6a00:893:b0:51e:77ab:8874 with SMTP id q19-20020a056a00089300b0051e77ab8874mr1354263pfj.21.1655163266142;
        Mon, 13 Jun 2022 16:34:26 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b00163ffe73300sm5691017plj.137.2022.06.13.16.34.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 16:34:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor/att: Fix decoding for notifications
Date:   Mon, 13 Jun 2022 16:34:19 -0700
Message-Id: <20220613233419.177421-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220613233419.177421-1-luiz.dentz@gmail.com>
References: <20220613233419.177421-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 monitor/att.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/att.c b/monitor/att.c
index 00db8ddaa..de70a9dc4 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -1547,7 +1547,7 @@ static void print_notify(const struct l2cap_frame *frame, uint16_t handle,
 		return;
 	}
 
-	attr = get_attribute(frame, handle, false);
+	attr = get_attribute(frame, handle, true);
 	if (!attr)
 		return;
 
-- 
2.35.3


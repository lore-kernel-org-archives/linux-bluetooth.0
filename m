Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0358BC433E3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D626B2064C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEzvugMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgGQTPW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgGQTPV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 15:15:21 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE81C0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:15:21 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z5so7137182pgb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9CGEiPF9wLML97aLDtUYlsZfnzcMXSIYdV6ccazgttk=;
        b=QEzvugMW3rA8H/hC61bH5KXTPgjAxuP1722fOdVyFEjhHCc4GzcHWSIC93EOC3LuZi
         r6we0pvaCPKQZXKcL6NVsRecO4MDz2Zy+thz1nf9HdF3AR5egnBmyTrCoJ57LtuwzzX2
         6LYK727UJVvCxOMnjB0GMhXbpf3qNleD9pDyaiF5S8yPzgh7DJgVdR0BVrlQ6IF2A3mg
         qGTfjaJpaTsB3BqZq2aEdAMz/kQOM9xAXEnxxyTcTwVXc0XWa8ZMnmzCFMG0JLNdPyt1
         V3Us5Jo1t2Rw7TRaY6aDvVNpIb7Wehvctt0l4stjs7wvvymnCvC1P0sSFZraqFu0X990
         KfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CGEiPF9wLML97aLDtUYlsZfnzcMXSIYdV6ccazgttk=;
        b=T2X0JcmbMwpCLIOP1DSMG2XwlIvt3sQp5TazGca/ePyM5zPWMpWwQzYS+dT/AoQv+0
         TBsGKra9xGQcJTABm3A5dV03hTwct8yhMHC9RFvqTDZwWJ65cGdfCs7LULGA2I4KZgt1
         ex5RmyVDj7k6MEh7rfBmWk/EZwy727doATvyNrschYKev33PB/AmuprLjqhe2CVF8dH1
         DPnkT/0C/LCGcnhzfi4d1c8IVtymrwH+pl2dnXmWkqKC2mqjx5CdNpPR4QHDO/j1Kesx
         WE/sw2XQds1QswIY3DmlXpDPYRQ9B34iwgguTyaX5QL+E6PLGnQtEH999JgjFjLp/mxx
         joZA==
X-Gm-Message-State: AOAM533GXqM1AnZQwXbmWckMosNXXrpaIFwFPBnJ5iHbQ55HBaji0e1Y
        cilIkIizSLXgvgK+449Kfp3G//3MDcc=
X-Google-Smtp-Source: ABdhPJxE/kSuEPzqBxwJlkkjCaqfKc/JiIsh92nF0YkFH7s8pgVSHeKGGpieTucKHVjYaJBDueSXCw==
X-Received: by 2002:a05:6a00:78a:: with SMTP id g10mr9473873pfu.0.1595013321219;
        Fri, 17 Jul 2020 12:15:21 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p9sm6488334pgc.77.2020.07.17.12.15.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:15:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] shared/gatt-client: Fix handling of service changed
Date:   Fri, 17 Jul 2020 12:15:15 -0700
Message-Id: <20200717191515.220621-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717191515.220621-1-luiz.dentz@gmail.com>
References: <20200717191515.220621-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When handling multiple service changed multiple discovery operations
would be performed but at the end of each one the hash would be read
which not only would create extra traffic but also prevents the code
to properly detection services disappering.
---
 src/shared/gatt-client.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 409a3ee57..f6cff5014 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1460,8 +1460,10 @@ static bool read_db_hash(struct discovery_op *op)
 	struct bt_gatt_client *client = op->client;
 	bt_uuid_t uuid;
 
-	/* Check if hash was already read */
-	if (op->hash)
+	/* Check if hash was already been read or there are more services to
+	 * process.
+	 */
+	if (op->hash || !queue_isempty(client->svc_chngd_queue))
 		return false;
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_DB_HASH);
-- 
2.26.2


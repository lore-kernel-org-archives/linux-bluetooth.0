Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5151C2BB41
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 22:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbiHPWF5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 18:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbiHPWF4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 18:05:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D65D72FF8
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 15:05:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gp7so10878237pjb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=0lZb1xai1JnBrrL7n4wa12Nq8PJJQDPpg+w/LzhBQd8=;
        b=Dt0hzi8q/SRl0entoADATZTNBZz0aHGxZMnTlnEts04p0FtnnaPOPbzW62bQZxaJBk
         HJCl7dlfDeML52leXE8Sx6YQiY3aMkKt3q+1WYcxbf6XSnX1my939SDI4GTYB5ygulVw
         9P2dtYA4YkIxZTmHhQrO++4BSQFrAEBkRPkmaADHPIaXlPdPJu4oXpbRFu6V8P5qeRn0
         GT7qOzsdzb3msarj4qdUGNz58tfF4DA0KsR5HjkW/vZB6kLlzu37Tv4NEu2ixAAnHiFt
         2GNO1968tjDjF31NRNs1afZ0UB3n+9YRKNFNKNEoeCU1dZvaHkwXcsHjiJHnf2DbVQXf
         7gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=0lZb1xai1JnBrrL7n4wa12Nq8PJJQDPpg+w/LzhBQd8=;
        b=N3aSliTtDWEnIYpXXTEStjbl9wkkj7KoNs6zR+BinNLlOLWBxNdVjkTprrCKcgRoUQ
         TqGkxWEmQhb3iM+lzwZDuhyI/pJX6g6ZDrfYgtmGZupuN+5zJMMaxtkNcnbMV5ZQ4JWY
         KCr9Cf+IWaTCzqt4IxjTjkZvYQVpMx+FV1CaCnlfqVD72DdwmaB3DNeIOC7txRcz5zKc
         TisUrhj1awQy6VMOTsiIlEKM2zf0b20pEQUHlnL11ZW3z4h/S6vLqf+J4uJKzE7qZQop
         vTX9vTDgxFtL16OgYPOcEhjpZ1Y2lFEEO48Yddj7pTDUNh7Dcv6d0BeFjmbbqUwKKU1l
         eQkg==
X-Gm-Message-State: ACgBeo3SJoQN1z7wZwL6TBEm0z+/vShYSRLtGemqCZqOJP0NJr2ZBo/2
        e70Qrrlix0FvTYDDIoR3rttdJWh4J/30H4f9
X-Google-Smtp-Source: AA6agR7By9LCHWOsFkjnDTp6gahH/+hyo0XoWCS+9Io+YyLOT0I2DrXmA4UhilcvscEdv7TUo7RL3Q==
X-Received: by 2002:a17:90b:3e88:b0:1f5:6029:1bf7 with SMTP id rj8-20020a17090b3e8800b001f560291bf7mr637908pjb.155.1660687555170;
        Tue, 16 Aug 2022 15:05:55 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a20-20020aa79714000000b0052d2cd99490sm8954286pfg.5.2022.08.16.15.05.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 15:05:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 2/2] hog-lib: Fix scan-build error
Date:   Tue, 16 Aug 2022 15:05:48 -0700
Message-Id: <20220816220548.1555673-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220816220548.1555673-1-luiz.dentz@gmail.com>
References: <20220816220548.1555673-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following errors:
profiles/input/hog-lib.c:600:19: warning: Access to field 'handle'
results in a dereference of a null pointer (loaded from variable 'chr')
        report->handle = chr->handle;
                         ^~~~~~~~~~~
profiles/input/hog-lib.c:637:11: warning: Access to field 'value_handle'
results in a dereference of a null pointer (loaded from variable 'chr')
                start = chr->value_handle + 1;
                        ^~~~~~~~~~~~~~~~~
profiles/input/hog-lib.c:1240:11: warning: Access to field 'value_handle'
results in a dereference of a null pointer (loaded from variable 'chr')
                start = chr->value_handle + 1;
                        ^~~~~~~~~~~~~~~~~
---
 profiles/input/hog-lib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index ace233d3ce8b..021db386f3b7 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -590,6 +590,9 @@ static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
 	struct report *report;
 	GSList *l;
 
+	if (!chr)
+		return NULL;
+
 	/* Skip if report already exists */
 	l = g_slist_find_custom(hog->reports, chr, report_chrc_cmp);
 	if (l)
@@ -630,6 +633,9 @@ static void external_service_char_cb(uint8_t status, GSList *chars,
 		chr = l->data;
 		next = l->next ? l->next->data : NULL;
 
+		if (!chr)
+			continue;
+
 		DBG("0x%04x UUID: %s properties: %02x",
 				chr->handle, chr->uuid, chr->properties);
 
@@ -1232,6 +1238,9 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 		chr = l->data;
 		next = l->next ? l->next->data : NULL;
 
+		if (!chr)
+			continue;
+
 		DBG("0x%04x UUID: %s properties: %02x",
 				chr->handle, chr->uuid, chr->properties);
 
-- 
2.37.2


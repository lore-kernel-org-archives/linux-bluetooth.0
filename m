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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9696C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 18:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9847207ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 18:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxZgbQI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgFESRs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgFESRs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 14:17:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AF3C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 11:17:47 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so4042130plt.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ne4lsec+U3AJ33tnijiF6V316Nr9mwIXEdrvN6qq4pE=;
        b=YxZgbQI8Ov9IxbqVJ28Vkg30TEJQW3RrkOVPVSUIoIAuaGTuqOjFivUFuXcOPwXPF9
         VQLe950VVnfnzPF1tPIyIGr0jENBpxL689Cvjd85DgbFryfgZKMsfupNm2uCpNPcPinO
         NS+jvi/sGdWDh4xvvMRrgpEH+2Vy/Dh5oI2m7DRnDy5pK0NzxHrqwRNC0LhFgxZJ1WXt
         M46NIKbECkcrqwL70hLZGGJZ3G9f8QmYSNVzwQkfQBlReNZ2/rPFKwELOI0bCYCexINF
         bKMUYEps9yPJUEWPn/E2N06ic3kyy8E/6d6AVMHR6V+AGUKrLrBG7aYMIAMYUqmzD2yj
         QiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ne4lsec+U3AJ33tnijiF6V316Nr9mwIXEdrvN6qq4pE=;
        b=FpOopy3c/WomKzhXeBD/iowqPRbcZAMyIBxdFO+r+vcQ2ZAgpSfvywXtgh1SmXMnvJ
         XJMfYaK1jGBH5wiMKzaEyKKjg4Da8F97owJVr0ocXNncigsfabgsz2zXejqH5e97zoZn
         AQPo+WWNOzTRt4bwA0xM+3PGqP0dtyE151UzTnWj8QH9q/foexnAS4ZfzU3+TL6L2sKO
         sFRfjhzGhqtwcESivQ7jrb2UBQ22ailKkS9HLRGyq25/3UGAXrRki+eVXiSwiBOGUOs3
         PRW+qIH3gsX/5jlasJvtT612ftjhsKyBmQNCutiRyP4zF1BLJr0gvTmojTuemchpbpOY
         j/CA==
X-Gm-Message-State: AOAM530qJyccioTJT9sr6AY5Z5A4979EbFEDW6AMPrdS1vM2qqgmpANZ
        +OCQLvu8a7NzQcpJes9h++idsZNo
X-Google-Smtp-Source: ABdhPJxs//VjFIEa/wAYFeB0gP42b6BxwWXn9GvzWmbh6wyX2TYP9mwk6+oA4bd3Qi0flTZc9QRS0g==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr10358318plo.162.1591381067047;
        Fri, 05 Jun 2020 11:17:47 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y5sm221385pgl.85.2020.06.05.11.17.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:17:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] advertising: Fix resetting NO_BREDR flag
Date:   Fri,  5 Jun 2020 11:17:43 -0700
Message-Id: <20200605181743.720661-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200605181743.720661-1-luiz.dentz@gmail.com>
References: <20200605181743.720661-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When setting BT_AD_FLAG_LIMITED it was actually overwriting
BT_AD_FLAG_NO_BREDR as well so this moves the logic of detecting if the
instance needs to set BT_AD_FLAG_NO_BREDR to set_flags so it is always
updated when attempting to set any flags.
---
 src/advertising.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 4c91586c2..076d591b6 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -675,6 +675,13 @@ static bool set_flags(struct btd_adv_client *client, uint8_t flags)
 	if (!btd_adapter_get_bredr(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
 
+	/* Set BR/EDR Not Supported if adapter is not discoverable but the
+	 * instance is.
+	 */
+	if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
+			!btd_adapter_get_discoverable(client->manager->adapter))
+		flags |= BT_AD_FLAG_NO_BREDR;
+
 	if (!bt_ad_add_flags(client->data, &flags, 1))
 		return false;
 
@@ -697,12 +704,9 @@ static bool parse_discoverable(DBusMessageIter *iter,
 
 	dbus_message_iter_get_basic(iter, &discoverable);
 
-	if (discoverable) {
-		/* Set BR/EDR Not Supported if adapter is no discoverable */
-		if (!btd_adapter_get_discoverable(client->manager->adapter))
-			flags = BT_AD_FLAG_NO_BREDR;
-		flags |= BT_AD_FLAG_GENERAL;
-	} else
+	if (discoverable)
+		flags = BT_AD_FLAG_GENERAL;
+	else
 		flags = 0x00;
 
 	if (!set_flags(client , flags))
-- 
2.25.3


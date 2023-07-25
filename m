Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0DEC0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 08:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjGYIrK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 04:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjGYIqi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 04:46:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7756B1BD1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99313a34b2dso769338166b.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690274692; x=1690879492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaL2DgaNC+1z327qtfZ1KrQuYZxhQvPHWnqk5Q87V8k=;
        b=oI4kGqxgoVNrQROxKKw/FqtcrhcNUyfoSoU30wAFtfdxZMJgawHN96MlJZyP4bFAlG
         igTf5Cs/N34p0G+WXk/eXofUtZVfSj378GSZMYfL8VkWkFlXJnT3rkZniPB0fzdG7ePt
         5kEKatSKd5gCmql8xfj6dwtibjhWB5fG5jcZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274692; x=1690879492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaL2DgaNC+1z327qtfZ1KrQuYZxhQvPHWnqk5Q87V8k=;
        b=W5hhdYEnP/BqNX3aBxhPeqyWsR2IqcFAEXt+7ecJFcicySEvl4QUzjgV00e7pDrSbF
         8g53gYj1f9Cg3AWlAhfQHIfGCZA4ry25RSiw/uw0EEwu4Sfwpd5jcAF0FrgLcd73jOvh
         33W0U7kCLUZ2cAE5FrOy0PRt2GiAKE+0kEmcKonnE75DUx9zEq1P00MN1bRjRIU4dYIl
         2sdKU9j+bukcKxTljCHkc/N31/PmBUn2+Sr2+dkty3KIyBJwxxrAK/lLMkEoSpl/98+e
         fk8d8RQoPB+2X+IR5Mx7wUITTzKiA4GwsNFeev3Azjw482UP9ZT+1G69chllr6PD62HF
         65zg==
X-Gm-Message-State: ABy/qLZ81Tu+7xtngiF//jxuEGYLZTjbq0yh3qnjgDgaU8xQ46tZWclE
        d831Erhf9wft185/Wmj+Voo1KU8zHVP4e2goGtc=
X-Google-Smtp-Source: APBJJlGOu98XeKUnao9zQqlO1TNjXeL0S1Q0cobuo1TnWmrKKBtuIp91xp6TzpP3FuQaPpY/TPCzHQ==
X-Received: by 2002:a17:907:7895:b0:99a:7ff1:9b5a with SMTP id ku21-20020a170907789500b0099a7ff19b5amr12467744ejc.4.1690274692468;
        Tue, 25 Jul 2023 01:44:52 -0700 (PDT)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:ed64:7921:ba0:11aa])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906164a00b00977cad140a8sm7866577ejd.218.2023.07.25.01.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:44:52 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/8] advertising: Fix setting "BR/EDR not supported" flag
Date:   Tue, 25 Jul 2023 10:44:24 +0200
Message-Id: <20230725084431.640332-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We need to check if adapter is connectable since remote device can connect
to our device even when we are not discoverable according to advertised
MAC address.
---
 src/advertising.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index d959bf38f..b50900029 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -95,6 +95,8 @@ struct dbus_obj_match {
 	const char *path;
 };
 
+static int get_adv_flags(struct btd_adv_client *client);
+
 static bool match_client(const void *a, const void *b)
 {
 	const struct btd_adv_client *client = a;
@@ -736,11 +738,11 @@ static bool set_flags(struct btd_adv_client *client, uint8_t flags)
 	if (!btd_adapter_get_bredr(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
 
-	/* Set BR/EDR Not Supported if adapter is not discoverable but the
+	/* Set BR/EDR Not Supported if adapter is not connectable but the
 	 * instance is.
 	 */
-	if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
-			!btd_adapter_get_discoverable(client->manager->adapter))
+	if ((get_adv_flags(client) & MGMT_ADV_FLAG_CONNECTABLE) &&
+			!btd_adapter_get_connectable(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
 
 	if (!bt_ad_add_flags(client->data, &flags, 1))
-- 
2.34.1


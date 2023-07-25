Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAC3C001E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 08:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjGYIrW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 04:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGYIql (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 04:46:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7F34215
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b74310566cso76904671fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690274697; x=1690879497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4Jhtve8i1N+ldqV//aP+0i7v5Dzki1fWBpJO4+fkmI=;
        b=jRJMA1+6kR8Bg7hBlX2DVwrOMVw+BycPwKt1bdMPwPGhBh2YtsXhXmxN0rbVYwMpsl
         zIDeBjGdfpP6kfHW4QRIMkwzj53TQ0NRX2d+1wbINJMaz6++xtH6p78tktjm6nPRS0t8
         ShRI2w3AGtQYbO1OVtt1LzMy3rm4wQGeez1lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274697; x=1690879497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4Jhtve8i1N+ldqV//aP+0i7v5Dzki1fWBpJO4+fkmI=;
        b=InPYaQqbZRhq0HMwjN6BH+AlsgxWTE8n9H/20dZ0BdIm8hOe5Ss6gu1v0RGUVZRXcx
         58+muwI8cu/9YUIvbWFmStR7Uf3lDEMD2FiJdz6hVWFldEa/DclNtgqNtVA0gbeQ86bq
         UVweyEx+3Aq6E24RvpRhfFtfb5OFRHbpoUKG0xuyYFFgg6ZANC0lRSXfvQAUZkj6RRP1
         o1gcdezs+I9ONNBskdItasee5ocAeAi1aYSsTlnDUPvLtuE+h8U2AtAoiD9jHAZJqOIw
         JJ7yIa04e2zqw3wBGnta8DhpzIkHH7DBCJLngtPR0uVqeqwPP17DgTq2x5B0rWwHSiCO
         E1HA==
X-Gm-Message-State: ABy/qLZGkQ+IPwgUVg8RFy/8I+l8X8aGyj52egpICeq/7PcjnTXaWieI
        Sbmwzi2mNnnFl+M9AqpRX9BlZW1z+QkYVoo1hvE=
X-Google-Smtp-Source: APBJJlGWf+61fQGEqxbjRy9gB8ozeWBbRAIZj9AklhxFW5KoXQJM7E9wGh75UvqcgXyWACdPlmSWIw==
X-Received: by 2002:a2e:8707:0:b0:2b9:4aa1:71e1 with SMTP id m7-20020a2e8707000000b002b94aa171e1mr7580879lji.50.1690274697779;
        Tue, 25 Jul 2023 01:44:57 -0700 (PDT)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:ed64:7921:ba0:11aa])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906164a00b00977cad140a8sm7866577ejd.218.2023.07.25.01.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:44:57 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 8/8] adapter: Ensure that file exists on IRK write
Date:   Tue, 25 Jul 2023 10:44:31 +0200
Message-Id: <20230725084431.640332-9-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/adapter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 4c3bb091d..fe8ae7604 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8823,6 +8823,8 @@ static void store_irk(struct btd_adapter *adapter, const bdaddr_t *peer,
 
 	g_key_file_set_string(key_file, "IdentityResolvingKey", "Key", str);
 
+	create_file(filename, 0600);
+
 	store_data = g_key_file_to_data(key_file, &length, NULL);
 	if (!g_file_set_contents(filename, store_data, length, &gerr)) {
 		error("Unable set contents for %s: (%s)", filename,
-- 
2.34.1


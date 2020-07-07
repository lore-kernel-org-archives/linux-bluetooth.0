Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 02:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1A3206E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 02:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hxDzQktX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGGCTl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgGGCTl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 22:19:41 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52151C061755
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 19:19:41 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id e10so2243603vkm.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 19:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=COXbuCTb1uxtXUkclqvogDk3kuYU7hDA74gntG4a48g=;
        b=hxDzQktX3lf+qlZOLr/v+bqWr4EKqomcnjjwKbDmIlDY5DwnfioKFxyGUsLEkNn47I
         jAOaYZYW5rFeey26CTOQ/aYJkZ0DrfI39US3Hpw0v/pOM6JZK669ki9tTYbrYt+0tl6n
         FXdrCcLb6Cw1ec8jtXHGmP/hdEUSSGU9whtpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COXbuCTb1uxtXUkclqvogDk3kuYU7hDA74gntG4a48g=;
        b=EGvYFYYbco7E9+8yBXrcdqKnkgk5FEFjFcHZnv/Y0M7YLsngRaV2gyX0szp+hD0YOH
         OteYwb1R4/rdRNC5/Mh/6euMq3HFh220fxkf6M23PxsMKO2RpeCgMGoQgep4azYw0vHI
         31Y8xQdBQ7uCEZa/xVMH30jlO4I4pOb7fkGw4lfyAwUfW98V9RdyXbkCmfgiWRK5dk+V
         /9KP0cid6T8J/b0+Z8PdBop4GWD47G4PbAtg9iRYZDjIjPaiTIFQVb909JiPhxkdNjpl
         vbrP2IG+QO8R34roj3c62QrwZur2W9D2BRyxSVEWtuBxxJF8mDTzSH4S6+8O/8AhsaxL
         dl2Q==
X-Gm-Message-State: AOAM5334WDM5p7ekfguYD2TXGaBqEFUuc54rIeqereI0t+UkI4KuxYBy
        tOYT6WWhDhYyaRK7zS5d5KzsjEUZy5g=
X-Google-Smtp-Source: ABdhPJyQcmMzGnekXBAL0Memn0Ei4Vy4juD0V/5MuJFv/Z5F7SNghfr9NW0JmksAU663JBAQJij0rA==
X-Received: by 2002:ac5:c183:: with SMTP id z3mr19464427vkb.74.1594088380245;
        Mon, 06 Jul 2020 19:19:40 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id q200sm4855727vke.53.2020.07.06.19.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 19:19:39 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH 2/2] client: Add support for the Roles property.
Date:   Tue,  7 Jul 2020 02:19:20 +0000
Message-Id: <20200707021920.209213-2-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200707021920.209213-1-alainm@chromium.org>
References: <20200707021920.209213-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for reading the Roles property through bluetootctl's
show option.

[bluetooth]# show
...
Roles: central
Roles: peripheral
Roles: central-peripheral

---

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index c0b351aed..8af7c4e0f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -925,6 +925,7 @@ static void cmd_show(int argc, char *argv[])
 	print_uuids(adapter->proxy);
 	print_property(adapter->proxy, "Modalias");
 	print_property(adapter->proxy, "Discovering");
+	print_property(adapter->proxy, "Roles");
 
 	if (adapter->ad_proxy) {
 		bt_shell_printf("Advertising Features:\n");
-- 
2.27.0.212.ge8ba1cc988-goog


Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F52C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 04:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F53820738
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 04:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5YgV5NB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgHSEMk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 00:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHSEMj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 00:12:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD34DC061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 21:12:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e196so24609320ybh.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 21:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NAYmT5pippiwPtvep7OJSxG8Hwp8J5cDMvPe3QXl29I=;
        b=j5YgV5NBvP12iEfssdXHIWsPKz5HBBAQuYd6YstWZuGyJupdVuyLPK3SWHrzIKukL+
         Oy2HMwUGM6ZKqbAltItRNRnNxn/GCosk9qyQDw9Hm8MALCg8V+TcTnVDbLFa7zXvqA4w
         HM35Kjh2o536ECsBh9zBUt7p6pVntJPII0uEchu5bvVhG8T89rnFGnAGsRKQMIywcDJ+
         d/tVF33ZCGQYWNv2QvKwK63ZFZxVoYnZfo2DfhvZnH1pS3PAR8LuGOicUG1nis/Qib0z
         YqTrqjzrs11yHtcoSG0R/rGhCeo3NzJxnaVGvfnQG4pah7EJAY+EiDtv2vrlvqaLYfUe
         Ckww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NAYmT5pippiwPtvep7OJSxG8Hwp8J5cDMvPe3QXl29I=;
        b=QSYDYqMHOvx8IYWvqptNoyezdeO9marpIukCwSA9SL+fdd4Awekt3I15rANc8WccMw
         DXJzzrRrB4O7BP26hm7XOvn4totpJUybNynTfP3GDNYkc4SewPohOwhPqcvoxeCikN6s
         k5uuejbEo4mld3TwFoQcIcQT+9ZbUMkkqjXGtZuZsOn9zEB0is/ilE47ivcEMLm7XvPi
         lyI+AFCOTC6tE1b2cUh28oqXUX1Je+Aqrc7l1eOkev22vHyZ6rJ62tyDEgnsfNKiUeyV
         mw/91YAjbtO8RqIAFVDo0Axm2DuJ5cBOWr/lzvZUpN+0mcejBplWsnGOQ7/ZhzuM9Won
         PzUQ==
X-Gm-Message-State: AOAM530MUrVrz70rWchIH/qT1sYaOE3tZdGJO73Pu+GrFYx7DiRY27h0
        GOVCgz6Bzk7I5bj+JiMxY1znjwg3EW/FNRZm4BvUjPnxsdI2c7aHtky5Z5iXeBkouA1+G7hM403
        Huh3X7GrkR1hsHgPWzUtEyCi0taDH2ElbAubsv2ofxF5ZoME5l99UEqt31J74w1NaHeMpcjjhw5
        k9K08s3SmN4tQ=
X-Google-Smtp-Source: ABdhPJypSxy6Q+jDMoQkNt9PubSGX41e+45UZkBZgTsAhrKxur52gnS5xTyNt+js7mMypX5sTHnt8oR8MbWfo1NDFQ==
X-Received: by 2002:a25:df02:: with SMTP id w2mr28905861ybg.189.1597810357890;
 Tue, 18 Aug 2020 21:12:37 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:11:05 +0800
In-Reply-To: <20200819121048.BlueZ.v1.1.I3a57ea1eb3e3f5b87abc44ea478fc83817627ffc@changeid>
Message-Id: <20200819121048.BlueZ.v1.4.I0ebba5ae17d45060148f91000e6c622bcd0b30da@changeid>
Mime-Version: 1.0
References: <20200819121048.BlueZ.v1.1.I3a57ea1eb3e3f5b87abc44ea478fc83817627ffc@changeid>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [BlueZ PATCH v1 4/4] core: Add AdvertisementMonitor to bluetooth.conf
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, mcchou@chromium.org, mmandlik@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

AdvertisementMonitor must be included in bluetooth.conf in order to
be able to call Release

Signed-off-by: Howard Chung <howardchung@google.com>
---

 src/bluetooth.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 8a1e25801..b6c614908 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -10,6 +10,7 @@
   <policy user="root">
     <allow own="org.bluez"/>
     <allow send_destination="org.bluez"/>
+    <allow send_interface="org.bluez.AdvertisementMonitor1"/>
     <allow send_interface="org.bluez.Agent1"/>
     <allow send_interface="org.bluez.MediaEndpoint1"/>
     <allow send_interface="org.bluez.MediaPlayer1"/>
-- 
2.28.0.220.ged08abb693-goog


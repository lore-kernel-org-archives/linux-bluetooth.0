Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7E4C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Nov 2021 15:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbhKTPdG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Nov 2021 10:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbhKTPdG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Nov 2021 10:33:06 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F0C061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 07:30:02 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id e4-20020a170902b78400b00143c2e300ddso5793873pls.17
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 07:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jmpCJe5TKrx6C8LTBNW6hibZhG79HzwFdwgGf0nOh30=;
        b=J7l3Vuu/5S2YbzMd60qnM+r+LR8kQz1pFZ/jgU1QwNyk51lFf4c+7Mm13YrHF1dJeb
         jGE0+rZdw+r9zD4Mq2gpE8NPCqJqPa2RZWjlJCAyu8gjiQ/G3SnKZvM2srvDefoHVGnv
         06pGdip7wX3UfrIKNFKffyhxy8621lW2bKxtQm1Hta+RoY2xYbi7TpWkNT1exgFdS31G
         ieb+QONseSBsZEBx5XB8EC8W0M8cWvkT8zxVonoL9t2xdu2qzUWHtHIS20bgTj65Vv7X
         WtoNmSGEXBMNcQy0FQ+f86FO6Lr6aFpEGaG21N9dGAyTf+GZMKl7GJo5ZdeALpCAmx4Q
         0eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jmpCJe5TKrx6C8LTBNW6hibZhG79HzwFdwgGf0nOh30=;
        b=CoJ9Cx7IS5tsiGMXAuRNfWRVvaCLW5kTTGyliri4C4zNdBehz/SeRIXXAxah31cGIC
         aJk5hDUfQVNyGrshFS/Ww+j6NI4sfPpRB8kLKAxVQHH3DT0FJQfMLkkVlzRSgaXYbehz
         z/4hAB0Lzf4JhInJNQtTzpjGjMYCoS/YDT8z85/reBqa+9ET1kRwDqegylzRI7UZrvte
         HDZNvOyl5l7+Um9D0GlFkOoOfTvshC5684qrcDFtnaHdfveyKNxfHyszl9uC31nMgHDu
         FKahGPLJ6YQCezb6QctgrLNwcvK4nj28pW4B7G0rF6PL7TLJ8GO6Z6OuIVP4HOOMWxe0
         J+rg==
X-Gm-Message-State: AOAM532cEGUv0r4WPGFw/QWANt11WvskNTQqL23RchrsqrmWzK8uiQWM
        3cMcoj3PlXSu+QTf0hOHBfnwsg/2/reSPA==
X-Google-Smtp-Source: ABdhPJwkCCBgaEsdMATrkJG159LAtlQTbqXc6UZu0ih+wrzsR8up25SJIsKLzEQkl3Vvao8klxbSZ+PJGBj9mw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:8437:70f3:c03b:1c71])
 (user=mmandlik job=sendgmr) by 2002:a17:902:d114:b0:142:3934:be82 with SMTP
 id w20-20020a170902d11400b001423934be82mr87809355plw.40.1637422202328; Sat,
 20 Nov 2021 07:30:02 -0800 (PST)
Date:   Sat, 20 Nov 2021 07:29:40 -0800
In-Reply-To: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Message-Id: <20211120072449.BlueZ.v6.5.Ib85d2d946d853ea8c879dc922ad8e47587d3c603@changeid>
Mime-Version: 1.0
References: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [BlueZ PATCH v6 5/6] adv_monitor: Change sampling period to uint16_t
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>,
        Archie Pusaka <apusaka@google.com>,
        Miao-chen Chou <mcchou@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the Advertisement Monitor API, RSSISamplingPeriod is an unsigned
value. Change sampling_period variable to uint16_t in the code.

More info: doc/advertisement-monitor-api.txt

Reviewed-by: Archie Pusaka <apusaka@google.com>
Reviewed-by: Miao-chen Chou <mcchou@google.com>
---

(no changes since v5)

Changes in v5:
- New patch in the series. Update 'sampling_period' data type to the
  correct type.

 src/adv_monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 27d5f3308..bf7f2bed3 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -772,7 +772,7 @@ static bool parse_rssi_and_timeout(struct adv_monitor *monitor,
 	int16_t l_rssi = ADV_MONITOR_UNSET_RSSI;
 	uint16_t h_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
 	uint16_t l_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
-	int16_t sampling_period = ADV_MONITOR_UNSET_SAMPLING_PERIOD;
+	uint16_t sampling_period = ADV_MONITOR_UNSET_SAMPLING_PERIOD;
 	uint16_t adapter_id = monitor->app->manager->adapter_id;
 
 	/* Extract RSSIHighThreshold */
-- 
2.34.0.rc2.393.gf8c9666880-goog


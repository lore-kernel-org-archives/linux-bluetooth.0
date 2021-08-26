Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB85C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 16:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A324A6108E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 16:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbhHZQCN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243019AbhHZQCL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Aug 2021 12:02:11 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26981C061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 09:01:24 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so1778558qvt.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=H0VAuWF26ohP14J2Nw467dzt0bukh6I4zoWTNeqNllI=;
        b=EYqWffEz4RCw5Vao8rVpjF1DK9WTwMo6scGb5lbTm6saH30zH1X1kwg1yLCLUKkwoX
         NIyYb10HZKlz8MgYfustCtJmutbA8FGTUToDM8SQZ4bykWpNXOItYHXFaFQLEhHh5VTz
         2/le0HUcZNP5zMOmy6k5XfS4V4+Fju9ulU9rr/89EvZucoGM5M/WSfaUkAYuk325is7/
         /aiJc19KCv1H2u6ak52uM+hrX0KyWvn+6/kPDmyzOPuNMrDzWd8NVxv4fN/O9eQBhqWh
         ut4hgiQWuDSZDaswQ5Df/H7L01izoxTYtwXBYnSjysJY22GMmlTvj7JZTMfNsrdhzPDE
         3ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=H0VAuWF26ohP14J2Nw467dzt0bukh6I4zoWTNeqNllI=;
        b=AtKRDRqsy3d+OlaecXJAuYhrfYEjHr5YQ/vEOOtO6Y1c03QAmaR+Tzwi+VAVoRLcRI
         WK5vVL8lLhEt96xibnJbe2rBUfRuR81IyZfyhPnFB9aP618vB4yvBPLmtyNQl7FNnluo
         54S28UsZGd3S/Go+4gtkfQJUluSzt99hnQmae1JvYjXndt3+Ygq6C1iSL3CAYoKynv1M
         iRKiQGLpqAgxzPxWamJXEgLlQ3x0CaQqN9TXwMQIIhnz71xDP54O73XlCjoKfejpEazE
         W2ufaMWDLL75nv+QWu2pRxVpM46gnGHSmKhGKRrLKSEfSIDfNXrmwqLPXsy06Zq4QSXf
         oy1A==
X-Gm-Message-State: AOAM530YyO6R1hPMDxmORYZ+Qn/c3D8dsJBhw20r0cMIUZfTWgjDCXA8
        9d/BvcdZ7fTv0BB35E0riIS9JxsCzIdU6A==
X-Google-Smtp-Source: ABdhPJzq/GRxB35RuXs98XlFRZz3dCIr45yl0JCv1dN1K4XmYCKPCrewYs54lvcG+jQ5Cl6bvi2orACgwgh2WA==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:c962:4df3:558d:32ee])
 (user=mmandlik job=sendgmr) by 2002:a05:6214:2609:: with SMTP id
 gu9mr4749419qvb.35.1629993683303; Thu, 26 Aug 2021 09:01:23 -0700 (PDT)
Date:   Thu, 26 Aug 2021 09:01:19 -0700
Message-Id: <20210826090050.BlueZ.v1.1.Ib85d2d946d853ea8c879dc922ad8e47587d3c603@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [BlueZ PATCH v1] adv_monitor: Change sampling period to uint16_t
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>, apusaka@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the Advertisement Monitor API, RSSISamplingPeriod is an unsigned
value. Change sampling_period variable to uint16_t in the code.

More info: doc/advertisement-monitor-api.txt

Reviewed-by: apusaka@google.com
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 src/adv_monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 17f1777eb..9cbdcd23c 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -767,7 +767,7 @@ static bool parse_rssi_and_timeout(struct adv_monitor *monitor,
 	int16_t l_rssi = ADV_MONITOR_UNSET_RSSI;
 	uint16_t h_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
 	uint16_t l_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
-	int16_t sampling_period = ADV_MONITOR_UNSET_SAMPLING_PERIOD;
+	uint16_t sampling_period = ADV_MONITOR_UNSET_SAMPLING_PERIOD;
 	uint16_t adapter_id = monitor->app->manager->adapter_id;
 
 	/* Extract RSSIHighThreshold */
-- 
2.33.0.rc2.250.ged5fa647cd-goog


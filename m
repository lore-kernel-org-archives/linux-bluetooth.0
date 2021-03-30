Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A3FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 06:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849106191B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 06:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhC3GQZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 02:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhC3GP7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 02:15:59 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F9BC061762
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 23:15:59 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id u13so2518971qtv.20
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 23:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=a94eyPW48B2bSD1ggxSG7EzYAsnk4Ura1YcAF42Y9nA=;
        b=BYMGIBPsBxyH+pN5bNhet4UUtYl3woQ7jRvLfwtvIUTz8z11h6fBVeGsQWTJuE0yx5
         F8lbePXVADqfbCL4AIkQT2giBtBC7CEfvvSU/CZehcJ+LbdGIdWVcbhf2RilTKSK7Nx2
         Fs6QRNFco53xzoZZlGXAtPWstQvnM5OdXE4ivJ+hDygQK0/oKve//ZhdIvWMHW6XP8iI
         QJgi7XjwZUEz82g/DscL1Owj8OrxhdjVea/3Hc6sBBZowGRdzxFHv11Be668zZLKbBtP
         +M7L5EwsxhBrtwUy6yTci8+uyg31T7JmSf1ZBbOeEF1mZKBHnnpuvNWldZhjAR10RaE1
         kt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=a94eyPW48B2bSD1ggxSG7EzYAsnk4Ura1YcAF42Y9nA=;
        b=VSAM7UIs8Y974pqBvqFS17MDiAZ+afMMiPs0kDi3EdFKa+80M2DwuG6GmmYW/8giS6
         0z9jDNROvRUOwB/eEhIvzfIrfZC2CC8XcnivIqkoFx9uk7pUpoRqMwA09CsBCs6rDdZa
         aMoS1SDNPKn5XGimyYKTZBZPIedIXjjMgJqnpe56qCWZgh440dMzQgGg9KDeL7nq7LjW
         9mN+RCKGVSIS8wSeSH1VFQqUPItY+65rp6vekqZlRCr6/DC4+hf449gUVGkDLKn934ND
         mCyDdkN3pRcbnSvgEvMYIhcBye/pf++R6bU95m7YAR21VDH8lSCDFlB95+5wVWsP7H6b
         0xyA==
X-Gm-Message-State: AOAM531UbRd4yAPJRi3tGgwlQThx9cz/QWSoigNl4BlEVdZhLy/RImJ7
        8XN53glwcGSZFM+w4wY6bqjgRx01o5akgw==
X-Google-Smtp-Source: ABdhPJzQOSExHsCwkeLFdguPJzgdyvBqwsEB6QnNExKnHUMyyvcA/59mBfAmwoIXfsGW5nf9MRehfteT5jrZ0A==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:95e8:4717:81b0:c797])
 (user=mmandlik job=sendgmr) by 2002:a0c:dd14:: with SMTP id
 u20mr29536428qvk.13.1617084958776; Mon, 29 Mar 2021 23:15:58 -0700 (PDT)
Date:   Mon, 29 Mar 2021 23:15:49 -0700
Message-Id: <20210329231544.bluez.v1.1.I18e234e0b4d11e2ee24a699e70bde7e0a84b0be7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [bluez PATCH v1] test: Fix AdvMonitor RSSI filter properties
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>, apusaka@chromium.org,
        howardchung@chromium.org, mcchou@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update the creation of Advertisement Monitor object as per the
decoupled RSSIThresholdsAndTimers strucure.
More info: doc/advertisement-monitor-api.txt

Reviewed-by: apusaka@chromium.org
Reviewed-by: howardchung@chromium.org
Reviewed-by: mcchou@chromium.org
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 test/example-adv-monitor | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/test/example-adv-monitor b/test/example-adv-monitor
index 6fe8a3058..a405fc7b0 100644
--- a/test/example-adv-monitor
+++ b/test/example-adv-monitor
@@ -61,8 +61,10 @@ class AdvMonitor(dbus.service.Object):
     def get_properties(self):
         properties = dict()
         properties['Type'] = dbus.String(self.monitor_type)
-        properties['RSSIThresholdsAndTimers'] = dbus.Struct(self.rssi,
-                                                            signature='nqnq')
+        properties['RSSIHighThreshold'] = dbus.Int16(self.rssi_h_thresh)
+        properties['RSSIHighTimeout'] = dbus.UInt16(self.rssi_h_timeout)
+        properties['RSSILowThreshold'] = dbus.Int16(self.rssi_l_thresh)
+        properties['RSSILowTimeout'] = dbus.UInt16(self.rssi_l_timeout)
         properties['Patterns'] = dbus.Array(self.patterns, signature='(yyay)')
         return {ADV_MONITOR_IFACE: properties}
 
@@ -72,11 +74,10 @@ class AdvMonitor(dbus.service.Object):
 
 
     def _set_rssi(self, rssi):
-        h_thresh = dbus.Int16(rssi[self.RSSI_H_THRESH])
-        h_timeout = dbus.UInt16(rssi[self.RSSI_H_TIMEOUT])
-        l_thresh = dbus.Int16(rssi[self.RSSI_L_THRESH])
-        l_timeout = dbus.UInt16(rssi[self.RSSI_L_TIMEOUT])
-        self.rssi = (h_thresh, h_timeout, l_thresh, l_timeout)
+        self.rssi_h_thresh = rssi[self.RSSI_H_THRESH]
+        self.rssi_h_timeout = rssi[self.RSSI_H_TIMEOUT]
+        self.rssi_l_thresh = rssi[self.RSSI_L_THRESH]
+        self.rssi_l_timeout = rssi[self.RSSI_L_TIMEOUT]
 
 
     def _set_patterns(self, patterns):
-- 
2.31.0.291.g576ba9dcdaf-goog


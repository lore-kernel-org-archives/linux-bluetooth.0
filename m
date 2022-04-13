Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06000C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 20:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbiDMU5y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbiDMU5i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 16:57:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82DE53718
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h82-20020a25d055000000b00641d2fd5f3fso2311807ybg.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uTiLus5wZpzBdaNIG2x/m/7MW6CIV6AQUuw8YBGtDQw=;
        b=FWPkBjV2Hd8Ey8qh9GRVLYp2U2G8Sc0AmfQjJjbmMOIYanak+NWYR08ZZYEP6yevg6
         g1QNI/BYuGlZtRiNuhfe4Z3s/WqwpuTxdLI0TzC4KUE7N03hwulMzBJP0nsV9Ofhjl6Q
         h/DyPkD1BuDHz2ImZejzZ4kUYtDYwVM5I4toS44qGlbSVeiwBj/AdC41n1ixDgzzsj7N
         p8+pjZXAfU16kaZi+9CZH7IvvDhLdMvq8Z6ueMJWGxlG8bH8obF1potE6Nbv56Hzs8yT
         JEZtMZ74TAllbgUfHbNV4J8RtztTGUjm8sL4VSXuisX5dTTRb44CbTs6yh7VtIIVMXks
         vMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uTiLus5wZpzBdaNIG2x/m/7MW6CIV6AQUuw8YBGtDQw=;
        b=Q8AEttG8k5RLW8f/Akr34UYtO8xMzXZE2JT62irbOCjXC1MzKx2yhxPJGIY6orfpzw
         GsbkQgLmavIe3nOljMKnLkrHWr7w7sejcsYPR9b6dYp4E82WS0tLX+fAgRqPJV63mRt7
         PEBiuYbYI5mM5tNbi9UNSyzPcvJHwp88EKZ+7NeISUjaMrMNfVhEh7/Oj9ctm8QOCmr9
         vsHL5avLATqYb5SDaEvWPKkugK1Z0tZQXC5XgX47+3VC+HkdR75vVCglXb9rGM9YN4Hq
         rG+xQPTdZlmFGC3CKvyotANLUdliqF2prydywDltwBpJMDMvPN6sxiOsmsNlT0iooRsN
         8qIA==
X-Gm-Message-State: AOAM532u48a3fnv0DLY2PvKwnpJhd5n9giz8HcEsnGscwNjvyqjEPjJU
        3mwIxkVB37ddrWO7qZKAELZVpDR3mQOVow==
X-Google-Smtp-Source: ABdhPJyvmtPFaBrweGdzFv6byuR+gsqwj2g7Yihka+3TcnT86NwfSKG7hVGc1IKWoWwt+iQ5tG3nBm/TesoDSQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:2620:46aa:79ff:778d])
 (user=mmandlik job=sendgmr) by 2002:a25:fd5:0:b0:641:185f:1d14 with SMTP id
 204-20020a250fd5000000b00641185f1d14mr716720ybp.568.1649883315981; Wed, 13
 Apr 2022 13:55:15 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:54:49 -0700
In-Reply-To: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220413135223.BlueZ.v2.9.I6c034497f366eccbb78925ad107ce957f81d97b1@changeid>
Mime-Version: 1.0
References: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [BlueZ PATCH v2 9/9] test: Display the AdvMonitor Release reason
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bluetoothd returns the release reason when a monitor is released. Read
the release reason received as part of the Release event and print it
using the example python app.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 test/example-adv-monitor | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/test/example-adv-monitor b/test/example-adv-monitor
index a405fc7b0..b01114c6b 100644
--- a/test/example-adv-monitor
+++ b/test/example-adv-monitor
@@ -117,10 +117,11 @@ class AdvMonitor(dbus.service.Object):
 
 
     @dbus.service.method(ADV_MONITOR_IFACE,
-                         in_signature='',
+                         in_signature='y',
                          out_signature='')
-    def Release(self):
-        print('{}: Monitor Released'.format(self.path))
+    def Release(self, reason):
+        print('{}: Monitor Released (reason: {})'.format(self.path,
+                                                         format(reason, 'd')))
 
 
     @dbus.service.method(ADV_MONITOR_IFACE,
@@ -352,7 +353,10 @@ def test(bus, mainloop, advmon_mgr, app_id):
     # Run until user hits the 'Enter' key. If any peer device is advertising
     # during this time, DeviceFound() should get triggered for monitors
     # matching the advertisements.
-    raw_input('Press "Enter" key to quit...\n')
+    try:
+        raw_input('Press "Enter" key to quit...\n')  # python2
+    except:
+        input('Press "Enter" key to quit...\n')  # python3
 
     # Remove a monitor. DeviceFound() for this monitor should not get
     # triggered any more.
-- 
2.36.0.rc0.470.gd361397f0d-goog


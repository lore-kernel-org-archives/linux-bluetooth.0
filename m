Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC67C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 01:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbiCUBix (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Mar 2022 21:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344018AbiCUBiw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Mar 2022 21:38:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C2DE901
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y32-20020a25ad20000000b006339fb8e18cso8411474ybi.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iEjX0ROiUQFHfIqhoycGS7Ir4vAwahHJTq/EAslgS8I=;
        b=prYrO57GUhr+K+Ou6koSz/P2JmwDT/cR2h/7eipGfP2TzIbkLYu9gGSE3QmnvLZ189
         orMZgRk782d686iKQ2hKCu30uFAQwr6hFxKanFmFgKyH0kNdNg7TM8OZmwB0N6wU0nv4
         fkRI8j+P47YMNFJKN1YwaR7sBoLQyXN+FxR1WlXHsVj8hpHIOcq3iB4QFiK09wexDh63
         xBmoIRkNDOGkR69uID7ibuZOLh80IP/KhJpI/6GHzp/JnpDWIzJYQLpFaQ3AIqpRSZqh
         zckn9j09oKzrcjI2hp2UY8QqxoKRdYkf4ONhEU22ki1KTpbWbMAMhtxuVvvKQPksmtf/
         USuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iEjX0ROiUQFHfIqhoycGS7Ir4vAwahHJTq/EAslgS8I=;
        b=xygQFQbqMBxvs/2HviIomqDduYHH8BEI9uoskzCM01oHvLoIN0KMI0OFUdjqzGyjXE
         HTJF80gmv7Iu0Y6Fqd+OXwKFnylY+LUJXTxFPD8i8Vu8QiXS2ENEFvGuiRDqLTeqQpHe
         vQz1kzcw+PxPNYLG6RNQRu3CjxanAkpAOxCn0XTWITPI1F9iYV9PyPNTbl8WW4GForbR
         a5G/BWR/SehA7ZvclkMvDxXfkLL4X3UohD8KnBoH7Z6sderfmq4+tK0Dg3zPTdvK8+vp
         n270fxRyE4fWlPtjNJdwdb5bz6IxNZF8Fk4+SNIckEcg1fEGLGmWFMbJDdThdyK5vovT
         CvpQ==
X-Gm-Message-State: AOAM531bgdVuabKyoTGtClDk/Hh4zEPjd+Pfk/ijKx6TuMagJ8ap1+rA
        12+AW5AIkyZDGIvomvSXywOXQM7OGsnaww==
X-Google-Smtp-Source: ABdhPJwjf8gLXMo3hNZ1SpaS10P/uXI+V4s36o54PZ4BFhKri9C8QvrbdXYdKP6C920UJQ7pbZEssP0DA42hTg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e0cb:81c1:7b8f:ab9f])
 (user=mmandlik job=sendgmr) by 2002:a81:53c6:0:b0:2d0:e6df:adb6 with SMTP id
 h189-20020a8153c6000000b002d0e6dfadb6mr22178978ywb.483.1647826647887; Sun, 20
 Mar 2022 18:37:27 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:37:03 -0700
In-Reply-To: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220320183445.BlueZ.9.I6c034497f366eccbb78925ad107ce957f81d97b1@changeid>
Mime-Version: 1.0
References: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [BlueZ PATCH 9/9] test: Display the AdvMonitor Release reason
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
2.35.1.894.gb6a874cedc-goog


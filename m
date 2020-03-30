Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F2AC43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F6A206E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffyP0Yfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgC3IEd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:04:33 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:54606 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbgC3IEd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 04:04:33 -0400
Received: by mail-vk1-f202.google.com with SMTP id i26so5249050vkk.21
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t9KWA9TXseSGKzSaj2xUqPufvYRn2IcAIkpo4hpGUsc=;
        b=ffyP0YfeWxCIApygAbhLHpnjKIfPKABqJpPKCFr0wm7vM/pBH7Q77tFwzLta0vKY2M
         OuGEcVtwXb8b8MfALymPYYoSSdUVbuGB6L/my4jIktEeFbbA7mHtyvtKwDuexR5+6KiQ
         +kxti8BKd7RoTNO+5j9S86SbE0Uv7lDgXwWDrn+JmBDe1M+JPdIUuYDHQkQAQLUqHVEF
         Jk/JR9skcw7oqK9D9aHnFOXfbN98hTy8Abm4bdwDCLt8/g5/+F576q5DcCx8rqk3DRpu
         GlNjol8OOLWCGKSuYM3IgayzsoOckJFj8+TPMS4ohYay8jFi0cg0Z+rsvW8ZDM3HU7D4
         t0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t9KWA9TXseSGKzSaj2xUqPufvYRn2IcAIkpo4hpGUsc=;
        b=eevGhsEe8aGKIGOMvvNo2SS9DAPbnsfMBigmxBBwiD4QK8b8quxxELAOTTGtDzRGsc
         PR76FYOIkue9GZfhah55y7GOrtsg08jjSTmfOlyZ4P1xEal9cxm+h9UCccAz0fdINkP4
         kTCnR/wjv3Hk/COWBjZQZMJvGOHt+4QqUT2bxomDXxPqcGChU6vPFLPvZoSsQHmGX3He
         AuF/tRfvilnXSRgG5RoTJ+bcU70h+DXNL8NnYK1BsIrVSm3wBzhvlBmS3XwbTIDdxijM
         w3W6ol11+6fuhq4j4+l/bPrFJ32T0yzg/6SmfCLkP675oQiXg06JB5CZML835a524TqQ
         M/dQ==
X-Gm-Message-State: AGi0PuYIAxykrmZsxTfpBmYjphq/CasdRFlDAFOBWHsaxirp2fpFXhDY
        WGM0DOw0Cv5nQEm0vI0SdPYUR8fl4yI5GMfOUys2gLWRf6P8aLHiRRZbZaISojEemGvkPr9mBRi
        b81P8hAQUTwj7eqgCP91XjjzIS5C8GW0JCtPxvPixV3m0UoTFSKyB0AH5hmPNyXcUE6DLVsKka3
        DGOnuwTLFBIWw=
X-Google-Smtp-Source: APiQypJWq/jMiO9R9NJkeJqgdv8vPdBSslwLiONw8f+xVCg5bfDNbKB1Gej+EdOly+MZAV6wDdTk571ABgbKXg75rw==
X-Received: by 2002:a1f:a2d0:: with SMTP id l199mr6578040vke.77.1585555470048;
 Mon, 30 Mar 2020 01:04:30 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:03:56 +0800
In-Reply-To: <20200330080357.96989-1-howardchung@google.com>
Message-Id: <20200330160343.Bluez.v2.5.Ie551a8a414d17604f04e10cf8d9c514a2b170e31@changeid>
Mime-Version: 1.0
References: <20200330080357.96989-1-howardchung@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v2 5/6] test: Add test for LE Set Advertising Interval
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Perform the following steps to verify advertising intervals.
Open a terminal on the DUT, and execute
$ btmon

Open another terminal on the DUT, and register an advertisement.
$ ./example-advertisement

Observe that the default intervals are 1280 msec in btmon log.
    < HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
Press ctrl-c to terminate the advertisement.

Set new intervals to 200 ms.
$ ./example-advertising-intervals 200 200

It would show the following line in btmon log.
    = bluetoothd: Set Advertising Intervals: 0x0140, 0x0140

Register an advertisement again.
$ ./example-advertisement

Observe that the new intervals bcome 200 msec in btmon log.
    < HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15
        Min advertising interval: 200.000 msec (0x0140)
        Max advertising interval: 200.000 msec (0x0140)
Press ctrl-c to terminate the advertisement.

Signed-off-by: Howard Chung <howardchung@google.com>
---

Changes in v2: None

 test/example-advertising-intervals | 48 ++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 test/example-advertising-intervals

diff --git a/test/example-advertising-intervals b/test/example-advertising-intervals
new file mode 100644
index 000000000..8afc7225e
--- /dev/null
+++ b/test/example-advertising-intervals
@@ -0,0 +1,48 @@
+#!/usr/bin/python
+
+"""A simple script to set advertising intervals through the dbus method.
+
+Usage:
+    $ ./example_advertising_intervals.py min_interval_ms max_interval_ms
+
+    Example:
+    # Set both min and max advertising intervals to 200 ms.
+    $ ./exampel_advertising_intervals.py 200 200
+"""
+
+import dbus
+import time
+import subprocess
+import sys
+
+argv = sys.argv
+argc = len(argv)
+prog = argv[0]
+if argc == 3:
+    min_interval_ms = int(argv[1])
+    max_interval_ms = int(argv[2])
+    print 'Set advertising intervals: [%d, %d]' % (min_interval_ms,
+                                                   max_interval_ms)
+else:
+    print 'Usage: python %s min_interval_ms max_interval_ms' % prog
+    print '       python %s 200 200' % prog
+    sys.exit(1)
+
+
+# Set advertising intervals.
+bus = dbus.SystemBus()
+adapter = bus.get_object('org.bluez', '/org/bluez/hci0')
+adapter.SetAdvertisingIntervals(
+        min_interval_ms, max_interval_ms,
+        dbus_interface='org.bluez.LEAdvertisingManager1')
+
+
+# Wait a little while for dbus method to complete.
+time.sleep(0.2)
+
+
+# Check the current settings using btmgmt.
+btmgmt_cmd = 'btmgmt info'
+for line in subprocess.check_output(btmgmt_cmd.split()).splitlines():
+    if 'current settings' in line:
+        print line.strip()
-- 
2.26.0.rc2.310.g2932bb562d-goog


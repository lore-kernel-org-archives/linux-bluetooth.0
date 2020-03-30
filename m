Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E84C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9008E20781
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2bqqkdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgC3HFk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:05:40 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:47617 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgC3HFk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 03:05:40 -0400
Received: by mail-pl1-f201.google.com with SMTP id l1so12274156pld.14
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 00:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sRxvBt9CbHrEaWbg6j4fY+lBQ0TJ6ryxG2Jm/LbqOgg=;
        b=g2bqqkdjudMNT02IE4EeyXbWWp3tAWdmRbnAuSj+zdL/5/cBgR5Ogh7+2Rp/3sh85M
         YXhZ1fK0ejcXS9Io8TMr9itHrkewI2f+447X+B5P/ONbZUHFt8agW3BBCg16M8MahZ48
         BB0lxJ6x20rhd9KuzQlKU268xNFR+dNjIZlBlo0+yAV5hZ91ycqDCtnhSPYPnF1WPU+S
         UrDnyC4pIp/VRVvK/lL4x70FSYFKIfo6g0DEIepCINNqz62HR75+cpSZYVISBzJ96t93
         lGyZLcDofST1lLsi8iNXEpgDFK9cVu90q6BjUKkMdWATQFBlKhfU9YhUQ4HOxMDqT2OY
         8oWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sRxvBt9CbHrEaWbg6j4fY+lBQ0TJ6ryxG2Jm/LbqOgg=;
        b=Yv4dhbWPZJHUq6GdNXvDD02ty+Sp9SAzwuRH7mhAfKcW2Yq4zIp8ZoUaKh7vG2WUfW
         4ssJKM9EStDYZVxzyQe5lLBV0r7ObETfWII89CBHOtxILqkKdREqUPcQh2T61Gi1vbxI
         bxzmXLyFxQU82WTkklX09POaZS15MNC8oHw2s6k6qVMbFGFbyRCbggd4pf4ev+rE5oHF
         2tsTFr7TGWqSgxI1Y1BmLIajY2LlHKZaT9Lm1WkVkCuYPUgZ50iatf09OcpIuDULfR6D
         JvNWVsar1HwXvmV5rPtOe8zMO+nqYbM61NuLbOaDve8BR0cey4U9imbFXYwRE0qvvULz
         XScw==
X-Gm-Message-State: AGi0PuapDA0pCfo3+QMcACYOGQf6dR33UAKMZk3GkpACYBBjz/MkA98J
        pJB4AHvgkrKxwt8ryRP1isTHKIRaHY8B9OlvSNMHh+0JCnmFb4UF55lzy6T9LgYD+pveFTgrGzX
        qFmc6uSneetFu+9sijLAE4moMsxu8nRZqgx1Oq6u+gDnvd05FVGyLfWYeMryKR8iW0FiiKZ4L7E
        jwjGvLQ1pDfXc=
X-Google-Smtp-Source: APiQypJV8aSwyyhTAVElL8APbeWX7FnwdSF4Vecycg//QO4qUd8+wy5MaJZgya31Eg/igholOxkqWhxTViDOsiBRtA==
X-Received: by 2002:a17:90b:1116:: with SMTP id gi22mr10026804pjb.134.1585551939036;
 Mon, 30 Mar 2020 00:05:39 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:04:37 +0800
In-Reply-To: <20200330070438.37316-1-howardchung@google.com>
Message-Id: <20200330150424.Bluez.v1.5.Ie551a8a414d17604f04e10cf8d9c514a2b170e31@changeid>
Mime-Version: 1.0
References: <20200330070438.37316-1-howardchung@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v1 5/6] test: Add test for LE Set Advertising Interval
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


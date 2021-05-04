Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB30C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 05:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF7E611EE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 05:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEDFDE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 01:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhEDFDE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 01:03:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D09C061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 May 2021 22:02:09 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p4so6253668pfo.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 May 2021 22:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/vkgdE+SoVLTbEs/5G6QDOYDCIrTJGjfkk2tNdijOE=;
        b=LWzXeny6jNt/8AqtHJZleyb3EfxU2P+OMojsN1cEj0XUCqVOKaBq/w162fsGGJec3B
         0TFQ9UcFQSbwOtO6JudlW48QYYilcZn9FxFl1+WmWmONxBAdtlx5Za7NpBSrjW8/tmb3
         0aUWHbjw3GIj7fO9xfWP3qYDdwyJj44F6oYyMp5MA2+qOaADvMuwSmMEvWzmB3SHKLoU
         9N07SH8V10DWiyJxU/ZhJm73LiFqhvPp5C9Jt9Utf1BnLWZr9WOAd0UvYhFHjguSM+7e
         4NbpMB7zh5TWMUwrQmPYDGcuVqaHV+WAJduHNUm1/pvJsfA3mR3e2PLGkZ2slluE81ER
         40Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/vkgdE+SoVLTbEs/5G6QDOYDCIrTJGjfkk2tNdijOE=;
        b=GIEaT4PTdL4DZT8enXavm9JqPuVit9icddU4MU25AnmfE/U51deMLcOa3UysPASDRu
         KDmi8iOK9CK2/a7ZmnBlYJEkcIzc2GpR9dBJglOoSStzUEkB8VegOcuWThwPfEg/YIW5
         LTHYP5eEVuFGBYETgR0Mdl1nqv0bUhAYb7nQhbNM6M2/BfH4mTlIPDMwEe+1T8WfCjhx
         3jWugE7P0Pa1YBjBQiolNGfF1Zs3eqwHQ0XcZPp2wPOVe7sMsApsVDGj9hkKeQp22RKF
         toiDQMGTVFIPvy2SjFPdH3DWloro9ZVWZNEKiuqfWhw9KYQJ/AAbs6q/La3+F/J8qsaa
         UdyQ==
X-Gm-Message-State: AOAM533YvQ9Zo6y1JU2r9SY8pYtjvNgFBuI7DgqINzMxRa2s1M+mfBmx
        4pI2xdo4PcVWd2iHzXA7uNv3NnK4NZlPNA==
X-Google-Smtp-Source: ABdhPJyQbnCIj0HiEF5po2okjOI6uLHVP9Jow9caqkF69kzyC0NDKwbR3m+TPpvy4f+IoWpuPoAVPw==
X-Received: by 2002:a63:1c52:: with SMTP id c18mr2134956pgm.258.1620104529077;
        Mon, 03 May 2021 22:02:09 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::f7ee])
        by smtp.gmail.com with ESMTPSA id m20sm1508385pjq.40.2021.05.03.22.02.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 22:02:08 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 0/4] Convert manpages to rst format
Date:   Mon,  3 May 2021 22:02:03 -0700
Message-Id: <20210504050207.841261-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch set converts the existing troff fomatted manpages into
reStructuredText format, which is easier to write and manage.

Also, it fixes the issue which the manpages are alwasy installed by
default regardless of "enable-manpages" option is not set during
configuration.

In order to convert .rst to manpages(.1/.8), it requires rst2man tool
and now this tool is checked during configuration if the manpages is
enabled.

The contents of the manpages were not changed or updated while
converting the old manpages into .rst format.

Tedd Ho-Jeong An (4):
  build: Fix manpage enable flag
  monitor: Convert manpage to rst format
  src: Convert manpage to rst format
  tools: Convert manpages to rst format

 Makefile.am           |  37 +++---
 Makefile.tools        |  33 +++--
 configure.ac          |   6 +-
 doc/btmon.txt         |  35 ------
 monitor/btmon.rst     | 171 ++++++++++++++++++++++++++
 src/bluetoothd.8.in   |  63 ----------
 src/bluetoothd.rst.in |  84 +++++++++++++
 tools/bdaddr.1        |  68 -----------
 tools/bdaddr.rst      |  76 ++++++++++++
 tools/btattach.1      |  53 --------
 tools/btattach.rst    |  79 ++++++++++++
 tools/ciptool.1       |  68 -----------
 tools/ciptool.rst     |  71 +++++++++++
 tools/hciattach.1     | 158 ------------------------
 tools/hciattach.rst   | 166 ++++++++++++++++++++++++++
 tools/hciconfig.1     | 272 ------------------------------------------
 tools/hciconfig.rst   | 271 +++++++++++++++++++++++++++++++++++++++++
 tools/hcidump.1       | 118 ------------------
 tools/hcidump.rst     | 119 ++++++++++++++++++
 tools/hcitool.1       | 255 ---------------------------------------
 tools/hcitool.rst     | 213 +++++++++++++++++++++++++++++++++
 tools/hid2hci.1       |  46 -------
 tools/hid2hci.rst     |  50 ++++++++
 tools/l2ping.1        |  76 ------------
 tools/l2ping.rst      |  69 +++++++++++
 tools/rctest.1        |  90 --------------
 tools/rctest.rst      |  81 +++++++++++++
 tools/rfcomm.1        | 113 ------------------
 tools/rfcomm.rst      | 100 ++++++++++++++++
 tools/sdptool.1       | 132 --------------------
 tools/sdptool.rst     | 103 ++++++++++++++++
 31 files changed, 1701 insertions(+), 1575 deletions(-)
 delete mode 100644 doc/btmon.txt
 create mode 100644 monitor/btmon.rst
 delete mode 100644 src/bluetoothd.8.in
 create mode 100644 src/bluetoothd.rst.in
 delete mode 100644 tools/bdaddr.1
 create mode 100644 tools/bdaddr.rst
 delete mode 100644 tools/btattach.1
 create mode 100644 tools/btattach.rst
 delete mode 100644 tools/ciptool.1
 create mode 100644 tools/ciptool.rst
 delete mode 100644 tools/hciattach.1
 create mode 100644 tools/hciattach.rst
 delete mode 100644 tools/hciconfig.1
 create mode 100644 tools/hciconfig.rst
 delete mode 100644 tools/hcidump.1
 create mode 100644 tools/hcidump.rst
 delete mode 100644 tools/hcitool.1
 create mode 100644 tools/hcitool.rst
 delete mode 100644 tools/hid2hci.1
 create mode 100644 tools/hid2hci.rst
 delete mode 100644 tools/l2ping.1
 create mode 100644 tools/l2ping.rst
 delete mode 100644 tools/rctest.1
 create mode 100644 tools/rctest.rst
 delete mode 100644 tools/rfcomm.1
 create mode 100644 tools/rfcomm.rst
 delete mode 100644 tools/sdptool.1
 create mode 100644 tools/sdptool.rst

-- 
2.26.3


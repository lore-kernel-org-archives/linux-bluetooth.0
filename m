Return-Path: <SRS0=BfW8=XM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40A4C4CEC9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Sep 2019 21:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A605921897
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Sep 2019 21:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BCnH8N+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfIQV1J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Sep 2019 17:27:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35568 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfIQV1F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Sep 2019 17:27:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so2914397pfw.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2019 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KQLz48qGupB3U3q6Hm9UR083MeuUpn5l8eEYZ8P5LH4=;
        b=BCnH8N+v2Ndf8nZ0xfh7LR+M4kkjyoeZ9PT63+Jj6BMVvaEbYgtYK8KXQItxswnrYd
         5VAsNknB30Szust6QXMPRDzNNgR6pSwWmDW0Cxodb6nQbCR0nWNkMebeWcW6oOxGJaOh
         Y6tn4n6yykauA7gfG2Q2Cz+h/TV3DMQ0bSVFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KQLz48qGupB3U3q6Hm9UR083MeuUpn5l8eEYZ8P5LH4=;
        b=l/NPFO9w64ARouavf21L7wQTza20gXYmG3YoG3wx+5Ti/0GmYd+a8KZK1/hPBZLetS
         AMXPCs7u4YYRHuhfHqcaKjXZ0sM4bBLF/5LagxC4pewd1ziunPAQhN+WRl6igf+sMUv+
         gfSD0qnzJ4Z7W//I3ugBY4hGFRYS0pZBFShDcxVXj7l3DfhsiwzAQAjAenT9a5FxmgGA
         pzViAOY95JtSIHFndZwZAODcvs7Bviz8IxzhfmCfusKnnNflj9ZyqwbYQ8qbWKmuQN4W
         2ev4TaPIFEeGYCwQ1sJA88q4BNzkgRIc0WjnL/lWfjC2CW/JBXUuueVu934gMDsVPK1h
         nNsg==
X-Gm-Message-State: APjAAAWSY8/xrGBL/atpc23DxTIFl49V5iiBsGp99TGJy0y67Bwi7Cxb
        NMY6f2AH3qIxzzg9SWSpGFBVqqRAExs=
X-Google-Smtp-Source: APXvYqwrNqaZUJYT/gTjZKUsczgj5OqMIQHDe2jbqIfs1EULCI8Vl/6owKyGElJ4hykt9BdVCbqwUA==
X-Received: by 2002:a63:9245:: with SMTP id s5mr862110pgn.123.1568755624437;
        Tue, 17 Sep 2019 14:27:04 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id l7sm8489803pga.92.2019.09.17.14.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 14:27:04 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hui Peng <benquike@gmail.com>, linux-pm@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Len Brown <len.brown@intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mans Rullgard <mans@mansr.com>, Pavel Machek <pavel@ucw.cz>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 0/2] Reset realtek bluetooth devices during user suspend
Date:   Tue, 17 Sep 2019 14:27:00 -0700
Message-Id: <20190917212702.35747-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On a Realtek USB bluetooth device, I wanted a simple and consistent way
to put the device in reset during suspend (2 reasons: to save power and
disable BT as a wakeup source). Resetting it in the suspend callback
causes a detach and the resume callback is not called. Hence the changes
in this series to do the reset in suspend_noirq.

I looked into using PERSIST and reset on resume but those seem mainly
for misbehaving devices that reset themselves.

This patch series has been tested with Realtek BT hardware as well as
Intel BT (test procedure = disable as wake source, user suspend and
observe a detach + reattach on resume).



Abhishek Pandit-Subedi (2):
  usb: support suspend_noirq
  Bluetooth: btusb: Reset realtek devices on user suspend

 drivers/bluetooth/btusb.c | 26 ++++++++++++++++++
 drivers/usb/core/driver.c | 56 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c    |  6 +++++
 include/linux/pm.h        |  8 ++++++
 include/linux/usb.h       |  3 +++
 5 files changed, 99 insertions(+)

-- 
2.23.0.237.gc6a4ce50a0-goog


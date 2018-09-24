Return-Path: <SRS0=ctyp=MG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A706ECE560
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Sep 2018 19:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127EE2087A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Sep 2018 19:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EzezjHM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127EE2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeIYBis (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:38:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45061 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbeIYBis (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Sep 2018 21:38:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id t70-v6so4856136pgd.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Sep 2018 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7DbMj9cPLA/wH1eC3vGrKUSlQEjo0U4OMyKE56JmYs=;
        b=EzezjHM3Id2i0blaa4lgfQ4YrUgctMoalCoQUT7vPnSZIV8CDeFWl5QvpIGl6wcJzh
         PNf4rSAjS1+mrnXXSBv58NRGylF0LVEDRb82vnyiFa13p6Q4+2uVPnu3z5ekHjkHYEBA
         e9n3wIOi3K6KMuB9snNGEE3ngkfVgR1bZZXTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7DbMj9cPLA/wH1eC3vGrKUSlQEjo0U4OMyKE56JmYs=;
        b=VmCxRqYANl1KKOHJEQyNvInLyZpzGzldHpoCvVfe05nvZA/3du3ux3MHXIn1a8lCSZ
         avgO0nYS0PjCu+hw++jNpxDhVoB856aPm81qgwqvKguzZZ892cG5EHArzrlaSWV0U8Sq
         sr8nRj9kjo2qW/urqyDUn/Gh9WWuUG4ZwVy1t8BP/iKZ2jHTxbA12+rlqGEqJqYTCnLI
         kI/ieMzGrkY+z+eIVaVk286/DRpxNpKYUKXsz3Uxn3KnUBft7zX6pbQum3rs5Vn9zlbi
         nkCWRQ1fil/heQY1Vb7glAuXeHQn89Y585+3Rgcam6zBu0ITEltP3InInzS1YS1bJR6F
         WTjQ==
X-Gm-Message-State: ABuFfoicsFO+KWPIqf2ZYeapbcroUOeuDegBLCQTs8vsRIzooCHxjv1I
        m9CjX5gSrTjYWhFh1Wizs/eftQ==
X-Google-Smtp-Source: ACcGV625DnfScF30xSyERn6KKbc/FGgB31r3hLvxxHYiysrOm0N1vLJyZFj/MRUeARN3LOJ2oSerbg==
X-Received: by 2002:a62:6699:: with SMTP id s25-v6mr278447pfj.84.1537817703365;
        Mon, 24 Sep 2018 12:35:03 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 77-v6sm112234pfw.159.2018.09.24.12.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:35:02 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 0/2] Add API to retrieve the Bluetooth Device Address (BD_ADDR)
Date:   Mon, 24 Sep 2018 12:33:50 -0700
Message-Id: <20180924193352.96335-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
on the Bluetooth chip itself. One way to configure the BD address is
through the device tree. The btqcomsmd driver is an example, it can
read the BD address from the DT property 'local-bd-address'. It is
also planned to extend the hci_qca driver to support setting the BD
address through the DT.

To avoid redundant open-coded reading of 'local-bd-address' and error
handling this series adds an API to retrieve the BD address of a device
and adapts the btqcomsmd driver to use this API.

Matthias Kaehlcke (2):
  device property: Add device_get_bd_address() and
    fwnode_get_bd_address()
  Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()

 drivers/base/property.c       | 46 +++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btqcomsmd.c |  4 +--
 include/linux/property.h      |  3 +++
 3 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.19.0.444.g18242da7ef-goog


Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F24DC43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 00:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1644521566
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 00:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nsec8cYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1644521566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeI0HEZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:04:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33066 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeI0HEZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 03:04:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so592317pge.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Sep 2018 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xUL1ep5YulCv8tYmJ085iDc7GTmTFmf9XugNtYkFpvo=;
        b=nsec8cYEhUD0W9Bp+gLbaplSSfAodml6GWgnL/rhcReGG3/7q3fyyx4G5AQmh9NNfo
         ZmkGI5r6KaPbysE8cfrR+7gh9gug0oeiAgPTTa2Wh+rV6B3nLN0q1aJZvuvNt0QOTYmG
         r9PDgA/63af64Q7KgX1KMNhADh+VC2GJV0k08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xUL1ep5YulCv8tYmJ085iDc7GTmTFmf9XugNtYkFpvo=;
        b=kxotjfBXw14q2JTbvqTK2xw/QzPhL+fLoiz7d+IdNH4k/5Xm68EhmXXvnAEuRs1ARm
         E+cQb2hUnK10GVmXU3S5nuyJuTRdMMB3G/O7+/4ACWEAZL0zPFtzmzip8QrtyXFTNdlN
         3112MjXXwysIHYtg7isPkxIEvZAWcWtFVuahmp07yTWZL+lJfDObFMWtkloPA3/JlX2I
         ypLxpH+DX2WPUFehklmqhK9kRspunEIBAXoHJ3LmGHA4aznDX5b3Zag0btlw8BflIVvZ
         AjCmRD2n3jYEVTgu3AIl5b29DoeVCl2hDH7nph+F/0j8A8WRy9FdP/P48ig6hzZXXG7y
         HUQA==
X-Gm-Message-State: ABuFfogBmOqEu1nuincPpGbXVo6EboekXNkom5d963czneWyScemAO3j
        vvbFmgqFu+LXttJnJ9jjQ9YvIQ==
X-Google-Smtp-Source: ACcGV63BCrZJi5Da6bgQQwNO303kxSKITkhPU4mLfH9y5hTFjVigf/c6VwFrp1FcYTaQdsCuBzbXkw==
X-Received: by 2002:a62:25c5:: with SMTP id l188-v6mr8482081pfl.179.1538009330683;
        Wed, 26 Sep 2018 17:48:50 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g3-v6sm404173pfi.9.2018.09.26.17.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 17:48:49 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 0/2] Add API to retrieve the Bluetooth Device Address (BD_ADDR)
Date:   Wed, 26 Sep 2018 17:48:08 -0700
Message-Id: <20180927004810.124185-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
on the Bluetooth chip itself. One way to configure the address is
through the device tree. The btqcomsmd driver is an example, it can
read the address from the DT property 'local-bd-address'. It is also
planned to extend the hci_qca driver to support setting the BD address
through the DT.

To avoid redundant open-coded reading of 'local-bd-address' and error
handling this series adds an API to retrieve the BD address of a device
and adapts the btqcomsmd driver to use this API.

Matthias Kaehlcke (2):
  Bluetooth: Add device_get_bd_address()
  Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()

 drivers/bluetooth/btqcomsmd.c     |  4 +---
 include/net/bluetooth/bluetooth.h |  2 ++
 net/bluetooth/lib.c               | 34 +++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.19.0.605.g01d371f741-goog


Return-Path: <SRS0=tqgc=MH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B461FC43382
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Sep 2018 19:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3BA20867
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Sep 2018 19:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fH7sJ2W+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3BA20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeIZBTZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:19:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36388 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeIZBTY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Sep 2018 21:19:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id b7-v6so4461584pfo.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Sep 2018 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FAL/vSpAHIOF3zkyA2G9jDKJRB48/ThfzjB59pHekxA=;
        b=fH7sJ2W+lASka8c99WhQ1JumH23TlYv41wx3iO5gFNG1xhXhkdGXAIFcZ6xRW644Nf
         a72mxG/NspTG7IOCJNf1tAR3Nul+C9KVIb7lm/Ff2xSGGLQWptxAu69qFYmEni4cP2iE
         wslQBWNpikZDAP5D9TSQBDTZE01Qj68y3AXDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FAL/vSpAHIOF3zkyA2G9jDKJRB48/ThfzjB59pHekxA=;
        b=g6uKsVK/S6zDHbw7xwfARnYZxARTZNXOEQyotAKp49p7G/Zh1bvoo6OsR5rkvFEmug
         T+kLXW88a498HeHiEdQGGAGT2oC6LisqYciydstCt27IFe6+2FJwaTul07jCre9tYhpE
         9s4OLDOY7BNnSXr12LiiB1btgBVNSyqjH//OU9NZjkQrAHbGz+KRUCHuyhXgTQChwlJu
         vbjJoL/7t9HBOnDqEyw31isOLy9pIVZM0JYAalZVMgCmTQybrtyH6uWuFojkmaEFKH+n
         lvPokQYkhqtakYQ1BKyk7JHcBWbRpIKZBhXf8dNuL2eMttCpU7sa6grHhIBJUoBjbWRt
         xGHg==
X-Gm-Message-State: ABuFfohra7P6AS6lPHeVIG7/aE/GeMziWaFtdUm8u/J4TwB/4e2y3Cmw
        zawEbdJasl30rAitIk7zfA0SJg==
X-Google-Smtp-Source: ACcGV624VglsY6ILrlJitYSsBVY72cck4/0UqBLf2oDcUUBrcGNZGB+uL3U/sxaVjYIgilT7p1C3UA==
X-Received: by 2002:a62:d286:: with SMTP id c128-v6mr1135452pfg.14.1537902626200;
        Tue, 25 Sep 2018 12:10:26 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id p4-v6sm5082718pgs.75.2018.09.25.12.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 12:10:25 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3.1 0/2] Add API to retrieve the Bluetooth Device Address (BD_ADDR)
Date:   Tue, 25 Sep 2018 12:10:12 -0700
Message-Id: <20180925191014.85573-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

(previous v3 post was messed up, resending as v3.1 with the correct stack)

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

 drivers/base/property.c           | 46 +++++++++++++++++++++++++++++++
 drivers/bluetooth/btqcomsmd.c     |  4 +--
 include/linux/property.h          | 18 ++++++++++++
 include/linux/types.h             |  5 ++++
 include/net/bluetooth/bluetooth.h |  5 ----
 5 files changed, 70 insertions(+), 8 deletions(-)

-- 
2.19.0.605.g01d371f741-goog


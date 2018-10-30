Return-Path: <SRS0=qOEI=NK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDC2C2BC61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 00:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2012C2082D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Oct 2018 00:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PAG1G0ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2012C2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeJ3JgM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:36:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46635 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeJ3JgM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Oct 2018 05:36:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so4871839pfb.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Oct 2018 17:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0FVSxhLHcynWiypcCq2zv01OmaWJABRwUDhEigfy/k=;
        b=PAG1G0ruT6VlbKDXSh0mpACTut3Oi8C03BCfsc7xXbzPTsb9ZP4NFZEKNveXNFWZRz
         DX7YzgG8cdvzRXTvaaGGRdhdBnH4VfPk3ECpFOfBAfS1zdGg6DhNCW8eB46gcJxPCA/f
         nwzWqfpWbshh1UJLdOq7x+8KNRjaJBKxK9Le4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0FVSxhLHcynWiypcCq2zv01OmaWJABRwUDhEigfy/k=;
        b=V5ffvHkMg52TGGsKFZ3fn/ddlvlBqu2alrvT1nmAilCG1GAuMfggl+CAqo+tllQgIX
         xwjgcdVqe4hcc9bdEgBygORpACCYYYkXxBQAFaoLMp0xxZEN2JRLPEmJzVLBLMjqQtIs
         vHlQZV/Ewdq0zVS5pyWLPQb4K2F9jJh85eKdBAwnYQdC2BQzneSXGdvnscPnmrqH3pif
         d2aqcSoKOzSbJmPNWn0+bJ7nBQP65VUsMH556chEDHuJgmDsMptkPYYhbBTz03u0vidR
         Yjh8E9RFFAAH/fOVRXSrnv9vyrjzQvLwZZLjd9RHKg81tF6dc0jpQcvviCsW6nOMlDBd
         B0Mg==
X-Gm-Message-State: AGRZ1gL8pVgLi3smShOHwL0LSWMXk0LxFK66CrVkyCZSnNrFUXipq2ap
        PIWbdWwzzVvGKIu90ReF/27+GA==
X-Google-Smtp-Source: AJdET5dZbJxPAFrqIGLqZvBmY0TsdfgTjOJpdqVS1CfNZueWJNEska132yBCOR9i4s8jKfog0LMBVw==
X-Received: by 2002:a63:3204:: with SMTP id y4mr15788852pgy.41.1540860299612;
        Mon, 29 Oct 2018 17:44:59 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y1-v6sm24289644pfy.89.2018.10.29.17.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 17:44:58 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 0/3] Add quirk for reading BD_ADDR from fwnode property
Date:   Mon, 29 Oct 2018 17:44:12 -0700
Message-Id: <20181030004415.237101-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
on the Bluetooth chip itself. One way to configure the address is
through the device tree (patched in by the bootloader). The btqcomsmd
driver is an example, it can read the address from the DT property
'local-bd-address'.

To avoid redundant open-coded reading of 'local-bd-address' and error
handling this series adds the quirk HCI_QUIRK_USE_BDADDR_PROPERTY to
retrieve the BD address of a device from the DT and adapts the
btqcomsmd and hci_qca drivers to use this quirk.

Matthias Kaehlcke (3):
  Bluetooth: Add quirk for reading BD_ADDR from fwnode property
  Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
  Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990

 drivers/bluetooth/btqcomsmd.c | 29 +++-------------------
 drivers/bluetooth/hci_qca.c   |  1 +
 include/net/bluetooth/hci.h   | 12 ++++++++++
 net/bluetooth/hci_core.c      | 45 +++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c          |  6 +++--
 5 files changed, 65 insertions(+), 28 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog


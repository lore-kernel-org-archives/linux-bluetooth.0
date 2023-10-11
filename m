Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45A5CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 19:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjJKTPc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjJKTPa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 15:15:30 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D5394;
        Wed, 11 Oct 2023 12:15:28 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57f02eeabcaso116444eaf.0;
        Wed, 11 Oct 2023 12:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697051727; x=1697656527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Q8SUadMNKwBh5jP8LiqkCCKJqcT99feSI0fWFI3X5k=;
        b=gjMShEwmMvK0UA0qhKFz7BVFV9adbkgl7fhzr+UlBXLhjy3vKUbRrkMXJmz0zNZBOA
         8R/X0Xf6H4sb0rFb1/YGvtVTX28okpvktBO8ZjKv3vAiE1coPA3gpNpfJlZHkuoXr2/W
         A3i9Aj0izq7VewxEY3B6zla56lB6mPak6wqei40AZyVNTRYn9PaInDGUKOqZtNGr/3ii
         QMtmeDDMVqogFuGPj/WyId9YfVb/h+968IUj/nrLPQrEnCdQ4tpSu8Dwpc4huOgFoEHQ
         TQ52dRGTYlznQhYgR5WIbtX2G3YANMhZuVrysb+srjeWvJ0dSacKqomlq5W5dR9tBhxf
         ACBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697051727; x=1697656527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Q8SUadMNKwBh5jP8LiqkCCKJqcT99feSI0fWFI3X5k=;
        b=eOOUOxf3DESQd0W/n/e+KAKDLT5ZZKWag5M35+p2mJkrLNDsIS+3o6rw+frv0eU6Qj
         ymPtSKc6rhORTwOq8J6xeZWK+vBLhOnvDGO35mhgOghaP47kFiZoYTB6xubylwg9Cw/f
         0AGeHK9aF4sevRD2nH53Ck6/sXK7KLm8iQ4En0mVIOzBWytD1wtu2MMdKg85/0PQapxF
         N6+89HE80kvRdg+ftUcqAvDoZ0lGfoTuEV0Ch8MJQF+DEbUt+/IlFixzrpXw/y+WciZX
         eX0lcY5DfULXU9fWaw7VYkn2VHgMd41IuRUX6TadC57QhnMBiU7GXG8Kjjve8PVz4+Ve
         yEfQ==
X-Gm-Message-State: AOJu0YwfhNwfJaEVbdVNGoTbT49f80pV+dp5ENM3J7VOHWEvBxFKv4gD
        t6Fu4a6RicawO/LxEqC2ZEo=
X-Google-Smtp-Source: AGHT+IGzFjhyf85FPrEafG0SB3xIdT76JbTY2BHt4mtsXNLDf685RQO+BT0fuSVIJ7mIlHL/HDQZbg==
X-Received: by 2002:a05:6358:9218:b0:142:fd2b:d30c with SMTP id d24-20020a056358921800b00142fd2bd30cmr25528029rwb.23.1697051727106;
        Wed, 11 Oct 2023 12:15:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id j19-20020aa783d3000000b00690d255b5a1sm10429895pfn.217.2023.10.11.12.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 12:15:25 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull-request: bluetooth 2023-10-11
Date:   Wed, 11 Oct 2023 12:15:24 -0700
Message-ID: <20231011191524.1042566-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following changes since commit a950a5921db450c74212327f69950ff03419483a:

  net/smc: Fix pos miscalculation in statistics (2023-10-11 10:36:35 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-10-11

for you to fetch changes up to fc11ae648f03e97d00853d2ea045c909e64d0f36:

  Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name (2023-10-11 11:19:11 -0700)

----------------------------------------------------------------
bluetooth pull request for net:

 - Fix race when opening vhci device
 - Avoid memcmp() out of bounds warning
 - Correctly bounds check and pad HCI_MON_NEW_INDEX name
 - Fix using memcmp when comparing keys
 - Ignore error return for hci_devcd_register() in btrtl
 - Always check if connection is alive before deleting
 - Fix a refcnt underflow problem for hci_conn

----------------------------------------------------------------
Arkadiusz Bokowy (1):
      Bluetooth: vhci: Fix race when opening vhci device

Arnd Bergmann (1):
      Bluetooth: avoid memcmp() out of bounds warning

Edward AD (1):
      Bluetooth: hci_sock: fix slab oob read in create_monitor_event

Iulia Tanasescu (1):
      Bluetooth: ISO: Fix invalid context error

Kees Cook (1):
      Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name

Lee, Chun-Yi (2):
      Bluetooth: hci_event: Ignore NULL link key
      Bluetooth: Reject connection with the device which has same BD_ADDR

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix using memcmp when comparing keys
      Bluetooth: hci_event: Fix coding style

Max Chou (1):
      Bluetooth: btrtl: Ignore error return for hci_devcd_register()

Pauli Virtanen (1):
      Bluetooth: hci_sync: always check if connection is alive before deleting

Ziyang Xuan (1):
      Bluetooth: Fix a refcnt underflow problem for hci_conn

 drivers/bluetooth/btrtl.c       | 10 +++------
 drivers/bluetooth/hci_vhci.c    |  3 +++
 include/net/bluetooth/hci_mon.h |  2 +-
 net/bluetooth/hci_conn.c        |  9 ++++++++
 net/bluetooth/hci_event.c       | 48 +++++++++++++++++++++++++++++++++--------
 net/bluetooth/hci_sock.c        |  3 ++-
 net/bluetooth/hci_sync.c        | 26 +++++++++++-----------
 7 files changed, 69 insertions(+), 32 deletions(-)

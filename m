Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4AFC6FA8F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 20:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbjHXUPQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 16:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243510AbjHXUPG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 16:15:06 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B3D1BE6;
        Thu, 24 Aug 2023 13:15:02 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34961362f67so3391855ab.0;
        Thu, 24 Aug 2023 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692908102; x=1693512902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eV99/KwJCOXDWRzyS7YmiM7xdn/lqE3M72sQmP0DJtM=;
        b=AQpYibZWJ0yjL4GWoHbavY/PKBXQqD7DSb2wKIY6UeyVX+6ooqIlEsb+sDJOrmwopE
         0hiJzXag7WllokvR1y39Z+LjpK587czEkB5IlIru62oImC+zeWwVTVK5twbaHgrhF+Ed
         uwQ3DLwhrdj6OQYGQELmIraNaTrE2YA6bvfwoT06YZ0aLkQosZjiigXRoT+G5tigPwME
         D1DYRzjyWfANa0HfS4VkCIfVAwcEIiMN/2QJxuHA515G/1QoSS3Qq7w67vh8js5lZM5x
         UPgqZlehx6uVFTLj7yG9a5at++pq9c0Cygzq6wgrmrWlbEZh+VmIcGQ2m6ZKwk39r0pe
         EUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692908102; x=1693512902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eV99/KwJCOXDWRzyS7YmiM7xdn/lqE3M72sQmP0DJtM=;
        b=foS/0sJI/9j6vongbRSEMPDYhUBG9DEyN3suj4MIlLf2w8XxwnTWT2AIvx1ykt0n/9
         WFGH+jjdoXT9E0zEtJPsOOfDuK1qwqi6Q/3XRpZUMRJjpItK5fNu/Nu7CQRW2qKIEJq9
         xL7CwmFlOAL3nl5hyrqQLuXTTJJfuHHBnCPTeVtoWJYO6IHeuQ8AYvT5oHV2TiTQ7Apw
         pzgEH1zRz7yZ42bMoB2mnXlthNt+apXbwzjQH8fRYaACv5XUJFnKlrRGYDiR1cXMm6/q
         lywhUcwzGLa6VRu6qqZntcbc1B7DTFTp4ZxAbTKQJyfwV3NkrtqbQhD296BR3n6ZRAla
         ASNQ==
X-Gm-Message-State: AOJu0YzxyArXVUeuUNaIAaGyf4F3bSBWMDhWM/fH7xCadvaf0Oa2Ir0b
        SovELS91pxnd7j7korELWaY=
X-Google-Smtp-Source: AGHT+IFGnQrYdYbQgSdLdXpVh2qj5TsbG97/gWpBB7COP/mgkL9HhDGRuBJ/r39i/BRgUGZ6grwjpw==
X-Received: by 2002:a05:6e02:13cc:b0:348:76eb:17d8 with SMTP id v12-20020a056e0213cc00b0034876eb17d8mr6067482ilj.6.1692908102022;
        Thu, 24 Aug 2023 13:15:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id x2-20020a920602000000b003459023deaasm63560ilg.30.2023.08.24.13.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 13:15:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2023-08-24
Date:   Thu, 24 Aug 2023 13:14:58 -0700
Message-ID: <20230824201458.2577-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following changes since commit 59da9885767a75df697c84c06aaf2296e10d85a4:

  net: dsa: use capital "OR" for multiple licenses in SPDX (2023-08-24 12:02:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2023-08-24

for you to fetch changes up to 2a05334d7f91ff189692089c05fc48cc1d8204de:

  Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave() (2023-08-24 12:24:37 -0700)

----------------------------------------------------------------
bluetooth-next pull request for net-next:

 - Introduce HCI_QUIRK_BROKEN_LE_CODED
 - Add support for PA/BIG sync
 - Add support for NXP IW624 chipset
 - Add support for Qualcomm WCN7850

----------------------------------------------------------------
Bastien Nocera (1):
      Bluetooth: btusb: Fix quirks table naming

Claudia Draghicescu (1):
      Bluetooth: ISO: Add support for periodic adv reports processing

Iulia Tanasescu (1):
      Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync

Jinjie Ruan (1):
      Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave()

Lokendra Singh (1):
      Bluetooth: btintel: Send new command for PPAG

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
      Bluetooth: hci_conn: Fix sending BT_HCI_CMD_LE_CREATE_CONN_CANCEL
      Bluetooth: hci_core: Fix missing instances using HCI_MAX_AD_LENGTH
      Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED

Neeraj Sanjay Kale (3):
      Bluetooth: btnxpuart: Remove check for CTS low after FW download
      Bluetooth: btnxpuart: Add support for IW624 chipset
      Bluetooth: btnxpuart: Improve inband Independent Reset handling

Neil Armstrong (3):
      dt-bindings: net: bluetooth: qualcomm: document WCN7850 chipset
      Bluetooth: qca: use switch case for soc type behavior
      Bluetooth: qca: add support for WCN7850

Pauli Virtanen (1):
      Bluetooth: hci_conn: fail SCO/ISO via hci_conn_failed if ACL gone early

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |  23 ++
 drivers/bluetooth/btintel.c                        |  31 ++-
 drivers/bluetooth/btintel.h                        |   7 +-
 drivers/bluetooth/btnxpuart.c                      | 216 ++++++++++-------
 drivers/bluetooth/btqca.c                          |  97 +++++---
 drivers/bluetooth/btqca.h                          |  37 +--
 drivers/bluetooth/btusb.c                          |   6 +-
 drivers/bluetooth/hci_qca.c                        | 264 ++++++++++++++++-----
 include/net/bluetooth/hci.h                        |  21 ++
 include/net/bluetooth/hci_core.h                   |  40 +++-
 net/bluetooth/eir.c                                |   2 +-
 net/bluetooth/hci_conn.c                           |  48 +++-
 net/bluetooth/hci_event.c                          |  64 ++++-
 net/bluetooth/hci_sync.c                           |  75 ++++--
 net/bluetooth/iso.c                                | 188 ++++++++++++---
 net/bluetooth/mgmt.c                               |   6 +-
 16 files changed, 818 insertions(+), 307 deletions(-)

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FF5C47098
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 07:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFC3613D6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 07:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFCHqG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 03:46:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3044 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFCHqG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 03:46:06 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fwd875cpbzWr89;
        Thu,  3 Jun 2021 15:39:35 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 15:44:13 +0800
Received: from huawei.com (10.67.165.24) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 15:44:13 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yekai13@huawei.com>
Subject: [PATCH v3 00/12] Bluetooth: correct the use of print format
Date:   Thu, 3 Jun 2021 15:40:53 +0800
Message-ID: <1622706065-45409-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to Documentation/core-api/printk-formats.rst,
Use the correct print format. 
1. Printing an unsigned int value should use %u instead of %d.
2. Printing an unsigned long value should use %lu instead of %ld.
Otherwise printk() might end up displaying negative numbers.

changes v1 -> v2:
	fix some style problems
changes v2 -> v3
	fix some commit message style

Kai Ye (12):
  Bluetooth: bnep: Use the correct print format
  Bluetooth: cmtp: Use the correct print format
  Bluetooth: hidp: Use the correct print format
  Bluetooth: rfcomm: Use the correct print format
  Bluetooth: 6lowpan: Use the correct print format
  Bluetooth: a2mp: Use the correct print format
  Bluetooth: amp: Use the correct print format
  Bluetooth: hci: Use the correct print format
  Bluetooth: mgmt: Use the correct print format
  Bluetooth: msft: Use the correct print format
  Bluetooth: sco: Use the correct print format
  Bluetooth: smp: Use the correct print format

 net/bluetooth/6lowpan.c     | 16 +++++------
 net/bluetooth/a2mp.c        | 24 ++++++++--------
 net/bluetooth/amp.c         |  6 ++--
 net/bluetooth/bnep/core.c   |  8 +++---
 net/bluetooth/cmtp/capi.c   | 22 +++++++--------
 net/bluetooth/hci_conn.c    |  8 +++---
 net/bluetooth/hci_core.c    | 48 ++++++++++++++++----------------
 net/bluetooth/hci_event.c   | 24 ++++++++--------
 net/bluetooth/hci_request.c |  8 +++---
 net/bluetooth/hci_sock.c    |  6 ++--
 net/bluetooth/hci_sysfs.c   |  2 +-
 net/bluetooth/hidp/core.c   |  6 ++--
 net/bluetooth/mgmt.c        | 16 +++++------
 net/bluetooth/mgmt_config.c |  4 +--
 net/bluetooth/msft.c        |  2 +-
 net/bluetooth/rfcomm/core.c | 68 ++++++++++++++++++++++-----------------------
 net/bluetooth/rfcomm/sock.c |  8 +++---
 net/bluetooth/rfcomm/tty.c  | 10 +++----
 net/bluetooth/sco.c         |  8 +++---
 net/bluetooth/smp.c         |  6 ++--
 20 files changed, 150 insertions(+), 150 deletions(-)

-- 
2.8.1


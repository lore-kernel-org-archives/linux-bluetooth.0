Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089B3C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 06:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA6A610CF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 06:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhDAGxz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 02:53:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15427 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhDAGx0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 02:53:26 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F9v3s4TylzjXhp;
        Thu,  1 Apr 2021 14:51:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 14:53:13 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <yumeng18@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] net/Blutooth - Coding style fix
Date:   Thu, 1 Apr 2021 14:50:37 +0800
Message-ID: <1617259839-31383-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove 'return' in void function and fix some coding style

Meng Yu (2):
  Bluetooth: Remove 'return' in void function
  Bluetooth: Coding style fix

 net/bluetooth/6lowpan.c     | 5 +----
 net/bluetooth/hci_debugfs.c | 8 ++++----
 net/bluetooth/hci_event.c   | 2 +-
 net/bluetooth/hci_request.c | 6 ++----
 net/bluetooth/l2cap_core.c  | 7 +++----
 5 files changed, 11 insertions(+), 17 deletions(-)

-- 
2.8.1


Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB87C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 14:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 864E0206F1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 14:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgFQOji (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:39:38 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34800 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgFQOj0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 10:39:26 -0400
Received: from localhost.localdomain (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 40C2ACECD4
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 16:49:16 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/14] Combination of pending patches
Date:   Wed, 17 Jun 2020 16:39:06 +0200
Message-Id: <cover.1592404644.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is the list of pending patches and fixes merged together. Please
review that the set and functionality is correct and working as
expected.

In v2 the Reviewed-by tags have been added.

Abhishek Pandit-Subedi (4):
  Bluetooth: Add bdaddr_list_with_flags for classic whitelist
  Bluetooth: Replace wakeable list with flag
  Bluetooth: Replace wakeable in hci_conn_params
  Bluetooth: Add get/set device flags mgmt op

Manish Mandlik (1):
  Bluetooth: Terminate the link if pairing is cancelled

Marcel Holtmann (2):
  Bluetooth: mgmt: Add commands for runtime configuration
  Bluetooth: mgmt: Use command complete on success for set system config

Miao-chen Chou (7):
  Bluetooth: Add definitions for advertisement monitor features
  Bluetooth: Add handler of MGMT_OP_READ_ADV_MONITOR_FEATURES
  Bluetooth: Add handler of MGMT_OP_ADD_ADV_PATTERNS_MONITOR
  Bluetooth: Add handler of MGMT_OP_REMOVE_ADV_MONITOR
  Bluetooth: Notify adv monitor added event
  Bluetooth: Notify adv monitor removed event
  Bluetooth: Update background scan and report device based on
    advertisement monitors

 include/net/bluetooth/hci_core.h |  73 +++++-
 include/net/bluetooth/mgmt.h     |  77 +++++++
 net/bluetooth/hci_conn.c         |  11 +-
 net/bluetooth/hci_core.c         | 153 ++++++++++++-
 net/bluetooth/hci_event.c        |  13 +-
 net/bluetooth/hci_request.c      |  32 ++-
 net/bluetooth/l2cap_core.c       |   6 +-
 net/bluetooth/mgmt.c             | 382 ++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt_config.c      |  23 +-
 net/bluetooth/mgmt_config.h      |   6 +
 net/bluetooth/msft.c             |   7 +
 net/bluetooth/msft.h             |   9 +
 12 files changed, 755 insertions(+), 37 deletions(-)

-- 
2.26.2


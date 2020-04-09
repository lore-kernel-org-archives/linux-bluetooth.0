Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9148FC2D0EA
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 06:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCF820784
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 06:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDIGFz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:05:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60244 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIGFz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 02:05:55 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6E1A5CECF2
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2020 08:15:29 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Cleanup patches for LL Privacy work
Date:   Thu,  9 Apr 2020 08:05:46 +0200
Message-Id: <cover.1586412226.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

These are are few cleanup patches before the LL Privacy work can
continue.

Marcel Holtmann (4):
  Bluetooth: Sort list of LE features constants
  Bluetooth: Use extra variable to make code more readable
  Bluetooth: Enable LE Enhanced Connection Complete event.
  Bluetooth: Clear HCI_LL_RPA_RESOLUTION flag on reset

 include/net/bluetooth/hci.h      | 5 ++---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 8 ++++++++
 net/bluetooth/hci_request.c      | 4 +++-
 4 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.25.2


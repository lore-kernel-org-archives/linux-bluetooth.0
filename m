Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0795CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E302A6128B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 16:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbhKIQo1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238286AbhKIQoX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 11:44:23 -0500
Received: from sipsolutions.net (unknown [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47BFC0613B9
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=lSfcP7eOVSw4c5jDibayrhPioukG4Weehmto05Q+vKQ=; t=1636476097; x=1637685697; 
        b=oaVasdPKLZ/aOQ0xuzYKSyHY4p5SB0TQnfOwAMvJB2r8qBeLb6uGIsL4A14w7wW9eXAT3bMp/pW
        4C6rWLjBHe2Vk/dgsTtLM1S5Qy/E4R2wernUksiurZCuFHgyAj4kZh4kdzWVFu5kcCGZzUz51Nt9H
        AGJCVj+4CK3Otdo3YtDuGikHwqWEAQqLORYmduNMKEHMRvAezq7sVXBgQHpJLB4mcTPh7HoKJz3Y4
        bCX5Qp43HUAQsMQdZ7TjcKGwtiC9SkWFmTvnPeTMjI6MQlh3s0oWMLt+3oZhrtb1F2uoJQlfVWOIp
        Kzh2U+6DY45i92clfOaNNQ2LhLjZiSJgWPzw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mkUBh-00D1dY-4o;
        Tue, 09 Nov 2021 17:41:33 +0100
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 0/4] Cancel sync commands if a TX failure occurs
Date:   Tue,  9 Nov 2021 17:41:09 +0100
Message-Id: <20211109164113.65981-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It was reported that userspace could hang for 10s after resuming due to
btusb hitting the internal timeout when sending the firmware.

In this case, the bluetooth dongle disappeared right after resume due to
the thinkpad_acpi rfkill being blocked. This causes the USB device to
disappear, however the bluetooth stack does not handle the
corresponding ENODEV errors and instead waits for a timeout to happen.

To avoid blocking everything for such a long time, the synchronous
command has to finish immediately after an ENODEV error occurs. This
requires further error handling, which this patchset adds by building
on top of the existing cancellation infrastructure for synchronous
commands.

Note that this just adds basic error handling in order to quickly abort
the initialization routine in case the device disappears at that time.
Additional error handling such as calling hci_reset_dev might be
sensible in some cases.

Benjamin Berg (4):
  Bluetooth: Reset more state when cancelling a sync command
  Bluetooth: Add new hci_tx_error function
  Bluetooth: hci_core: Signal TX failure if sending a frame failed
  Bluetooth: btusb: Signal URB errors as TX failure

 drivers/bluetooth/btusb.c        | 16 ++++++++++++----
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  9 +++++++++
 net/bluetooth/hci_request.c      |  5 +++++
 4 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.31.1


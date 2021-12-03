Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787CEC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 14:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381632AbhLCPCh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381624AbhLCPCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 10:02:35 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30261C061354
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=fr6ADaLeJISaS6F3g3sSOP8RSmzKp56ndBiROZj1gdo=; t=1638543551; x=1639753151; 
        b=Mn0buEtMwtgqZW9FVh2NlyEoxwlURtObPJRfwmfQi4pLb5gfKtJtTje35OQ89WDpadD2Ouxv3xZ
        k4PfvuPU18/Qa602bGEY4npvHItkDLUbRD82PJea7b3ybVoJ9XweKXrpksojxf2EhwMkbDvKT8Qn5
        xH7L/uRgnoKdox9jToH6nwubqqdoCrKB7qnkF/9bmHVhqIhXt1bcrNDJ7ZVrXYzqaoKBOqTM3xQpm
        +XfgGTJtSj2R9xIw/EF7Oc/xaIIHS32Qj5n+FDuq2i7qAHvTfhLygor3OfzM+yE8x8qgdaxG05eJL
        aci2lc5PgNKu5hIgFmvPLgTU/IBbtA/6hKGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mtA1k-006QDV-96;
        Fri, 03 Dec 2021 15:59:08 +0100
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 0/4] Cancel sync commands if a TX failure occurs
Date:   Fri,  3 Dec 2021 15:58:58 +0100
Message-Id: <20211203145902.3223861-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.33.1
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
  Bluetooth: Add hci_cmd_sync_cancel to public API
  Bluetooth: hci_core: Cancel sync command if sending a frame failed
  Bluetooth: btusb: Cancel sync commands for certain URB errors

 drivers/bluetooth/btusb.c        | 11 +++++++++--
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_core.c         | 14 +++++++++++---
 net/bluetooth/hci_request.c      | 13 +------------
 net/bluetooth/hci_request.h      |  1 -
 net/bluetooth/hci_sync.c         | 17 +++++++++++++++++
 6 files changed, 39 insertions(+), 18 deletions(-)

-- 
2.33.1


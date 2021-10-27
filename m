Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FB2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 09:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8596103C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 09:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbhJ0JRC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 05:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbhJ0JRA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 05:17:00 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87990C061570;
        Wed, 27 Oct 2021 02:14:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD75617A1C1;
        Wed, 27 Oct 2021 09:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1635326071; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=1XcIWwSkm+sFXxO+Q0Y5PRBVerqRn/iZKzGXGbGR1ak=;
        b=tIke39SPuq4aZGak6494qmyRVKilv/pyU3ic46Rp04ifRwg0rrPUdGAD4CQYpBDU/r0Fas
        k/tNuQxUoucF5JiQzG5R//yl3QRkJrQjBISoXPpb/1SHYQEfk4XWyB6vAElBG7zLgmkVOQ
        yR/a1hDPngCRQ0fz26wWOluNR388KuZ+OSE2dOc2lX7NENUbpKI9uvr7iNPSVq+pbv96PS
        L+RSS9a8r9I1QBoX9K9lT9NI6Z7CPtj5+C1r8WkJx7ymrfpTcA7p3U7uK51JAv/dDF+lm6
        6aAuMtdF1UQRmwmlzo/U3KBNPsx69CTdzo0kEjdknEavRln5/urz+3jv/a3mAQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Bluetooth: hci_h5: btrtl: Add support for RTL8822CS hci_ver 0x08
Date:   Wed, 27 Oct 2021 12:14:14 +0300
Message-Id: <20211027091416.1577668-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar to RTL8822CS with hci_ver = 0x0a
The controller does not always start when the system starts up, so we do a forced reset via gpio during initialization.

Changes from v2:
- align the patches for bluetooth-next
Changes from v1:
- remove Signed-off-by chbgdn <chbgdn@gmail.com> as not reachable

Vyacheslav Bocharov (2):
  Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
  Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open

 drivers/bluetooth/btrtl.c  | 7 +++++++
 drivers/bluetooth/hci_h5.c | 5 +++++
 2 files changed, 12 insertions(+)

-- 
2.30.2


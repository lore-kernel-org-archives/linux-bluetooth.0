Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DDDC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 10:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100486134F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 10:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhJSKGy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 06:06:54 -0400
Received: from hh0.msync.work ([95.217.35.189]:51446 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235218AbhJSKGv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 06:06:51 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2021 06:06:50 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC252160F3E;
        Tue, 19 Oct 2021 09:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1634637470; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=XFLkX/xaWyvvz1dy5b61ZlkpTFUhn3xHtMkmVdypEKs=;
        b=pP2HRkh73gkhIpYZ4g4r9mXA/RfbRq/NG05RdXpvkZAsXwUPl8BqfXxth4JoGQlnWVDWeW
        BnjrA2ZBxaKLNwGz9gTT1KA0GqOy5KVKn5D7V2eSuPqkAvAtl0vxvU/cJJSb/XG11PFWQ4
        posAHQQ9bh+iHdXw0DUqr19x2y1yrWhM/zVJB4CbzedFRfr3KI93jexd4PuOVtFSxrsnIJ
        cBGemSo/ftCcxYCSLdy7RtMRC5daRujmfUFtJuVZFiUqY7oRFWOsN43XopFKSmW5d2447L
        CZ40henW3k6lLzimfPOakPFzM4hTWTR4EWct/MIWSgcJ3CRF9ZtvUPZFnPTtJg==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: hci_h5: btrtl: Add support for RTL8822CS hci_ver 0x08
Date:   Tue, 19 Oct 2021 12:57:36 +0300
Message-Id: <20211019095738.2098486-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add a variation of RTL8822CS with hci_ver = 0x08.
The controller does not always start when the system starts up, so we do a forced reset via gpio during initialization.

Vyacheslav Bocharov (2):
  Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
  Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open

 drivers/bluetooth/btrtl.c  | 7 +++++++
 drivers/bluetooth/hci_h5.c | 5 +++++
 2 files changed, 12 insertions(+)

-- 
2.30.2


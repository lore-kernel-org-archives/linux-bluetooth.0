Return-Path: <SRS0=ehmo=RB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EE4C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 19:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAFD21850
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 19:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PxKsiVL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfBZTrC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:47:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42835 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfBZTrB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Feb 2019 14:47:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id v11so1304905plg.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Feb 2019 11:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNvnOHOK68RqItWemYHG7QHR5eU/B11GOxVuIIAZwKI=;
        b=PxKsiVL6LJViJL8TlFc4bJ99KuEmXp0XhQpUYrbDL9D2Hhu1HSlEpQu1Fe4gb6D+II
         OzofscBFH1LQ1mZMpGFszSrCzwN1bc0eJ+Q2bsa+8vANaXQn1MrqhKNNETuj0cPnJ2ZP
         GBsVXXGVbu8gjd0AquE6Vbuo3fL4eleaRmZrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNvnOHOK68RqItWemYHG7QHR5eU/B11GOxVuIIAZwKI=;
        b=cyCsioPzD2JsG70kOkjbtRSDRTwCUVJN/4GYeFN0thhM2fIIu2CjC+UxOtgf2n/l2F
         kPNkMRW9qKDxASSPiHAhGdrQlyGkNpxdWQ9+9nRBbXe7zSkdyqysP3oNpVJorma6UwvB
         +Ruwy/iZVFgRUnSf698PQlbTYQU6BmVwib9fJkHzVyc8fViDJY7csr+02A5zJQUlGGun
         SYvsR9/F6x+e1R5uYilo5WyXJMZVeq0FzBlyANMQ0m/xlWtJxVw0PAZucK+gVrIkxq//
         5WAHXOJWTyIplBDvs/Urjt8DOj/L34DVXQbrLyaZCmFstKW9mD1hBXXm15dQWq+pMhpl
         tmGA==
X-Gm-Message-State: AHQUAubibQKndcpx/L8fihsGGd/+KQpktKxHIfbKoekDp9APYbMo5ioB
        aInaWinJ8LiD0EBGTuK+1ppCRw==
X-Google-Smtp-Source: AHgI3IYTW52V7M4VKun9mLCYuFDbsBXUQI+34B/7VXt+f/PAzeL6m7g5j5gYf1WWXU9R8J0V+mryag==
X-Received: by 2002:a17:902:1c9:: with SMTP id b67mr21271373plb.176.1551210421323;
        Tue, 26 Feb 2019 11:47:01 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r6sm15766498pgk.91.2019.02.26.11.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:47:00 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 0/3] Bluetooth: hci_qca: Add delay after power-off pulse
Date:   Tue, 26 Feb 2019 11:46:44 -0800
Message-Id: <20190226194647.146078-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Initialization of the QCA WCN3990 often fails at boot time:

 [   15.205224] Bluetooth: hci0: setting up wcn3990
 [   17.341062] Bluetooth: hci0: command 0xfc00 tx timeout
 [   22.101453] ERROR: Bluetooth initialization failed
 [   25.337740] Bluetooth: hci0: Reading QCA version information failed (-110)

A short delay after sending a power-off pulse (which is done immediately
before sending a power-on pulse) fixes this.

Also move the delays to qca_send_power_pulse(), since they are directly
related with sending the pulses. Change the interface of
qca_send_power_pulse() to receive a boolean instead of a power pulse
command, this improves readability of the function with the delays
added.

Matthias Kaehlcke (3):
  Bluetooth: hci_qca: Pass boolean 'on/off' to qca_send_power_pulse()
  Bluetooth: hci_qca: Move boot delay to qca_send_power_pulse()
  Bluetooth: hci_qca: Add delay after power-off pulse

 drivers/bluetooth/hci_qca.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.21.0.rc2.261.ga7da99ff1b-goog


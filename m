Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A87EC05027
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Feb 2023 22:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjBNW4Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBNW4Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Feb 2023 17:56:24 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ED528D31
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 14:56:23 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id m10-20020a170902f64a00b0019a68e484e1so8738251plg.14
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 14:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d2LKeVjdglgBPLcsM7WUahFxxZMsBH+ZUt0TnFuwIo8=;
        b=CVHEhPypiO5omY1RQfCswgvy4wUi+AoBlXqVxDRnbUcIhGVJiOOHBXKcru3HvsWzGA
         9DaP4h84gZoYw5os8S4tTM9f0UNBmFHVp1QDoWTXJ5Yyhk8G6CvtB1V/D0di6gj+g9W0
         AkVdGdp2QHl5oeuvyUa0Yg83Uq3k3hNTX2qm8k0aYLCdKPQPKzd6ippLYk93gJ80JjkQ
         T++lUE4ddbnBTgRG1tTREEXeUtwTMbAimm+/r9TEfhnf6ORXo2zPSjYm37xrMEQ8leU8
         h1ofBTWzu9nFKqhMudA8JVcbY4x81IuB+XRzNOLWsoWZr5dmjQ5UvHCkWq+yg9zWTUgl
         K3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2LKeVjdglgBPLcsM7WUahFxxZMsBH+ZUt0TnFuwIo8=;
        b=wN8lkAQsr4dK9hKRug0p1zBH1+MO2RMmrSycOaIqj7wAqIzA1OBYXkSRvOjfceyZi+
         aZEZ7US7k+tfyZ4t09hC5J2OrpAHrVxFeV1mvxwetYDgFpcwbvr4QDUXrLtZCXAuMwhA
         CK/aNC6FL52VpMW2kaYH4b1irvwKeet5+s144Bzzf8una5CLirrutkgu/e/3wRsmJy7n
         Prft6bCJi1xANKoEHFI02F0hQXNZgB6QI1DRvi/qNOyFHoUrjpP88+2J/l6nivj1fE0T
         QQhmSa5VYt9nz7ol2EaOwHnDpdu/qjDy2euDacINWdYXKNoCO1XIed6H4mR78iBeV9sT
         HLMg==
X-Gm-Message-State: AO0yUKXYLZPb2zETooBh65KlXx/IVx+JvENqUaludPONF5DW9PpCRaVq
        ROrmm4Gqr84HputzobTqQa6lI6LU+7Rn/M0dLTngzx5SZyi52NxWAI/Ipj7VttWGIM4UQi7GIev
        4eNT/MaganQI8sLg7jl2B5L3vBow/gzYBPlUpPmg0MGYIkOCl/gsdUUKmhSqs8oJZrn9gGDIlq1
        8W
X-Google-Smtp-Source: AK7set9BvZ/DhHYJw1UrLDAhl1Q/FEU7qxcVDPgWRxw4ufKvXz4u2Ps9KqzAxxYudUhHorD2e6iRiGQzqeh6
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a63:3dc4:0:b0:4ce:e113:5e32 with SMTP id
 k187-20020a633dc4000000b004cee1135e32mr10817pga.10.1676415382678; Tue, 14 Feb
 2023 14:56:22 -0800 (PST)
Date:   Tue, 14 Feb 2023 14:56:15 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230214145609.kernel.v1.1.Ibe4d3a42683381c1e78b8c3aa67b53fc74437ae9@changeid>
Subject: [kernel PATCH v1] Bluetooth: hci_sync: Resume adv with no RPA when
 active scan
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The address resolution should be disabled during the active scan,
so all the advertisements can reach the host. The advertising
has to be paused before disabling the address resolution,
because the advertising will prevent any changes to the resolving
list and the address resolution status. Skipping this will cause
the hci error and the discovery failure.

If the host is using RPA, the controller needs to generate RPA for
the advertising, so the advertising must remain paused during the
active scan.

If the host is not using RPA, the advertising can be resumed after
disabling the address resolution.

Fixes: 9afc675edeeb ("Bluetooth: hci_sync: allow advertise when scan without RPA")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Always pause advertising when active scan, but resume the advertising if the host is not using RPA

 net/bluetooth/hci_sync.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 117eedb6f709..edbf9faf7fa1 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2402,7 +2402,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	u8 filter_policy;
 	int err;
 
-	/* Pause advertising if resolving list can be used as controllers are
+	/* Pause advertising if resolving list can be used as controllers
 	 * cannot accept resolving list modifications while advertising.
 	 */
 	if (use_ll_privacy(hdev)) {
@@ -5397,7 +5397,7 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	/* Pause advertising since active scanning disables address resolution
 	 * which advertising depend on in order to generate its RPAs.
 	 */
-	if (use_ll_privacy(hdev) && hci_dev_test_flag(hdev, HCI_PRIVACY)) {
+	if (use_ll_privacy(hdev)) {
 		err = hci_pause_advertising_sync(hdev);
 		if (err) {
 			bt_dev_err(hdev, "pause advertising failed: %d", err);
@@ -5416,6 +5416,10 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 		goto failed;
 	}
 
+	// Resume paused advertising if the host is not using RPA
+	if (use_ll_privacy(hdev) && !hci_dev_test_flag(hdev, HCI_PRIVACY))
+		hci_resume_advertising_sync(hdev);
+
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
 	 * private address.
-- 
2.39.1.581.gbfd45094c4-goog


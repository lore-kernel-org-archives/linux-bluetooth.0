Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9CEC6379F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Feb 2023 23:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjBNXlT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Feb 2023 18:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjBNXlQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Feb 2023 18:41:16 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468052CC55
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 15:41:14 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-52ec696664fso157854257b3.17
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 15:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=grEA36ljVWkareCn41RVV7kCMGzVsX5H4mlh3GnOHcg=;
        b=Rj+QKRBuWBXtbyjeSkwpjtr37IZdkvFx8SDbZv19ynPGWB6r9GqkTi7SyaUIpEet5y
         NMI0kOIOnH90AI29yIs0OMJ+9hxOb4fbApbgleJNmJuSr5oGOZrcZpCQJo+OGkYDRbYT
         UTWvdK/I6zkiY1lck/j+h8674fjCaUA3eJp4LRoL4Psz1AIUqXT0OiGgJV1Xw22HQ8qe
         qRSM+LidPIk+0x0kmzXl2cjLY474HS7loprG1CBJsvWjRDUXB1tNF0rNmZseZ/PRigrL
         aTu1bTleqE7J1j5Ma6zofFItjuBwRYNamr6E7eLjtHH7CK6O+SHpqiuipH8SlLaiat6T
         qfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grEA36ljVWkareCn41RVV7kCMGzVsX5H4mlh3GnOHcg=;
        b=zu/rm2LonKuOZhbeejb2hXFzkV6aupouSxQFV8CDzZgZBDmxyCQ6YNW/ESYTzeHRjK
         TSdPp6ORZAUdBL+oPuaOoXZd2VIvsoJTrDCVUiSttOLIuLtoU5FWLfIABJw76M8UTxAL
         hi7ULQCcOYxKfB9bk+Rxriun5ulHt+cA26MyW5LKC5+nba5J+fSHQ95XY8jXb4b8TKUU
         Vq6pGOHdNeVIRFYCbSroGOGPAtCDYqOTCXFlDGdesS8J862xaJY/hS0+58V/5CbTLQAv
         yw58ZE7Qfor3+z4G7VGWcPEhUcS+25b6OIZmE9BYTPUu4k6x3eVfQZUwgl7ifUKrr/kc
         bqyA==
X-Gm-Message-State: AO0yUKXp4A8R2UbrtlJZ47WnH/2rn9Fa5tNAq2d96RsK/yKezWwsKkQ3
        5zFLfPg4yEXJM6HIvAbNgCBGhl5qM1BQaLz9awd2HV63kem6AV40l6Y2fLY0c4aD44IYBxQZg1r
        McYkoqL/tDB5/VjWlDyxK5VRzy3XYCGVzu12e4h3eP7rluqID0Y9QR06xqjarYhn366CSYiX1+6
        ll
X-Google-Smtp-Source: AK7set8UWf9ag5bskq5yKp7JvmYMGfgeqRAqbG2T139Y6sSk9CkyzZs3FVSHlecILKKQ19vikSUX/1C7Kigy
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a5b:7c6:0:b0:8cb:3bb0:8a35 with SMTP id
 t6-20020a5b07c6000000b008cb3bb08a35mr52918ybq.100.1676418073501; Tue, 14 Feb
 2023 15:41:13 -0800 (PST)
Date:   Tue, 14 Feb 2023 15:41:09 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230214154104.kernel.v2.1.Ibe4d3a42683381c1e78b8c3aa67b53fc74437ae9@changeid>
Subject: [kernel PATCH v2] Bluetooth: hci_sync: Resume adv with no RPA when
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

Changes in v2:
- Commit message format

Changes in v1:
- With LL privacy, always pause advertising when active scan
- Only resume the advertising if the host is not using RPA

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


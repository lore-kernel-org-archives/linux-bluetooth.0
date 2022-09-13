Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08056ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 23:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiIMXh0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 19:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIMXhX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 19:37:23 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03F2719B2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 16:37:22 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h5-20020a636c05000000b00429fa12cb65so6507821pgc.21
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=3R3kd3ajupj3cdm7/eN6SOKkue4SpZWOLdvBLhR9NOg=;
        b=PD40MUF8Fbm96f+EH4eN6upE2dgzH6/V5FZ6SzuMdGoEo4HvZK+fJbXAWO9ldkK2lx
         kzQSobzZo1PkoYHzVvsc4e9FM5Oe0qds/6+zWntw22zR4S8nBVNl0xisR46tkpiuNeF6
         Qwjo6rOvh+Hm3kJRwyJmG9pkUFK9aQpTB0G+Wk2x+pNyqN3M8l1Rt0e3yxRZOYGpsM+b
         zO+qdXeOuJ3TSuFJjZJlMoBRd21LP2UZQ8LZHym5g/lybtCFr/ReZhe7Fyg5JnOf8E2H
         flQYwuHYKHqFGoR/HQKD4DtAsfVNxH29HqEtp4ooAqIc4K59hP2YIhJfnoLW6OUbii1P
         tQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=3R3kd3ajupj3cdm7/eN6SOKkue4SpZWOLdvBLhR9NOg=;
        b=BcokyW2FMB7bk2xFyrrCuVwI0n/XTghv3E1XfJWjaWfXWO2VCyVxFIqk8LokXd0iLv
         CAmpGBNU8HxzOpeipbAZJx90orw3KDxcO/v1FVy38cudeX38PIi6l8JRwqdaFEkYL5l4
         UC3fxalZditu97drk2v9wY0R2NA8dNM9IiW2W66+YuXyclWKhsYdKqwKcw4s5P8Nrj9Y
         SqxcE2RX8Zixuj72DGm3z/qLaWlzizk9Cd9TItCOqrqLJ5OkGQBYaIurp+SFqHY+kYVO
         VJ6SR13kifv0trQSx1GfM2HRExyXmlF2+qsFOROkMR+8RbD3XxN6yl0Pm5zhAW8SG3me
         ooLA==
X-Gm-Message-State: ACgBeo29HImoCNcatUfPRlggAILrdce9svREs6MeHDZU0VVPxQ/25iLy
        GMKQQdh6KYNWk1UCB+HKKVkpJylfGJkQFmdTfpIHOb2E8ULKcm9wS+qwMH1wgfmCkp9PqGy9EYd
        qq1G/KG5ztOkBPkZKW/RauSz00WABQcFjfoYo9Xc/GAJF77xZFn+oTHniXqb1CHeI29uSjwpo8B
        Vz
X-Google-Smtp-Source: AA6agR6Rx7aJ5ESWaikv/TsLescyNMcGIubGq9nFlHDf+hu7K3rAOvznwWK4PlXHlMg1lAROBMAWgzwevRQe
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:902:6943:b0:178:4751:a76b with SMTP id
 k3-20020a170902694300b001784751a76bmr5349334plt.37.1663112241844; Tue, 13 Sep
 2022 16:37:21 -0700 (PDT)
Date:   Tue, 13 Sep 2022 16:37:15 -0700
In-Reply-To: <20220913233715.3323089-1-jiangzp@google.com>
Mime-Version: 1.0
References: <20220913233715.3323089-1-jiangzp@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913163710.kernel.v2.1.I54824fdfb8de716a1d7d9eccecbbfb6e45b116a8@changeid>
Subject: [kernel PATCH v2 1/1] Bluetooth: hci_sync: allow advertise when scan
 without RPA
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Address resolution will be paused during active scan to allow any
advertising reports reach the host. If LL privacy is enabled,
advertising will rely on the controller to generate new RPA.

If host is not using RPA, there is no need to stop advertising during
active scan because there is no need to generate RPA in the controller.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v2:
- Modify title to reduce length within limit

Changes in v1:
- Check privacy flag when disable advertising

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 41b6d19c70b06..422f7c6911d9f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5351,7 +5351,7 @@ static int hci_active_scan_sync(struct hci_dev *hdev, uint16_t interval)
 	/* Pause advertising since active scanning disables address resolution
 	 * which advertising depend on in order to generate its RPAs.
 	 */
-	if (use_ll_privacy(hdev)) {
+	if (use_ll_privacy(hdev) && hci_dev_test_flag(hdev, HCI_PRIVACY)) {
 		err = hci_pause_advertising_sync(hdev);
 		if (err) {
 			bt_dev_err(hdev, "pause advertising failed: %d", err);
-- 
2.37.2.789.g6183377224-goog


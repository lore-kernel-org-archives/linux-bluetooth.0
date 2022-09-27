Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356E2C6FA83
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Sep 2022 20:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiI0USf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Sep 2022 16:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiI0USB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Sep 2022 16:18:01 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D745819286
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 13:17:23 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x23-20020a634857000000b0043c700f6441so6165951pgk.21
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=F72lE+m5jUyXJTZtAHspzg4fSLtIEdJfsL6DV7/dUu4=;
        b=Mn8MbU84gVPCY9rdXSLA84U8EL0aqabNS24qrZWJ2AnahzfD2GFj4FE4Z0n05/O/Zt
         V/aIs40HUCDBjONjB/LyF+BOhm2UoyobiRZGpXu8lr1esxucb3JZeu+8OKc2pVc2hh+x
         UbnmqFSEJ68jJdDpoYY6FLvV3Seo1t7Gv9OPvEIWZJuj7+TsSj0WhD3vvSxJxaBFJcr0
         ld8bUZgzL82VhOu3rnVqg118AzBJEQHny195aliXzFCnm2SSzbP2u1ixIV6zu1pdNmo5
         8zrLlDxN1AZsVn+LXYQQ7GgkBbtgIuNb5lkEruA8D7OJ2ywQrsl3f6gNazJf9QttXIYO
         gHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=F72lE+m5jUyXJTZtAHspzg4fSLtIEdJfsL6DV7/dUu4=;
        b=D0hoDPMDUDgOlTFaWaLzOUM7Bzfsp090tRxTwTkV+Q9OvuvpNNxOm9dAMX3TT+Q2n1
         Lg7PTMGQp/THnUrd6Z9KF9Udr9Fucto5SjSruCdYqLfEtjvBcH60XbtOESUC24GVnZ2N
         h+5sOvvgymgfKnxKHxuhbTwJ2zuN43yROaFQKiEa71iZujB3Oj6Ujbh9jJeWVcfKnq6/
         /O4WF5hnFJjlea7u7LWMfMGXkbNvpQLpw/35yzX6NDBKuurmvt/RzVoRYIc7u4Fewy7F
         HNS7ylulcuAfZyqAno/Y5uD38SmXxrhXdloY/ur9u0oAaHvsEWk/OBPXsMkwYeBQI89n
         rrSw==
X-Gm-Message-State: ACrzQf230O58RLHO0vHwyOaXnT1lv0+k74BMcsTrRAaBawr0onquqx+F
        LoxNmvy4pbLqFvKL8X0u67ZL8LqFScsqHzs5dAMD1XleexwLcia/ufecPVBE5bbNa5KhNfmzZu3
        Xo9XEdZj9PDSWhv1LcuMZ2MDTDaj8Wf7XnFrDNczc4sHC8Vo82aKystiopWkizZOghqjJxW2IKo
        UavAw4JZGdVSsGvc/FM/8=
X-Google-Smtp-Source: AMsMyM4YN8OcX/N4kLK/55u37LO9rUT0u12bu6lrEYV/DZXomjgyk3g5okkp2Zpf8VEXOnvAkp4pZZsMv5Jul6oz+V5raQ==
X-Received: from abps.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:9b4])
 (user=abhishekpandit job=sendgmr) by 2002:aa7:9e0d:0:b0:540:94a7:9051 with
 SMTP id y13-20020aa79e0d000000b0054094a79051mr31047543pfq.59.1664309843219;
 Tue, 27 Sep 2022 13:17:23 -0700 (PDT)
Date:   Tue, 27 Sep 2022 13:17:20 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220927131717.v3.1.Ic8eabc8ed89a07c3d52726dd017539069faac6c4@changeid>
Subject: [PATCH v3] Bluetooth: Call shutdown for HCI_USER_CHANNEL
From:   Abhishek Pandit-Subedi <abhishekpandit@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Some drivers depend on shutdown being called for proper operation.
Unset HCI_USER_CHANNEL and call the full close routine since shutdown is
complementary to setup.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Using hci_qca, we can get the controller into a bad state simply by
trying to bind to userchannel twice (open+bind+close, then open+bind).
Without running the shutdown routine, the device seems to get into a bad
state. A similar bug also occurs with btmtksdio (using MT7921).

This change properly runs the shutdown routine, which should be
complementary to setup. The reason it unsets the HCI_USER_CHANNEL flag
is that some drivers have complex operations in their shutdown routine
(including sending hci packets) and we need to support the normal data
path for them (including cmd_timeout + recovery mechanisms).

Note for v2: I've gotten a chance to test this on more devices
and figure out why it wasn't working before in v1. I found two problems:
I had a signal pending (SIGTERM) that was messing things up in the
socket release function and the HCI_USER_CHANNEL flag was preventing
hci_sync from operating properly during shutdown on Intel chipsets
(which use the sync functions to send a reset command + other commands
sometimes).

This was tested with hci_qca (QCA6174-A-3), btmtksdio (MT7921-SDIO)
and btusb (with AX200).


Changes in v3:
- Added hci_dev_shutdown to wrap disabling and re-enabling flag.

Changes in v2:
- Clear HCI_USER_CHANNEL flag at start of close and restore at end.
- Add comment explaning why we need to clear flag and run shutdown.

 net/bluetooth/hci_sync.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 422f7c6911d9..15c75ef4c271 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4727,6 +4727,31 @@ static void hci_pend_le_actions_clear(struct hci_dev *hdev)
 	BT_DBG("All LE pending actions cleared");
 }
 
+static int hci_dev_shutdown(struct hci_dev *hdev)
+{
+	int err = 0;
+	/* Similar to how we first do setup and then set the exclusive access
+	 * bit for userspace, we must first unset userchannel and then clean up.
+	 * Otherwise, the kernel can't properly use the hci channel to clean up
+	 * the controller (some shutdown routines require sending additional
+	 * commands to the controller for example).
+	 */
+	bool was_userchannel =
+		hci_dev_test_and_clear_flag(hdev, HCI_USER_CHANNEL);
+
+	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
+	    test_bit(HCI_UP, &hdev->flags)) {
+		/* Execute vendor specific shutdown routine */
+		if (hdev->shutdown)
+			err = hdev->shutdown(hdev);
+	}
+
+	if (was_userchannel)
+		hci_dev_set_flag(hdev, HCI_USER_CHANNEL);
+
+	return err;
+}
+
 int hci_dev_close_sync(struct hci_dev *hdev)
 {
 	bool auto_off;
@@ -4746,13 +4771,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 		hdev->adv_instance_timeout = 0;
 	}
 
-	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
-	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
-	    test_bit(HCI_UP, &hdev->flags)) {
-		/* Execute vendor specific shutdown routine */
-		if (hdev->shutdown)
-			err = hdev->shutdown(hdev);
-	}
+	err = hci_dev_shutdown(hdev);
 
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
 		cancel_delayed_work_sync(&hdev->cmd_timer);
-- 
2.38.0.rc1.362.ged0d419d3c-goog


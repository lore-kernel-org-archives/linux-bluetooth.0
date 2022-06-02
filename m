Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7355CCCA478
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 16:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbiFBQrL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 12:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbiFBQrC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 12:47:02 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11B7E002
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 09:46:58 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 206-20020a6218d7000000b0051893ee2888so1166784pfy.16
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jun 2022 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AjgkzHRF/kCv3qib+iv1yxeRLWexzkrlF44AYXOVusk=;
        b=PxcI3fqzRJ7ZD3F6KPWNr09AVcJI3FmA018q2QE7ljYZ8ppYLmY6bTn+v/xRABQGzp
         dgNKXCmEAexbMOwU1KkOvF6piTfhYEhVMTWQWsIpFpNFLMtc4mfllCSHGAJdQk5ygEx5
         jh6JUAwHYFTllZ0dMB833W72tz5J+XqkfjrO0Gbifa2eEmfkKVS2tbjme7t9MRTQNgn8
         wwxi2oZS6MefD6oVPHX3XuNP7fbSg2brEIq4LwVvhFIaCCk9V0MXWJdWhiOoh/IVJwGe
         Y8EtxkroN3qmRx/2olrHz6SxgDavRLd5PKiV/Fqn1UWPpuqOwWhUdfqAZQwD9MVtS4Vi
         nKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AjgkzHRF/kCv3qib+iv1yxeRLWexzkrlF44AYXOVusk=;
        b=FJLBMuIM0+HDnxtr4lH9orZ5Ql7Jovuf+0TniQ+f0ZsRTB0hkDU6cG59PwUiCSRuCi
         FF8EABYH9szjjdOJSdkyfvB1QhzyXCxI6TXASoJsfFAC5OmTV01qo4V93hVzgRG02pqx
         OEEhy/Lz/Hk3c2CwV+GLYXFxp4pkmbDT+OW7NDFVUCld37UDP+79tpjbgeiFG8ioEvBt
         Cod8rGwE/188OaVJJgZBDCDjz6aSBTDDUUVvzCvkmDshUzHhhMO3P5FuZF8bFrwnW+QT
         iInlWb2UpjcEtH5xLLp10FSDj1Lh+1B3cU2W0Pt6AqOJ86EoeaCA8coIacc2CYEWkeQL
         tdnQ==
X-Gm-Message-State: AOAM53117fDb3EpwQbllDNGpzwZOOCpK3X7ICzmU6AZx5wn90RtJcLW7
        shVcVuJZhgTPoUI++aWFCu8M02vfTXHD7xnFZV2OMPOGzbDkdOvuF/Y9Q6ejG8PuH+xH79sMHEi
        phyGT4FeWUcgTGpow5woE+gfMATxd8AdN0Hq2GTWKJUxTvK74n+pYXiZI6hYkSQIMk1E7Zyc03F
        BDSIbhr5Ns14xwE8IyLEU=
X-Google-Smtp-Source: ABdhPJzMZ7vAEN4yoTtCnwEpdV5+bYJUnxSfJnm0kicvX9WAmIRgBOKPinDQ13Q7fSmw2ILb6suwvmfBYsxE/o9sPRV4kg==
X-Received: from abps.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:9b4])
 (user=abhishekpandit job=sendgmr) by 2002:a63:5c52:0:b0:3fc:cf92:ff43 with
 SMTP id n18-20020a635c52000000b003fccf92ff43mr4911152pgm.249.1654188418220;
 Thu, 02 Jun 2022 09:46:58 -0700 (PDT)
Date:   Thu,  2 Jun 2022 09:46:50 -0700
In-Reply-To: <20220602094645.1.I7d191480c15b45a237b927e26aa26ba806409efb@changeid>
Message-Id: <20220602094645.2.I8fe1bc0737dd40d4e3843ddd973fdd04ee006cfa@changeid>
Mime-Version: 1.0
References: <20220602094645.1.I7d191480c15b45a237b927e26aa26ba806409efb@changeid>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 2/2] Bluetooth: Unregister suspend with userchannel
From:   Abhishek Pandit-Subedi <abhishekpandit@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
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

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

When HCI_USERCHANNEL is used, unregister the suspend notifier when
binding and register when releasing. The userchannel socket should be
left alone after open is completed.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Currently, the suspend notifier is harmless when used since no traffic
is actually passed to controller with HCI_USERCHANNEL. When I suspend,
all I see is the MGMT Controller Suspended and Controller Resumed
events. However, for correctness, I've opted to unregister the suspend
notifier entirely when using HCI_USERCHANNEL (similar to how the
HCI_QUIRK_NO_SUSPEND_NOTIFIER works).

The alternative to this approach would be to always keep the notifier
registered and exit early in hci_suspend_notifier. Please let me know
which you prefer.

Tested on ChromeOS kernel and compiled with allmodconfig on
bluetooth-next.

 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 33 ++++++++++++++++++++++++--------
 net/bluetooth/hci_sock.c         |  3 +++
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5a52a2018b56..5b92a9abe141 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1289,6 +1289,8 @@ void hci_free_dev(struct hci_dev *hdev);
 int hci_register_dev(struct hci_dev *hdev);
 void hci_unregister_dev(struct hci_dev *hdev);
 void hci_release_dev(struct hci_dev *hdev);
+int hci_register_suspend_notifier(struct hci_dev *hdev);
+int hci_unregister_suspend_notifier(struct hci_dev *hdev);
 int hci_suspend_dev(struct hci_dev *hdev);
 int hci_resume_dev(struct hci_dev *hdev);
 int hci_reset_dev(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5abb2ca5b129..ab647a63830d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2639,12 +2639,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	hci_sock_dev_event(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
 
-	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks)) {
-		hdev->suspend_notifier.notifier_call = hci_suspend_notifier;
-		error = register_pm_notifier(&hdev->suspend_notifier);
-		if (error)
-			goto err_wqueue;
-	}
+	if (hci_register_suspend_notifier(hdev))
+		goto err_wqueue;
 
 	queue_work(hdev->req_workqueue, &hdev->power_on);
 
@@ -2677,8 +2673,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_cmd_sync_clear(hdev);
 
-	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks))
-		unregister_pm_notifier(&hdev->suspend_notifier);
+	hci_unregister_suspend_notifier(hdev);
 
 	msft_unregister(hdev);
 
@@ -2742,6 +2737,28 @@ void hci_release_dev(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL(hci_release_dev);
 
+int hci_register_suspend_notifier(struct hci_dev *hdev)
+{
+	int ret = 0;
+
+	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks)) {
+		hdev->suspend_notifier.notifier_call = hci_suspend_notifier;
+		ret = register_pm_notifier(&hdev->suspend_notifier);
+	}
+
+	return ret;
+}
+
+int hci_unregister_suspend_notifier(struct hci_dev *hdev)
+{
+	int ret = 0;
+
+	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks))
+		ret = unregister_pm_notifier(&hdev->suspend_notifier);
+
+	return ret;
+}
+
 /* Suspend HCI device */
 int hci_suspend_dev(struct hci_dev *hdev)
 {
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index bd8358b44aa4..0d015d4a8e41 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -887,6 +887,7 @@ static int hci_sock_release(struct socket *sock)
 			 */
 			hci_dev_do_close(hdev);
 			hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
+			hci_register_suspend_notifier(hdev);
 			mgmt_index_added(hdev);
 		}
 
@@ -1215,6 +1216,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		}
 
 		mgmt_index_removed(hdev);
+		hci_unregister_suspend_notifier(hdev);
 
 		err = hci_dev_open(hdev->id);
 		if (err) {
@@ -1229,6 +1231,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 				err = 0;
 			} else {
 				hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
+				hci_register_suspend_notifier(hdev);
 				mgmt_index_added(hdev);
 				hci_dev_put(hdev);
 				goto done;
-- 
2.36.1.255.ge46751e96f-goog


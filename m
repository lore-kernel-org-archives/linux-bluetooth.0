Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837CAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Mar 2022 10:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiCLKKU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Mar 2022 05:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiCLKKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Mar 2022 05:10:18 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF37B226C37
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Mar 2022 02:09:13 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dcd6a5e4b6so90055947b3.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Mar 2022 02:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=v0INzGgR4QVffzC6zq3G/Euc0szlm+qrGZcoVeZG7VQ=;
        b=ShszOJyZjdPPLb5B4ng5mZ6noaksydnRNmBc5T8kVfAiGIFOSDc0SuvjuGA4RfYLJU
         vKu4zUJduKDBH2q1hDlkW9E2n9VlaRNkcFrdjmYNf3DEAo4fRm7Cw4lwWLLvMYbX1gvx
         AiJL2pyQZD90I7DnnpI+po/up1t6XtjJ4zo9LQ1HEi1xDNb9K8dge6a/nkQokgQEfbEE
         Y1G+Xb+j6F3RAtO4TWJ7jpy0mEmSbgjehIQp3tB7wI3rE8fwXd1HIptIIdYQOytkl/Bz
         ZBQVt2kSEY8YQ9FDSUbTr5K5gKVK7uRyFVc3Ut1dmFKaTV285BxcIu6okv0YnNHoP9xP
         W+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=v0INzGgR4QVffzC6zq3G/Euc0szlm+qrGZcoVeZG7VQ=;
        b=8DskCa8MwQKjVT98awU+/Y6+zvJUPK5c//Kt7dsUu+bu1WYbMz3DsKANGwW3CtQ9nA
         Ht/PgkWwKF+kLFkGYGQoxl+dcNZYLN8CaNf9N60tMKWUUSTjrLKReijJzDu/AiwbUbsY
         YLFCEOkZQBz/Mk/rGCVIMggbFOTVzhjfzLFWfHPSQEbbNuWMVBgQQPn0EhvXfzEoiQah
         aJXzFryeTisEFxDTGeHPxS0nS8+SVS49VLQ8LzCbn+XgzSp/Zwr1x6D+MN6F1pRfVRXe
         jElC9owjoX1gH6mmLVAxbP1b8gzthDIPTTaGu/nbRSwj6OUYaiizFQWNf1N00II6oBrv
         6naw==
X-Gm-Message-State: AOAM530liH7OQE6Cb8942H8oi1v8MWktPV7BtXjEuElnBodv8OoqLKp4
        33C9oxEEWOO3QepKj1xGoXsrJ72p8gtS9A==
X-Google-Smtp-Source: ABdhPJxixmLfsMESvqL79T2A6JOIB9t89esliSfrsowEfLFeyDrZH5Kj0WGMoZtHy6z0g5QgukynEccfCabYKw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:1cf8:bbfc:56cd:c500])
 (user=mmandlik job=sendgmr) by 2002:a0d:d6c2:0:b0:2dc:a9b0:d22 with SMTP id
 y185-20020a0dd6c2000000b002dca9b00d22mr11818901ywd.194.1647079752865; Sat, 12
 Mar 2022 02:09:12 -0800 (PST)
Date:   Sat, 12 Mar 2022 02:08:58 -0800
Message-Id: <20220312020707.1.I2b7f789329979102339d7e0717522ba417b63109@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 1/2] Bluetooth: msft: Clear tracked devices on resume
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Clear already tracked devices on system resume. Once the monitors are
reregistered after resume, matched devices in range will be found again.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 net/bluetooth/msft.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 9a3d77d3ca86..f43994523b1f 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -330,12 +330,13 @@ static void msft_le_cancel_monitor_advertisement_cb(struct hci_dev *hdev,
 		/* Do not free the monitor if it is being removed due to
 		 * suspend. It will be re-monitored on resume.
 		 */
-		if (monitor && !msft->suspending)
+		if (monitor && !msft->suspending) {
 			hci_free_adv_monitor(hdev, monitor);
 
-		/* Clear any monitored devices by this Adv Monitor */
-		msft_monitor_device_del(hdev, handle_data->mgmt_handle, NULL,
-					0, false);
+			/* Clear any monitored devices by this Adv Monitor */
+			msft_monitor_device_del(hdev, handle_data->mgmt_handle,
+						NULL, 0, false);
+		}
 
 		list_del(&handle_data->list);
 		kfree(handle_data);
@@ -522,6 +523,16 @@ int msft_resume_sync(struct hci_dev *hdev)
 	if (!msft || !msft_monitor_supported(hdev))
 		return 0;
 
+	hci_dev_lock(hdev);
+
+	/* Clear already tracked devices on resume. Once the monitors are
+	 * reregistered, devices in range will be found again after resume.
+	 */
+	hdev->advmon_pend_notify = false;
+	msft_monitor_device_del(hdev, 0, NULL, 0, true);
+
+	hci_dev_unlock(hdev);
+
 	msft->resuming = true;
 
 	while (1) {
-- 
2.35.1.723.g4982287a31-goog


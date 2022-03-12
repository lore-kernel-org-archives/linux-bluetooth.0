Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D50C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Mar 2022 10:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiCLKKY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Mar 2022 05:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiCLKKV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Mar 2022 05:10:21 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86892272EE
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Mar 2022 02:09:15 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dc44b6dc9dso90086567b3.23
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Mar 2022 02:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KYvhJwEqPqMacll2Nmd0cKWfMMmSrt6TYTGYVr6fAKo=;
        b=J7927ySszHyeEQ7P3AfY7detl3yHPIjk9WdOIkUB8+zI2dkgItouavznSbYeg3NM+P
         SXANcpzXzr3G/7UmiTDBUm88mHvQp2aL2VATbxYYqV7D1DdBv5ZoxAQTX3Vs+qiW7I5B
         4zV1G9DGOv7Mt5OkPAoI6c13wbFEgyatJJ7jtAUNK1V8jHkroNF6kmgknUSn+dt3gDTs
         F0+ynuPrf1nqKM8RahsoEZHKcR7VchM17ovI8tyUc3uTtPsGp+QbOc4cbu6frU1Qi06R
         EF0rKjFbynmwND6YkEz6lAcGwdMSRWh1R4fsqzk8M6SYRs/5P751Zaii0RPBZ3cSYrfO
         Y1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KYvhJwEqPqMacll2Nmd0cKWfMMmSrt6TYTGYVr6fAKo=;
        b=YnsiAlJ1iKBhDx6G2mJs+j6Gke2igEPduDs52MgUo20j/0l5qWQm+nY88TUMxUPTwC
         hkKObvkoO0EYPwnh96cvdhUEn87kmBew2dZ7vOpf2K/SgQ+NC5+t7JJv0hZ41R6F/2JQ
         7zUHSzoiH2kgUNPQtL+iWu9yqgWA4oSvwvrs29mfyJuOK87cNHJTo9F71ENc+HD8uHtA
         LdeiXo70k1+rrUeEWo1bNyWCD9jEZNsIMyjfpgD6IGgN3ulVpjfda66m87qgAX9Ybliy
         TM5cOU6AIeXI225TPbWs2cQwToKUBz5DmNGGPL7SJnVpXfukl0vBuN8ECMna1LcxONyl
         xsFQ==
X-Gm-Message-State: AOAM533JMCYRRwiPCOT2bEkXI0BR+1ZX8X7KjGLhB5yeQttvLw1IIpNW
        M9nmkzGfgYM2Xi5/iGGTJOMfSVZThOUOlQ==
X-Google-Smtp-Source: ABdhPJxcRzDPnhDhS87upQvOk2nbkWf71y95bto7e4L03qhYhuyrC/KST/9j5nK7UuzuIkXsbhSUQCrLvX6E5w==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:1cf8:bbfc:56cd:c500])
 (user=mmandlik job=sendgmr) by 2002:a81:493:0:b0:2dc:a1c3:5e13 with SMTP id
 141-20020a810493000000b002dca1c35e13mr11655097ywe.381.1647079755192; Sat, 12
 Mar 2022 02:09:15 -0800 (PST)
Date:   Sat, 12 Mar 2022 02:08:59 -0800
In-Reply-To: <20220312020707.1.I2b7f789329979102339d7e0717522ba417b63109@changeid>
Message-Id: <20220312020707.2.Ie20f132ad5cb6bcd435d6c6e0fca8a9d858e83d4@changeid>
Mime-Version: 1.0
References: <20220312020707.1.I2b7f789329979102339d7e0717522ba417b63109@changeid>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 2/2] Bluetooth: Send AdvMonitor Dev Found for all matched devices
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

When an Advertisement Monitor is configured with SamplingPeriod 0xFF,
the controller reports only one adv report along with the MSFT Monitor
Device event.

When an advertiser matches multiple monitors, some controllers send one
adv report for each matched monitor; whereas, some controllers send just
one adv report for all matched monitors.

In such a case, report Adv Monitor Device Found event for each matched
monitor.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 net/bluetooth/mgmt.c | 70 +++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d59c70e9166f..e4da2318a2f6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9628,17 +9628,44 @@ void mgmt_adv_monitor_device_lost(struct hci_dev *hdev, u16 handle,
 		   NULL);
 }
 
+static void mgmt_send_adv_monitor_device_found(struct hci_dev *hdev,
+					       struct sk_buff *skb,
+					       struct sock *skip_sk,
+					       u16 handle)
+{
+	struct sk_buff *advmon_skb;
+	size_t advmon_skb_len;
+	__le16 *monitor_handle;
+
+	if (!skb)
+		return;
+
+	advmon_skb_len = (sizeof(struct mgmt_ev_adv_monitor_device_found) -
+			  sizeof(struct mgmt_ev_device_found)) + skb->len;
+	advmon_skb = mgmt_alloc_skb(hdev, MGMT_EV_ADV_MONITOR_DEVICE_FOUND,
+				    advmon_skb_len);
+	if (!advmon_skb)
+		return;
+
+	/* ADV_MONITOR_DEVICE_FOUND is similar to DEVICE_FOUND event except
+	 * that it also has 'monitor_handle'. Make a copy of DEVICE_FOUND and
+	 * store monitor_handle of the matched monitor.
+	 */
+	monitor_handle = skb_put(advmon_skb, sizeof(*monitor_handle));
+	*monitor_handle = cpu_to_le16(handle);
+	skb_put_data(advmon_skb, skb->data, skb->len);
+
+	mgmt_event_skb(advmon_skb, skip_sk);
+}
+
 static void mgmt_adv_monitor_device_found(struct hci_dev *hdev,
 					  bdaddr_t *bdaddr, bool report_device,
 					  struct sk_buff *skb,
 					  struct sock *skip_sk)
 {
-	struct sk_buff *advmon_skb;
-	size_t advmon_skb_len;
-	__le16 *monitor_handle;
 	struct monitored_device *dev, *tmp;
 	bool matched = false;
-	bool notify = false;
+	bool notified = false;
 
 	/* We have received the Advertisement Report because:
 	 * 1. the kernel has initiated active discovery
@@ -9660,25 +9687,6 @@ static void mgmt_adv_monitor_device_found(struct hci_dev *hdev,
 		return;
 	}
 
-	advmon_skb_len = (sizeof(struct mgmt_ev_adv_monitor_device_found) -
-			  sizeof(struct mgmt_ev_device_found)) + skb->len;
-	advmon_skb = mgmt_alloc_skb(hdev, MGMT_EV_ADV_MONITOR_DEVICE_FOUND,
-				    advmon_skb_len);
-	if (!advmon_skb) {
-		if (report_device)
-			mgmt_event_skb(skb, skip_sk);
-		else
-			kfree_skb(skb);
-		return;
-	}
-
-	/* ADV_MONITOR_DEVICE_FOUND is similar to DEVICE_FOUND event except
-	 * that it also has 'monitor_handle'. Make a copy of DEVICE_FOUND and
-	 * store monitor_handle of the matched monitor.
-	 */
-	monitor_handle = skb_put(advmon_skb, sizeof(*monitor_handle));
-	skb_put_data(advmon_skb, skb->data, skb->len);
-
 	hdev->advmon_pend_notify = false;
 
 	list_for_each_entry_safe(dev, tmp, &hdev->monitored_devices, list) {
@@ -9686,8 +9694,10 @@ static void mgmt_adv_monitor_device_found(struct hci_dev *hdev,
 			matched = true;
 
 			if (!dev->notified) {
-				*monitor_handle = cpu_to_le16(dev->handle);
-				notify = true;
+				mgmt_send_adv_monitor_device_found(hdev, skb,
+								   skip_sk,
+								   dev->handle);
+				notified = true;
 				dev->notified = true;
 			}
 		}
@@ -9697,25 +9707,19 @@ static void mgmt_adv_monitor_device_found(struct hci_dev *hdev,
 	}
 
 	if (!report_device &&
-	    ((matched && !notify) || !msft_monitor_supported(hdev))) {
+	    ((matched && !notified) || !msft_monitor_supported(hdev))) {
 		/* Handle 0 indicates that we are not active scanning and this
 		 * is a subsequent advertisement report for an already matched
 		 * Advertisement Monitor or the controller offloading support
 		 * is not available.
 		 */
-		*monitor_handle = 0;
-		notify = true;
+		mgmt_send_adv_monitor_device_found(hdev, skb, skip_sk, 0);
 	}
 
 	if (report_device)
 		mgmt_event_skb(skb, skip_sk);
 	else
 		kfree_skb(skb);
-
-	if (notify)
-		mgmt_event_skb(advmon_skb, skip_sk);
-	else
-		kfree_skb(advmon_skb);
 }
 
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-- 
2.35.1.723.g4982287a31-goog


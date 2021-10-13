Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D39C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 19:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827FE61139
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 19:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbhJMTC7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbhJMTC5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 15:02:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E4C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 12:00:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s6-20020a254506000000b005b6b6434cd6so4183372yba.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WAc+wmUNd3z1POC6nqUlp3tkcuVAO8550gDEBh9OUhU=;
        b=bFETv/24UHVPVliIn/ZWlIOU4khpx7ak3zwJps1k56z9v/1V+4D4k/rhLupyNdEKpU
         AorUCStiD3aI0mqrVdeL04ALQAjWXIV7fGd/5WYX2zShEh5MEztlwzOF00/WS1h8AGcm
         Ln+PGok5QA1xHZipKMu+pwxLMpqlI45mAuGaSf3QmAYDM1uodQawKz3eHjunWJ5mS5Cs
         UaIg28+ETNd48jT4D8NXmelXS31k3yoFK+zHJ0X3pQmXnzIT920xDsLWvGgSCXkN9yp+
         ERku2psz0i6wt+66bsT3COH9lQ3MTnp+mzv/UTwAU0OpMWAH4gLfHuAdFq2wcLexG/yA
         J2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WAc+wmUNd3z1POC6nqUlp3tkcuVAO8550gDEBh9OUhU=;
        b=O/TttB0eUBH4itrUqgXNRQPrWntamwr1hs5dHKTtB6ctn9KZeRcqzyS9p+ptWie+tE
         SmwCdgvCvco10QM4O4Lj1cQxE88apt5L50FE8QQR7mXY4BDBqQQR4a57Ct23ii+QSZEX
         K5REhMFfTNf6wHnovnYamu7XpyEz5hRQoTRMuir6rWMOKHzU053HYaxpMUJhrNqcFs+O
         uOH9JomzVNBriMo4eHECsC/fi0WmnCd2B7s9g1sGv7DKlhBjwcYMmJ35S+LkNfQh+PB0
         iB5idXpJ4Zu8DHMFMh0J0MausDpe69TKreAabyAg26RrvUpl8o/Quf3P/SujtGjDP/s5
         nLcg==
X-Gm-Message-State: AOAM531hJVMr2M+Kzj851ejo+Ji4lIIxYOcG42tP1n9sfME+/mMl0JzE
        Iomp2N0hwEXmQnNKSe81rerswBFhNjT71A==
X-Google-Smtp-Source: ABdhPJz9qMcYCAW6fSz9pVKG0idsGNmOkgxcxVVvxO8y09gGr3sZsjyUpQH/YQ+fShZ4Y9JJUA9PYyI0LI3CrQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:9910:f10f:1467:c3f])
 (user=mmandlik job=sendgmr) by 2002:a25:cdc7:: with SMTP id
 d190mr1190216ybf.53.1634151653193; Wed, 13 Oct 2021 12:00:53 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:00:35 -0700
In-Reply-To: <20211013190035.1876237-1-mmandlik@google.com>
Message-Id: <20211013115927.BlueZ.v3.3.I68039747acc3c63f758278452889d6ed2bfff065@changeid>
Mime-Version: 1.0
References: <20211013190035.1876237-1-mmandlik@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [BlueZ PATCH v3 3/3] adv_monitor: Receive the Device Lost event
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch registers a callback function to receive Advertisement
Monitor Device Lost event.

Test performed:
- verified by logs that Monitor Device is received from the controller
  and sent to the bluetoothd when the controller starts/stops monitoring
  a bluetooth device.

---

Changes in v3:
- Fix indentation of the adv_monitor_device_lost_callback() name and
  it's arguments.

Changes in v2:
- Update function name adv_monitor_tracking_callback() to
  adv_monitor_device_lost_callback() as it will receive only Device Lost
  event.

 src/adv_monitor.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 715ac5904..385ab26e6 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1531,6 +1531,27 @@ static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
 		ev->monitor_handle);
 }
 
+/* Processes Adv Monitor tracking event from kernel */
+static void adv_monitor_device_lost_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adv_monitor_manager *manager = user_data;
+	const struct mgmt_ev_adv_monitor_device_lost *ev = param;
+	uint16_t handle = le16_to_cpu(ev->monitor_handle);
+	const uint16_t adapter_id = manager->adapter_id;
+	char addr[18];
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter_id,
+				"Wrong size of Adv Monitor Device Lost event");
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+	DBG("Adv monitor with handle 0x%04x stopped tracking the device %s",
+			handle, addr);
+}
+
 /* Allocates a manager object */
 static struct btd_adv_monitor_manager *manager_new(
 						struct btd_adapter *adapter,
@@ -1555,6 +1576,10 @@ static struct btd_adv_monitor_manager *manager_new(
 			manager->adapter_id, adv_monitor_removed_callback,
 			manager, NULL);
 
+	mgmt_register(manager->mgmt, MGMT_EV_ADV_MONITOR_DEVICE_LOST,
+			manager->adapter_id, adv_monitor_device_lost_callback,
+			manager, NULL);
+
 	return manager;
 }
 
-- 
2.33.0.882.g93a45727a2-goog


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6288CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 21:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148E1619CB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Mar 2021 21:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhCWVS7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Mar 2021 17:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhCWVSc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Mar 2021 17:18:32 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683B4C061765
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 14:18:32 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o16so111865pjy.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Mar 2021 14:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IQhrNSzzRo5IK8pWj/871CxEvc5sDb7hvYKb9bWs5PY=;
        b=KN38NpSiyK1jTjlQ83KhVeIAFt3K80SF6VSS1g2Jd6f/kh8nPpyuIJPztBAAMETnVu
         L1TuPqVmfYXaileuYB41opce3o14vJUEDGZFQm4mqdPltLJOh35UjMecsZT00vrZ45Z6
         bMk6r664cLfto6awWP6eqYTsRL/seiWKh2zQiWoafJMIrHgxtgqehsGCuzcsuz8KJR/N
         qrMlrwM9B3xSJDl67Qq2r65EjcM2nEK8GohueBoYsEWv6SXRhh5Rnmj5Pp6KbTGKyr1e
         ohWDaFpB0qusp/s6H0LYK787EY8fWslgnUp35D6SDsQXXhOeAO00QXpFaRUJaRvhifnw
         Gkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IQhrNSzzRo5IK8pWj/871CxEvc5sDb7hvYKb9bWs5PY=;
        b=ShWELUY2LYH6neyGgJa7l9jYlkUM6lK+LW1rV7Ww3gs4YaSjBcVi14e9wk1TS4NOf2
         5FcmSYnyS6GWVFngdKFcH2zzYhow7CrV6BpDKBN7QcXzmOzmsEBTcUoJgiZM5l/RTEJT
         ry/spCU356gsdMqvnUuYoLVE+EcBnp1fVq0TUbgLpa44y0JjPPIkY3/PlUzjMRVgrmeY
         0vrgKvA5YCtwPRBUnX6kju027zTxhisUvGSPMdRN6oLzSqLuKrb8bxOo8YSmwnInmqdt
         tguGqW5bR6AWKh+anb7AnRzyzsyVuETJEoyn6435JrZ7nDoEZx1LGQWRdEeeNMPTpygZ
         ACpg==
X-Gm-Message-State: AOAM530/c51kxPc9mAB9HQBGtQhTZw6O1FFvbztYCSoAkyd9ECm6mghQ
        TwyKxkytra4h8lX/pjFQ+eiyc1CnssrPcs9i4Z8z+zwr5yAmAe84Or7NBzvdjPlzqhdPDeyAPND
        rBr1pd2LmlRqCH8MrbhE+kIvWdVJgCF1SDGkbi9WtgAsVvqCQUfV2vMQkNbKV3MH2zqtLAUfTan
        ISwMH2eHQ6iN3v7DPP
X-Google-Smtp-Source: ABdhPJyA9VXXmhbh2eHFc9vjsbOs7A7JCXheNnJWzX6ciTpOXFtQyV4+cNABNQ9D75XBXirz5fTuzVlC+Uxr7nOd6GNf
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f18d:a314:46c6:7a97])
 (user=danielwinkler job=sendgmr) by 2002:a05:6a00:2348:b029:21d:4e83:7898
 with SMTP id j8-20020a056a002348b029021d4e837898mr132848pfj.65.1616534311315;
 Tue, 23 Mar 2021 14:18:31 -0700 (PDT)
Date:   Tue, 23 Mar 2021 14:18:21 -0700
Message-Id: <20210323141653.1.I53e6be1f7df0be198b7e55ae9fc45c7f5760132d@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] Bluetooth: Always call advertising disable before setting params
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In __hci_req_enable_advertising, the HCI_LE_ADV hdev flag is temporarily
cleared to allow the random address to be set, which exposes a race
condition when an advertisement is configured immediately (<10ms) after
software rotation starts to refresh an advertisement.

In normal operation, the HCI_LE_ADV flag is updated as follows:

1. adv_timeout_expire is called, HCI_LE_ADV gets cleared in
   __hci_req_enable_advertising, but hci_req configures an enable
   request
2. hci_req is run, enable callback re-sets HCI_LE_ADV flag

However, in this race condition, the following occurs:

1. adv_timeout_expire is called, HCI_LE_ADV gets cleared in
   __hci_req_enable_advertising, but hci_req configures an enable
   request
2. add_advertising is called, which also calls
   __hci_req_enable_advertising. Because HCI_LE_ADV was cleared in Step
   1, no "disable" command is queued.
3. hci_req for adv_timeout_expire is run, which enables advertising and
   re-sets HCI_LE_ADV
4. hci_req for add_advertising is run, but because no "disable" command
   was queued, we try to set advertising parameters while advertising is
   active, causing a Command Disallowed error, failing the registration.

To resolve the issue, this patch removes the check for the HCI_LE_ADV
flag, and always queues the "disable" request, since HCI_LE_ADV could be
very temporarily out-of-sync. According to the spec, there is no harm in
calling "disable" when advertising is not active.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

 net/bluetooth/hci_request.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 8ace5d34b01efe..2b4b99f4cedf21 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1547,8 +1547,10 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	if (!is_advertising_allowed(hdev, connectable))
 		return;
 
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
-		__hci_req_disable_advertising(req);
+	/* Request that the controller stop advertising. This can be called
+	 * whether or not there is an active advertisement.
+	 */
+	__hci_req_disable_advertising(req);
 
 	/* Clear the HCI_LE_ADV bit temporarily so that the
 	 * hci_update_random_address knows that it's safe to go ahead
-- 
2.31.0.291.g576ba9dcdaf-goog


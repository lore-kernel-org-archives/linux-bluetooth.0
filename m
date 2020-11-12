Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04933C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 05:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9633421534
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 05:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ELCFvjXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgKLFj1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Nov 2020 00:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgKLEIw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 23:08:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D94C061A49
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 20:06:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h6so4607485ybk.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 20:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=T6CplrPxy27A6yiutX6XDympOldMSJN7QDPt35avta4=;
        b=ELCFvjXL6ZEvxXAt7MuiY8qSckQNyrSWVYRUOWscjvr1LpO5rTXC2Ou2LYrySaI7tn
         Xk+MzbSByOEz4egWSxEO1I1BXs3nVgINfCXXM5UepiekzGhSUFydk5bUdFmcc3tMmsuT
         FgNABFsa1hOuHaJPoxGLdGofjQY/pQK1yplGL9rLeYieGVftYPPV0fi4ejOv0La7qQ7h
         KO7p/5pXLycOu4K9wAealuvgYsNnZOJTO6IUmeotFftH+YhRRqUe1YQrL8uWBqP8T8/q
         TwUcgv+tggp6Nw9oJ7QU9osxW4i1q9gSn30FEvwlR2jWqE4rLNMKAEPmCHsKSpJmTRJN
         LS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T6CplrPxy27A6yiutX6XDympOldMSJN7QDPt35avta4=;
        b=lEiwHLUIwiT/7QArAvgEl3fNRWbW/14PFNsIlF8APfKWIJuEA7cRC80Jq5UU+dmMAd
         ZDKH/lxkhk84HK2VnFd4mG+cm2WoZA3ytkIkygMfOqVb5STBh0wkJGUPJiiOO6HRe31q
         EMrgIdGTJPddkSlyLnzY6muvsshTle5eR5YTljQONMJ9s4jNyhQZoSrNLI0gdahUk0Xn
         Rp2Pkhv/gLlBNsGk7zaeUD2EbhmZnwqNuHpftu4DeiGApdvRUtEBwrYM1arUl2hShJ3K
         u7+MweuhF9wDZa38KMg7I54pm79xuKJkzAIRY8/NNq0F3DLK54qJo/sjqvCQN3GanP1W
         jALw==
X-Gm-Message-State: AOAM530uuwy22Gm9OOjiaEEekZUM/CKJFUiKVmaImUGnq/Nm3f6G7t94
        K1bSH4NzloL99v7cilNGssLnubF93hDZCwtiC9oP/OG/Z0NzUcX2HPCo3xlusPAgKTQNmUa8x90
        a3lAzIoXREwzeDc4rjJZFU3zbKYYZswKR49YhXwp26ghPt7JHudKzWxjA0psRD1NF9SzRnE+Rg6
        ++Il8r1IdW8+E=
X-Google-Smtp-Source: ABdhPJwUj5JDrVJ4ySn2SgAaNrjMtCBoDksecI53K6KX+m0pKHpJUZXGKoKkWokZ8qdgIzbHYok65FLyD6nH5Ak9Yg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:b68a:: with SMTP id
 s10mr36237332ybj.311.1605154015834; Wed, 11 Nov 2020 20:06:55 -0800 (PST)
Date:   Thu, 12 Nov 2020 12:06:38 +0800
In-Reply-To: <20201112120532.v10.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201112120532.v10.3.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20201112120532.v10.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v10 3/5] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, mcchou@chromium.org, alainm@chromium.org,
        Howard Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds code to handle the active scan during interleave
scan. The interleave scan will be canceled when users start active scan,
and it will be restarted after active scan stopped.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v1)

 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3bb0d2a98e82c..2368b050c17f1 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3099,8 +3099,10 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	 * running. Thus, we should temporarily stop it in order to set the
 	 * discovery scanning parameters.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 		hci_req_add_le_scan_disable(req, false);
+		cancel_interleave_scan(hdev);
+	}
 
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
-- 
2.29.2.222.g5d2a92d10f8-goog


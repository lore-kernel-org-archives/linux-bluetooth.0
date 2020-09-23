Return-Path: <SRS0=ZvEB=DA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBD3C4727D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Sep 2020 09:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B68520719
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Sep 2020 09:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTEylZUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIWJWq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Sep 2020 05:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgIWJWq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Sep 2020 05:22:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66395C0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2020 02:22:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e2so581387ybc.17
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2020 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OYN0waWCzIpz4ouqNQwOPc0HvVqV4aulKVgXstFC8pM=;
        b=UTEylZUZ5updRxJyyE1aYQG2MB/kp+pzMWY5DhOtjk4PMP63yPQX5Vh2r0Nx4gPB/1
         V9zrBiDN+pQkVLjlflvjNSdooxWO4yGD3nHAzZ7CQNQ/gkOk2/DccLeqY0U7p37oAanE
         HYrMNwgimP/NEksULzdrBxeNR8m+30WlcQf8eUzLQ3oteCOE7BPiRlV0qCmZ77rX7QZJ
         1w2brV8qQ6HMyZXR6jkJdQsLRBEcefQT3hIXJlOu5K21VItm12/SvWm552hMC42DmvFz
         hYfl3JtNg2oaINdq4AZSFZzhyIHN4rU3btDdpttPcGEmxPsuGmWKTBXc8BqQ3zcFnme6
         4sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OYN0waWCzIpz4ouqNQwOPc0HvVqV4aulKVgXstFC8pM=;
        b=JaS7oq/K8vrfZ9DeFS0BYRncEHTwSuFKYZ+atrFZz/c/yVsm+s/SvqptAuSpE6+gs3
         e79nO5YnLZ3U/rzoOi23II4Kga3xCtduc4dMFGVDsfV7yzkhr3Anj9cRxzlD/poKpq4P
         MsSzUOfC4KQdtBN6tT2y5j6ExVN0fc+gOznkP+q8GZ+kBZYQn+Gb+rfg9gSkghcWjm1T
         nCjgQqDCkP7fezXGFmFvJ0MsamWmLOyTP1AcXxJ+rZ92Oi5vOVrXZIKGEjOnVDLqWRm8
         Wng/YIpY5a4pjMexVlCt4I9Eopx05PcPB0BgtT08+L4tQsk9uv3vW56HUnUptT+FQLlS
         CKmA==
X-Gm-Message-State: AOAM532BTt8716l1KLtRcVbhBzQE7z34rdCwlVKeHE8hqWGhLRamFaHe
        0x3mvmvmWdoIMF5vrTyeHx93K7kgljOwglYooS+WaxwQ3Er5dl4ixmz8PwGSKjQzscoMzZnDdES
        kssMuS1z8gNa4+s0h6aPeNh1MR72oKoMp0YHuK/Os3oamugcgn+Go04omfg3mnJELriOXLY/8va
        VrH3yFXDju8LA=
X-Google-Smtp-Source: ABdhPJzI1T8McZlIoA0sf6bztLH3WBdup6fzS5cp23Ntzzcb/8oA+VMcbFtGnTpIynAxzj4FvQFFnE7BM8+AvHZ9jQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:8746:: with SMTP id
 e6mr11266110ybn.89.1600852964527; Wed, 23 Sep 2020 02:22:44 -0700 (PDT)
Date:   Wed, 23 Sep 2020 17:22:31 +0800
In-Reply-To: <20200923172129.v5.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20200923172129.v5.3.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20200923172129.v5.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v5 3/4] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.orgi, mcchou@chromium.org, alainm@chromium.org,
        Howard Chung <howardchung@google.com>,
        Manish Mandlik <mmandlik@chromium.org>,
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
index db44680fbe9c9..4048c82d4257f 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3083,8 +3083,10 @@ static int active_scan(struct hci_request *req, unsigned long opt)
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
2.28.0.681.g6f77f65b4e-goog


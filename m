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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9789EC55ABD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 10:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40244207BB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 10:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fN+dlOtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgKJKSy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 05:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730654AbgKJKSx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 05:18:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E0EC0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 02:18:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7so14244353ybm.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 02:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C95huzuAXxK/Q/ur78yeB7NRb6+ErTiDkKW1OinYBEM=;
        b=fN+dlOttk59kV4mLEiOPuNPqRVO5JnVN+aLCHgK4Ide9SzT2SQ3I1Yp3N5t72yFdir
         34VUGkP4Cvs7PgQaYEmHpmbygeZ3AOQw1Pcu5X64sVf/KYR3/Zvp+Jtqmky9LNAMiyK9
         yHgzL0q3RFCeESLtPDPRlS44QRMGM03aVf5L8qeRpxeY5wq2LY2FbBI5YCagY3N/ML8h
         7alq99rz5kLQbnA2mlTGvhGpeRazuasVf4ZJpuJ1N3j4IJGh2yI0rCnyhq2a0ybp/N67
         JJaJ8aXsthHSK58MdaYjLmplXIPzz9REb/KjTV4SQfWagMuVv38m6r4oJ1Y95ua6bjPa
         Kodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C95huzuAXxK/Q/ur78yeB7NRb6+ErTiDkKW1OinYBEM=;
        b=QuOjucivFEY15lLv1itj4bvQfG3dSq5ev2V1KOOtuITXn+NJmRM7PBeVgXjeVC+52N
         Qh5s5DI++b47Qk+bjid9JltjM/AVUmozJBLnwjoXIufY0Jkc3yUacfdQZd9NWDTSNYzt
         giWW7TJYl/LIbqqXu9uFZR6tt09su/X4Xazkpx3BtNqApLm1jWIWekdvFU/b/FNXBS6J
         ZTAq2IH5jiZn6tP/S6tiT/qUpOt9Zgx6r1Ony0b/Ls4Pc4CqvcRzuGfqZjy4Qd+Yqyf2
         2P7P13ljfHkVf9yhnGh9T6ouYQFo5dGAcIo2kAGRvJZfi/qNb2jPP3/1wf9bbYizuWoi
         DDZw==
X-Gm-Message-State: AOAM5316gsyLbS9nd4m3fKyN1phCniLodcA+nDT9QDKz8Piy1WWzFf8O
        YoZ2JGYTNC2q75qcKWypLuaZRS1XF04vIzBPLbJFuT57eUYVv3ApU4mRCCOx/HnzGVHy00ufMe9
        egBQv2s3J5/mYq0orMcaHNzEFP73ToGZhYCIRT0CyV4xDKo/wbIFkFs/yEjkKgATTwOT5oBO2ak
        nQidedXIi9t+o=
X-Google-Smtp-Source: ABdhPJx69PbWxwCICMrL7Wj6VOTH3H80JJyY09ctMYN6Hw9Hg3URXQvI6M3r7B32IDzklPSaZONPScF2und96eg5ZQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:ac23:: with SMTP id
 w35mr26697654ybi.171.1605003531984; Tue, 10 Nov 2020 02:18:51 -0800 (PST)
Date:   Tue, 10 Nov 2020 18:17:53 +0800
In-Reply-To: <20201110181740.v8.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
Message-Id: <20201110181740.v8.4.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20201110181740.v8.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v8 4/6] Bluetooth: Handle active scan case
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
index d943ad2885aa0..172ccbf4f0cd2 100644
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


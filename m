Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABBCC43463
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 04:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9062A20888
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 04:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJuzUxiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIUEXf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 00:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgIUEX2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 00:23:28 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF826C0613CF
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2020 21:23:28 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a16so7811806pfk.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2020 21:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KBETbgHJRtwnWH3QRJ6V38Ec73b7Ro5YQIkQRswxAOg=;
        b=tJuzUxiw1SA9quuoXjslcjTek27JhLsC98t22DS3rNXHxHyfi9QHtNqsTtmZebk5e2
         /HWmclAyu8Ro01J4F3vQdTRr8Jf0YA64+XmaMQB+6hfU3cc2wD9YLcjdKkrHWZtG14JI
         IBs7U/3kpXNKUjzQ2sW1NLMHCSYlWvjI07HWDrMVWOoHrj5yxKVLXalI12rSBb+l7UaP
         R8WdyoYjR8SAWLwBiPluWLb6DbrVE/4OZyh04mOKQEDfBySB9lJ+0lEUZvRElvj0g6Qq
         g2VCB9QK//uRtVAgrUIBlTa4gqWQLqIIygz3Db2uNxtZfm8Oy77jxM6mOenqgIaPRpbP
         sDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KBETbgHJRtwnWH3QRJ6V38Ec73b7Ro5YQIkQRswxAOg=;
        b=ALW3U14sFyL2eiIXghH71krrxscImGJe5WsPxtxslMOjYAIr1ZARNTzVq/5d0DbqZ7
         lPyIqWtfXW5IIKJtgma1SEJHmtfjLzKKhVNDmlXsu9NXAzj1WqLgIJggASWP9hW9lTic
         3lzIDb4SfQ6/If4QBy4kz+OurDy+f9p7z/jeGjJ6bJD1rhyLCseIZNBp/CRHidmv9aVd
         rloH+SJioR2pUN42ZZJAGmSAbG9Qe9OrPEcJuxRAQXIgiw+XYdMY8ypXMrOV7g0wsIh3
         eRhRMb9UWBoEUNsoiY7MFjrC50IrvvjjpCmtvcK7t6nFXHGuERhR09L7F6XwAtxHjQTl
         D1Ig==
X-Gm-Message-State: AOAM532VQln+4kg6YY/nSi/C1C/jB6wtbQRQBC9ya28bJINBWF6YnB5o
        cXAsNlPshXy5BP74vV7R7l76PRgMcpKAJV+SVSnII/ShmUuaDToRMQWtR+wP8Lim008dSWJkx1Q
        47NUL/s/OVapkhkxmN1bG+8kjkxq2IDVKEmJ4FdUfsaRXa7i5RtlUnh14HNWQLUIuhg6HIW/h7A
        lmfZmjQGcKWVo=
X-Google-Smtp-Source: ABdhPJyBY4AJhf1noantDjUICD2bTO6IE5Zw0P4pyRPtpEdk8XdZ3Ir4ib1DpFYqwc56u6U0F6GiYNnFgaIJLfN9hg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:902:a418:b029:d1:e598:4009 with
 SMTP id p24-20020a170902a418b02900d1e5984009mr26109409plq.67.1600662207933;
 Sun, 20 Sep 2020 21:23:27 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:23:07 +0800
In-Reply-To: <20200921122216.v4.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20200921122216.v4.3.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20200921122216.v4.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v4 3/4] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     alainm@chromium.org, mcchou@chromium.org, mmandlik@chromium.orgi,
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
index d9082019b6386..1fcf6736811e4 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3085,8 +3085,10 @@ static int active_scan(struct hci_request *req, unsigned long opt)
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


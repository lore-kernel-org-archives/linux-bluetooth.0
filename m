Return-Path: <SRS0=Q1DV=EF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705B4C5517A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 09:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C2020725
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 09:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyXPfxub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgJ3JIt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 05:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgJ3JIq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 05:08:46 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4828EC0613D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 02:08:46 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id j17so199066qvi.21
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 02:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=d0ULAdnRkpP0tiJ9/bir4TO+qpr79/0IK0rveQZPnt0=;
        b=tyXPfxubkKIRGg/KIZF9G5IRxo7TciRnhlKJPHOrHk1Cp9Y68QDQqneATMSHTq0gyi
         S+QCQc8RTvIudCaw2/UUbd7r/3AntfelNY9TVZr2IWTp5nfAE130BYPLMCmlj/vUV3IV
         Ki/fWMMBnv04KzC/R7VUXYzGtqrsnilkpUNgDLkA+UFnU9t9xL3EJI1TreQGaCDcevIL
         JvNahGyYMCegBP3W99HX8+mVWI405Ion/TuoGLVmULNK+5+ooCXCT4+QgimRdoD9oAcM
         MpdKi5uIDcxTqE4DAHQxc5us2j6Evxz42dS0bpzu8mwaMiY8zEeS3lYJKiYdpHo1ZCQs
         oDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d0ULAdnRkpP0tiJ9/bir4TO+qpr79/0IK0rveQZPnt0=;
        b=iKCnBEwFpvepE7bEyHxG25On3Zz633pu96tjITVQJ6EVQfAONCux64gpm/l+QAXtZF
         SiYIYU5H7AynFckrOqVVD5QmHbDs+Isa4G/J40jOa4kuw2128u2dxzpgEiP1/KAM5s0w
         3MLIikg8AM9ceofaZXUb5reSj7vTJYlJ6uwHefkIgcFN1CGL5AWElNvMQI2Ls0m+SJSN
         v0w4GcCz5DsgsWHzzQUVxXNdw2ntn3FITgofXF5ZwXgFTJ3keqyNXOevczRRaz5V8Fbw
         Fw5cQO5yqNUv6dPlQa8w8JeNPLdgJS6YligfLgXzcWLlvfShOiIv/enM8ePlKZCIIBGu
         T88Q==
X-Gm-Message-State: AOAM532Euyp8P16hyqiiBGwqzcUsYkNawIJzxHtqz+il4p+K6yDOm2KS
        brPSMmofjUolWvOFz0QilvberhpYt/EYoCNzjsi33fEdViYU8ja/B48V7Tw+krnWbJ2Q/8BOybl
        wDFwSBP2TEde5AVjJ63lhpHzoKYbd2VDjGYce/M5lclZ52yplZyNThWGGNh/wGSYtbh3fDdNL4L
        W20kAX/2q41q0=
X-Google-Smtp-Source: ABdhPJwDUShIiCm4ZQ7Be3llx0aPNgpneRGMjPv+gtzuLViB9OtGsiBHu6o1MxIO2GaexnkAgctAPH+ZsNmWAZXjzQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:db13:: with SMTP id
 d19mr7898374qvk.23.1604048925295; Fri, 30 Oct 2020 02:08:45 -0700 (PDT)
Date:   Fri, 30 Oct 2020 17:08:25 +0800
In-Reply-To: <20201030163529.v6.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201030163529.v6.3.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20201030163529.v6.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 3/5] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     alainm@chromium.org, mmandlik@chromium.orgi, mcchou@chromium.org,
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
index b615b981be9d6..396960ef54a13 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3092,8 +3092,10 @@ static int active_scan(struct hci_request *req, unsigned long opt)
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
2.29.1.341.ge80a0c044ae-goog


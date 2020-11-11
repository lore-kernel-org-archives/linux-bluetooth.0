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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87704C388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 07:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C41E20786
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 07:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YgqMMzV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgKKHCy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKKHCu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 02:02:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3BEC0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 23:02:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u37so1433829ybi.15
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 23:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C95huzuAXxK/Q/ur78yeB7NRb6+ErTiDkKW1OinYBEM=;
        b=YgqMMzV72cotIeIOR4rQM3a+Hm8zGJWbl4+4bPGgH87ABhfuYrLJ3ZPmKeUx6+o+jV
         VGrXiP7WDqOqrCQbFayHT9i89gXNvsoxhTn+6gQG8BiQrZTBiwgD4rEP8+JGUvIpwgCI
         SpQNnic1DuDL1Er/u+KIMZaNtF7j8GSx+Bt4A8CWLwtnHtuoD3vNbqwyc7OCw147YRmG
         8rLlMgthgFSKaJ+bYtdfqFJcjIS1N2YB+uTGj/tGgTYHZB65geRiGrPtMqS4phI/xSN3
         P4fhRI89t0CHPkwJXjrk/NUPX83oPVhK3R+QWf4sWKEs+LOkj8vFQDBcJQeYHw+x4blG
         k1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C95huzuAXxK/Q/ur78yeB7NRb6+ErTiDkKW1OinYBEM=;
        b=bRlI/3pkaADCcn4nbSgwSDVZEQTVw0jYSGhP6JHRhMg14/uxYmV2spDjGDoGKlHWXj
         R120PEQIHCITWv4MMiaoQmegWJztZts4yL9ai51v8M0cBbUeEN2hVYbXD54ORuI6FL7p
         GC6T6DgujsKmGiUsDum3SwVEoBAgXkmRkvWddEtGbObCrE7oIPt2DnFy5IRe66PIQq/T
         IeNIsNpWx6uMWv/llal/RyglT9lNYUmw81eE/MGs1/ABb+z1SNLEh8gZ1Q2IH6K1KCif
         vxWaH2fbkhLcTUjQX8nOOA+ynUB7oM1m/fX+sUcAGaRq1odbR0dvL+jmTa0RozmvLT5b
         eOlQ==
X-Gm-Message-State: AOAM533nH0+UrmyHB9x32H6bZxbksGFufIEBR8cc6f1lEDfi3hl9lnPY
        Aqg8NIKEKa0DqF/aDz8un9Xeox4lFRUksRbFNt47gUrMPnQRJ/GTHYtt30AELFVal1VTH4WWRs/
        tKxP9nl/iv5oOAhSCH40Fw7G4ID23Ff849mpBdKou3wYvdZPLVwawh+12Om2aQ8shI8526DDvEL
        zzPrSBj5fJNU8=
X-Google-Smtp-Source: ABdhPJz6FsnPgsGWaQzSUMDb9ruAALlS+KuNe//2KbbYnUGDYkLX+oRQU2x83NNjr8G83RnsyxnVKfvoQH/7laY9RQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:d30a:: with SMTP id
 e10mr74900ybf.196.1605078169043; Tue, 10 Nov 2020 23:02:49 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:02:22 +0800
In-Reply-To: <20201111150115.v9.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
Message-Id: <20201111150115.v9.4.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20201111150115.v9.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 4/6] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     alainm@chromium.org, mmandlik@chromium.org, mcchou@chromium.org,
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


Return-Path: <SRS0=RRj3=DG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6253C4727C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 12:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EAA12076A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 12:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P0EFlUaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbgI2MWy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Sep 2020 08:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbgI2LfK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Sep 2020 07:35:10 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3DCC0613D7
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 04:25:57 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o28so2386373qkm.23
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 04:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m75O2982+PQQujsmqb8P0g73yWH7B3X1YjQuvuJ3s38=;
        b=P0EFlUaqz03Mx4ll/cRUbZKm0DPRGoRvKrTFutN8HNdiCtTIenEuESdO/ZTFjxPk9U
         vxeM3le0FTQL1YJQgMEEKP8dPph18/mQKGrYdKdJV4cA+vPrfrkVKdzvCpil94w/d4vg
         e2rMbo/SW80jIHb9Pw3J0btcxeW5ovaY1X9UkS0I9TNbMT/1Tv4kW65cBcuCIBKRm7ja
         gySFr6i0waDdV07DPFZmJjaRN2SM6Xio8FaTwqNTtIESERmytHtpu30HPz4wp9wcY+Ua
         tr+W/MKovNUE9PimMT+3XbyOCKXD2VfDpnBJrqgDl0EMYKQhKE7XlJVgbmGa8QP9Q9C1
         0E0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m75O2982+PQQujsmqb8P0g73yWH7B3X1YjQuvuJ3s38=;
        b=iebhZKu9Wmeg3wVfVozon5BnJg/WQkgiHEbY4YXDVMV9XgyK+Vdbb65yvHFY2idtWT
         rB/EVIvDdb92QLxzpTQHwFUUtDyW2ECu4rgpzDGuvOmuh0WS2NeKijWWWh5jpQGNIrjN
         8RT5vdMx7tXwoLKZqhgZnlWQx+sj5v66phpLp7zvak1Wb2weN1v/4qnuDAWRfrh46mz6
         yoUp1/fAnxHjuRC1BE7Nzhbik1qlvp5zNR5eRUyEakaQEaqVGrW+OsAdyKGd9EL10D6x
         Lu01FhCeD3uqBnN5s8i0oYZblpnHdU3HgjuKRpt4VZkY8BVQaYUZ7H5WOs5vBx3HbqGi
         yRCQ==
X-Gm-Message-State: AOAM532pfj0ONPvycgTdjIto2KxoBzyZBorPrDUreUsF8Tk2KgGjoxN2
        GSwZO/riYfdicgVKU1VewCOD6rYLCAdohD4322CZWhqdsq3x4Sv21ooeWPxWMKRQ5MLxjPU3MFF
        kwQPWOIk3mPqeC0AElGYjg4lrgVhPEwLCM+XW9NMbwulmVPCNyKs5s9LgzuICl7t5b+Y7jjh+t9
        e4WFEhooCCEnI=
X-Google-Smtp-Source: ABdhPJwSYEndcvqnyOVxihgzuHG+2ktZR5vXcAP+SWXeCZwLUBigIU9X83j1nNQWDtsbD55xexKgCizCoVS5IjnGsA==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:55ce:: with SMTP id
 bt14mr4131043qvb.2.1601378756257; Tue, 29 Sep 2020 04:25:56 -0700 (PDT)
Date:   Tue, 29 Sep 2020 19:25:25 +0800
In-Reply-To: <20200929192508.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20200929192508.v7.3.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20200929192508.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v7 3/4] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, alainm@chromium.org, mcchou@chromium.org,
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
2.28.0.709.gb0816b6eb0-goog


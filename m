Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE85C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 05:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B072078D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 05:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nrIqOSlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIQFbL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 01:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIQF3y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 01:29:54 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E94C061788
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 22:29:52 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id m186so92720qkf.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iN2CxHeMNgWaifXzqNK0PvVkokPY17tdMHt/mMLio+0=;
        b=nrIqOSlka6gtQA/RNk0dOAyWdFk1JRuotnAsgOi4qPsbqcEhwnvkcHDzjNXMTHchAW
         sXhWyBjoCzGM7UibTywYYwkI62nicmbZaWCAUya0veldw469JT5qps31uB1GnE4+YsJa
         DOFulqEQ8dT5ZWZKc3yRNn1NOq74s7naWuJ4aPOLwf3U3BzhzPIAooWHhCOOrQbZCKRT
         3j3HRkslX5TI4xaHyEh1m7oH+kNkkfB4DApDmjBPY50Uu4cCaskv6LUilb/XAcMOsryw
         Snv+OqzXw9bLaiykWU1qA5fSPqtexYAGSd+FAm/fS1bmjWIxt3mdnhQvVlQKMHu7RdvI
         9wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iN2CxHeMNgWaifXzqNK0PvVkokPY17tdMHt/mMLio+0=;
        b=gRfsTyWWRKh6j3MsRymwBFam9aG+pL/85e4UeF7EMP1s33UWxXGvgO+q33hEe7kTXh
         FfgbpHeKK/daBfjjtJvexYHoM7ihDzIp6XC1YHRpw5MOtey40dlsYIlxcVJy0enOG0Q+
         gDowhO6kojfCzlurYtM5oNFXbWtrhK5V9eqo4BQUP3DNOaMqKd/L6JuFW7GOun09hASy
         A0/klqeJIqs0co51Ys7ulG1A6uAW5fwsG5GBzP4KbCNLG/0Bs5IIh4nNwJ1d1Qwe13Vg
         /IwZWCzbF/IpgVPWxVJWSQNsmfp29FQRDWZrcy8JK3WBhGip9fL5/Hrp7nM1DnXW0boR
         WCiw==
X-Gm-Message-State: AOAM533kGzWPk/drwfWC470ExV13D05/fNdZ3usmV6RkOGJTDNDi74ty
        LTDVl+DYd3RdhLN8BDbJ5bdwvaUumxHZb49ptfjGNMdRx/ipxtL7wW8sIf4zRrI5pEevTlvw/z4
        0jReUKWcD3zyDzd1bApUHn/fcsVF9M7jTHJlOGUj7DxAFoVxDsglH0f/uOnV0tDubjz3Rjnrthx
        vcuprweFR37Mo=
X-Google-Smtp-Source: ABdhPJxh6ZM7nWp+f56ZHzsBJQta1PXhiAYtNC+IKmQct9nghl9r42M5HOw/4ZPapXC7Rh/zWov0/Z9I9u+dwlWNEQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:5006:: with SMTP id
 s6mr10447990qvo.51.1600320591974; Wed, 16 Sep 2020 22:29:51 -0700 (PDT)
Date:   Thu, 17 Sep 2020 13:29:39 +0800
In-Reply-To: <20200917132836.BlueZ.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917132836.BlueZ.2.I8aafface41460f81241717da0498419a533bd165@changeid>
Mime-Version: 1.0
References: <20200917132836.BlueZ.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH 2/6] Bluetooth: Set scan parameters for ADV Monitor
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, marcel@holtmann.org, mmandlik@chromium.org,
        howardchung@google.com, luiz.dentz@gmail.com, alainm@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set scan parameters when there is at least one Advertisement monitor.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 net/bluetooth/hci_request.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 413e3a5aabf54..d2b06f5c93804 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1027,6 +1027,9 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	} else if (hci_is_le_conn_scanning(hdev)) {
 		window = hdev->le_scan_window_connect;
 		interval = hdev->le_scan_int_connect;
+	} else if (hci_is_adv_monitoring(hdev)) {
+		window = hdev->le_scan_window_adv_monitor;
+		interval = hdev->le_scan_int_adv_monitor;
 	} else {
 		window = hdev->le_scan_window;
 		interval = hdev->le_scan_interval;
-- 
2.28.0.618.gf4bc123cb7-goog


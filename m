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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0788C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 08:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4FB21973
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 08:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VU8ABKyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIQIuA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgIQIr1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 04:47:27 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D272C061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 01:47:26 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 60so1103673qtf.21
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 01:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jbS6cNnfIa6p5stK1Reth2jOjANie62zi7bf38pOt7A=;
        b=VU8ABKyVEn1Vi1rt82lQk6xUqNGfYRWs/LonOCMsKotTAWQFAHyIc3lbKvYZpbOPbG
         MLBq1euoqVyrQDSTl1Hn497WOw8rPdkkXdwAPRWLRoO3izaUQ0UjsEBZy0e7IMHQMQwO
         IRMVs+oBTadkQl6tMo4NjAv7adnZrNFsliwjAXXvdoS3ZjEEyXB5LYnmzQG0ysyMOqa6
         OpiqVFGN9mOfW0wyj9iRsAc6gYLNQC3atiD3JNtZgIht32e/aAOSTI4TTSlxkHc6NTVx
         t4DZGgU30FskG66Z23ockLs4ZBISMfw5G8QRp1cWpKjOSB7/Db0YOb6yROSj2czhoPRG
         iDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jbS6cNnfIa6p5stK1Reth2jOjANie62zi7bf38pOt7A=;
        b=gJeaUnWqdVnFta1KzmvmM7TifCeoqroYpqyiDo5+uLacyi/Jvuo+Fgn74sU6n2X98Z
         BSKnZzpINdbotiTYvK1CFqROiHRpLyklupVLrrmaILg1+KHr2zIwGFcRYShVMzVoCoFS
         vvZi2tyc8ImzToitVsZpFA2bkz2f80NncC2BCQYHaKnDiGA7Rrl4AG3RzSITJN7y/8yB
         GgRpeLlP332ZZXPuWQhfioA1KPCZRR5YrXZrwiDvD2veZryWpQ97Af2w1o9eeLx6f2P1
         ACs+ADkbRC+H3l0eoM6opQxJXVlGcc7uQ0k0v91TpjQFJgdgArPr1RJz7zljP4BO6GSu
         p+Mw==
X-Gm-Message-State: AOAM530pA7WnDAVoQjAz6vf8ZRYc+mebT1grJAsJ8F/OppspFan5dsxV
        WiqhuvDoJhWidLKDEBYWUWA9+UOghbIjuZNI0uKeVMHPCH1REcmKhZRhvrhOifWhFZKxjwn5XR9
        tFWhCc3kwXAwC5kvngATP+0HDgkIwtrh32EyItjmoUH4H9ehzXl1qqqEzZ/C/7mQ20LyjS5DTLt
        Woki071xIlb80=
X-Google-Smtp-Source: ABdhPJwTNXeoAZcmFbhFvyRqDwANRZEt20ZmHgLpLRvnL2hVahKmCTmSyY44Xr1VsvT7WQAf5nhMs5ts+tK5asWQow==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a05:6214:14e8:: with SMTP id
 k8mr17144487qvw.19.1600332445243; Thu, 17 Sep 2020 01:47:25 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:47:11 +0800
In-Reply-To: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917164632.BlueZ.v2.2.I8aafface41460f81241717da0498419a533bd165@changeid>
Mime-Version: 1.0
References: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v2 2/6] Bluetooth: Set scan parameters for ADV Monitor
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, mmandlik@chromium.org,
        mcchou@chromium.org, howardchung@google.com, alainm@chromium.org,
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

(no changes since v1)

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


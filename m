Return-Path: <SRS0=PnVy=63=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147FCC2D0FB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 02:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E865E2492C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 May 2020 02:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y1F/Owmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgEMCJp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 May 2020 22:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgEMCJn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 May 2020 22:09:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94F3C05BD09
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 19:09:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so10430843pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 19:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8MeJ34SnvYHzMHHvMnJ7xniPWpeltfCL/1NFcCqodmE=;
        b=Y1F/OwmkgG6a/vJSNdeI/glSNcKRNQhR1ng7pGL2w59MihUJLZYgexQEWUZuyMbmHS
         mFk8UbtWEBPqVMJsNeKFvBtlZ/TxIOMHq68Y2wuKPqG6/AG78hEtZkXw8k/fGwC2k9XT
         EvxSQTcfn3/wAg4QKCrM77pL1R02TQfdm0DJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8MeJ34SnvYHzMHHvMnJ7xniPWpeltfCL/1NFcCqodmE=;
        b=uf7mqr8E/YCw9rZFtAjKt7VLkr+4gnAGLxek2gusprF/4PyZH0x9/lQKVlfrWIGKC9
         C2istqsxFZC9C6JxQvLIoJF/keGP6tI+C7AI8c964qVWiI4vvsQApPE4warI/Q8jckKU
         iWk5ldbw/PuKppt4G3bGjouP2Mfips2nVsiYZhz2bzl0mPaZm8WyDd27IjBCYcmM95J3
         lhbyRqrmX2jqGJhPwSFb0d4eb6io8wmoQvO1gA5oEQD8xDigjXCF6fMToQerJbEDUXUe
         t2cB+qxVKnHG9Puq8SlACapBen8U1fqT6VnVh01rbR+CRtz4XfbcrMckWyxvb2C2J2Gv
         lyhA==
X-Gm-Message-State: AGi0PuYRcLcDIujQ1mWck3TaD3Aj1hokv0e0XA/gDAZslPHs65WdsBs/
        A6gBxAGeLre5YIWKAs3CgummXQ==
X-Google-Smtp-Source: APiQypL5VhmJml8Eed/W5CjePHC1qJ4xGeTRfq/uu6YZm5Sp5R8CkjoREdA/z3nYr6+ZeuAsu5y9zg==
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr32211504pjn.124.1589335783268;
        Tue, 12 May 2020 19:09:43 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id x7sm13456749pfj.122.2020.05.12.19.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 19:09:42 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 2/2] Bluetooth: Modify LE window and interval for suspend
Date:   Tue, 12 May 2020 19:09:33 -0700
Message-Id: <20200512190924.2.Ibdf1535b0d4c63aaf337161a333b419d6d32c364@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513020933.102443-1-abhishekpandit@chromium.org>
References: <20200513020933.102443-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When a device is suspended, it doesn't need to be as responsive to
connection events. Increase the interval to 640ms (creating a duty cycle
of roughly 1.75%) so that passive scanning uses much less power (vs
previous duty cycle of 18.75%). The new window + interval combination
has been tested to work with HID devices (which are currently the only
devices capable of wake up).

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 net/bluetooth/hci_request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index f6870e98faab2..6b45e31432a77 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -35,7 +35,7 @@
 #define HCI_REQ_CANCELED  2
 
 #define LE_SUSPEND_SCAN_WINDOW		0x0012
-#define LE_SUSPEND_SCAN_INTERVAL	0x0060
+#define LE_SUSPEND_SCAN_INTERVAL	0x0400
 
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
 {
-- 
2.26.2.645.ge9eca65c58-goog


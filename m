Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F15C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 07:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C477621548
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 07:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJ6VRbDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgI1Hlg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 03:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgI1Hlf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 03:41:35 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EBAC0613D5
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 00:41:35 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w3so78261qtn.16
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OYN0waWCzIpz4ouqNQwOPc0HvVqV4aulKVgXstFC8pM=;
        b=AJ6VRbDPC7e8smY4eGXu9zYa/IX0MLfCd6bcLc93w842F9ZclCRQhVODpSB3qxUaXS
         3q5zTjxBUavZMzrU21HiiY1Rnqxls24W+X2mg2OEZlSLv8jpaUBB6hz/U7bi5xoBMFTb
         vBfBQB97GAT4qoBrwgPsBFBG5WuuxbRrNX746+CZKMXZogMgWWU5FJlV48QFlfQLAvHm
         vBiC0/c6vDW4ATubViknB0rQzgL9JHhk2FQgBKCNcwapfHzfnHG4yFGzV9R1rBKgSbXi
         F6mOKdaNYV+pWJXtQdfADTJXN4eJI1vHC3IlDk4UgXCvP6HN2aB7mWcXfWVejiT7xF1y
         GbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OYN0waWCzIpz4ouqNQwOPc0HvVqV4aulKVgXstFC8pM=;
        b=fqECim6oYyMxy/aIn+/QKHsZTyshhO+0E2ngqh3iTf9nbcHuaPTaYoHzKEQs1m11J0
         mxkdUuqMtNYDHqZVtg0DAzTksPmgQKN03bQVP4d682JVju13h+SgDIdIv/Mdp/nFfZeJ
         D++Fzi2juHUlbmYSdfh9VCf6v8iLi+yLbCEF9wz4WE8aDQ8Gar6CSW+j27zQZumMI7PS
         j4w7z1bRTMW7ybAZPEg07ERRmeBAVczApd5qUZZqWutkG9CnapEDxPquFEdLw7145epN
         DSOtJInrvGv1K8uIV0ietiDXA3OSDtXpwQ2AtDgIrk+TFbSm1BQ5y9emaYoAvTmkBFtj
         h/mA==
X-Gm-Message-State: AOAM532TyfOaNg5MMU6XlZiI0yKKK+QLcPCvL9y9iE2BxT5u2F/nyH86
        xRHcZfqZ0S8gZnWMoQt5bszOSe9UoE9ESvM6CRN4aafED+x3jq45HT1vhkYAXx2sylVCw/vivsM
        S7ugFBetDjMY7ukLuLenYDKfNfTf6MwJlFb63dg5zT7h0yz0gG5/zuv3IxlHbEnzPTsbYZ/I2Od
        5+BIrUjpAX7C4=
X-Google-Smtp-Source: ABdhPJwYplovwAH/Ggf4KQjk8UPe7L60iiVDgXR97jOVqK4Kkp/p5mkNWmU+paCz80w6qi0LVwevK/2oLluFzxDMcw==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:b343:: with SMTP id
 a3mr10507577qvf.41.1601278894603; Mon, 28 Sep 2020 00:41:34 -0700 (PDT)
Date:   Mon, 28 Sep 2020 15:41:20 +0800
In-Reply-To: <20200928154107.v6.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20200928154107.v6.3.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20200928154107.v6.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v6 3/4] Bluetooth: Handle active scan case
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


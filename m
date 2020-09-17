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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120CAC43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 05:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C975F2078D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 05:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TohQyaKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIQFaI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 01:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgIQFaE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 01:30:04 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A029C061788
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 22:30:04 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id v14so753095qvq.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 22:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=XmWCE7age5UnMwS5JxN69B5KWt/qREsunjUKP7hacM0=;
        b=TohQyaKedV/7Ibhkoc0hUwGYUEX+/BNWsSL89N2gO0v+tE9tqhLwpg6tZeaw4GUbZo
         4HhpI/j7aAxBG2p8cW/hQfog/Kmro0dyRPtJQtGNmyH54sBGaXykSOQGiR/ASZmrz8BF
         tB78F/5HihiYxkviq3wgYXKfaYCMIF+MQqfbpXGGxHWVrp06DGKXlmhcBOx929fO4+VY
         fJ449NLpfNWft19izeqkHXiNKFEvYfZa1hQnlrx2VsjAIbgz1MzSDAimpkHRCDpoC6bK
         ePgoYsCEivmmA6gpPsZYqOuNoETRSoKI10bgfJU+B7xe6W6Huuf2ythSEi2yJIlqmoJr
         Zblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XmWCE7age5UnMwS5JxN69B5KWt/qREsunjUKP7hacM0=;
        b=pClwaY9BskqtjhX3fz5vxiq3PlfC1cFs6eLejk3TGiUp/nOBSfwJG4mCEvjhxozI9T
         cn0HAHhJF4egPwEdHVft9swtpbeKm1n3wNphjFgoYRD7AJp+5t6BULmdWQxHxKi1o3MQ
         mY9ASFsXb+ZN0wCDm0fHU19kJcSROOPZPOLubFaSgl7mvkQYIJ6sVNekVps8IUmc1175
         QLvXGDM1b7tgVyPKUho2u1bIUvEdUkZJJLIcLNvBlZb+aG2tJJ5MrkC0k8rGT9XIcgiF
         JWReJ3YIXEW7HmiDZVNb1P4HAqVsbhHGwINuUjw/48v+mTX6LpN/OExyHtFU23ZMHojc
         9ASg==
X-Gm-Message-State: AOAM533fYcVXuIIJ3PDam/QlCZoJMYkSJhbBz+Eahatl1PsqdVixFq4U
        /zZLIfmP/SV32IL6kQRbit9Wk/yfxw+HFB6sfWuQz3zPG1+Z8YhecPacYZEeuI4ZBkCSjpHHmN3
        7BqydCyFDMUlhDUMWaVYmLM+YyycTh5zejNNmjQ9LXHURpjD+EQgWM2zui7ThcsgwdoMu8WtMy0
        ZO26DXfWPnUIo=
X-Google-Smtp-Source: ABdhPJwtM46x5bZUFvh2+P9WwAGt7EnNMSpRF+abYwADScuXGTd4JUZBu0FtOj7Xlb0a4eiqNhvSTg7TGV+oMTOq8A==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:d848:: with SMTP id
 i8mr27007933qvj.31.1600320603105; Wed, 16 Sep 2020 22:30:03 -0700 (PDT)
Date:   Thu, 17 Sep 2020 13:29:42 +0800
In-Reply-To: <20200917132836.BlueZ.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917132836.BlueZ.5.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20200917132836.BlueZ.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH 5/6] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, marcel@holtmann.org, mmandlik@chromium.org,
        howardchung@google.com, luiz.dentz@gmail.com, alainm@chromium.org,
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
2.28.0.618.gf4bc123cb7-goog


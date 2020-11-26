Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59F2C64E90
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Nov 2020 04:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C838206B7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Nov 2020 04:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iDzWIHl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbgKZEWn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Nov 2020 23:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbgKZEWn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Nov 2020 23:22:43 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37FAC0617A7
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 20:22:42 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id o16so491297qvq.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 20:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=WxTrIWAl1OFz/p2XgGWsNIasHOfXcWw9KdLID5kiGtQ=;
        b=iDzWIHl1TuhMAtKb0aofpkHueZhgS1E6/v9x+eoNx58miDIp0Z84cq//OAbu0i5r2u
         JnuIY6pDQjXAzUqs4xheL7FNk30jmCcT5r9KYxoOrr6GM0guxFl2zQHAvC9rz1Ow3y16
         5ScfKg2hjWKy9+AEg0Y6/pvqODSqNSkJLeKebUy2DIFsgpwB9i9D3Nkyt9iq3k56ijJR
         EoBsH8PD/ZQBOKhsPFJ4D0LUWKkYEDljhmiJkiKPAp0Ex/3XosADhPLUC9FwV/qzIe9z
         DQfV8Lzfk9ToXx9gAIBNnFaUKEgmhZdkYhNDyeIjGIasBPZK8B3S4TSAVvjP/cq5fKR7
         8PxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WxTrIWAl1OFz/p2XgGWsNIasHOfXcWw9KdLID5kiGtQ=;
        b=DVXYFqBWl4JmhIzDcTv/TLP687JYAnLu12SXEAUe2gsi2Wr101kvZVTweO0aedD3hh
         VypF64gyIFewwRtl4y5CP47pUZU7Os2WTGf2xynDDg2NRJ/gz0dwTqqYPMpqnpsBNFje
         p561YFIeNLGh/ewOn9zpR2yzJy4FNspRH64TO4Iu+l1T5Lfoqx8zxJ6gF/c134vcKiAw
         +uzK98wwZ6N7PKunnAVCsjX6FReglROomgXrk/irxXTcCZeXSRV7MIpXEjS50tUPgc/r
         2RwssivwuqOwltcUUtj1J9zqoSbrbKQr402LPfNclUAII6FEIzXm3LFhJDhCgqs5pWRp
         wS6A==
X-Gm-Message-State: AOAM532mBMaGIsTCBAPNGrPddVKUaEKeWU74V1eyE5CCdsDoIV96xZQK
        lrtvOQgwRsTrK3ABMnn+uV+SZVKyKDTrK2vExdZHq62Jr7teNV7i6mCV9j/0wBXk40478ebuRUO
        nHygsVSa3kv80xmeoGFgjRHv97QsJhddhzh3Z7Z17YvddhiodAJ+gXDMsFGvNWTI0Zm/gNzahrF
        RA7o6C0s8YLkE=
X-Google-Smtp-Source: ABdhPJwUVfUk18DYNe9QmqdENAlWh1mLcXupvbGPm2Uou1KNtkmBMbu6L00mvd2LvWr6NYW/5xJPgQdrGkYS7jjMbg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:b34a:: with SMTP id
 a10mr1366288qvf.15.1606364561003; Wed, 25 Nov 2020 20:22:41 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:22:23 +0800
In-Reply-To: <20201126122109.v11.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201126122109.v11.3.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20201126122109.v11.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v11 3/5] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     alainm@chromium.org, mcchou@chromium.org, mmandlik@chromium.org,
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
index 8addb94560013..0c326e32e240c 100644
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
2.29.2.454.gaff20da3a2-goog


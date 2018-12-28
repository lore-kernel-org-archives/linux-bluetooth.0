Return-Path: <SRS0=+lf3=PF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A97CC43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 19:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4370520869
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Dec 2018 19:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="aW45K2PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbeL1TyC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:54:02 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:51834 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731742AbeL1TyC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Dec 2018 14:54:02 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 0583091D
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Dec 2018 19:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iox_j0wZqXm5 for <linux-bluetooth@vger.kernel.org>;
        Fri, 28 Dec 2018 13:54:00 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id C7FA37A9
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Dec 2018 13:54:00 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id g7so26255809itg.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Dec 2018 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OOQZ2gUP/hFWYwmXJPBuARknrljj37IHB2B7Qlx9Ggk=;
        b=aW45K2PIL7dj0eKXhxVNkgW8T8gjZ45Y5kbXS47Tl+6mJsOETOmTzjsj1AbXXpIh5y
         7ImbiF8NiAZlA1lLiC7IDOIx3oOQ/g2Kcb/PPiYrScEfkRHex72ZrOYJqWduP6XPO90B
         JHLrJjKTLIMEZCy0FSkQGwMrKElhfO4cHCou27brTxRgMOV0NWIQKo4tzu9E0julkCof
         7RX/lzhLaKiO3z+XlGlL1dPQAydxN6NIcY9PY3/0Ns6MTUGH3GF4cMNA2JlwK5NwpAtI
         uXUAhNN/00Xk1Q2+tPDHo4cVvusayoXjE4vv3x4FBTWg7W1L7kxq3yKnakVyx7YLtKUp
         soOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OOQZ2gUP/hFWYwmXJPBuARknrljj37IHB2B7Qlx9Ggk=;
        b=o1L84Mpc6wxajxXPn2jtNyFgozJz/R5nP3xOV9EvTEQV7Hj67m0olDdp6wkUK+FwD6
         uS23lHVzjFVlyvmCTCok0ZbP2nBKKrPhXJ+4EhP+uWjjd4GlvycMSMWjmz3sBK1Ys3CI
         MVNloMoDeonFMq6uNLEZ0KV6+pI+MvJdfY/ennazxA0a4CMFvqN6vFVe+tdMbIe9h0Pj
         d0TOB0deX8kcOuME9YUEs0iubAz19gUfCN2Wx/roD/05F7H2XWmfysOGJnawKVRM11nJ
         FgK/kbhWUJLCurK9Wy1H5Q8qWYhWGEcEla3zzX4FdfmiynBabAQIx2oxeOwX7jtoIp6b
         MqFw==
X-Gm-Message-State: AA+aEWZ/8mALx2+X+I33imAyMx1amagUsOsmagPY9+q7GW44uWqqelZG
        JgFdzksrjT0H8mL5tuHsB+3leCLs+Jj4eFvsOZYowNOaCqCwlCxBFBiLx5YtfGhaBTz9PfRUPs1
        uiboorkSE90V/xdoralCpFvDTs+9UHTd5
X-Received: by 2002:a24:d12:: with SMTP id 18mr17112162itx.31.1546026840233;
        Fri, 28 Dec 2018 11:54:00 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UVectugpd+Z8lQKCDdq7nqOfv32VdKWC2PxjK9Puw4KDUWVeZSDw/OzU8OS+tbwsrVCXpj7Q==
X-Received: by 2002:a24:d12:: with SMTP id 18mr17112148itx.31.1546026839974;
        Fri, 28 Dec 2018 11:53:59 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id v3sm1992206ioj.79.2018.12.28.11.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 11:53:59 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: hci_intel: Check for driver register failure
Date:   Fri, 28 Dec 2018 13:53:51 -0600
Message-Id: <20181228195351.11009-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

While initializing the driver, the function platform_driver_register can
fail and return an error. Consistent with other invocations, this patch
returns the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/bluetooth/hci_intel.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index f31410526c57..8450389a2017 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1242,7 +1242,11 @@ static struct platform_driver intel_driver = {
 
 int __init intel_init(void)
 {
-	platform_driver_register(&intel_driver);
+	int rc;
+
+	rc = platform_driver_register(&intel_driver);
+	if (rc)
+		return rc;
 
 	return hci_uart_register_proto(&intel_proto);
 }
-- 
2.17.1


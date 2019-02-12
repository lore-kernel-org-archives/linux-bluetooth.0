Return-Path: <SRS0=8P1K=QT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F629C282C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Feb 2019 08:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EEE2184A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Feb 2019 08:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmntlUoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfBLIgx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:36:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45601 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfBLIgw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Feb 2019 03:36:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so945346pls.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Feb 2019 00:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HNWXvEaLYcEHS16vyHBT011Dc3SSM/dSNQsgo4Wfpk0=;
        b=RmntlUoN26+eNXDDKj4vXgjTJY3kqPPtKRI+0s9Nivp5oPWkcHAx8SZRzsyZRnm8hF
         eXc/gVu5JUx4Q//EsXIsWzSrBRNh/83eZULp1tn1vBepjJpFA9idGfLGMOYullm2FqHo
         62E9tvhzwqan3tw3DNWOyrwr1bjOijGvESG3Clfw8fBIyhwzQgfOyddcqE51Gigbrd9y
         lx7GmZLLEqdyJrIALQdskfIcLKtq+xGwJRbbHPrEBABCdu3VMsb4AoBa8KdEUyAgX9kS
         rR5xT9ua3GOHWncgfamuldWDBae+TLiUwiexQQE2oxeqZecdS2baWKZhX/8R2lVpLfK1
         lPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HNWXvEaLYcEHS16vyHBT011Dc3SSM/dSNQsgo4Wfpk0=;
        b=puCLEVprrQHW8UlwNxvHxSisQdjqYOwLSUHnlru+sDQbiUhIV6kRRSyewAmCnK4uIU
         HTcCgL01gg+M+KVcyU2NJK8Qz6pUxEbsa9dyhAdWeP84nqtmHzsmrMMsHCF4BnfU4QgT
         tB8UC5/lhr3M+FzEfDzxVVqG9fgtjQ70IpaE7CDu0or+4C9p1L8mRggoQeJbt03BOYeW
         MJ/w3Wf9UnwEn2MNUBvvZWoTGBERwpCP8CGWTJSTEzFhqwAH+s/qYBquwYkzPSvOTVek
         jw5p1d5y/vx2asZ49HWF0A1TG030nZPEuzSaaYbwz0/iRg/G3qqVUYi7AqVh57M/Ui7A
         egog==
X-Gm-Message-State: AHQUAuYZi4APZpIo5XmTXakcDgoDldXJt1JNkLt7p++OPS524suaohqg
        8suJmPrXOvUBO9/OYQ5bJuR7fIUj
X-Google-Smtp-Source: AHgI3IYTRrFFTbhhTvUrJLJVHZjLbmOvDZB/AUBNgF+d5SSmuLTZQYKB2BtyMl49Jf9XNbPyl5+sOw==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4mr2870162pls.5.1549960612144;
        Tue, 12 Feb 2019 00:36:52 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id c18sm7465741pfc.63.2019.02.12.00.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 00:36:51 -0800 (PST)
Date:   Tue, 12 Feb 2019 00:36:49 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: hci_ldisc: Add NULL check for tiocmget() and
 tiocmset()
Message-ID: <20190212083645.GA7055@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tiocmget() and tiocmset() operations are optional and some tty drivers
like pty miss the operations. H4 spec requires the operations to set
flow control. Return -EOPNOTSUPP in hci_uart_tty_open() if the oprations
are not supported.

Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
Changes in v2:
  - Add NULL check and return error in ath_setup() instead of
    ath_hci_uart_work()
  - Remove braces in if statment

Changes in v3:
  - Fix to return -ENODEV
  - Split into 2 patches
  - Add stable CC and fixes tags

Changes in v4:
  - Return error in hci_uart_tty_open()

 drivers/bluetooth/hci_ldisc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..3b1e433aa35b 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -474,10 +474,11 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 
 	BT_DBG("tty %p", tty);
 
-	/* Error if the tty has no write op instead of leaving an exploitable
-	 * hole
+	/* Error if the tty has no write or tiocmget or tiocmset op instead of
+	 * leaving an exploitable hole
 	 */
-	if (tty->ops->write == NULL)
+	if (tty->ops->write == NULL || tty->ops->tiocmget == NULL ||
+	    tty->ops->tiocmset == NULL)
 		return -EOPNOTSUPP;
 
 	hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL);
-- 
2.17.1


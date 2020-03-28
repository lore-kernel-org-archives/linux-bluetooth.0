Return-Path: <SRS0=vtF+=5N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB2CC43331
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Mar 2020 00:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC072076B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Mar 2020 00:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CikuszFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgC1Aes (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:34:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39953 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgC1Aes (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 20:34:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so4101867plk.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 17:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UbLv58JbPZxhtNFgATo8vniurV6oOws6JszXEjaMpmE=;
        b=CikuszFVXSEMr2V+pG0C2CKNOoHoLbiEWQRhJjrT86g42Gpg9bK4OenhRL5mX1ef3r
         ZjZphmIshyuS6WwAeI2Z8pPr9LQxnqwSgFLs4/SxiCjlbPmiELMERflBTQpgsWNX4lk0
         LjFVG/IzSOpOKJqaqG+RBCTYWEfvAuu28eYWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UbLv58JbPZxhtNFgATo8vniurV6oOws6JszXEjaMpmE=;
        b=Wi00XPTN7g4tH/YqorALzBAXHnyeV4js9feDG+cLBYkprcEdCtASAw2bE5D+Pi/OKC
         LoHp+dJHzZi7FRl02sb3MEIUwuoOmOin/z3dGg2Rn4I2NqqF+BpxhQf7EsB+9pjrPO3W
         +x+C78bDi8GMBH3oaJjpulzixZI5o9JRn61/DuqT0qAdf5YacE+kSMve2QscCqciaCIa
         tbfrka7Awnd8UvyMkh4YWMY91kBD0mAosDzBQlrSmmCeAzjPjoY7pSkWPQXnMhMh7jiB
         30WWXz4BtGQhK0LG5jb1o8qUlyg02Oje+GMOK7C67fDTJt81flnDkPZDsLTtlWYqbDCB
         QCvA==
X-Gm-Message-State: ANhLgQ3t1VKkAkSKxLgE3kNcclNVhisjBLK9LJ3Dxx70DiX+PIBpzvGD
        u2ksnbUI5oTSNLrxRw3IItcnuTFRSlc=
X-Google-Smtp-Source: ADFU+vs3Y2h1AUo9K1alhtYv7x0lz44wHZd3n400/WWUAr7NTidZOJL4so+V4ENXAIb15WisXO0SFA==
X-Received: by 2002:a17:90a:f305:: with SMTP id ca5mr2085383pjb.75.1585355686628;
        Fri, 27 Mar 2020 17:34:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id l18sm1280264pgc.26.2020.03.27.17.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:34:46 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@gmail.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH] Bluetooth: Always request for user confirmation for Just Works
Date:   Fri, 27 Mar 2020 17:34:23 -0700
Message-Id: <20200328003423.14079-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sonny Sasaka <sonnysasaka@gmail.com>

To improve security, always give the user-space daemon a chance to
accept or reject a Just Works pairing (LE). The daemon may decide to
auto-accept based on the user's intent.

Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
---
 net/bluetooth/smp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1476a91ce935..d0b695ee49f6 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -855,6 +855,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	struct smp_chan *smp = chan->data;
 	u32 passkey = 0;
 	int ret = 0;
+	int err;
 
 	/* Initialize key for JUST WORKS */
 	memset(smp->tk, 0, sizeof(smp->tk));
@@ -883,9 +884,16 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 	    hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT)
 		smp->method = JUST_WORKS;
 
-	/* If Just Works, Continue with Zero TK */
+	/* If Just Works, Continue with Zero TK and ask user-space for
+	 * confirmation */
 	if (smp->method == JUST_WORKS) {
-		set_bit(SMP_FLAG_TK_VALID, &smp->flags);
+		err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
+						hcon->type,
+						hcon->dst_type,
+						passkey, 1);
+		if (err)
+			return SMP_UNSPECIFIED;
+		set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
 		return 0;
 	}
 
-- 
2.17.1


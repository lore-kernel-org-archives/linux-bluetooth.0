Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB4C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Dec 2020 03:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964A621D95
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Dec 2020 03:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgL0DOC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Dec 2020 22:14:02 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:44531 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbgL0DOC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Dec 2020 22:14:02 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 6052F864
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Dec 2020 22:12:56 -0500 (EST)
Received: from imap6 ([10.202.2.56])
  by compute2.internal (MEProxy); Sat, 26 Dec 2020 22:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm2; bh=Sqg6xhuI3FJYBvYXktRNdcBtMhsmYgzm99qWgxD7h9c=; b=JwfApTyP
        3x8GJ8BIwLRxJVZJ0XZuSR4b4Of+u8+y48VQw4CMQUnY7m/Dj8V59XNZuiWg7gPL
        1khoyWRJ8IVfVBONCK/AzPz9Djov1i0fJ+pX5T9z/WuihNvs4iGmWyY+84LZf0sP
        1UGVXzM4BQxR02V0CFJ46vmk/hgHor1esXQQ4bQS1ocegnjmg7OrJKUiJDfzGpj5
        kSw6Btpo4UHcOHTjBPOXgMd3UJBh7qUvNs3HLlUnc8iYLm3IUsPeGEe91nGFRsKg
        2zjfexfJy6mUAg7VFjdejfwaeh/oHUXGyBbBJIBDCk9ZVmGoXr5zYMitPFeV+UPV
        sNuxwzCoIwPpkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=Sqg6xhuI3FJYBvYXktRNdcBtMhsmY
        gzm99qWgxD7h9c=; b=SHtHYeb5EnpYBkgbu3kpq1fOgVy1UAomAK9yp585P1EA1
        +2mtnuteyWy3a/OkYzmffuLm39ZwbXCNKcpBxhDtr/7ds3p0HPO7U7cX1g3035x8
        4BMZvd/IF1LBNXJcDZa+lOipbGnsoDEt7ay4XxqLLE4ytHT2lAncgawROcDMgecj
        igVil/dh4FzWfWG3xpYUDw3fsX3tG712ZTMyIX1B4j4eNUwFLP6d5cROQGnkDLZE
        U78qmdeTpEqTarQkJXfziIJRIhCsrRGLHR/dj0xJf2ouys9gW6fLqA3qi2MSXYXW
        m1Kq0Zf/NG3MdfJJQKyC0pymKOgI7LQFkay2jk0vA==
X-ME-Sender: <xms:t_vnX1TFuPh5uQfzR-xT7GwkBFtvMNs7fy0qICTkDmtzroCFw-GWXA>
    <xme:t_vnX-yYW_GYds5KTOaC0wGHwV9xF3h2FNvD0f6Z6z0luV9NdWLUslAfjTzTxKXYY
    y5E1XkBUCgxavjVMuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdduiedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfvehhrhhishhtohhphhgvrhcuhghilhhlihgrmhcuufhnohif
    hhhilhhlfdcuoegthhhrihhssehkohguvgehgedrnhgvtheqnecuggftrfgrthhtvghrnh
    epleduvddtteduhedvuefhhfehkeetlefhjeefvddtffdugfeikedtueetgeffgfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrhhish
    eskhhouggvheegrdhnvght
X-ME-Proxy: <xmx:t_vnX618VKjpyD2GSJ4q9h8_I_85okNYX__iJTgH6xRWd-Bu_HKsjw>
    <xmx:t_vnX9DvW87jLkL1lpkaYzI6AIvH7yTr2DgALsfnf_boDfirSLnsVA>
    <xmx:t_vnX-i_nSa6AGtdV5LQhfZvdwIA6osTnqAq47DkT-r1NPJwkgsQOg>
    <xmx:uPvnX5sG1Q_xN6WKwBLl0_XmI_z7ziWGgQTgvzvEqUPMvwgit7nWBw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0D1731400A1; Sat, 26 Dec 2020 22:13:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.1-61-gb52c239-fm-20201210.001-gb52c2396
Mime-Version: 1.0
Message-Id: <f2e0ca7e-4ffa-4e39-bd46-e0f70d23567e@www.fastmail.com>
Date:   Sat, 26 Dec 2020 19:12:32 -0800
From:   "Christopher William Snowhill" <chris@kode54.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix initializing response id after clearing struct
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Looks like this was missed when patching the source to clear the structures throughout, causing this one instance to clear the struct after the response id is assigned.

This is in regard to Message ID <20200806181714.3216076-1-luiz.dentz@gmail.com>,
subject: [PATCH 1/4] Bluetooth: A2MP: Fix not initializing all members

I must apologize for not noticing this sooner, as I remember reading the articles linking to this patch several months ago. Either it slipped my mind, or I failed to notice it then. Apparently, nobody else noticed it, either, so I guess it's just not that obvious.

---
 net/bluetooth/a2mp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index da7fd7c8c2dc0..7a1e0b785f459 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -381,10 +381,11 @@ static int a2mp_getampassoc_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	hdev = hci_dev_get(req->id);
 	if (!hdev || hdev->amp_type == AMP_TYPE_BREDR || tmp) {
 		struct a2mp_amp_assoc_rsp rsp;
-		rsp.id = req->id;
 
 		memset(&rsp, 0, sizeof(rsp));
 
+		rsp.id = req->id;
+
 		if (tmp) {
 			rsp.status = A2MP_STATUS_COLLISION_OCCURED;
 			amp_mgr_put(tmp);

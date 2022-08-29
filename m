Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737D7ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 20:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiH2Ubk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiH2Ubi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 16:31:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C122A85FDB
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 13:31:36 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2A4AE6601EFC
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 21:31:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661805095;
        bh=RV22VPkuxsue9tUo9epYMtrLQw3X95030umtA9KVT40=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=N8GRWxxVJ0IlHCPo4/sXc0oWYdmOGjIhu2CqQWYIxSYQOlmfA0upD0gs3TeDTxguE
         BLw1ZYP3g9kWvpsXPvZJFYIH/BQMKh9jC6/l0MHz0C+Iz7yDwOuIr+7K4TrZ2a63x6
         DUc8cri+wfxagywClO6c2vl6PPwFWhgTpjsZPTnIylsDhpJV9udD42w/mPrMVvfQCS
         7xL17/PIteCFS+llzUw5BT4UyI7M/16O+2U1S1P7TQtwp7BICG6qlvtzM+0eSFduRf
         QM09xP5WcT6cwSUqQQ9woI50LbgLJWSKTNmp4p8bjxx3NEnPASd5aM5hs1YaqsE6mG
         EfH+gHxxwU1aw==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] doc: Add remote endpoint path to SelectProperties
Date:   Mon, 29 Aug 2022 22:31:22 +0200
Message-Id: <20220829203122.51343-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829203122.51343-1-frederic.danis@collabora.com>
References: <20220829203122.51343-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/media-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 9cd211355..1866ecfcb 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -598,7 +598,7 @@ Methods		void SetConfiguration(object transport, dict properties)
 			configuration since on success the configuration is
 			send back as parameter of SetConfiguration.
 
-		dict SelectProperties(dict properties)
+		dict SelectProperties(object remote_endpoint, dict properties)
 
 			Select preferable properties from the supported
 			properties. Refer to SetConfiguration for the list of
-- 
2.25.1


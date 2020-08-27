Return-Path: <SRS0=2B3h=CF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E9FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 15:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296D62080C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 15:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edef.eu header.i=@edef.eu header.b="Kyfc+NSA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="snMo+noG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgH0PRa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:17:30 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36983 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728662AbgH0LgZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Aug 2020 07:36:25 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 359865C02A7;
        Thu, 27 Aug 2020 07:28:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 27 Aug 2020 07:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edef.eu; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=PVXMaRT6s2xDNwONmZIZUhlBy1
        bqQ2JglZRPiGhzxk8=; b=Kyfc+NSAbbS14HQfQt68QDI/yH3ZtIFafXK+nDYWJ/
        uC79vCJ2l0q6NAqkwABGTZyQ6K6fKBfK5L6D1tRP4LVezg9ZX91SHoh5D33+IhZ7
        P8X7RaEBiJb2usf7E7IFEjMyBJ/GhC/anwox+ZA8CqIECLt/jkW2jupfxxKK396x
        JBlYMyqRk955J8UtAGnSkvBN7wufR76AhrtRWexaU5CTwZH9OeP/z/S0X3/Q/ARr
        iSrFevxsXR4V28gaU+2AUA10r7sMsb6ztZxPgrHxUE1eZX9rswHDIGcu7HnbJplQ
        b85VRvJhBtPYR4ojVKDmfUXnlFTYhDSZDuN2ulo1saTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PVXMaRT6s2xDNwONm
        ZIZUhlBy1bqQ2JglZRPiGhzxk8=; b=snMo+noGKVMj9zRqhzfPUKj9RHX5+hIVO
        Ij5hLRy2XliAjy6ziceb5p7yxtDFl60ZIUVGtQZXgRLuKOuZMfFb9zhqrXOlDQJZ
        N/fx0OGcKTK466q3l92IatNvxjzj6q/TTI/oYi83rTh3+9ys70Wajj8ksGMhPBEP
        /nvpbmoYyHS58C3rYb9gI5lTn5u839hju+HBfkuhvf/eOon/b1YXPJMyVKjUf9Ra
        4egfHLJhVtFVhhFDMRc2QgbbZYqUgUgulYLjeYg/8TtoL7EbyNgutZ8e3Aqwnf47
        TPoBZ60SkyxAUvdGf/j+AVHKHmNpqMONCtgYuCIhLfgHVdhuDARIw==
X-ME-Sender: <xms:x5hHX0Rkytg3HRSlunxT956KksOp1QdFMiracz2CDdi1uki3smieHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepvgguvghfuceovgguvghfsegvuggvfhdrvghuqeenucggtffrrght
    thgvrhhnpeffteetheefleejveelffefheeiuddtgffhfeejlefhvefhueejuddvgeejfe
    ehudenucfkphepudelhedrvddtuddrvddtiedrudejfeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegvuggvfhesvgguvghfrdgvuh
X-ME-Proxy: <xmx:x5hHXxzl59Jjayv4BrDfcMiJHNUgEpnvwozZtitoMVzTLgIDgZJvcg>
    <xmx:x5hHXx0NxJkgvxjf0zdKEsNBg_FmEFgVrMjCC4j5wPiZ5kbfKIQEFA>
    <xmx:x5hHX4AP4R3jVOn29yEMT9I3aYfIrF2DlFQ-paEyN0s2K84UpZ2O_A>
    <xmx:x5hHX4uTgeweMubJdmK3pc9taN5cuI3NSYAJiKKCHwjpWdGBRQwjLg>
Received: from localhost (uhura.edef.eu [195.201.206.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id C133D30600B4;
        Thu, 27 Aug 2020 07:28:06 -0400 (EDT)
From:   edef <edef@edef.eu>
To:     linux-bluetooth@vger.kernel.org
Cc:     edef <edef@edef.eu>
Subject: [PATCH BlueZ] profiles/network: Log connection event after setting device name
Date:   Thu, 27 Aug 2020 11:27:59 +0000
Message-Id: <20200827112759.6914-1-edef@edef.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Without reordering these two statements, the logs look like this:

    bnep%d connected
    bnep0 disconnected
---
 profiles/network/connection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 97b87d02e..170841de6 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -216,9 +216,9 @@ static void bnep_conn_cb(char *iface, int err, void *data)
 		goto failed;
 	}
 
+	memcpy(nc->dev, iface, sizeof(nc->dev));
 	info("%s connected", nc->dev);
 
-	memcpy(nc->dev, iface, sizeof(nc->dev));
 	btd_service_connecting_complete(nc->service, 0);
 
 	if (nc->connect)
-- 
2.27.0


Return-Path: <SRS0=18cS=PX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168ECC43444
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D362D20868
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUDwydyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfAOOMb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:12:31 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:34200 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfAOOMb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jan 2019 09:12:31 -0500
Received: by mail-qt1-f179.google.com with SMTP id r14so3097660qtp.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jan 2019 06:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=+WtCu0rsyZy4nM8CNOMdSd/tCuGs86sGScNx81ACbjI=;
        b=vUDwydyxti/WUajxdDa7eClfR7LRPQ8/Z/xMMOqxuxMy35A3vcdwBg5FjKjIsd2nLC
         7HlfqLXmz2QKKhpg2+fNcAom25VXdZSBu7Y/HOGw3btp8Gj6RjJHULbgBkueyaen9GaO
         3jEpt8z0IOYuqFeVuija1Y0vr72VS/X3Gp4lW/lwsTn+thJe9jFbj5Me0sBjLfJpl0RS
         iK+bS9PnV/Dmzb6sqTOq/IgJGYRPYWV2Rub2yTpxHU7oxj5Ifz1noOddyDHXlR8qddYF
         tNLt3tv8PmW4KubqkWsdPjMVGFQxuUZBrCekx78A7JgodJHmNduneTT7KHyGuiKhbu0s
         rmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=+WtCu0rsyZy4nM8CNOMdSd/tCuGs86sGScNx81ACbjI=;
        b=eRhrVLYVff1DKh3T/wxkXydNT2ORm9siBALc2TCpnEFkmvem9gTjjOzBMHcRFFVDNq
         pQOY+K8WcG6WPC6d25EAI7UAVthU0y5jifGb00J1rAn08nLQfN5eMDY34SWgZYI1T8Bs
         1/3VvuISdlTPbPVphntynFn3uvQAcV6Kiuz4LOtVhtGfgWD59tc0D/pIphumRi0sKfDu
         1SxcgylmF5KwUXf5vfPNVtZ7qwC6RDRa+ovY/wr9BCDHQlszbp+BIRaILcWfyd8EHP/J
         xqjhE28fA7XPf4t3pSkydM81rb9Ux+Kht3EMr+iLXvHFzVLj5eyeLukh4AnRh+5wWDy8
         atlA==
X-Gm-Message-State: AJcUukdxl4ZGR0DWNIhebZeI5PPdCgNKuqs2cw43Q6uSbVQKZsTuy2Lu
        D4Kiger0C9hhZ3O4ProMADDAlieeAms=
X-Google-Smtp-Source: ALg8bN6aH/Yb/6MWuNqtIs7/tnW0Aw8D1lj/mJM30aLGtoCRKWcjH1dQe+EbcRmwr856EU+yevppQw==
X-Received: by 2002:a0c:e84f:: with SMTP id l15mr3019170qvo.124.1547561549936;
        Tue, 15 Jan 2019 06:12:29 -0800 (PST)
Received: from localhost.localdomain ([186.206.5.228])
        by smtp.gmail.com with ESMTPSA id l95sm10572580qkh.37.2019.01.15.06.12.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 06:12:29 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/8] doc/media-api: Add Endpoint property to MediaTransport
Date:   Tue, 15 Jan 2019 11:10:18 -0300
Message-Id: <20190115141023.353-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190115141023.353-1-luiz.dentz@gmail.com>
References: <20190115141023.353-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Adds endpoint object to MediaTransport so application can resolve which
MediaEndpoint is in use.
---
 doc/media-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index af9485342..292e9034c 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -627,3 +627,8 @@ Properties	object Device [readonly]
 			acquired by the sender.
 
 			Possible Values: 0-127
+
+		object Endpoint [readonly, optional, experimental]
+
+			Endpoint object which the transport is associated
+			with.
-- 
2.17.2


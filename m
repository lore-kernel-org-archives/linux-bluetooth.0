Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F77CD13CF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Sep 2023 16:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjIQQvQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Sep 2023 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbjIQQu5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Sep 2023 12:50:57 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B99130
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Sep 2023 09:50:51 -0700 (PDT)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9FB223F12B
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Sep 2023 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694969449;
        bh=wiPP/+sLlBW7UQ8BhhWHT0gdAxh4k9m2TY1B9Jy8qYI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=iMdgVUOEzh1NC6y1KxA/hsrDMke8NpSOn13fTacDQ7hJfLqbY/duuevJBigD0ufsC
         EIDzJfX+Suf/K0iXBTeXRAwVPGAB1V1w/9PKOhFZ63Cm1q9HJOkKzAS7XLsNqdmesZ
         cUbrotDiIWBNFCYkfMd2j/uCnRVHy12p72TJAR389+YIGoivAzO2qECorCnwlFZ2wS
         hMS7Yflepnf00yK0rl6+FAcLWjQ+sTd7tIpNjIia967Indv4gqWyukuJ7e2iUakqla
         fX8XalsyrvYTxkVu8yFn6BIhV+oa7M/xY1BrFZDr9OtmfEAUuWN/6SSYRzWbsyNuR5
         bsbmVCamHGIaQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c43334badcso17620335ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Sep 2023 09:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694969447; x=1695574247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiPP/+sLlBW7UQ8BhhWHT0gdAxh4k9m2TY1B9Jy8qYI=;
        b=Wa0BIEmPmqsgqdonEJzS7stjB6QDchLKbF7d4dBgBTWuk7cFk70bJUKTRiEzOaaezx
         EiWdaL81wIa8xr99+0I5m4dAFZZUsBY5ku9dIoxU6qicp+OOGQQWL6E+tN7c8O1h6Xqy
         SU14WQq4C5faRY1AmIZJi6FZIHxra+Rhchn2/shB/nW0LLDFtwc72xErNCRUJATd6IsB
         IHVs6r6H8/QyIDixS8FjPluFtmh/LI8AsrpU8nrVkbHkbVtGKQmLqgtqxs1nI4qgS/l4
         6kpzP7wbgFKJYUkdw8IBWTQ8GOJz2nlKnCdv/gE3FNw2vtRbgPCxICi17YDEUiyvVsgp
         PJow==
X-Gm-Message-State: AOJu0Yy9A1tR6HaE/F3UC7pg/R9bCWbjzVaABuWloZ380ySYXISvpgz7
        z2N3xw+5FEA/fZ1QTgRqWZk0ocz16rXwUhmRVjtc72m9V3minLtBm+rzx9Llmms+T2mqaBYvqhZ
        91g5Swzfs+XT5yxOjj2V8QMxEkv9bF8FLKw5DOqSshwMTgy5LvaP6Kw==
X-Received: by 2002:a17:903:120e:b0:1c1:fe97:bf34 with SMTP id l14-20020a170903120e00b001c1fe97bf34mr7235760plh.24.1694969447655;
        Sun, 17 Sep 2023 09:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCN260wHbjGkeAjUp4XD/1pgmGwMvAha78BBJK8WmjjBdJK9eI4OBzSi0r5ZjI3Yfh/B/ILg==
X-Received: by 2002:a17:903:120e:b0:1c1:fe97:bf34 with SMTP id l14-20020a170903120e00b001c1fe97bf34mr7235752plh.24.1694969447279;
        Sun, 17 Sep 2023 09:50:47 -0700 (PDT)
Received: from canonical.com (125-228-206-109.hinet-ip.hinet.net. [125.228.206.109])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b001a5fccab02dsm1724124plc.177.2023.09.17.09.50.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 09:50:46 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] configure.ac: Add enable_btpclient and enable_mesh for internal ELL
Date:   Mon, 18 Sep 2023 00:50:44 +0800
Message-Id: <20230917165044.40310-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

when enable_external_ell is not specified, confiugre doesn't not check
if enable_btpclient and enable_mesh are enabled.
this causes the internal ELL must be installed.

Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 4186c3792..9897d36d6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -301,7 +301,8 @@ if (test "${enable_external_ell}" = "yes"); then
 	AC_SUBST(ELL_CFLAGS)
 	AC_SUBST(ELL_LIBS)
 fi
-if (test "${enable_external_ell}" != "yes"); then
+if (test "${enable_external_ell}" != "yes" &&
+		(test "${enable_btpclient}" = "yes" && test "${enable_mesh}" = "yes")); then
 	if (test ! -f ${srcdir}/ell/ell.h) &&
 			(test ! -f ${srcdir}/../ell/ell/ell.h); then
 				AC_MSG_ERROR(ELL source is required or use --enable-external-ell)
-- 
2.34.1


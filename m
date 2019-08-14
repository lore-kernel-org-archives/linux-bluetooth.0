Return-Path: <SRS0=WtLI=WK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59E6C433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 23:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A9C2067D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 23:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htUHwqMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfHNXCP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Aug 2019 19:02:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35157 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHNXCO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Aug 2019 19:02:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn20so286224plb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2019 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mGYxd3S8YkNP1exy8vet13fjskHFwmmFJfDN2Nk9sE=;
        b=htUHwqMHAKddBhR1EmzWYayviC7mn0Pret0IxJClraxh/eGUlTMWHr2BCPQdtPyt0+
         QaX7Ty97Ov9AnmAv+l4+nQ9BNr4pcl06Y/3QJ5CjTPMDJAZ/0rCxkZbBKCuj+xu0R5AX
         X78IaaEjFI6OTAnl3Z82JR3Ad35beUjhR2M00g+ooQf0NR5Hrg/QAp8/MLB8fjutpaiX
         nKnGdnENBjyP26nSm81jSAzou6emxZSCnZAxSfr3E1AYt4gMX876GveuPGACfVl2cEFo
         YFSELyL4TxFlimXQzjThm485gm6EfvjyOUNMqGlmBw2nm/Qm+FSM25MnO41bjZyG4VhX
         CoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mGYxd3S8YkNP1exy8vet13fjskHFwmmFJfDN2Nk9sE=;
        b=ZgIKhtf4UkClaikgVABXGYfXKulflNYv0j8mm2qw9oidOYd+Vb1lJwc0tTmzzgM5/P
         X7k3GRXWcsnqCbddF2HkP/bCCRGU3rHGJeomwE/oL48W3esh/5c67ukjX+vUpqlyd7WN
         4/sKgBte2HNAK3K1XgQMppDp2D7AT7RHbEMLGeNSV4H+Kn6nwLTE+/LocKH9lgzuefKn
         p4rccuDvfez/ncD9FReModrvsjUG6UVUTU74E1uk2EEz32k0jlW71X0RW/VrONk3rJ0j
         4ou/9ohMcGGXF4ZMAyMl21ZFgOs4DKzHPmHscTUHBAnPxOPNRzJGsHOr1YuYchfCAIG6
         XBXQ==
X-Gm-Message-State: APjAAAXwDZ5NSihf36HLOa2sQXjI4nXyWGicEphzIiK0bRQLCq4exgmP
        XvaJG7NXNrlKMDIcAiUypwQGyxA=
X-Google-Smtp-Source: APXvYqzabXi12YYhQ+UtdgK3TnZpb95u+dMrcBvO0u/O3KxZp145cnSxzo5ZzcM0ZrfgzCi9p70wxA==
X-Received: by 2002:a17:902:b582:: with SMTP id a2mr1599557pls.199.1565823733859;
        Wed, 14 Aug 2019 16:02:13 -0700 (PDT)
Received: from rxps.home ([2600:8800:1e00:242:6d22:761b:1bb6:6636])
        by smtp.gmail.com with ESMTPSA id y128sm680491pgy.41.2019.08.14.16.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 16:02:13 -0700 (PDT)
From:   Ronan Pigott <rpigott314@gmail.com>
X-Google-Original-From: Ronan Pigott
To:     linux-bluetooth@vger.kernel.org
Cc:     Ronan Pigott <rpigott@berkeley.edu>
Subject: [PATCH BlueZ] shared/shell: fix help message typo
Date:   Wed, 14 Aug 2019 16:00:34 -0700
Message-Id: <20190814230034.15031-1-rpigott@berkeley.edu>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ronan Pigott <rpigott@berkeley.edu>

---
 src/shared/shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index eac654f40..df621295f 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -267,7 +267,7 @@ static const struct bt_shell_menu_entry default_menu[] = {
 	{ "help",         NULL,       cmd_help,
 					"Display help about this program" },
 	{ "export",       NULL,       cmd_export,
-						"Print evironment variables" },
+						"Print environment variables" },
 	{ }
 };
 
-- 
2.22.0


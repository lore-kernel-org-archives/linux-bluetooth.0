Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31F8C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 17:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E37D2073B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 17:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lchnPL+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgC3RaL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:30:11 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:37681 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgC3RaK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 13:30:10 -0400
Received: by mail-pj1-f54.google.com with SMTP id o12so7638904pjs.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcgX10IMjasbu9SeGerAcxdZgAY6e3lxYPxIWKq63SM=;
        b=lchnPL+MbEc2s//Nzm4JRQrUKyo5H6abjRZ47o+j6rf06hlgQ0rVHxM46I2Bch9uVy
         WReFdJw9jzNlWswWIcYBbRB/wvbS2wAodgLTHpBk+09hhNhXpzhBMqzOWk8Gu3R1PNGW
         jS4f6xaZ/6rGZLJn8HST2LxbvzebL00yO/2v6n+tgzdHrdUToaJBjANCyi6iLR7Ir8VF
         NKOLO0Z0Akb0os8+4647AsQOR/LGbpVZtnGIXSJJ3L6w4ykH8+us4Cg0SFdTgC5GJFU2
         AS6moaSF1d0XvZxpdhhKHTdv7E7Xy+5jRyoyzvTgxmsj9qHzTO3XYjXG0/X3nA6C9+jV
         Dcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcgX10IMjasbu9SeGerAcxdZgAY6e3lxYPxIWKq63SM=;
        b=GlsateOhwXTe9f8t5wid/k0gYAc9SwIb/KCk9D8WKiBf1JSPnLR3o3AdLbJw9umD4w
         /rb9EFKDGZ13svdUJHInQ6x6o/4qMeTSqrBb8JgQvuR/VMVb3Sjk+6r9PYn6CRkoM8kk
         C54k7gXS4OMjMqhLpDZjlR91A43d9yRjYuxPhMHzwvLd0VaR2vmc73MTg1MFXpGnwrh5
         MfjXS1uRdoOfYyShqZ6MUrXHMftEc+nOFxfshSiASgzDLntFHxUm3k2af5pg2PfkryhW
         vG/aXDxbs9z3RfjxIFTy+LizCSXk7bzr/FH/DL3aZkhjWIETDsHVq7+dE582I7IXi+sU
         /adA==
X-Gm-Message-State: AGi0Pua1tbaF0bwTU3ULnCS9/iVMdzSBXzUqBOTi6xB/q/WyWsX1ckP+
        yd7Ok31+v6Y97vCxFLoZb05EWLL96aI=
X-Google-Smtp-Source: APiQypIfmee6Iu1A/Je2abVBI38TF3mw9eESPE4CGXLliu8MPGVcZ2X+iEGiuFmy781d7s3SKQ7S2g==
X-Received: by 2002:a17:90a:326f:: with SMTP id k102mr227303pjb.48.1585589407891;
        Mon, 30 Mar 2020 10:30:07 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r8sm115571pjo.22.2020.03.30.10.30.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:30:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] btmgmt: Fix irks command parsing
Date:   Mon, 30 Mar 2020 10:30:05 -0700
Message-Id: <20200330173006.12785-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

btshell does not allow use of nested parameter delimiters.
---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index b1820b41c..37c1c1c9e 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4455,7 +4455,7 @@ static const struct bt_shell_menu main_menu = {
 		cmd_keys,		"Load Link Keys"		},
 	{ "ltks",		NULL,
 		cmd_ltks,		"Load Long Term Keys"		},
-	{ "irks",		"[--local <index>] [--file <file path>]",
+	{ "irks",		"[--local index] [--file file path]",
 		cmd_irks,		"Load Identity Resolving Keys"	},
 	{ "block",		"[-t type] <remote address>",
 		cmd_block,		"Block Device"			},
-- 
2.21.1


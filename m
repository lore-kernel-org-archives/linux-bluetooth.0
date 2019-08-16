Return-Path: <SRS0=GHQ/=WM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19DCC3A59C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 07:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5DB20644
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 07:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="pLOHjUlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfHPHgi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:36:38 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:46115 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfHPHgh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Aug 2019 03:36:37 -0400
Received: by mail-lj1-f177.google.com with SMTP id f9so4425809ljc.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 00:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIXguf7hUWGMVKjT2pOrtaaTy72+sU52wHTmGiolXsk=;
        b=pLOHjUlJJKEEysnbxtMBO7HsyvfnpizdXAeckmLmjwQmhNyJ90+W00Oktd7Uq59On6
         Swm7xPSwMkQ2ksWmXwRHltSF3cLLNOEcR+C8dLQE2dXNV5dTUi9gestMMeBoa+eGNkxJ
         yW3nZWvLAmALf1DlgaG0F0jk38IeWFNaMNgzMdql7Ywy/a5+eoY9B2n+8/u+Qt8/kRNt
         v/JtayJndX/R1o/IRgVsbo3nse+vowfAnmcMvu4l4YwYx7lf82UxzsVlyDTuZdnwYOoz
         qx7dhkwl8Qsjti1mLz2UjO9Roj20dXlBHb1XYYc7KEbZrZsjiY4mFKuuJYFFKR1CsKvp
         0Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EIXguf7hUWGMVKjT2pOrtaaTy72+sU52wHTmGiolXsk=;
        b=G23jnWIA7+Vue09zbzfy79BvQgDh3kM9vNmt7cH5wogoNupFP0Wa4EPLof0ycaTIQh
         eKtZkBlnGEkx49YLB1Au/faDFPkwnFxAiujX7Qj3eNLJiw2ZwodDGthYHhXBUR/iJ5BK
         Fb0eaqHnj9iRF87SM94lNw3awrK0F3JM4Eg5/SbiYxmVB/AFUnyxSxnBbAh2++SMDL0e
         VRbXVk0h3UboBRi48yqdu/UJVPurmtpz1M0NTLhPf3YLxiUWzW2qWwC8KRNKmaOllTsE
         yEtG4JXrPoS3y/xufcjHGpq5EVzWxMxf7wrCShU2q8DplhVBGgvuqiokL4EYZqfIS/pA
         Mz3Q==
X-Gm-Message-State: APjAAAX/JAWK5nqH5WMIixAAya+/vQfjHi950J9jQ/eJxDm32n3cTz5l
        vvOyB63EHPEhuh2EsaM0tHFeay2kOEo=
X-Google-Smtp-Source: APXvYqzrK8sQjEbmjR60B70Mj0YyU/tRrkMVO/25QX+/xM4hpJNtGdWD68By4V6utWoQ5057wfUhKQ==
X-Received: by 2002:a2e:8004:: with SMTP id j4mr4631198ljg.231.1565940994943;
        Fri, 16 Aug 2019 00:36:34 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id t10sm808987lfc.85.2019.08.16.00.36.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 00:36:34 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix handling of Config Relay Set message
Date:   Fri, 16 Aug 2019 09:36:27 +0200
Message-Id: <20190816073627.18123-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/cfgmod-server.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index dbed7e03f..55cc8e9eb 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -872,8 +872,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst, uint16_t unicast,
 
 		count = (pkt[1] >> 5) + 1;
 		interval = ((pkt[1] & 0x1f) + 1) * 10;
-		node_relay_mode_set(node, !!pkt[0], pkt[1]>>5,
-					pkt[1] & 0x1f);
+		node_relay_mode_set(node, !!pkt[0], count, interval);
 		/* Fall Through */
 
 	case OP_CONFIG_RELAY_GET:
-- 
2.19.1


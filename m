Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2265ECCA47C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jun 2022 19:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378459AbiFPT6L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 15:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbiFPT6K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 15:58:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DF92A402
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 12:58:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so2377430pjg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zYbMI0BpEdMu15hoQt6cBSlzn5rY9vTNCM/MaXO5eCk=;
        b=KngWZvASIk1ihgzr6uaIFQE9KQy4SET7rWiAFD4xDneAu09EGigRc3UyPf/NVuojTK
         /z2yYvINOCNE/1bf4DZxmBIbhDN1WHV3IPO7uWuh15Nk3XkWzctj2fMJVQzYplf+/Ed9
         XmoMUVA1smfwUV/K50y5EfB4l9YCCMd+tOC/60wiapqZMqr+howQhJtArGIso+nw/G5a
         xdfu16BdokoYgIyryO1/Pg3y/UMDKtsAlx9B1t42JQz5nqPMDlzvaE3rF5vZjm5OIss4
         sS4BiNTLix83Md9l2P7OK4ZvonTzFTsvEXumDlJtPcuH78192fAGYZDWrmP7U5D4oSaO
         meQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zYbMI0BpEdMu15hoQt6cBSlzn5rY9vTNCM/MaXO5eCk=;
        b=742jBfznm4OJh/dWbgvfAH0a0Rl80JEAPZreE0aFaDU/vRMAsNSHMObir3JxPSzqkv
         LhZQDQ8oFrkUczYRezPTaI4wkckGKeYa+ATQBaPSIV7qiO8NQLXHetsMjI1X0/NY9tkw
         C34jZbQfimFliViXogB4VDZ5DaEJ5OOou8E91cyLxbTkOZkJfhs3wrfnTp8bKcE6RVOR
         PBhOkFZ6/zDXZgwF9CL0sckT9QMFMnKNhDxd4aeX3cNl2wP95uaR5ZTZPfd/9e7sBzHZ
         xTRe+JhcqNK+qcDnqmYqZPBGNzlzUyWRH2o6t14lStIjpkNRA7MZTr+/7xPOcGdw2gEO
         3ZVg==
X-Gm-Message-State: AJIora8+BDohV5K7Shlw7b7xrzfsTsgJ8KzOaLNgjqxDwDSLL8hCRsJB
        nXjwZw1rXG5+WTFlviatwbscA6P/xCU=
X-Google-Smtp-Source: AGRyM1uFBAxz7JACz041MP+QKKkS42KAM8DpB3AVaPS+tyxYZS2TzlN7JpjGEH5EUHUQTUcJoRFoBQ==
X-Received: by 2002:a17:90a:6284:b0:1df:4595:57af with SMTP id d4-20020a17090a628400b001df459557afmr6693943pjj.188.1655409488760;
        Thu, 16 Jun 2022 12:58:08 -0700 (PDT)
Received: from han1-ubuntu-dev.. ([192.102.209.8])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b0016a034ae481sm89285plk.176.2022.06.16.12.58.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 12:58:08 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/3] doc/mgmt-api: Update for Add Extended Advertisement Command
Date:   Thu, 16 Jun 2022 12:58:01 -0700
Message-Id: <20220616195803.99346-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch aligns the input parameter for Add Extended Advertisement
command with actual data struct and add missing flag descriptions.
---
 doc/mgmt-api.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index a429f0ef3..23ea42228 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3593,7 +3593,6 @@ Add Extended Advertising Parameters Command
 	Controller Index:	<controller id>
 	Command Parameters:	Instance (1 Octet)
 				Flags (4 Octets)
-				Params (2 Octets)
 				Duration (2 Octets)
 				Timeout (2 Octets)
 				MinInterval (4 Octets)
@@ -3631,6 +3630,8 @@ Add Extended Advertising Parameters Command
 		7	Secondary Channel with LE 1M
 		8	Secondary Channel with LE 2M
 		9	Secondary Channel with LE Coded
+		10	Indicate tx power can be specified
+		11	Indicate HW supports the advertising offload
 		12	The Duration parameter should be used
 		13	The Timeout parameter should be used
 		14	The Interval parameters should be used
-- 
2.34.1


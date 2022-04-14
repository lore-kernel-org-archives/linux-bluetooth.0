Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B26C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Apr 2022 21:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiDNVzM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Apr 2022 17:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiDNVzL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Apr 2022 17:55:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E566CAB
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 14:52:44 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id md4so6266826pjb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLEXJqoNfhDcSo/m+DEeVXkRQ2EhSwqq6M+G0z4IneI=;
        b=p2A/9a40VntJBaV1frk5lU2xqfTT5Xm48tW/SSkMwJDxRa1ZHlhKuyXHH7ZUDdHyf2
         Xky3xiE8N3kPkUrix/KXoPP/RSyQ/omskrs2Y8lsXIvZDx1NNW4zi9hozeQWAlkpCxnr
         rn2/x5iqBWFEMytP+4Gc+o7OuqQkYaECJIMBJyjzawGIMdYTFT7pdrKQ5+ucON3UH4Le
         nJZQRLNqzX8oUN7Phy4d2N8fxiQhc2B3kVvv/SZ9lF6Q/zmzhCWZzTkTaIMK5l2kv8VF
         Uy2brXiNB8v3iSVSbmQTrepnL0Bgyb2Ron4yWm67+dcMMZbrCXO16wDM6H1Dig8E0vR4
         m/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLEXJqoNfhDcSo/m+DEeVXkRQ2EhSwqq6M+G0z4IneI=;
        b=ztBnS96qMEFmIZvviU8sZOX2oWR6VazwT/TbGTYpP4EgmnQoal6SIHag6MPp1/t2Ee
         8E2Qo4sDxiGawQ/Jxc6bKRtWkqhuTzLny90oO3Dqog1FfdAWLSeOZXzXD6wFteGU44J4
         N4a4h8YsbaITD80vmBdTKVODx6Lc0s6k/LrsY6RL481Jm+4ZGpzhDW6aM1H+ntY8bkY6
         EookofYiIcYPoYikGkWcMwasqnksECY/u1NZ10W19fBMaHClTEaon4pRKdjyxGvCWEB1
         PGf2qR0/sfYxgkqCL6kOrii5yngjgpCUrQpSnZP9gTfDoNgOCEa3awJd3ftB/1mU3lOL
         1fjw==
X-Gm-Message-State: AOAM533U+72xClFcRL3d/Uu6ujfDByR5HsDtQu/ipUidYnmmtP9ikeCC
        OfufFY5RrpjeDa0RcA+q1NDi9gtG2a8=
X-Google-Smtp-Source: ABdhPJx6iHBveccU8KcSpWIwn9ciJmN+g7rAuqmB1myntdQHDDhdw4fGppUxkLt8GuR2w1A3F+2h6A==
X-Received: by 2002:a17:90b:4b0e:b0:1c6:f499:1cc9 with SMTP id lx14-20020a17090b4b0e00b001c6f4991cc9mr635209pjb.133.1649973163357;
        Thu, 14 Apr 2022 14:52:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id bm27-20020a656e9b000000b0039e5d327f78sm2787903pgb.44.2022.04.14.14.52.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 14:52:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Fix bluetooth.service
Date:   Thu, 14 Apr 2022 14:52:42 -0700
Message-Id: <20220414215242.554396-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes bluetooth.service failing to start if statedir has not been
created yet:

bluetooth.service: Failed to set up mount namespacing:
/run/systemd/unit-root/var/lib/bluetooth: No such file or directory

It also removes ReadOnlyPaths since ProtectSystem=full already mounts
the entire filesystem as read-only.

Fixes: https://github.com/bluez/bluez/issues/329
---
 src/bluetooth.service.in | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index f18801866..12adad34f 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -19,8 +19,7 @@ ProtectSystem=full
 PrivateTmp=true
 ProtectKernelTunables=true
 ProtectControlGroups=true
-ReadWritePaths=@statedir@
-ReadOnlyPaths=@confdir@
+ReadWritePaths=-@statedir@
 
 # Execute Mappings
 MemoryDenyWriteExecute=true
-- 
2.35.1


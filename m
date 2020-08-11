Return-Path: <SRS0=5Aiy=BV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6B3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 19:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204A120774
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 19:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="hXSckqYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHKTgM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTgM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 15:36:12 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC83CC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 12:36:11 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id t6so14846937ljk.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QoWUrHUI37BhHrd5gtDXSnBITu53jXT7bzCBrIIvQMQ=;
        b=hXSckqYYbW/UMauC+dL9LeqEubqyEHBZsujHUkFhkul0Kf08u14o7v3IeKbulVMJrX
         T/NgT7HCmuu4jzeNjUMDWXcD0XBjGwTDL+S/rgxz6sCI/0tVxFyha/Fn7V6dwZvMdGT/
         6Po72SUP6r7BBtfJjaAQgJ6EWHirnspR2bNJCBfMNITVrBn0u153X3YVdxgLHWubygJS
         EBIATcrWDGT6gw/K9frCjXLFLQYg8hVEQgVBVSkdfg4L9gG9qb1s35nJQH0mBXegowcv
         /K8ybutcHK8vA62qWr52qIXfHJwJydYQLGThE+HDpE3EMq15JzyQox9WWluGqk+i8VDK
         noKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QoWUrHUI37BhHrd5gtDXSnBITu53jXT7bzCBrIIvQMQ=;
        b=l06Niz8paUaBtcTvLu/iSEjyiMYJGHh3vhlN1cd604cYkB+TfnS8cif+fQ36EvgRiS
         v7WuDxnPDCPlzTotDAp+QSuGOpAvXx7Ihi/dOVbZ4UQaX4fJTKfjGkA11ouiJhL/2nNr
         Yjw9wUnoroCVz+70zxnoRz6PAGQGrqQsLSGQlPqz9ewSzb+PFqcV39A/cK9u21vBT8T+
         DoFb625J/eIRPgWBcJLf40+Gv8vFOalcuEhza/5W0x60i8YUZ9basFfHj8AG7T1SdV0u
         VYN6bZaHoUcUFXSh86RKpKvh2kpSIHzs9N5BLoS7d11UVDBmY04W0EhTul2KVJ2OyORQ
         vCZA==
X-Gm-Message-State: AOAM5323iKx2qNkmkZXESpc7xe+bY6UPAMnnPg8+qws4xtLbkhTTmCY4
        p/dO3fH5wR2n+ggVger8k40yHVZpbohFHA==
X-Google-Smtp-Source: ABdhPJw662+CIO4HcJlF+UZRpi/g2hatb3qS5AECLoYNHiRoGjMtiBgIjq1NnOAB48Cgylua+gJuSw==
X-Received: by 2002:a2e:9dd0:: with SMTP id x16mr3577475ljj.144.1597174567734;
        Tue, 11 Aug 2020 12:36:07 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id c17sm11820674lfr.23.2020.08.11.12.36.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 12:36:06 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix encoding of Config Key Refresh Phase Status
Date:   Tue, 11 Aug 2020 21:37:09 +0200
Message-Id: <20200811193709.27341-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Config Key Refresh Phase Status is 4 octets long (see Mesh Profile
v1.0.1, section 4.3.2.60): 1 octet for status, 2 octets for net key
index, 1 octet for the phase.
---
 mesh/cfgmod-server.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 9da981700..90ebdf046 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -447,11 +447,11 @@ static uint16_t cfg_key_refresh_phase(struct mesh_node *node,
 
 done:
 	msg[n] = status;
-	l_put_le16(idx, msg + n);
-	msg[n + 2] = (status != MESH_STATUS_SUCCESS) ?
+	l_put_le16(idx, &msg[n + 1]);
+	msg[n + 3] = (status != MESH_STATUS_SUCCESS) ?
 						KEY_REFRESH_PHASE_NONE : phase;
 
-	return n + 3;
+	return n + 4;
 }
 
 static uint8_t uint32_to_log(uint32_t value)
-- 
2.20.1


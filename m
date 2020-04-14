Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20320C2BB85
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2CB2072D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="XHwHQtx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437248AbgDNIzx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437215AbgDNIzn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 04:55:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB59C0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 01:55:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id x25so12129990wmc.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 01:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HmN12xntwSzzHYA614R5tce78fEORuWoO5H77KCpCGU=;
        b=XHwHQtx2tBAIW1GgB0FTTQbEoygC09efxYxg//bDODjUE9huD3qW9ArNY3xOI/PHCi
         2G/HWl2W+nIDGEAzeVQozSJ65ZWROv328F/dbN9MS9+rGx/8RunYeKSDpWKirsvIZyxq
         VfgGtiyVhCO4jEMuHo+ed+ejCXguDTDi9oIr78Ap6Yb3IfZ3sIxrM6O6K0UF1tpC+Pnl
         iOYFhZ3dOzMBT+ddE3v6c8nmNnI3IIISbowc8c8e8JqZ62JfUTLZJBuOC5q7tt/FDk4C
         KNKCuBonAqsBl0yZmoZ+P/afiFLvkTYuECtn6YKSP/BlRGc/4O9zRSpZQuvKgoRwCc8X
         126Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HmN12xntwSzzHYA614R5tce78fEORuWoO5H77KCpCGU=;
        b=OIP+9Z4RZehMFNplO68c17Nj6mzYzDAE46lBtbFDf89LlDgO7/J9uyTDmN5evcEUWu
         52W5ozfKLOnQAB453C+nXDS3XQavKdtwcBz9fVaAWnDfqX/3wD5J8CxSQ4kJxYBuEK7R
         foXZrSG96OwAXpEhpW30RrS6LQuj+wXp8m453t5RIiwQJQCn4wKmVNP23pUkSDK8XbsR
         Mevv4J/Qtj/YmiPBlDkGqYuiK9KJvlkPuQgkuepVJc8CV1JZ5I+BpJiVpZZ7ziVmZYXk
         570tHQF6nxVjH8sQ6Jk9+XHIJcmEBUTU+t5FTsb+P5X6FSbEvujUyjGUqiVJbegk9nwt
         v5fg==
X-Gm-Message-State: AGi0PuakeGZ4nYdhUiasdQ5ZW2yKpffMrnsU0l3yYSNGe66DgLpO5O7t
        UyQWoKTXj7OrtCs+UIc7iPamW4lOFig=
X-Google-Smtp-Source: APiQypKYCEloNr4PeEEq649B8BFqONbrBrJQvHQJEMV9QmwO+j4x/3EyATwOoIGPFFVor+NZ3EcJjg==
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr22901245wmg.117.1586854541116;
        Tue, 14 Apr 2020 01:55:41 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w83sm18361553wmb.37.2020.04.14.01.55.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 01:55:40 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 0/4] mesh: Always deliver tokens via JoinComplete
Date:   Tue, 14 Apr 2020 10:55:53 +0200
Message-Id: <20200414085557.23464-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset implements API change discussed in
https://marc.info/?l=linux-bluetooth&m=157660821400352&w=2

v5:
 - Updated wording in doc/mesh-api.txt
 - Rearranged patches to include error checking fix and logs in
   patch #2

v4:
 - Restore original C parameters on the response for dbus
   send_with_reply.  Any parameters can now be "returned" by the App,
   and a NULL message indicates an internally generated time-out

v3:
 - Add distribution independant timeout for JoinComplete() method calls
   such that a 30 second timeout of the call is treated as failure, so
   stale nodes clean up correctly

v2:
 - Fix mesh-cfgclient to send JoinComplete reply before calling Attach

Brian Gix (1):
  mesh: Add Time-outs to critical dbus send-with-replies

Michał Lowas-Rzechonek (1):
  doc/mesh: Change API to deliver tokens via JoinComplete

Przemysław Fierek (2):
  mesh: Change API to deliver tokens via JoinComplete
  tools/mesh-cfgclient: Add waiting for 'JoinComplete'

 doc/mesh-api.txt       | 30 +++++++++-------
 mesh/dbus.c            | 40 ++++++++++++++++++++++
 mesh/dbus.h            |  6 ++++
 mesh/mesh.c            | 68 ++++++++++++++++++++++++++++--------
 tools/mesh-cfgclient.c | 78 +++++++++++++++++++++++++-----------------
 5 files changed, 162 insertions(+), 60 deletions(-)

-- 
2.20.1


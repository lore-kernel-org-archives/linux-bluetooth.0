Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73780C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 19:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344002074F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 19:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Io+r+kCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgDITrn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:47:43 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:45828 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDITrn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 15:47:43 -0400
Received: by mail-lf1-f41.google.com with SMTP id f8so556873lfe.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WDDXwtf+giJRa1B+y+65uUIDepYe+700kgDpZaxbn1U=;
        b=Io+r+kCacCu4j33kNlZGdMnGyY8eTIeiEmNNOgi0wYHGySZ7OmGgZeI3QLhRoyKHEK
         guuPW1OMHgXVF3yvTmEOcjqJKAbp8S0t9D8ZAp5M9j41ge4WFiOQ02XsM4qLwu+Kvj77
         De+1a1TdfPERaYIcjsPNsABM5Prp9UIL3a8i0WaloLbrzqzWb/PPUW8KzQ8+jEGGdkrI
         Vr0mZQulqGrHP2gRgYzP/8psiMfn5QVrPp95Q88HDQm1U8VsJ+W30AnnuOhEcZ/XsZtF
         TmfBsolhjgnXzFaxNOUdXwI/A1PizMQ65vgEdN80bh82+O5ZEDVQemzieDg5pmiivKy/
         eCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WDDXwtf+giJRa1B+y+65uUIDepYe+700kgDpZaxbn1U=;
        b=GbrErBW/NDCsm3rE/RV7C7aEtEBaQu+lb5qKsAnAQVWvmA6uLO3ZANwKTEiq4rIJjO
         nUDm2tsqs8y4R11F2BaWomdL7gj7JRxjcVSls6jJu6f1SQVef30UuwpuAlf3/XObI2vp
         dM95at2w3lIz8lGC4yEEGyd8UqkfU2nqzEIPPymtDjoyfw7fwmfi9aiaKIPtUD9hS3lT
         NBsAV2QRP624STsXSZW+I39TSJgKfeeZNg04FK/QcOd6hYOVs7IZVc+E8BzJYUI8VemW
         JvDGn9i1uLOJUeOg6uYCdeKb1np0kry8UzE/eU3Y+jX9MBh1cKWHIk4smsllz9wrCLNR
         doxg==
X-Gm-Message-State: AGi0PuZP4yuQBpguuQSeYS0dDKtg2+bqvuGrwDOTcTbqTYE/8h8KOG/j
        6J7LFMLHSSZYW7HHhRmi3R1fj/uAqj8=
X-Google-Smtp-Source: APiQypLZigE15RHb+qlkWGwQJ+pr4U9g8hgacKbSqBFDOyZvrlwQnXTlBw3VB+lspFCzEzRNPhBh5A==
X-Received: by 2002:a05:6512:10c9:: with SMTP id k9mr506309lfg.183.1586461660441;
        Thu, 09 Apr 2020 12:47:40 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id l13sm15915895ljc.84.2020.04.09.12.47.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:47:39 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/4] mesh: Always deliver tokens via JoinComplete
Date:   Thu,  9 Apr 2020 21:47:29 +0200
Message-Id: <20200409194733.18039-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset implements API change discussed in 
https://marc.info/?l=linux-bluetooth&m=157660821400352&w=2

v2:
 - Fix mesh-cfgclient to send JoinComplete reply before calling Attach

Michał Lowas-Rzechonek (1):
  doc/mesh: Change API to deliver tokens via JoinComplete

Przemysław Fierek (3):
  mesh: Fix invalid app_path on 'Join'
  mesh: Change API to deliver tokens via JoinComplete
  tools/mesh-cfgclient: Add waiting for 'JoinComplete'

 doc/mesh-api.txt       | 22 ++++++++----
 mesh/mesh.c            | 67 ++++++++++++++++++++++++++----------
 tools/mesh-cfgclient.c | 78 +++++++++++++++++++++++++-----------------
 3 files changed, 110 insertions(+), 57 deletions(-)

-- 
2.26.0


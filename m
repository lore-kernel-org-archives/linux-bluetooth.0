Return-Path: <SRS0=BOCR=WN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831E1C3A59B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 06:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580AF20880
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Aug 2019 06:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkCeDVqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfHQGgZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:36:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34299 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfHQGgZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Aug 2019 02:36:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so4016444pgc.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtabfBwQWtyC3zyjLV1LAil4r41xMNWr577SDboN4vk=;
        b=fkCeDVqSK77RVKd0DHClKH1TxHua43D/1RG89fDkQ6rgAaCS9mPPTlOSerUcc12Vbv
         8+xah3Mer8o3TD0Oq1j3YG/cGy+5VuqAhAJfHrc3L1iXTPA0vYxU5vF3ZB1LZ6FNCbz4
         G4NKf7cnYoU6GFe1Zeauby/Eqzpp9gRigbXHVAvVzApy9963XCd00ZyxBz5lVo0aTXel
         sxFuAP5jTFL4tgrphfJdCyDxG7lRyXqX05XMNxdzfjUkWhSRRJrCoYdDR2PYUkQXJKsl
         JLTd03Bh1FBlaqZmHcEPkDMeAPzIX5anD5+OEkXB9Yqh93JNGVtgZqnEEl6EXKoXsdTq
         VeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtabfBwQWtyC3zyjLV1LAil4r41xMNWr577SDboN4vk=;
        b=qtztKcuJebvKSEMajiRAYyYhg9CWLUSAViIPlt7LpCwM7oM1JMqaTGDCCu+7mt4RTo
         odU3evtop+uugKUnmyRmB6qeISpsf0KaXGvyE5DBAy+uhhjxEV+01o/QiruAe+lCTJJH
         C05KW/iW6se2WH8M0x1FT2UlpI22CX69quXsw24/4reCdSu5I60MVkglF9DjPRyxAyAU
         BalgJ6IO0K7Qzu926mP1kg6x+vTRaT/SqbogcmOyT1ftC4auKyMfVm4+MrqzRpb5thIt
         RukvivVA4NbYGpuaTc9IXw35RbpteKK7baL5UptW2t3nRF46d3gCVX3FN7NgSeCs+7yI
         85Hg==
X-Gm-Message-State: APjAAAUlWFwKwdCbl13OP2RIg0+cFIUZdn7I6ZHoIziSHSBPxrssvSLZ
        4DYFE6o0mGtaoveyB/+qsl8dDgE=
X-Google-Smtp-Source: APXvYqxSKBt9Fy0PtFwGOjUGV9Olw4sAv+fKbsnc6UPaNVPw7jKTLz2ADPqi3NU6S8U3CWyTzb7Y5g==
X-Received: by 2002:a17:90a:2047:: with SMTP id n65mr10976669pjc.5.1566023784356;
        Fri, 16 Aug 2019 23:36:24 -0700 (PDT)
Received: from rxps.home ([2600:8800:1e00:242:3550:edee:2708:4ad0])
        by smtp.gmail.com with ESMTPSA id y128sm6684095pgy.41.2019.08.16.23.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 23:36:23 -0700 (PDT)
From:   Ronan Pigott <rpigott314@gmail.com>
X-Google-Original-From: Ronan Pigott
To:     linux-bluetooth@vger.kernel.org
Cc:     Ronan Pigott <rpigott@berkeley.edu>
Subject: [PATCH BlueZ v2 0/4] Add zsh completions for bluetoothctl
Date:   Fri, 16 Aug 2019 23:34:48 -0700
Message-Id: <20190817063452.23273-1-rpigott@berkeley.edu>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ronan Pigott <rpigott@berkeley.edu>

V2 of zsh completions for bluetoothctl

bluetoothctl has a nice interactive interface, but some of its functions
can be accessed quicker non-interactively, straight from the command
line. I made these zsh completions to facilitate that.

If you are a zsh user, try them out!

Ronan Pigott (4):
  client/main: add help option for available args
  shared/shell: add --zsh-complete option
  completion: add bluetoothctl zsh completions
  build: install zsh completions

 Makefile.tools               |  5 ++
 client/main.c                |  8 +++
 completion/zsh/_bluetoothctl | 98 ++++++++++++++++++++++++++++++++++++
 configure.ac                 | 12 +++++
 src/shared/shell.c           | 27 ++++++++++
 5 files changed, 150 insertions(+)
 create mode 100644 completion/zsh/_bluetoothctl

-- 
2.22.1


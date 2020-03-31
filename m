Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DB4C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 12:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF3320781
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 12:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Ht/7O+/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgCaMJR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:09:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43987 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbgCaMJR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 08:09:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id n20so17056449lfl.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7pLml00tXqiYXarZuzZtoRCtlptQvKUkiYknqwdBbpA=;
        b=Ht/7O+/8spF+BTZ5n01qXbWxvjl6MRWFZ26OHydT2JRSDLB1/ItOgxYSWoXZPAwIMc
         jgBUbygl6elSPDw4Slq6Z+JUmIvWse7qwe49VqqJunjfuS8FCZYDUFvqNgR/VKu3LMeI
         xi/QBjoWfF0FVXzCLirJ7rEgiDgpWBYLaDb8qD72Vf+Xuk6XIWaQGAvAhJ8C/kw75RNt
         4LaCSKmhYdNbI928rn/2r51eu0Cu+twTHZ5jrgi+3d8ZArsfYQLLTyeHk/BCjoV9Kw0k
         pX1Y9sM/ZrX9PM9xaYAKEIBJ/SxppotO65r7FI/M+1c8pKQ+tNth+1Gg9fsoWd8wrcp3
         PoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7pLml00tXqiYXarZuzZtoRCtlptQvKUkiYknqwdBbpA=;
        b=q8+Mr6hEV/6xgj9z1P7mDkR9Gc/Xa5dIPwqJCi2dJ2IBhxPtUs7BpEK8mHJUN4pb2D
         TXOHBgCLBX3C4MM6D23F+FoIgWTAl40vilG7FxDC4nV7K1blK5J9qBzk8n4jTXay+Mu2
         E837cX/H9TCNFKbLTX9mZ0gOwD+tQelAIOKgjEOZyVqcMP4Lj7rISa7+K7a/WtN3B8Li
         U3EoOJfReSRwAGA8ZG7/nwvUuw8rLI3WMpwZm2ft8nWGiNvrfnSbv/33aaABctCIOC2y
         JJBPePIWmpbtrteIjL5oNnSFDtPA/TBW9/EpfCHbPbeftA25R45rRrpgNJf2JybptuvK
         eiSA==
X-Gm-Message-State: AGi0PubNcicnS4QmwVPBOm/gjFmiUStrat/eo1tS2c8E6E9lrMpgJkzQ
        MMYMUYQDnk/6uLi+ttzLwbfK3Aa/LxM=
X-Google-Smtp-Source: APiQypJDGXwye1kiC6VJAOhUEwLw7qob++dW2Z3m4gGC6C6AYg9D4PwKIxgWKk3wg+/oHNkgLd03Fg==
X-Received: by 2002:a19:22cf:: with SMTP id i198mr11420311lfi.199.1585656555161;
        Tue, 31 Mar 2020 05:09:15 -0700 (PDT)
Received: from pfierek1997.silvair.lan (174.60.citypartner.pl. [195.210.60.174])
        by smtp.gmail.com with ESMTPSA id i190sm9828620lfi.7.2020.03.31.05.09.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:09:14 -0700 (PDT)
From:   =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/3] Add net_idx to 'send_seg' function 
Date:   Tue, 31 Mar 2020 14:09:05 +0200
Message-Id: <20200331120908.23215-1-przemyslaw.fierek@silvair.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds ability to send messages to subnets. 

I'm not sure about 'mesh_net_transport_send'. There were comment to add
'net_idx' but it currently takes 'key_id' parameter which is used just  
in case of friendship. I tempted to split it into two separate functions
but I don't full story behind this function.      

We didn't test the friend feature and I'm worried about breaking
something.

Przemysław Fierek (3):
  mesh: Remove unused argument from 'mesh_net_transport_send' function
  mesh: Remove unused functions: 'mesh_net_sub_list_add' and
    'mesh_net_sub_list_del'
  mesh: Add net key index to send_seg()

 mesh/friend.c | 16 +++++------
 mesh/net.c    | 77 ++++++++++++++++++++-------------------------------
 mesh/net.h    |  9 +++---
 3 files changed, 42 insertions(+), 60 deletions(-)

Return-Path: <SRS0=TohX=3J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F185C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 16:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44A5217F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 16:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Fhqx908M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgATQLY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:11:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39412 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATQLY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jan 2020 11:11:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so137444wmj.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2020 08:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ecA0xiDygGi3YJpCX3Q+rtTc6zSQ/mOLVNTXguwjeVA=;
        b=Fhqx908MiLR2xYa/3eFRLFglhZJKBpezrVz0NQLjBQ2t2hvDZoYJQruwuMEC4yMB4c
         pCf7iPqkt1E2e+yMKtlcc7xReyInmnzz/Zd2At4fB/oDjIYFO1qF6ZV8ciMShWJPhKZy
         lT9Tu0mkIXAynEHWYBiSQDQ5lQSWo8JFJ1ofntQ6axOdeAF6IxaZ7MQkLCJhruS9NEzY
         PaeyXwvqQdjI6H8j5Ood1RuxtK4hJoYNUpUDC3WHFazRNYzXzdd6RQd1Uii3qXPWb9ar
         Kf1jtIg86ST9R3blAbEdesfogOn2txB2grXAjPKXVA4BcgT3vtYZWnmB2vgNwKgVQTX/
         9VAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ecA0xiDygGi3YJpCX3Q+rtTc6zSQ/mOLVNTXguwjeVA=;
        b=X649VYvErlunouNhxo1uPcb8IVmGfazGC6Tro9mOo+0g5PTjMk9ciqioOvUV1W3u7g
         UO0j8q+aSP31kuEtrWKlPkRY/CnHE/2Ruvxn8EVSaDoa5ZV4qW99Vd87e6iX7YLFfnln
         EtF62mhBkH4MYyheeIPThjHjtjeBT2mUn4u49uTAMQhkw7dDRmvuuC+EpSFykXXwkphC
         JL4oasGwr86bw2AA/wN3y0nQlh1KUNcfNiTXIoQuVR8d9fr9RXi4yYCxyXa7+jdSYqXl
         6loJa7c2iXcd9Qk1UOmPMxSMOjSBj6HCLSyTwFz8958RokgmJRdef26IfS7dzU9sA4Y0
         LCiA==
X-Gm-Message-State: APjAAAWCa0If2a8bIOl3q8Ts49wE9ynxzVCo9cD/Rw6ZiAsl7kIN5jot
        FZvFNnmWVylWo21Ig+KoM1F+Ud9heCX7+Q==
X-Google-Smtp-Source: APXvYqwbBo17BmpZVjc2ukFqpMtnqj2LU5y3s+xGZgu4hggo0g/Yn6G9tpB0QXyIFMk+XmZ5emXsWA==
X-Received: by 2002:a7b:c765:: with SMTP id x5mr74638wmk.129.1579536681795;
        Mon, 20 Jan 2020 08:11:21 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 16sm22564602wmi.0.2020.01.20.08.11.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:11:20 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Allow to reattach with new composition data
Date:   Mon, 20 Jan 2020 17:11:11 +0100
Message-Id: <20200120161114.6757-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch allows the application to modify the CID, PID, VID and CRPL in the composition data.

According the Mesh Profile (2.3.4 Elements) the modification of fields other than "Elements" is not prohibited.

Also in my opinion (as you can see in the 1st patch), there is no need to use pointer to the node_composition struct.
The static is more clear and less problematic.

Jakub Witowski (3):
  mesh: use static node_comp instead of the pointer
  mesh: add composition data setter
  mesh: allow to reattach with new composition data

 mesh/mesh-config-json.c | 46 +++++++++++++++-----
 mesh/mesh-config.h      |  2 +
 mesh/node.c             | 96 +++++++++++++++++++++++++----------------
 3 files changed, 96 insertions(+), 48 deletions(-)

-- 
2.20.1


Return-Path: <SRS0=GHQ/=WM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0622C3A59C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 07:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDE920644
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Aug 2019 07:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOPM0uGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfHPHoq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:44:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34197 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfHPHop (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Aug 2019 03:44:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id b24so2739338pfp.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2019 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QhWx3rIJqkf0piRjovbrgZSk6D6ETEODTOjpjLq3V0=;
        b=jOPM0uGLo1bPgqR8lZfvkaJGzImy5kKH/hTfoZHJ7uczpjVvyd5uSZyYITCO1/1fzt
         yuDir9w8/mvzdWq4Tswk3PNLQS4jNY+d9LuGvlpF+L7ztqt9BZUv5eCj+RxOW3dH+qvW
         9MbPUyRE6dWDz8XwqBOD3G7uLkO9KBhSmRlnecke2Vm6bsgpP7BVG7yLHDu1a+cSPOXT
         Fq/GmyF8KgXKus5H6u3R/ZlVISrR+l7SBpHhAcVOB6wqitTuBSL5T8ccgO1B4ZibwEqM
         PbuBJGNldmQnGksONRr/bhcIpuotGnTPgUZxURVGuDsas9VcDfCHvH8y1Bemf/AlqI9e
         mI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QhWx3rIJqkf0piRjovbrgZSk6D6ETEODTOjpjLq3V0=;
        b=rbhPLa/BP6xQy8OUpNMoeg2UBK7g37AZJrAIaIMVFTNGy4U+s2pV0oG3BKQDz493pX
         slact+QjYAtcm7+iTcYkHQYDDE9M70Od41ESO0CVEk/eIg/05jReaXYC1mjPL6UN258a
         6qyzwOv+zEQo0l2tp8lFxBdvSDU0PV6dMfrLqG//KL11E812gvBLwSQofa6NEm7OrnQq
         YDqZ3+cgWNTiNCv9cy81ekZmU1m6aCi4nr4SZ0+ritSpoEUMm/ey9j+75r5xLk1yBW8m
         rxSu72hZH0y3pnOJrEvTbkLJYZAMndI2dC4QTjflLWeLzathdeJ2K9jQJ2oSqFWf481Q
         Ab3A==
X-Gm-Message-State: APjAAAWMd3+9sBG/HCT96GTPI2QJKkSOEDLnnMNkqdBE2hzeeUJcmMTk
        CuCSxfGHTeuLRB0Qu4LQdTefMmo=
X-Google-Smtp-Source: APXvYqwZwsAeTh/CQXmeKFHwnSt0TEznp7ncpIjtI6cZ2q7KZJlQ7Nh4jYkS3BmqJaCRkPu9awhMKg==
X-Received: by 2002:a62:5207:: with SMTP id g7mr942451pfb.152.1565941484863;
        Fri, 16 Aug 2019 00:44:44 -0700 (PDT)
Received: from rxps.home ([2600:8800:1e00:242:71a0:9ddd:9d48:afb])
        by smtp.gmail.com with ESMTPSA id v184sm4186679pgd.34.2019.08.16.00.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 00:44:44 -0700 (PDT)
From:   Ronan Pigott <rpigott314@gmail.com>
X-Google-Original-From: Ronan Pigott
To:     linux-bluetooth@vger.kernel.org
Cc:     Ronan Pigott <rpigott@berkeley.edu>
Subject: [PATCH BlueZ 0/3] Add zsh completions for bluetoothctl
Date:   Fri, 16 Aug 2019 00:43:30 -0700
Message-Id: <20190816074333.24673-1-rpigott@berkeley.edu>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ronan Pigott <rpigott@berkeley.edu>

bluetoothctl has a nice interactive interface, but some of its functions
can be accessed quicker non-interactively, straight from the command
line. I made these zsh completions to facilitate that, and I thought
to submit them upstream, if you like, so now I've made this patch. If you
are a zsh user, try them out!

I also added the 'help' option in order to help the shell completions
get their value from the same source as the interactive shell completions.

Ronan Pigott (3):
  client/main: add help option for available args
  completion: add bluetoothctl zsh completions
  build: install zsh completions

 Makefile.tools               |   5 ++
 client/main.c                |   8 +++
 completion/zsh/_bluetoothctl | 131 +++++++++++++++++++++++++++++++++++
 configure.ac                 |  12 ++++
 4 files changed, 156 insertions(+)
 create mode 100644 completion/zsh/_bluetoothctl

-- 
2.22.1


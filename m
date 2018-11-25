Return-Path: <SRS0=yWLZ=OE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C371C04EBA
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Nov 2018 09:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9265020867
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Nov 2018 09:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9265020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeKYUKy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:10:54 -0500
Received: from a3.inai.de ([88.198.85.195]:53996 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbeKYUKy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Nov 2018 15:10:54 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id 9EEDFF8B20; Sun, 25 Nov 2018 10:20:14 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id BE66CF8B15;
        Sun, 25 Nov 2018 10:20:13 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: [PATCH bluez] build system refresh (take 3)
Date:   Sun, 25 Nov 2018 10:20:04 +0100
Message-Id: <20181125092012.8001-1-jengelh@inai.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <CABBYNZL0jgnZTYSQ+c+54_fHudK+0fg-GwS_-LUzw7gde_aMyA@mail.gmail.com>
References: <CABBYNZL0jgnZTYSQ+c+54_fHudK+0fg-GwS_-LUzw7gde_aMyA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


The following changes since commit 9568f4439efdf5daa2f941f544d8a84a2eee5cac:

  doc: Initial Bluetooth Mesh API (2018-11-22 11:15:45 -0800)

are available in the Git repository at:

  git://github.com/jengelh/bluez

for you to fetch changes up to 97561f245b7609e4c041b4083a7922817acc3ae7:

  build: add missing BACKTRACE_CFLAGS (2018-11-24 20:09:10 +0100)

----------------------------------------------------------------
Jan Engelhardt (8):
      build: rename includedir to pkgincludedir
      build: change @foo@ to $(foo) in automake makefiles
      build: -l arguments to belong into LDADD/LIBADD not LDFLAGS
      build: -D/-I arguments go into CPPFLAGS
      build: add missing ELL_CFLAGS
      build: add missing UDEV_CFLAGS
      build: add missing ALSA_CFLAGS
      build: add missing BACKTRACE_CFLAGS

 Makefile.am         | 84 +++++++++++++++++++++++++++++++++++++++++++-----------------------------------------
 Makefile.mesh       |  8 ++++++--
 Makefile.obexd      | 15 ++++++++-------
 Makefile.plugins    |  9 ++++++---
 Makefile.tools      | 66 +++++++++++++++++++++++++++++++++++-------------------------------
 android/Makefile.am | 41 +++++++++++++++++++++--------------------
 6 files changed, 119 insertions(+), 104 deletions(-)


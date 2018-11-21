Return-Path: <SRS0=IL+U=OA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5B4C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 12:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE0520C01
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Nov 2018 12:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE0520C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbeKUXcQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:32:16 -0500
Received: from a3.inai.de ([88.198.85.195]:33958 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbeKUXcQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Nov 2018 18:32:16 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id F31B73BACCDE; Wed, 21 Nov 2018 13:57:58 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id A3E003BB6EF3;
        Wed, 21 Nov 2018 13:57:57 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, jengelh@inai.de
Subject: Re: [PATCH 1/8] build: rename libexecdir to pkglibexecdir
Date:   Wed, 21 Nov 2018 13:57:46 +0100
Message-Id: <20181121125753.15476-1-jengelh@inai.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <CABBYNZ+pLp5W0_sNC4ih_KuW2WmX5drBL2bPX4rG4fHQ4kyecg@mail.gmail.com>
References: <CABBYNZ+pLp5W0_sNC4ih_KuW2WmX5drBL2bPX4rG4fHQ4kyecg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


The following changes since commit 78bce480093799c287ac8561b9407fa48796a130:

  build: rename libexecdir to pkglibexecdir (2018-11-21 13:22:33 +0200)

are available in the Git repository at:

  https://github.com/jengelh/bluez master

for you to fetch changes up to 485987a00ef172e2598ae7e3d545a266f934c1d1:

  build: add missing BACKTRACE_CFLAGS (2018-11-21 13:54:37 +0100)

----------------------------------------------------------------
Jan Engelhardt (7):
      build: change @foo@ to $(foo) in automake makefiles
      build: -l arguments to belong into LDADD/LIBADD not LDFLAGS
      build: -D/-I arguments go into CPPFLAGS
      build: add missing ELL_CFLAGS
      build: add missing UDEV_CFLAGS
      build: add missing ALSA_CFLAGS
      build: add missing BACKTRACE_CFLAGS

 Makefile.am         | 80 +++++++++++++++++++++++++++--------------------------
 Makefile.mesh       |  8 ++++--
 Makefile.obexd      | 15 +++++-----
 Makefile.plugins    |  9 ++++--
 Makefile.tools      | 66 ++++++++++++++++++++++---------------------
 android/Makefile.am | 41 +++++++++++++--------------
 6 files changed, 117 insertions(+), 102 deletions(-)


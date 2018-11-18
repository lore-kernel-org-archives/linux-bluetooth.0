Return-Path: <SRS0=E1HW=N5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC99FC169D4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Nov 2018 16:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59662080F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Nov 2018 16:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59662080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeKSCfC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:35:02 -0500
Received: from a3.inai.de ([88.198.85.195]:54172 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbeKSCfB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Nov 2018 21:35:01 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id E54F5130157E; Sun, 18 Nov 2018 17:08:08 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id 8280C3BACCC8;
        Sun, 18 Nov 2018 17:08:07 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     jengelh@inai.de
Subject: [PATCH bluez] build system refresh
Date:   Sun, 18 Nov 2018 17:07:54 +0100
Message-Id: <20181118160802.11087-1-jengelh@inai.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


The following changes since commit 3ef0ce954b66fdf45538a6cdc629f3dac6642832:

  bluetooth.conf: remove deprecated at_console statement (2018-11-07 13:30:28 +0200)

are available in the Git repository at:

  git://github.com/jengelh/bluez 

for you to fetch changes up to b489fd9a11f7d03ec3125297ee71e9f4135e9eda:

  build: add missing BACKTRACE_CFLAGS (2018-11-18 13:28:27 +0100)

----------------------------------------------------------------
Jan Engelhardt (8):
      build: rename libexecdir to pkglibexecdir
      build: change @foo@ to $(foo) in automake makefiles
      build: -l arguments to belong into LDADD/LIBADD not LDFLAGS
      build: -D/-I arguments go into CPPFLAGS
      build: add missing ELL_CFLAGS
      build: add missing UDEV_CFLAGS
      build: add missing ALSA_CFLAGS
      build: add missing BACKTRACE_CFLAGS

 Makefile.am                       | 82 ++++++++++++++++++++++++++++++++++++++++++----------------------------------------
 Makefile.mesh                     |  8 ++++++--
 Makefile.obexd                    | 15 ++++++++-------
 Makefile.plugins                  |  9 ++++++---
 Makefile.tools                    | 66 +++++++++++++++++++++++++++++++++++-------------------------------
 android/Makefile.am               | 41 +++++++++++++++++++++--------------------
 obexd/src/obex.service.in         |  2 +-
 src/bluetooth.service.in          |  2 +-
 tools/bluetooth-logger.service.in |  2 +-
 9 files changed, 121 insertions(+), 106 deletions(-)


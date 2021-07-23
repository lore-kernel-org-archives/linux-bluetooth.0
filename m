Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE40AC4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 13:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE96460E9C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 13:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhGWNSY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbhGWNSX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 09:18:23 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFA5C061575
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 06:58:57 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4GWWBk1FRczQk8q;
        Fri, 23 Jul 2021 15:58:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1627048732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sCHaslaRiQYShCGPvZL0f2XthwQcM5OFCxd7i2Q/BOE=;
        b=isaRt3mYSljy7HXUloXMFbbU2T+QVNY7pA49q4KnZyBFK9i+UCpzZjquXzd6Lpooo389IJ
        CVJlly/NB35BGo607opQ+BdWn/6G48Qj/0SODPbaf0lqnIghsO9OU0fkAQPqmtTc6wmPMj
        745lPC0XQ3DmJ44VpI5mJzRVA3hRILLNBZ5iFRd6C4GIxEPfH2gbFqrNLVbyQB0CIAtTbZ
        EKpr2wnw1vxlA3BMgU7FzTX5EMs2oK42lci3YM1IvQ4Y7c5nwrbAHAaMLMhKUrHMESh4Lm
        GmXHiPYzGEyEMh9pQqU9epSAL+uT+IlEMKz3+GmcZ8e7B4ragTLXu29gTUn+zg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id Kny07NV-49Bt; Fri, 23 Jul 2021 15:58:48 +0200 (CEST)
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH BlueZ 0/4] obexd: phonebook-ebook: modernize
Date:   Fri, 23 Jul 2021 15:58:20 +0200
Message-Id: <20210723135824.8032-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB80418B9
X-Rspamd-UID: 15397f
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The ebook plugin was introduced during GSoC 2011 [1] and allows
BlueZ to share contacts stored in the Evolution Data Server to
connected clients such as car multimedia systems.
With the rise of Mobile Linux thanks to the PinePhone and Librem 5,
this plugin was modernized to compile with newer libebook versions
because the API was changed [2].

[1] http://www.bluez.org/gsoc-eds-backend-of-phonebook-access-profilepbap/
[2] https://wiki.gnome.org/Apps/Evolution/ESourceMigrationGuide

This set of patches modernizes the PBAP phonebook-ebook plugin for newer
libebook versions of the Evolution Data Server, allows to select the
phonebook plugin at compile time, and set the default apparams for some
PTS clients. Some clients do not send the mandantory apparams when
retrieving the phonebook, but they work fine with a set of default
apparams.

Dylan Van Assche (2):
  obexd: phonebook-ebook: modernize
  configure.ac: add libebook dependency

Hannu Mallat (1):
  obexd: phonebook: Set default apparams for PTS clients

Juho Hamalainen (1):
  configure.ac: specify phonebook plugin at build time

 Makefile.am                     |   2 +-
 Makefile.obexd                  |   4 +-
 configure.ac                    |  17 +
 obexd/plugins/pbap.c            |  15 +
 obexd/plugins/phonebook-ebook.c | 668 +++++++++++++++-----------------
 5 files changed, 355 insertions(+), 351 deletions(-)

-- 
2.32.0


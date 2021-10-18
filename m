Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513B4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CF960EE9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhJRRaw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhJRRav (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 13:30:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679CFC06161C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i5so5506742pla.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oPGiMYVcFP/PRF1iUKLfRdTZL2d6ebR3k2DQI7qC/DY=;
        b=aHbq26lhgagSzppCtiWKmlolH+OhGP4KxHSHIVz6th939mHqDyPenLHn/NMHTxTmTM
         zvIMPgv6Y+Vn9WdqDBePD4vRT9YYtEwBzqHP8N/+Zp+9tEcN93wN1WKhN7+1LFBnTPAa
         sxEkDVas0m6i41gZDQS76NjnJnd0UZ7I7wX28oZOkLfQNO+vm7V64MHFCjuDkIFxTTNG
         9+tDnGYooVHLfa0gHtg3Ahp/wc+9xD2jZLwiC9QBObh6FM9xVrVUQbm9pMKCCzNLo2Ty
         7CBNM335FXkg1KJbGXMvKhI9TqnREVb5XwR34iUZz2XGtdl1lNfPi6kbn1dHf6U+nwgG
         x3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oPGiMYVcFP/PRF1iUKLfRdTZL2d6ebR3k2DQI7qC/DY=;
        b=55xFs7pIG29U6huAZNCz4LrtHFsvGnBaIKhjzFctt+xLiU7IqCTpdfhETTkko5jyYY
         PCi1T5kyWHE+aWb7YlmvZ3Peq2wVSAkwuj1+kL3B3mbBTYyV9z3Exjz513Zf9IR3jh2t
         dnp95gPrGpSdqcH+XidAc68pJ0ESbmtE2h0tPjWAxRLSZmcXH9BngYqZNXgbUa5K0noW
         /Qmd4ftpmV4XKssuA+gUyxtCye+rmym34kNoFFr03F3zYy7r7kHlo6IR4jry/qKfjilN
         HpXJHTuBr9zZXwCDfszcw/6HsoGnh5hwcnsZ50CxkmZ4E9FgvT1xN5rBwt1Ag4d75WAH
         gJQw==
X-Gm-Message-State: AOAM533ITCDhrsLVD/3Mzbg4GUIQRpwvSPQkHbiPCynDttfuTSOCE/5X
        AOICvSHAQc5k11YQ3s9zLr6r2iPr9RlHRA==
X-Google-Smtp-Source: ABdhPJxHX7qCkbPLfPz9WA92mQAqGiCAqyF0041EFBuIq0SmpJTrpgurpPJpI9ShmRHPLXlFvJzOWw==
X-Received: by 2002:a17:90b:33c3:: with SMTP id lk3mr189721pjb.237.1634578119618;
        Mon, 18 Oct 2021 10:28:39 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:a510:aebd:a4ae:453c])
        by smtp.gmail.com with ESMTPSA id fv9sm51156pjb.26.2021.10.18.10.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:28:39 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ PATCH 0/9] Fix unchecked return value
Date:   Mon, 18 Oct 2021 10:28:24 -0700
Message-Id: <20211018172833.534191-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch series fixes the unchecked return value(CWE-252) issues
reported by the Coverity scan.

The idea is to make the change as simple as possible without changing
the functional flow. So, it logs the output when the function fails
after checking the return value.

Tedd Ho-Jeong An (9):
  device: Fix unchecked return value
  adapter: Fix unchecked return value
  attrib-server: Fix unchecked return value
  plugins/admin: Fix unchecked return value
  profiles/a2dp: Fix unchecked return value
  profiles/input: Fix unchecked return value
  mesh: Fix unchecked return value
  obexd: Fix unchecked return value
  peripheral: Fix unchecked return value

 mesh/keyring.c          |   6 +-
 mesh/mesh-io-unit.c     |   6 +-
 mesh/rpl.c              |  22 ++--
 mesh/util.c             |  11 +-
 obexd/client/transfer.c |  12 +-
 obexd/plugins/pcsuite.c |   4 +-
 obexd/src/main.c        |   4 +-
 peripheral/main.c       |   3 +-
 plugins/admin.c         |  15 ++-
 profiles/audio/a2dp.c   |  33 +++++-
 profiles/input/device.c |   6 +-
 src/adapter.c           | 249 ++++++++++++++++++++++++++++++++++------
 src/attrib-server.c     |  21 +++-
 src/device.c            | 141 +++++++++++++++++++----
 14 files changed, 441 insertions(+), 92 deletions(-)

-- 
2.25.1


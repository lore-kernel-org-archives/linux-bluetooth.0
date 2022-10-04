Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC3CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 01:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJDBzX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 21:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJDBzW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 21:55:22 -0400
Received: from smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345192C10A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 18:55:19 -0700 (PDT)
Received: from github.com (hubbernetes-node-cf2d0fd.ac4-iad.github.net [10.52.200.71])
        by smtp.github.com (Postfix) with ESMTPA id 48B52520492
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 18:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1664848519;
        bh=L073TTcLdzIRmJSF5fiIuSKbyrHyqpACrRdJDMSgKwk=;
        h=Date:From:To:Subject:From;
        b=msuFrjqb4LeeFQsUpwVspGzOvo0xH1tHbGlrBVjFpQ9guW0N7m1aOTr/4rYpzTUPP
         j8Ei8kI17mrU0DXphdf3ZNgc7mrO4RIVdbSMMn+oaDCEokD/HkoLURLUscOr2WMKFJ
         KXN4DTeNPyaCbSResDFuLBMWMXVLyp4TRdVeMSaY=
Date:   Mon, 03 Oct 2022 18:55:19 -0700
From:   inga-s <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/291cff-fe9427@github.com>
Subject: [bluez/bluez] 1f6553: build: Deprecate meshctl tool
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 1f6553edd8a5cb404036b33f7c24b375da137d4c
      https://github.com/bluez/bluez/commit/1f6553edd8a5cb404036b33f7c24b375da137d4c
  Author: Inga Stotland <inga.stotland@intel.com>
  Date:   2022-10-03 (Mon, 03 Oct 2022)

  Changed paths:
    M Makefile.tools

  Log Message:
  -----------
  build: Deprecate meshctl tool

This marks meshctl tool as deprecated since it is not longer
maintained.


  Commit: fe9427041167871a3ad30f834db54971acfbcb23
      https://github.com/bluez/bluez/commit/fe9427041167871a3ad30f834db54971acfbcb23
  Author: Inga Stotland <inga.stotland@intel.com>
  Date:   2022-10-03 (Mon, 03 Oct 2022)

  Changed paths:
    M README

  Log Message:
  -----------
  README: Update Mesh required Kernel Config section

Add CONFIG_CRYPTO_USER_API_SKCIPHER to the list of the required
.config options


Compare: https://github.com/bluez/bluez/compare/291cff068009...fe9427041167

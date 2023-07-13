Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A58FC001DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 19:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjGMTbT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 15:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjGMTbS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 15:31:18 -0400
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09842D68
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 12:31:16 -0700 (PDT)
Received: from github.com (hubbernetes-node-2a8587f.ash1-iad.github.net [10.56.149.37])
        by smtp.github.com (Postfix) with ESMTPA id E8DF81010CB
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1689276675;
        bh=92Bw0Ak3cUj7C+IuSV92+7IzTC1tP+2DlZ4Wk8fKeI0=;
        h=Date:From:To:Subject:From;
        b=JDyC/RWk3ALZdb428EXjvaCLYrsOyunjRBReyZt/+30Gw5SWNBquywMvF3tjTEOmK
         eYXRttDOff17iCIQVs2FDIjpV/JFriXHHEeyUlvpwTfuUmvlzfJTLpZyl2bgs2IC6K
         Yjj0myX945O2Ht1xgAnDSQVcP3C1H68QElndUvbA=
Date:   Thu, 13 Jul 2023 12:31:15 -0700
From:   Pauli Virtanen <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c62a4c-9aff3f@github.com>
Subject: [bluez/bluez] 7cea6b: test-runner: set non-quiet printk before
 running t...
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
  Commit: 7cea6b964119747925312a7a00ff217021d6c4a1
      https://github.com/bluez/bluez/commit/7cea6b964119747925312a7a00ff217021d6c4a1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-07-13 (Thu, 13 Jul 2023)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: set non-quiet printk before running tests

It is useful to see WARN_ON etc. messages when running the tests.

The 'quiet' in cmdline suppresses levels >= WARN, so re-enable them
explicitly after boot, so that it is on by default and doesn't need to
be handled in local test scripts.


  Commit: 9aff3f4941426d6a79d08404e1fe36767eadd0fd
      https://github.com/bluez/bluez/commit/9aff3f4941426d6a79d08404e1fe36767eadd0fd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-07-13 (Thu, 13 Jul 2023)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: fix behavior when no audio server

If no audio server, don't pass NULL to printf and parse TESTAUDIO
correctly.


Compare: https://github.com/bluez/bluez/compare/c62a4cb55183...9aff3f494142

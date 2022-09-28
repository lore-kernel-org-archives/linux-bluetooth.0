Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74386C04A95
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 13:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiI1NyN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Sep 2022 09:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiI1NyE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Sep 2022 09:54:04 -0400
Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBE1923F2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Sep 2022 06:53:54 -0700 (PDT)
Received: from github.com (hubbernetes-node-e96a5a7.ac4-iad.github.net [10.52.202.86])
        by smtp.github.com (Postfix) with ESMTPA id EBE4B600BF9
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Sep 2022 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1664373234;
        bh=O2SrofjUcmfRQwypSqwyZVr4DfL1EGGZ3JD90ad/Yqw=;
        h=Date:From:To:Subject:From;
        b=O95h4jqVNSeyOx2JQbE2N4tIktUHJP/4H6Mqki5KSE8Bsl+cEGBS5V+85r4p2/eD9
         q5l5cCkBWvHnC4ikCevAW8ricG2firZ+dX3UUxRAwSNkb9lMlTJ5rH6pDDvDNdqGF+
         f87Y3RdyBkZC4ysxFkFROGd57ItRVfzCp+Wog4uE=
Date:   Wed, 28 Sep 2022 06:53:53 -0700
From:   Brian Gix <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/293d67-3b47cf@github.com>
Subject: [bluez/bluez] 3b47cf: tools: Fix mesh-tester to expect end of ADV
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
  Commit: 3b47cf5db9a66949d4cc609cc516d592226d5e9b
      https://github.com/bluez/bluez/commit/3b47cf5db9a66949d4cc609cc516d592226d5e9b
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2022-09-27 (Tue, 27 Sep 2022)

  Changed paths:
    M tools/mesh-tester.c

  Log Message:
  -----------
  tools: Fix mesh-tester to expect end of ADV

Tester was failing by not clearing the HCI queue of expected events



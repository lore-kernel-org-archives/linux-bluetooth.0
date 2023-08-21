Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E18BEE4996
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 22:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjHUWei (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 18:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHUWei (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 18:34:38 -0400
Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9E9FD
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 15:34:36 -0700 (PDT)
Received: from github.com (hubbernetes-node-423c487.ash1-iad.github.net [10.56.149.25])
        by smtp.github.com (Postfix) with ESMTPA id 41A30340DBE
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1692657276;
        bh=bI0H8TbGNJ/bxofWIqv5Ky2UhJmOX0uHVAHWY8m52Kk=;
        h=Date:From:To:Subject:From;
        b=T1T+lPlMoLU5rf/95oNNkzirDdXG01MJZzxXicmbGTgjO3k2EtzV/G8Bvbt3537ts
         VfB5CuQG7mBZ1E2s62aTrrBBYMJJk0vjBM5ieFvkEBJPuUMxh+0F17w1anHCWKfXnR
         3J74WwHklJp1lX6CC/NeDA2l1iFdFGx+psPwoCYA=
Date:   Mon, 21 Aug 2023 15:34:36 -0700
From:   Lokendra <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e93094-c01cf4@github.com>
Subject: [bluez/bluez] c01cf4: monitor/intel: Add decoding of PPAG Enable
 command
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
  Commit: c01cf4552c12ae0b56cb3cfdbe3e9ce67b695716
      https://github.com/bluez/bluez/commit/c01cf4552c12ae0b56cb3cfdbe3e9ce67b695716
  Author: Lokendra Singh <lokendra.singh@intel.com>
  Date:   2023-08-21 (Mon, 21 Aug 2023)

  Changed paths:
    M monitor/intel.c

  Log Message:
  -----------
  monitor/intel: Add decoding of PPAG Enable command

Add decoding support for Intel PPAG Enable
command.

btmon log:
< HCI Command: Intel PPAG Enable (0x3f|0x020b) plen 4
        Enable: 0x00000002 (China)
> HCI Event: Command Complete (0x0e) plen 4
      Intel PPAG Enable (0x3f|0x020b) ncmd 1
        Status: Success (0x00)



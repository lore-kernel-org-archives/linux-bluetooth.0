Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68D0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 15:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJGPXp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJGPXk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 11:23:40 -0400
Received: from smtp.github.com (out-26.smtp.github.com [192.30.252.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB6710B7A3
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 08:23:38 -0700 (PDT)
Received: from github.com (hubbernetes-node-21828ad.ash1-iad.github.net [10.56.206.54])
        by smtp.github.com (Postfix) with ESMTPA id 0010D5E04D5
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1665156218;
        bh=MmyhryXTez1Ll0sZfrpoLC9XuuhnZvio3XO0K+DgqLs=;
        h=Date:From:To:Subject:From;
        b=cSYfY3uO3y5iPoRbHNh0VecHN+hD8VSG7c5sDU3X5DfQf00N/PZDje7yVL3CuwcTL
         SeyPvZw0uC/ObAm8aYCay3zmWq5iUHZ7/m5xV+++T+L4ZfCTCD08BD1W7hgSnhdAL3
         FyFIgtiEIS3u2VIjkOK/f5o5oJDJ+FmmnnpMomxY=
Date:   Fri, 07 Oct 2022 08:23:37 -0700
From:   Isak Westin <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/838ddc-dabf32@github.com>
Subject: [bluez/bluez] fc598f: tools: mgmt-tester - Test for HCI cmd after
 static...
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
  Commit: fc598fa12c08b554fb31e1a75b76ec3377c4dbaa
      https://github.com/bluez/bluez/commit/fc598fa12c08b554fb31e1a75b76ec3377c4dbaa
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2022-10-06 (Thu, 06 Oct 2022)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  tools: mgmt-tester - Test for HCI cmd after static addr set

This change checks for the expected HCI command after Static Address
change requested.


  Commit: dabf32b313c1dbfcbb434778541e4ab03bb2121e
      https://github.com/bluez/bluez/commit/dabf32b313c1dbfcbb434778541e4ab03bb2121e
  Author: Isak Westin <isak.westin@loytec.com>
  Date:   2022-10-07 (Fri, 07 Oct 2022)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: Fix msg cache ring buffer

The message cache should be a strict ring buffer, suppressed message
should not move to the front of the queue.


Compare: https://github.com/bluez/bluez/compare/838ddc931263...dabf32b313c1

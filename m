Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199C0CD379F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 20:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbjIOUL5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbjIOULY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 16:11:24 -0400
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB2C2700
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 13:11:12 -0700 (PDT)
Received: from github.com (hubbernetes-node-af2f4e6.ash1-iad.github.net [10.56.208.39])
        by smtp.github.com (Postfix) with ESMTPA id 00DC2101019
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1694808672;
        bh=IkKe5aQxbvHhhSDRxN+Nsqbvolid7CR7/TVzE+BuOf0=;
        h=Date:From:To:Subject:From;
        b=ZAtEkDL9Lxsb3RRyjuQEFomvNzCOWCfR4wIJEMfYLHFTI1JjARSmmJWHJWasW5/3N
         FOMKL6fA4hRw83Ja04fSuTYgrkVfwsEC2fat0yBWJFdIhDDrDjpgCUUOiYKOSYc/ZT
         gaE1gjsxjI4FUNtBLhSp9Mixhury0oOCT9Le1KPI=
Date:   Fri, 15 Sep 2023 13:11:11 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f83836-7b9d2f@github.com>
Subject: [bluez/bluez] d46f91: l2cap-tester: Add tests for closing socket
 before ...
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
  Commit: d46f91c5be579ed131fd08e096b7c7187ef4c388
      https://github.com/bluez/bluez/commit/d46f91c5be579ed131fd08e096b7c7187ef4c388
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-14 (Thu, 14 Sep 2023)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-tester: Add tests for closing socket before connection completes

This adds the following tests which attempts to close/shutdown the
socket before the connection completes:

L2CAP BR/EDR Client - Close
L2CAP LE Client - Close
L2CAP Ext-Flowctl Client - Close


  Commit: 7b9d2f3c763408bfe733c3bf70979a12938a448d
      https://github.com/bluez/bluez/commit/7b9d2f3c763408bfe733c3bf70979a12938a448d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-14 (Thu, 14 Sep 2023)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-tester: Add tests for connection timeout

This adds the following tests which attempts to use SO_SNDTIMEO so the
socket times out before the connection completes:

L2CAP BR/EDR Client - Timeout
L2CAP LE Client - Timeout
L2CAP Ext-Flowctl Client - Timeout


Compare: https://github.com/bluez/bluez/compare/f838361bf0a3...7b9d2f3c7634

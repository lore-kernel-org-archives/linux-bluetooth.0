Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB67CC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 21:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjDSVOj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 17:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDSVOh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:37 -0400
Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7686A6E
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 14:14:26 -0700 (PDT)
Received: from github.com (hubbernetes-node-558e25e.ash1-iad.github.net [10.56.15.33])
        by smtp.github.com (Postfix) with ESMTPA id 51A915E04C9
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 14:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1681938865;
        bh=5ln0uID19Q7BXPvEnUQJt8zTGdfvrK5QN8f77cByz4g=;
        h=Date:From:To:Subject:From;
        b=AvR7YVJ3V0PF6PbW7CRTP8PS1+StFGOupABVa7ByGeGRqBIDeuRm6XNb/DbraYmtK
         xoWHlUnT9BsYEm9LeO3WjS4W/Pcg8kpxvYd0jf20A9RmSu9ujgnOKf7DlCxO6T9fZK
         4xSsK0ZIdBTYp22zVHCfoWX4WzWk6Y5Oa5hdzXi4=
Date:   Wed, 19 Apr 2023 14:14:25 -0700
From:   iulia-tanasescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4d197b-b56479@github.com>
Subject: [bluez/bluez] 180d1c: monitor/packet: Fix BIG encryption decoding
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
  Commit: 180d1c9ad028310eb89de90f188153d37a309aca
      https://github.com/bluez/bluez/commit/180d1c9ad028310eb89de90f188153d37a309aca
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-04-19 (Wed, 19 Apr 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor/packet: Fix BIG encryption decoding

Fix incorrect decoding of the encryption parameter when logging
the LE BIG Create Sync command.


  Commit: ce1eb5dd0a03db1f6c123f14e4f837d115fd08d7
      https://github.com/bluez/bluez/commit/ce1eb5dd0a03db1f6c123f14e4f837d115fd08d7
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-04-19 (Wed, 19 Apr 2023)

  Changed paths:
    M tools/isotest.c
    M tools/isotest.rst

  Log Message:
  -----------
  tools/isotest: Add BIG encryption options

Add command line options for BIG encryption and broadcast code.


  Commit: b56479f4f5a350391af06cae331bd1d78651da58
      https://github.com/bluez/bluez/commit/b56479f4f5a350391af06cae331bd1d78651da58
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-04-19 (Wed, 19 Apr 2023)

  Changed paths:
    M emulator/btdev.c
    M emulator/bthost.c
    M emulator/bthost.h
    M monitor/bt.h
    M tools/iso-tester.c

  Log Message:
  -----------
  tools/iso-tester: Add Broadcast tests for encrypted BIG

This adds the following tests for encrypted broadcast:

ISO Broadcaster Encrypted - Success
ISO Broadcaster Receiver Encrypted - Success


Compare: https://github.com/bluez/bluez/compare/4d197b859e57...b56479f4f5a3

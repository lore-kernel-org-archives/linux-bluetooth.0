Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC479C07E9D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 18:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIZS2J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIZS1g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 14:27:36 -0400
Received: from smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CBB1402A
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 11:26:53 -0700 (PDT)
Received: from github.com (hubbernetes-node-239f8e3.va3-iad.github.net [10.48.209.77])
        by smtp.github.com (Postfix) with ESMTPA id 7FAA15C0675
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1664216812;
        bh=vHp2eu1s4yNQv/x1jKNOl4FG4enxrKNS/fMA0Tmqq5w=;
        h=Date:From:To:Subject:From;
        b=pzFNn0StwFlT/xjDRNtMMU7h0NaPMyaqXyQEIdLHzyCh+FiwDbhwhlpI1CM22FfaB
         UaNymPRQrZlAo7oxNQ/M1x6TxebJtwABSUlgTCsgNNCJIk5bKcCXKxYwYoOZg2SEcy
         W4xlqE0pxYDXXPpTm8S6ih+ZpGdePjndbeqm+mlY=
Date:   Mon, 26 Sep 2022 11:26:52 -0700
From:   hexchain <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6c7120-7738e9@github.com>
Subject: [bluez/bluez] 7b07f1: client/player: fix printf format string
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
  Commit: 7b07f1f980598cf54c91642e6583613bd6185eb1
      https://github.com/bluez/bluez/commit/7b07f1f980598cf54c91642e6583613bd6185eb1
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2022-09-26 (Mon, 26 Sep 2022)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: fix printf format string

Use macros from inttypes.h for correct printf format specifier for
int64_t


  Commit: fa8411cf37a3955e187824cc84235dd6ae76524d
      https://github.com/bluez/bluez/commit/fa8411cf37a3955e187824cc84235dd6ae76524d
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2022-09-26 (Mon, 26 Sep 2022)

  Changed paths:
    M monitor/analyze.c
    M monitor/packet.c

  Log Message:
  -----------
  monitor: fix printf format strings

time_t is 64 bit (long long) on many 32 bit platforms (e.g. ARM) now


  Commit: e01e89179d4ef8016f5593674834084ca549ca2a
      https://github.com/bluez/bluez/commit/e01e89179d4ef8016f5593674834084ca549ca2a
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2022-09-26 (Mon, 26 Sep 2022)

  Changed paths:
    M tools/l2test.c
    M tools/rctest.c

  Log Message:
  -----------
  tools: fix printf format strings

time_t is 64 bit (long long) on many 32 bit platforms (e.g. ARM) now


  Commit: 7738e9ac416b8dd9aa8f3209b75554f85836c5f0
      https://github.com/bluez/bluez/commit/7738e9ac416b8dd9aa8f3209b75554f85836c5f0
  Author: Haochen Tong <i@hexchain.org>
  Date:   2022-09-26 (Mon, 26 Sep 2022)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  tools/mpris-proxy: unregister object path if player registration fails

The `owner' string, passed as user data, is freed if the player fails
registration, but the object path still exists. Upon program exiting,
the lingering path will be enumerated and the attached user data will be
freed again.


Compare: https://github.com/bluez/bluez/compare/6c712030567b...7738e9ac416b

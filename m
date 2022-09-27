Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712B0C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Sep 2022 19:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiI0Tne (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiI0Tnd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Sep 2022 15:43:33 -0400
Received: from smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7632318D0C0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 12:43:32 -0700 (PDT)
Received: from github.com (hubbernetes-node-61c37c6.ac4-iad.github.net [10.52.208.19])
        by smtp.github.com (Postfix) with ESMTPA id CAE485200C8
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1664307811;
        bh=ApUHOVgGLA0+iu08GZme2Nh5FfaHj29uko1CxD1QMnw=;
        h=Date:From:To:Subject:From;
        b=oFuleKnp6XZNLWt5bS9xOSrAZmwUCHv99l+XVGLh1QamkOGFSS20Io8nyyfHH6pLs
         8IwgwBhQXWLAlaBRLDuOaRknQ24KXKpXwAfXyGqs4Bhj4DosE16GJz/Nr8tfKi0mTX
         PBkA7nuFOEYi7w4LKCJcX3YRthzjtGIOWXk7ijEI=
Date:   Tue, 27 Sep 2022 12:43:31 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d763bf-293d67@github.com>
Subject: [bluez/bluez] de1901: rctest: Fix scan-build warning
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
  Commit: de1901565979b5f56effc34b03594bee4f757f7d
      https://github.com/bluez/bluez/commit/de1901565979b5f56effc34b03594bee4f757f7d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-27 (Tue, 27 Sep 2022)

  Changed paths:
    M tools/rctest.c

  Log Message:
  -----------
  rctest: Fix scan-build warning

This fixes the following warning:

tools/rctest.c:131:2: warning: 1st function call argument is an
uninitialized value [core.CallAndMessage]
        sdp_list_free(protos, NULL);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~


  Commit: 643b074d7dc7f722588192eea852ce2e0d0584ae
      https://github.com/bluez/bluez/commit/643b074d7dc7f722588192eea852ce2e0d0584ae
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-27 (Tue, 27 Sep 2022)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor/analyze: Fix scan-build warnings

This fixes the following warnings:

monitor/analyze.c:381:2: warning: Value stored to 'data' is never read
[deadcode.DeadStores]
        data += sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:382:2: warning: Value stored to 'size' is never read
[deadcode.DeadStores]
        size -= sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:398:2: warning: Value stored to 'data' is never read
[deadcode.DeadStores]
        data += sizeof(*evt);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:399:2: warning: Value stored to 'size' is never read
[deadcode.DeadStores]
        size -= sizeof(*evt);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:418:2: warning: Value stored to 'data' is never read
[deadcode.DeadStores]
        data += sizeof(*evt);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:419:2: warning: Value stored to 'size' is never read
[deadcode.DeadStores]
        size -= sizeof(*evt);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:527:2: warning: Value stored to 'data' is never read
[deadcode.DeadStores]
        data += sizeof(subtype);
        ^       ~~~~~~~~~~~~~~~
monitor/analyze.c:528:2: warning: Value stored to 'size' is never read
[deadcode.DeadStores]
        size -= sizeof(subtype);
        ^       ~~~~~~~~~~~~~~~
monitor/analyze.c:629:2: warning: Value stored to 'data' is never read
[deadcode.DeadStores]
        data += sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:630:2: warning: Value stored to 'size' is never read
[deadcode.DeadStores]
        size -= sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:646:2: warning: Value stored to 'data' is never read
[deadcode.DeadStores]
        data += sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:647:2: warning: Value stored to 'size' is never read
[deadcode.DeadStores]
        size -= sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:710:2: warning: Value stored to 'data' is never read
[deadcode.DeadStores]
        data += sizeof(*hdr);
        ^       ~~~~~~~~~~~~
monitor/analyze.c:711:2: warning: Value stored to 'size' is never read
[deadcode.DeadStores]
        size -= sizeof(*hdr);
        ^       ~~~~~~~~~~~~


  Commit: 293d670fb0ec51b69cdd0b9bf625b1e4d3a7975f
      https://github.com/bluez/bluez/commit/293d670fb0ec51b69cdd0b9bf625b1e4d3a7975f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-27 (Tue, 27 Sep 2022)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor/packet: Fix scan-build warnings

This fixes the following warnings:

monitor/packet.c:410:4: warning: Value stored to 'ts_pos' is never read
[deadcode.DeadStores]
                        ts_pos += n;
                        ^         ~
monitor/packet.c:455:4: warning: Value stored to 'pos' is never read
[deadcode.DeadStores]
                        pos += n;
                        ^      ~
monitor/packet.c:7477:2: warning: Value stored to 'mask' is never read
[deadcode.DeadStores]
        mask = tx_phys;
        ^      ~~~~~~~
monitor/packet.c:7485:2: warning: Value stored to 'mask' is never read
[deadcode.DeadStores]
        mask = rx_phys;
        ^      ~~~~~~~
monitor/packet.c:11229:3: warning: Value stored to 'str' is never read
[deadcode.DeadStores]
                str = "AoA Constant Tone Extension";
                ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
monitor/packet.c:11232:3: warning: Value stored to 'str' is never read
[deadcode.DeadStores]
                str = "AoA Constant Tone Extension with 1us slots";
                ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
monitor/packet.c:11235:3: warning: Value stored to 'str' is never read
[deadcode.DeadStores]
                str = "AoD Constant Tone Extension with 2us slots";
                ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
monitor/packet.c:11238:3: warning: Value stored to 'str' is never read
[deadcode.DeadStores]
                str = "No Constant Tone Extension";
                ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
monitor/packet.c:11241:3: warning: Value stored to 'str' is never read
[deadcode.DeadStores]
                str = "Reserved";
                ^     ~~~~~~~~~~
monitor/packet.c:11242:3: warning: Value stored to 'color_on' is never read
[deadcode.DeadStores]
                color_on = COLOR_RED;
                ^          ~~~~~~~~~


Compare: https://github.com/bluez/bluez/compare/d763bfa4d089...293d670fb0ec
